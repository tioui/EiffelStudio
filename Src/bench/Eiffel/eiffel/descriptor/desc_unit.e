-- Descriptor unit: block in class type descriptor corresponding to
-- given parent class.

class DESC_UNIT

inherit

	ARRAY [ENTRY]
		rename
			make as array_make
		end;
	COMPILER_EXPORTER
		undefine
			is_equal, copy, consistent, setup
		end;
	SHARED_COUNTER
		undefine
			is_equal, copy, consistent, setup
		end

creation

	make

feature -- Creation

	make (c_id: CLASS_ID; sz: INTEGER) is
		do
			class_id := c_id;
			array_make (0, sz-1)
		end;

	class_id: CLASS_ID;

feature -- Generation

	generate (f: INDENT_FILE; cnt : COUNTER) is
			-- C code of Current descriptor unit
			--|Note1: Currently the feature type is written for all the 
			--|features when in practice it is used rather seldom. Try
			--|to find a better representation (without affecting the
			--|incrementality).
			--|Note2: The offset of an attribute is coded on 16 bits
			--|which might not be enough.
		require
			file_not_void: f /= Void
			file_exists: f.exists
			valid_counter: cnt /= Void
		local
			i,j: INTEGER
			re: ROUT_ENTRY
			ae: ATTR_ENTRY
			entry_item: ENTRY
			local_copy: ARRAY [ENTRY]
		do
			from
				local_copy := Current
				i := lower
			until
				i > upper
			loop
				entry_item := local_copy.item (i)
				if entry_item /= Void then
					re ?= entry_item
					if re /= Void then
							-- The entry corresponds to a routine.
							-- Write the body index of the routine (index
							-- into the run-time dispatch table) and the type
							-- of the feature.
						f.putstring ("%N%T{(uint16) ");
						f.putint (re.real_body_index.id - 1);
						f.putstring (", (int16) ");
						f.putint (re.static_feature_type_id - 1);

						if re.is_generic then
							f.putstring (", gen_type");
							f.putint (cnt.value);
							j := cnt.next
						else           
							f.putstring (", (int16 *) 0");
						end;

						f.putstring ("},");
					else
						ae ?= entry_item
						if ae /= Void then
								-- The entry corresponds to an attribute.
								-- Write the offset of the attribute in the 
								-- run-time structure (object) and the type of
								-- the feature.
							f.putstring ("%N%T{(uint16) ");
							f.putint (ae.workbench_offset);
							f.putstring (", (int16) ");
							f.putint (ae.static_feature_type_id - 1);

							if ae.is_generic then
								f.putstring (", gen_type");
								f.putint (cnt.value);
								j := cnt.next
							else           
								f.putstring (", (int16 *) 0");
							end;

							f.putstring ("},");
						end
					end;
				else
						-- The entry corresponds to a routine that
						-- is not polymorphic.
					f.putstring ("%N%T{(uint16) ");
					f.putint (Invalid_index);
					f.putstring (", (int16) -1, (int16 *) 0},")
				end;
				i := i + 1
			end;
		end;

	generate_precomp (f: INDENT_FILE; start: INTEGER; cnt : COUNTER) is
			-- C code of Current precompiled descriptor unit
			--|Note1: Currently the feature type is written for all the 
			--|features when in practice it is used rather seldom. Try
			--|to find a better representation (without affecting the
			--|incrementality).
			--|Note2: The offset of an attribute is coded on 16 bits
			--|which might not be enough.
		require
			file_not_void: f /= Void
			file_exists: f.exists
			valid_counter: cnt /= Void
		local
			i,j: INTEGER;
			re: ROUT_ENTRY;
			ae: ATTR_ENTRY
			nb: INTEGER
			entry_item: ENTRY
			local_copy: ARRAY [ENTRY]
			info, desc1, desc2, gen_type, type: STRING
			non_generic, gen_type_string, end_of_line: STRING
		do
			from
					-- Initialize all the constant string used during this generation
				info := "].info = (uint16) ("
				desc1 := "%Tdesc["
				desc2 := ");%N%Tdesc["
				type := "].type = (int16) ("
				gen_type := "].gen_type = "
				non_generic := "(int16 *) 0;%N"
				gen_type_string := " gen_type"
				end_of_line := ";%N"
				local_copy := Current
				i := lower
			until
				i > upper
			loop
				nb := i + start
				entry_item := local_copy.item (i)
				if entry_item /= Void then
					re ?= entry_item
					if re /= Void then
							-- The entry corresponds to a routine.
							-- Write the body index of the routine (index
							-- into the run-time dispatch table) and the type
							-- of the feature.
						f.putstring (desc1);
						f.putint (nb);
						f.putstring (info);
						re.real_body_index.generated_id (f);
						f.putstring (desc2);
						f.putint (nb);
						f.putstring (type);
						re.generated_static_feature_type_id (f)
						f.putstring (desc2);
						f.putint (nb);
						f.putstring (gen_type);

						if re.is_generic then
							f.putstring (gen_type_string);
							f.putint (cnt.value);
							f.putstring (end_of_line)
							j := cnt.next
						else
							f.putstring (non_generic)
						end
					else
						ae ?= entry_item
						if ae /= Void then
								-- The entry corresponds to an attribute.
								-- Write the offset of the attribute in the 
								-- run-time structure (object) and the type of
								-- the feature.
							f.putstring (desc1);
							f.putint (nb);
							f.putstring (info);
							f.putint (ae.workbench_offset);
							f.putstring (desc2);
							f.putint (nb);
							f.putstring (type);
							ae.generated_static_feature_type_id (f)
							f.putstring (desc2);
							f.putint (nb);
							f.putstring (gen_type);

							if ae.is_generic then
								f.putstring (gen_type_string);
								f.putint (cnt.value);
								f.putstring (end_of_line)
								j := cnt.next
							else
								f.putstring (non_generic)
							end
						end
					end;
				else
						-- The entry corresponds to a routine that
						-- is not polymorphic.
					f.putstring (desc1);
					f.putint (nb);
					f.putstring (info);
					f.putint (Invalid_index);
					f.putstring (desc2);
					f.putint (nb);
					f.putstring (type)
					f.putint (-1)
					f.putstring (desc2);
					f.putint (nb);
					f.putstring (gen_type)
					f.putint (0)
					f.new_line
				end;
				i := i + 1
			end;
		end;

	generate_generic (f : INDENT_FILE; cnt : COUNTER) is
			-- C code for generic types in Current descriptor unit
		require
			file_not_void: f /= Void
			file_exists: f.exists
			valid_counter : cnt /= Void
		local
			i, j: INTEGER;
			re: ROUT_ENTRY;
			ae: ATTR_ENTRY
			entry_item: ENTRY
			local_copy: ARRAY [ENTRY]
		do
			from
				local_copy := Current
				i := lower
			until
				i > upper
			loop
				entry_item := local_copy.item (i)
				if entry_item /= Void and then entry_item.is_generic then
					re ?= entry_item
					if re /= Void then
						f.putstring ("static int16 gen_type");
						f.putint (cnt.value);
						j := cnt.next;
						f.putstring (" [] = {0,");
						re.generate_cid (f, False);
						f.putstring ("-1};%N")
					else
						ae ?= entry_item
						if ae /= Void then
							f.putstring ("static int16 gen_type");
							f.putint (cnt.value);
							j := cnt.next;
							f.putstring (" [] = {0,");
							ae.generate_cid (f, False);
							f.putstring ("-1};%N")
						end
					end;
				end;
				i := i + 1
			end;
		end;

