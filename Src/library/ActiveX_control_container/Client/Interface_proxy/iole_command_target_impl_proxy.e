indexing
	description: "Implemented `IOleCommandTarget' Interface."
	Note: "Automatically generated by the EiffelCOM Wizard."

class
	IOLE_COMMAND_TARGET_IMPL_PROXY

inherit
	IOLE_COMMAND_TARGET_INTERFACE

	ECOM_QUERIABLE

creation
	make_from_other,
	make_from_pointer

feature {NONE}  -- Initialization

	make_from_pointer (cpp_obj: POINTER) is
			-- Make from pointer
		do
			initializer := ccom_create_iole_command_target_impl_proxy_from_pointer(cpp_obj)
			item := ccom_item (initializer)
		end

feature -- Basic Operations

	query_status (pguid_cmd_group: ECOM_GUID; c_cmds: INTEGER; prg_cmds: ARRAY [X_TAG_OLECMD_RECORD]; p_cmd_text: X_TAG_OLECMDTEXT_RECORD) is
			-- No description available.
			-- `pguid_cmd_group' [in].  
			-- `c_cmds' [in].  
			-- `prg_cmds' [in, out].  
			-- `p_cmd_text' [in, out].  
		do
			ccom_query_status (initializer, pguid_cmd_group.item, c_cmds, prg_cmds, p_cmd_text.item)
		end

	exec (pguid_cmd_group: ECOM_GUID; n_cmd_id: INTEGER; n_cmdexecopt: INTEGER; pva_in: ECOM_VARIANT; pva_out: ECOM_VARIANT) is
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

	delete_wrapper is
			-- Delete wrapper
		do
			ccom_delete_iole_command_target_impl_proxy(initializer)
		end

feature {NONE}  -- Externals

	ccom_query_status (cpp_obj: POINTER; pguid_cmd_group: POINTER; c_cmds: INTEGER; prg_cmds: ARRAY [X_TAG_OLECMD_RECORD]; p_cmd_text: POINTER) is
			-- No description available.
		external
			"C++ [ecom_control_library::IOleCommandTarget_impl_proxy %"ecom_control_library_IOleCommandTarget_impl_proxy_s.h%"](GUID *,EIF_INTEGER,EIF_OBJECT,ecom_control_library::_tagOLECMDTEXT *)"
		end

	ccom_exec (cpp_obj: POINTER; pguid_cmd_group: POINTER; n_cmd_id: INTEGER; n_cmdexecopt: INTEGER; pva_in: POINTER; pva_out: POINTER) is
			-- No description available.
		external
			"C++ [ecom_control_library::IOleCommandTarget_impl_proxy %"ecom_control_library_IOleCommandTarget_impl_proxy_s.h%"](GUID *,EIF_INTEGER,EIF_INTEGER,VARIANT *,VARIANT *)"
		end

	ccom_delete_iole_command_target_impl_proxy (a_pointer: POINTER) is
			-- Release resource
		external
			"C++ [delete ecom_control_library::IOleCommandTarget_impl_proxy %"ecom_control_library_IOleCommandTarget_impl_proxy_s.h%"]()"
		end

	ccom_create_iole_command_target_impl_proxy_from_pointer (a_pointer: POINTER): POINTER is
			-- Create from pointer
		external
			"C++ [new ecom_control_library::IOleCommandTarget_impl_proxy %"ecom_control_library_IOleCommandTarget_impl_proxy_s.h%"](IUnknown *)"
		end

	ccom_item (cpp_obj: POINTER): POINTER is
			-- Item
		external
			"C++ [ecom_control_library::IOleCommandTarget_impl_proxy %"ecom_control_library_IOleCommandTarget_impl_proxy_s.h%"]():EIF_POINTER"
		end

end -- IOLE_COMMAND_TARGET_IMPL_PROXY

