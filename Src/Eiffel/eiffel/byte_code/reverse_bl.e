indexing
	description: "Enlarged byte code for reverse assignment"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class REVERSE_BL

inherit
	REVERSE_B
		undefine
			find_assign_result, mark_last_instruction,
			last_all_in_result, analyze, generate
		end

	ASSIGN_BL
		rename
			target_propagated as register_propagated
		undefine
			enlarged, process
		redefine
			analyze, generate_regular_assignment,
			generate_last_assignment, source_print_register , make
		end;

create
	make

feature {NONE} -- Initialization

	make (other: REVERSE_B) is
			-- Create new  instance from `other'.
		do
			Precursor {ASSIGN_BL} (other)
			set_info (other.info)
		end

feature

	analyze is
			-- Analyze reverse assignment
		local
			source_type: TYPE_I
			target_type: TYPE_I
			gen_type: GEN_TYPE_I
			l_context: like context
		do
			l_context := context
				-- Mark Result used only if not the last instruction (in which
				-- case we'll generate a direct return, hence Result won't be
				-- needed).
			if target.is_result then
				l_context.mark_result_used
			end;
				-- The target is always expanded in-line for de-referencing.
				-- Ensure propagation in any generation mode (the propagation
				-- of No_register in workbench mode is prevented to force
				-- expression splitting).
			target.set_register (No_register)
			target.analyze
			info.analyze
			source_type := l_context.real_type (source.type)
			target_type := l_context.creation_type (target.type)
			if target.is_predefined and then not target_type.is_expanded then
				register := target
			else
				if source_type.is_reference then
						-- Source might need to be cloned before reattachment.
					create {REGISTER} register.make (source.c_type)
				else
					get_register
				end
			end
			l_context.init_propagation;
				-- We won't attempt a propagation of the target if the
				-- target is a reference and the source is a basic type
				-- or an expanded.
			if not target_type.is_none and then not target_type.is_expanded and then source_type.is_expanded then
				source.propagate (No_register)
				register_for_metamorphosis := true
				get_register
			else
				source.propagate (register)
				register_propagated := l_context.propagated
			end
			gen_type ?= target_type

				-- Current needed in the access if target is not predefined
				-- or if target is generic.

			if not target.is_predefined and target.c_type.is_pointer then
				l_context.mark_current_used
			end
			if gen_type /= Void then
				l_context.add_dftype_current
			end
			source.analyze
			source.free_register
			if register.is_temporary and not register_propagated then
				register.free_register
			end
			simple_op_assignment := No_simple_op
			if target_type.is_expanded then
				last_in_result := False
			end
		end

	source_print_register is
			-- Print register holding the source
		do
			if not (register_propagated and source.is_simple_expr)
				and not register_for_metamorphosis
			then
				print_register;
			else
				source.print_register;
			end;
		end;

	generate_last_assignment (how: INTEGER) is
			-- Generate last assignment in Result
		do
			generate_regular_assignment (how);
		end;

	generate_regular_assignment (how: INTEGER) is
			-- Generate assignment
		local
			buf: GENERATION_BUFFER
			source_type: TYPE_I
			target_type: TYPE_I
			source_class_type: CL_TYPE_I
			target_class_type: CL_TYPE_I
			is_code_empty: BOOLEAN
			l_context: like context
		do
			buf := buffer
			l_context := context
			generate_line_info
				-- First pre-compute the source and put it in the register
				-- so that we can use it inside macro (where the argument is
				-- evaluated more than once).
			source.generate
			generate_special (how)

			info.generate_start (buf)
			info.generate_gen_type_conversion

			source_type := l_context.real_type (source.type)
			target_type := l_context.real_type (target.type)

				-- If register was propagated, then the assignment was already
				-- generated by the `generate' call unless the source is not
				-- a simple expression.
			if not (register_propagated and source.is_simple_expr)
				and not register_for_metamorphosis
			then
				print_register
				buf.put_string (" = ")
				if source_type.is_reference then
						-- Clone object of a boxed expanded type.
					source.generate_dynamic_clone (source, source_type)
				elseif source_type.is_true_expanded then
					buf.put_string ("RTRCL")
					buf.put_character ('(')
					source.print_register
					buf.put_character (')')
				else
					source.print_register
				end
				buf.put_character (';')
				buf.put_new_line
			end
				-- If last is in result, generate a return instruction.
			if last_in_result then
				l_context.byte_code.finish_compound
				if last_instruction then
					buf.put_new_line
				end
				buf.put_string ("return ")
			elseif not target_type.is_expanded and then not source_type.is_expanded then
				target.print_register
				buf.put_string (" = ")
			end
			if target_type.is_none then
					-- Assignment on something of type NONE always fails.
				buf.put_string ("(EIF_REFERENCE) 0")
			elseif target_type.is_expanded then
				if source_type.is_expanded then
						-- NOP if classes are different or normal assignment otherwise.
					source_class_type ?= source_type
					target_class_type ?= target_type
					if
						target_class_type /= Void and then source_class_type /= Void and then
						target_class_type.class_id = source_class_type.class_id
					then
							-- Do normal assignment.
						if target_type.is_basic then
							target.print_register
							buf.put_string (" = ")
							source_print_register
						else
							generate_expanded_assignment
							is_code_empty := True
						end
					else
						is_code_empty := True
					end
				elseif target_type.is_basic then
						-- Attachment to entity of basic type.
					buf.put_string ("RTRB(")
					info.generate_type_id (buf, l_context.final_mode)
					buf.put_string (gc_comma)
					source_print_register
					buf.put_string (gc_comma)
					target.print_register
					buf.put_string (gc_comma)
					buf.put_character ('*')
					target.c_type.generate_access_cast (buf)
					buf.put_character (')')
				else
						-- Attachment to entity of non-basic expanded type.
					buf.put_string ("RTRE(")
					info.generate_type_id (buf, l_context.final_mode)
					buf.put_string (gc_comma)
					source_print_register
					buf.put_string (gc_comma)
					target.print_register
					buf.put_character (')')
				end
			elseif source_type.is_expanded then
				if register = target then
						-- Expanded object is already attached to reference target.
					is_code_empty := True
				else
					target.print_register
					buf.put_string (" = ")
					buf.put_string ("RTRV(")
					info.generate_type_id (buf, l_context.final_mode)
					buf.put_string (gc_comma)
					print_register
					buf.put_character (')')
						-- Perform aging tests when necessary
					if not target.is_predefined then
						buf.put_character (';')
						buf.put_new_line
						buf.put_string ("RTAR(")
						l_context.Current_register.print_register
						buf.put_string (gc_comma)
						print_register
						buf.put_character (')')
					end
				end
			else
				buf.put_string ("RTRV(")
				info.generate_type_id (buf, l_context.final_mode)

				buf.put_string (gc_comma)
				source_print_register
				buf.put_character (')')
					-- Perform aging tests when necessary
				if not target.is_predefined then
					buf.put_character (';')
					buf.put_new_line
					buf.put_string ("RTAR(")
					l_context.Current_register.print_register
					buf.put_string (gc_comma)
					source_print_register
					buf.put_character (')')
				end
			end
			if not is_code_empty then
				buf.put_character (';')
				buf.put_new_line
			end

			info.generate_end (buf)
		end;

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