feature -- Melting

	make_byte_code (ba: BYTE_ARRAY) is
			-- Append byte code of Current descriptor
			-- unit to the `ba' byte array.
			-- Format:
			--    1) Id of origin class (short)
			--    2) Number of elements (short)
			--    3) Sequence of triples (short, short, list_of_short)
		local
			i: INTEGER;
			re: ROUT_ENTRY;
			ae: ATTR_ENTRY
			entry_item: ENTRY
			local_copy: ARRAY [ENTRY]
		do
				-- Append the id of the origin class
			ba.append_short_integer (class_id.id);

				-- Append the size of the descriptor unit
			ba.append_short_integer (upper - lower + 1);

				-- Append the descriptor entries
			from
				local_copy := Current
				i := lower
			until
				i > upper
			loop
				entry_item := local_copy.item (i)
				if entry_item /= Void then
					re ?= entry_item
					if re /= Void then
							-- The entry corresponds to a routine.
							-- Write the body index of the routine (index
							-- into the run-time dispatch table) and the type
							-- of the feature.
						ba.append_short_integer (re.real_body_index.id - 1);
						ba.append_short_integer (re.static_feature_type_id -1);

						if re.is_generic then
							ba.append_short_integer (0)
							re.make_gen_type_byte_code (ba)
						end;

						ba.append_short_integer (-1)
					else
						ae ?= entry_item
						if ae /= Void then
								-- The entry corresponds to an attribute.
								-- Write the offset of the attribute in the 
								-- run-time structure (object) and the type of
								-- the feature.
							ba.append_short_integer (ae.workbench_offset);
							ba.append_short_integer (ae.static_feature_type_id - 1);

							if ae.is_generic then
								ba.append_short_integer (0)
								ae.make_gen_type_byte_code (ba)
							end;

							ba.append_short_integer (-1)
						else
							ba.append_short_integer (-1);
							ba.append_short_integer (-1);
							ba.append_short_integer (-1)
						end
					end;
				else
						-- The entry corresponds to a routine that
						-- is not polymorphic.
					ba.append_short_integer (-1);
					ba.append_short_integer (-1);
					ba.append_short_integer (-1)
				end;
				i := i + 1
			end;
		end;

end
