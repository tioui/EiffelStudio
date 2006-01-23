indexing
	description: "Implemented `IDocHostUIHandlerDispatch' Interface."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	Note: "Automatically generated by the EiffelCOM Wizard."

class
	IDOC_HOST_UIHANDLER_DISPATCH_IMPL_PROXY

inherit
	IDOC_HOST_UIHANDLER_DISPATCH_INTERFACE

	ECOM_QUERIABLE

create
	make_from_other,
	make_from_pointer

feature {NONE}  -- Initialization

	make_from_pointer (cpp_obj: POINTER) is
			-- Make from pointer
		do
			initializer := ccom_create_idoc_host_uihandler_dispatch_impl_proxy_from_pointer(cpp_obj)
			item := ccom_item (initializer)
		end

feature -- Basic Operations

	show_context_menu (dw_id: INTEGER; 
		x: INTEGER; 
		y: INTEGER; 
		pcmdt_reserved: ECOM_INTERFACE; 
		pdisp_reserved: ECOM_INTERFACE): ECOM_HRESULT is
			-- No description available.
			-- `dw_id' [in].  
			-- `x' [in].  
			-- `y' [in].  
			-- `pcmdt_reserved' [in].  
			-- `pdisp_reserved' [in].  
		local
			pcmdt_reserved_item: POINTER
			a_stub: ECOM_STUB
			pdisp_reserved_item: POINTER
		do
			if pcmdt_reserved /= Void then
				if (pcmdt_reserved.item = default_pointer) then
					a_stub ?= pcmdt_reserved
					if a_stub /= Void then
						a_stub.create_item
					end
				end
				pcmdt_reserved_item := pcmdt_reserved.item
			end
			if pdisp_reserved /= Void then
				if (pdisp_reserved.item = default_pointer) then
					a_stub ?= pdisp_reserved
					if a_stub /= Void then
						a_stub.create_item
					end
				end
				pdisp_reserved_item := pdisp_reserved.item
			end
			Result := ccom_show_context_menu (initializer, dw_id, x, y, pcmdt_reserved_item, pdisp_reserved_item)
		end

	get_host_info (pdw_flags: INTEGER_REF; pdw_double_click: INTEGER_REF) is
			-- No description available.
			-- `pdw_flags' [in, out].  
			-- `pdw_double_click' [in, out].  
		do
			ccom_get_host_info (initializer, pdw_flags, pdw_double_click)
		end

	show_ui (dw_id: INTEGER; 
		p_active_object: ECOM_INTERFACE; 
		p_command_target: ECOM_INTERFACE; 
		p_frame: ECOM_INTERFACE; 
		p_doc: ECOM_INTERFACE): ECOM_HRESULT is
			-- No description available.
			-- `dw_id' [in].  
			-- `p_active_object' [in].  
			-- `p_command_target' [in].  
			-- `p_frame' [in].  
			-- `p_doc' [in].  
		local
			p_active_object_item: POINTER
			a_stub: ECOM_STUB
			p_command_target_item: POINTER
			p_frame_item: POINTER
			p_doc_item: POINTER
		do
			if p_active_object /= Void then
				if (p_active_object.item = default_pointer) then
					a_stub ?= p_active_object
					if a_stub /= Void then
						a_stub.create_item
					end
				end
				p_active_object_item := p_active_object.item
			end
			if p_command_target /= Void then
				if (p_command_target.item = default_pointer) then
					a_stub ?= p_command_target
					if a_stub /= Void then
						a_stub.create_item
					end
				end
				p_command_target_item := p_command_target.item
			end
			if p_frame /= Void then
				if (p_frame.item = default_pointer) then
					a_stub ?= p_frame
					if a_stub /= Void then
						a_stub.create_item
					end
				end
				p_frame_item := p_frame.item
			end
			if p_doc /= Void then
				if (p_doc.item = default_pointer) then
					a_stub ?= p_doc
					if a_stub /= Void then
						a_stub.create_item
					end
				end
				p_doc_item := p_doc.item
			end
			Result := ccom_show_ui (initializer, dw_id, p_active_object_item, p_command_target_item, p_frame_item, p_doc_item)
		end

	hide_ui is
			-- No description available.
		do
			ccom_hide_ui (initializer)
		end

	update_ui is
			-- No description available.
		do
			ccom_update_ui (initializer)
		end

	enable_modeless (f_enable: BOOLEAN) is
			-- No description available.
			-- `f_enable' [in].  
		do
			ccom_enable_modeless (initializer, f_enable)
		end

	on_doc_window_activate (f_activate: BOOLEAN) is
			-- No description available.
			-- `f_activate' [in].  
		do
			ccom_on_doc_window_activate (initializer, f_activate)
		end

	on_frame_window_activate (f_activate: BOOLEAN) is
			-- No description available.
			-- `f_activate' [in].  
		do
			ccom_on_frame_window_activate (initializer, f_activate)
		end

	resize_border (left: INTEGER; top: INTEGER; right: INTEGER; bottom: INTEGER; p_uiwindow: ECOM_INTERFACE; f_frame_window: BOOLEAN) is
			-- No description available.
			-- `left' [in].  
			-- `top' [in].  
			-- `right' [in].  
			-- `bottom' [in].  
			-- `p_uiwindow' [in].  
			-- `f_frame_window' [in].  
		local
			p_uiwindow_item: POINTER
			a_stub: ECOM_STUB
		do
			if p_uiwindow /= Void then
				if (p_uiwindow.item = default_pointer) then
					a_stub ?= p_uiwindow
					if a_stub /= Void then
						a_stub.create_item
					end
				end
				p_uiwindow_item := p_uiwindow.item
			end
			ccom_resize_border (initializer, left, top, right, bottom, p_uiwindow_item, f_frame_window)
		end

	translate_accelerator (h_wnd: INTEGER; n_message: INTEGER; w_param: INTEGER; l_param: INTEGER; bstr_guid_cmd_group: STRING; n_cmd_id: INTEGER): ECOM_HRESULT is
			-- No description available.
			-- `h_wnd' [in].  
			-- `n_message' [in].  
			-- `w_param' [in].  
			-- `l_param' [in].  
			-- `bstr_guid_cmd_group' [in].  
			-- `n_cmd_id' [in].  
		do
			Result := ccom_translate_accelerator (initializer, h_wnd, n_message, w_param, l_param, bstr_guid_cmd_group, n_cmd_id)
		end

	get_option_key_path (pbstr_key: CELL [STRING]; dw: INTEGER) is
			-- No description available.
			-- `pbstr_key' [out].  
			-- `dw' [in].  
		do
			ccom_get_option_key_path (initializer, pbstr_key, dw)
		end

	get_drop_target (p_drop_target: ECOM_INTERFACE; pp_drop_target: CELL [ECOM_INTERFACE]) is
			-- No description available.
			-- `p_drop_target' [in].  
			-- `pp_drop_target' [out].  
		local
			p_drop_target_item: POINTER
			a_stub: ECOM_STUB
		do
			if p_drop_target /= Void then
				if (p_drop_target.item = default_pointer) then
					a_stub ?= p_drop_target
					if a_stub /= Void then
						a_stub.create_item
					end
				end
				p_drop_target_item := p_drop_target.item
			end
			ccom_get_drop_target (initializer, p_drop_target_item, pp_drop_target)
		end

	get_external (pp_dispatch: CELL [ECOM_INTERFACE]) is
			-- No description available.
			-- `pp_dispatch' [out].  
		do
			ccom_get_external (initializer, pp_dispatch)
		end

	translate_url (dw_translate: INTEGER; bstr_urlin: STRING; pbstr_urlout: CELL [STRING]) is
			-- No description available.
			-- `dw_translate' [in].  
			-- `bstr_urlin' [in].  
			-- `pbstr_urlout' [out].  
		do
			ccom_translate_url (initializer, dw_translate, bstr_urlin, pbstr_urlout)
		end

	filter_data_object (p_do: ECOM_INTERFACE; pp_doret: CELL [ECOM_INTERFACE]) is
			-- No description available.
			-- `p_do' [in].  
			-- `pp_doret' [out].  
		local
			p_do_item: POINTER
			a_stub: ECOM_STUB
		do
			if p_do /= Void then
				if (p_do.item = default_pointer) then
					a_stub ?= p_do
					if a_stub /= Void then
						a_stub.create_item
					end
				end
				p_do_item := p_do.item
			end
			ccom_filter_data_object (initializer, p_do_item, pp_doret)
		end

feature {NONE}  -- Implementation

	delete_wrapper is
			-- Delete wrapper
		do
			ccom_delete_idoc_host_uihandler_dispatch_impl_proxy(initializer)
		end

feature {NONE}  -- Externals

	ccom_show_context_menu (cpp_obj: POINTER; dw_id: INTEGER; x: INTEGER; y: INTEGER; pcmdt_reserved: POINTER; pdisp_reserved: POINTER): ECOM_HRESULT is
			-- No description available.
		external
			"C++ [ecom_control_library::IDocHostUIHandlerDispatch_impl_proxy %"ecom_control_library_IDocHostUIHandlerDispatch_impl_proxy_s.h%"](EIF_INTEGER,EIF_INTEGER,EIF_INTEGER,IUnknown *,IDispatch *): EIF_REFERENCE"
		end

	ccom_get_host_info (cpp_obj: POINTER; pdw_flags: INTEGER_REF; pdw_double_click: INTEGER_REF) is
			-- No description available.
		external
			"C++ [ecom_control_library::IDocHostUIHandlerDispatch_impl_proxy %"ecom_control_library_IDocHostUIHandlerDispatch_impl_proxy_s.h%"](EIF_OBJECT,EIF_OBJECT)"
		end

	ccom_show_ui (cpp_obj: POINTER; dw_id: INTEGER; p_active_object: POINTER; p_command_target: POINTER; p_frame: POINTER; p_doc: POINTER): ECOM_HRESULT is
			-- No description available.
		external
			"C++ [ecom_control_library::IDocHostUIHandlerDispatch_impl_proxy %"ecom_control_library_IDocHostUIHandlerDispatch_impl_proxy_s.h%"](EIF_INTEGER,IUnknown *,IUnknown *,IUnknown *,IUnknown *): EIF_REFERENCE"
		end

	ccom_hide_ui (cpp_obj: POINTER) is
			-- No description available.
		external
			"C++ [ecom_control_library::IDocHostUIHandlerDispatch_impl_proxy %"ecom_control_library_IDocHostUIHandlerDispatch_impl_proxy_s.h%"]()"
		end

	ccom_update_ui (cpp_obj: POINTER) is
			-- No description available.
		external
			"C++ [ecom_control_library::IDocHostUIHandlerDispatch_impl_proxy %"ecom_control_library_IDocHostUIHandlerDispatch_impl_proxy_s.h%"]()"
		end

	ccom_enable_modeless (cpp_obj: POINTER; f_enable: BOOLEAN) is
			-- No description available.
		external
			"C++ [ecom_control_library::IDocHostUIHandlerDispatch_impl_proxy %"ecom_control_library_IDocHostUIHandlerDispatch_impl_proxy_s.h%"](EIF_BOOLEAN)"
		end

	ccom_on_doc_window_activate (cpp_obj: POINTER; f_activate: BOOLEAN) is
			-- No description available.
		external
			"C++ [ecom_control_library::IDocHostUIHandlerDispatch_impl_proxy %"ecom_control_library_IDocHostUIHandlerDispatch_impl_proxy_s.h%"](EIF_BOOLEAN)"
		end

	ccom_on_frame_window_activate (cpp_obj: POINTER; f_activate: BOOLEAN) is
			-- No description available.
		external
			"C++ [ecom_control_library::IDocHostUIHandlerDispatch_impl_proxy %"ecom_control_library_IDocHostUIHandlerDispatch_impl_proxy_s.h%"](EIF_BOOLEAN)"
		end

	ccom_resize_border (cpp_obj: POINTER; left: INTEGER; top: INTEGER; right: INTEGER; bottom: INTEGER; p_uiwindow: POINTER; f_frame_window: BOOLEAN) is
			-- No description available.
		external
			"C++ [ecom_control_library::IDocHostUIHandlerDispatch_impl_proxy %"ecom_control_library_IDocHostUIHandlerDispatch_impl_proxy_s.h%"](EIF_INTEGER,EIF_INTEGER,EIF_INTEGER,EIF_INTEGER,IUnknown *,EIF_BOOLEAN)"
		end

	ccom_translate_accelerator (cpp_obj: POINTER; h_wnd: INTEGER; n_message: INTEGER; w_param: INTEGER; l_param: INTEGER; bstr_guid_cmd_group: STRING; n_cmd_id: INTEGER): ECOM_HRESULT is
			-- No description available.
		external
			"C++ [ecom_control_library::IDocHostUIHandlerDispatch_impl_proxy %"ecom_control_library_IDocHostUIHandlerDispatch_impl_proxy_s.h%"](EIF_INTEGER,EIF_INTEGER,EIF_INTEGER,EIF_INTEGER,EIF_OBJECT,EIF_INTEGER): EIF_REFERENCE"
		end

	ccom_get_option_key_path (cpp_obj: POINTER; pbstr_key: CELL [STRING]; dw: INTEGER) is
			-- No description available.
		external
			"C++ [ecom_control_library::IDocHostUIHandlerDispatch_impl_proxy %"ecom_control_library_IDocHostUIHandlerDispatch_impl_proxy_s.h%"](EIF_OBJECT,EIF_INTEGER)"
		end

	ccom_get_drop_target (cpp_obj: POINTER; p_drop_target: POINTER; pp_drop_target: CELL [ECOM_INTERFACE]) is
			-- No description available.
		external
			"C++ [ecom_control_library::IDocHostUIHandlerDispatch_impl_proxy %"ecom_control_library_IDocHostUIHandlerDispatch_impl_proxy_s.h%"](IUnknown *,EIF_OBJECT)"
		end

	ccom_get_external (cpp_obj: POINTER; pp_dispatch: CELL [ECOM_INTERFACE]) is
			-- No description available.
		external
			"C++ [ecom_control_library::IDocHostUIHandlerDispatch_impl_proxy %"ecom_control_library_IDocHostUIHandlerDispatch_impl_proxy_s.h%"](EIF_OBJECT)"
		end

	ccom_translate_url (cpp_obj: POINTER; dw_translate: INTEGER; bstr_urlin: STRING; pbstr_urlout: CELL [STRING]) is
			-- No description available.
		external
			"C++ [ecom_control_library::IDocHostUIHandlerDispatch_impl_proxy %"ecom_control_library_IDocHostUIHandlerDispatch_impl_proxy_s.h%"](EIF_INTEGER,EIF_OBJECT,EIF_OBJECT)"
		end

	ccom_filter_data_object (cpp_obj: POINTER; p_do: POINTER; pp_doret: CELL [ECOM_INTERFACE]) is
			-- No description available.
		external
			"C++ [ecom_control_library::IDocHostUIHandlerDispatch_impl_proxy %"ecom_control_library_IDocHostUIHandlerDispatch_impl_proxy_s.h%"](IUnknown *,EIF_OBJECT)"
		end

	ccom_delete_idoc_host_uihandler_dispatch_impl_proxy (a_pointer: POINTER) is
			-- Release resource
		external
			"C++ [delete ecom_control_library::IDocHostUIHandlerDispatch_impl_proxy %"ecom_control_library_IDocHostUIHandlerDispatch_impl_proxy_s.h%"]()"
		end

	ccom_create_idoc_host_uihandler_dispatch_impl_proxy_from_pointer (a_pointer: POINTER): POINTER is
			-- Create from pointer
		external
			"C++ [new ecom_control_library::IDocHostUIHandlerDispatch_impl_proxy %"ecom_control_library_IDocHostUIHandlerDispatch_impl_proxy_s.h%"](IUnknown *)"
		end

	ccom_item (cpp_obj: POINTER): POINTER is
			-- Item
		external
			"C++ [ecom_control_library::IDocHostUIHandlerDispatch_impl_proxy %"ecom_control_library_IDocHostUIHandlerDispatch_impl_proxy_s.h%"]():EIF_POINTER"
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- IDOC_HOST_UIHANDLER_DISPATCH_IMPL_PROXY

