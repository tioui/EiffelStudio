note
	description: "Implemented `IOleCommandTarget' Interface."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	Note: "Automatically generated by the EiffelCOM Wizard."

class
	IOLE_COMMAND_TARGET_IMPL_PROXY

inherit
	IOLE_COMMAND_TARGET_INTERFACE

	ECOM_QUERIABLE

create
	make_from_other,
	make_from_pointer

feature {NONE}  -- Initialization

	make_from_pointer (cpp_obj: POINTER)
			-- Make from pointer
		do
			initializer := ccom_create_iole_command_target_impl_proxy_from_pointer(cpp_obj)
			item := ccom_item (initializer)
		end

feature -- Basic Operations

	query_status (pguid_cmd_group: ECOM_GUID; c_cmds: INTEGER; prg_cmds: ARRAY [X_TAG_OLECMD_RECORD]; p_cmd_text: X_TAG_OLECMDTEXT_RECORD)
			-- No description available.
			-- `pguid_cmd_group' [in].  
			-- `c_cmds' [in].  
			-- `prg_cmds' [in, out].  
			-- `p_cmd_text' [in, out].  
		do
			ccom_query_status (initializer, pguid_cmd_group.item, c_cmds, prg_cmds, p_cmd_text.item)
		end

	exec (pguid_cmd_group: ECOM_GUID; n_cmd_id: INTEGER; n_cmdexecopt: INTEGER; pva_in: ECOM_VARIANT; pva_out: ECOM_VARIANT)
			-- No description available.
			-- `pguid_cmd_group' [in].  
			-- `n_cmd_id' [in].  
			-- `n_cmdexecopt' [in].  
			-- `pva_in' [in].  
			-- `pva_out' [in, out].  
		do
			ccom_exec (initializer, pguid_cmd_group.item, n_cmd_id, n_cmdexecopt, pva_in.item, pva_out.item)
		end

feature {NONE}  -- Implementation

	delete_wrapper
			-- Delete wrapper
		do
			ccom_delete_iole_command_target_impl_proxy(initializer)
		end

feature {NONE}  -- Externals

	ccom_query_status (cpp_obj: POINTER; pguid_cmd_group: POINTER; c_cmds: INTEGER; prg_cmds: ARRAY [X_TAG_OLECMD_RECORD]; p_cmd_text: POINTER)
			-- No description available.
		external
			"C++ [ecom_control_library::IOleCommandTarget_impl_proxy %"ecom_control_library_IOleCommandTarget_impl_proxy_s.h%"](GUID *,EIF_INTEGER,EIF_OBJECT,ecom_control_library::_tagOLECMDTEXT *)"
		end

	ccom_exec (cpp_obj: POINTER; pguid_cmd_group: POINTER; n_cmd_id: INTEGER; n_cmdexecopt: INTEGER; pva_in: POINTER; pva_out: POINTER)
			-- No description available.
		external
			"C++ [ecom_control_library::IOleCommandTarget_impl_proxy %"ecom_control_library_IOleCommandTarget_impl_proxy_s.h%"](GUID *,EIF_INTEGER,EIF_INTEGER,VARIANT *,VARIANT *)"
		end

	ccom_delete_iole_command_target_impl_proxy (a_pointer: POINTER)
			-- Release resource
		external
			"C++ [delete ecom_control_library::IOleCommandTarget_impl_proxy %"ecom_control_library_IOleCommandTarget_impl_proxy_s.h%"]()"
		end

	ccom_create_iole_command_target_impl_proxy_from_pointer (a_pointer: POINTER): POINTER
			-- Create from pointer
		external
			"C++ [new ecom_control_library::IOleCommandTarget_impl_proxy %"ecom_control_library_IOleCommandTarget_impl_proxy_s.h%"](IUnknown *)"
		end

	ccom_item (cpp_obj: POINTER): POINTER
			-- Item
		external
			"C++ [ecom_control_library::IOleCommandTarget_impl_proxy %"ecom_control_library_IOleCommandTarget_impl_proxy_s.h%"]():EIF_POINTER"
		end

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- IOLE_COMMAND_TARGET_IMPL_PROXY

