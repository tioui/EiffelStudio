note
	description: "Implemented `IOleWindow' Interface."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	generator: "Automatically generated by the EiffelCOM Wizard."

class
	IOLE_WINDOW_IMPL_PROXY

inherit
	IOLE_WINDOW_INTERFACE

	ECOM_QUERIABLE

create
	make_from_other,
	make_from_pointer

feature {NONE}  -- Initialization

	make_from_pointer (cpp_obj: POINTER)
			-- Make from pointer
		do
			initializer := ccom_create_iole_window_impl_proxy_from_pointer(cpp_obj)
			item := ccom_item (initializer)
		end

feature -- Basic Operations

	get_window (phwnd: CELL [POINTER])
			-- No description available.
			-- `phwnd' [out].  
		do
			ccom_get_window (initializer, phwnd)
		end

	context_sensitive_help (f_enter_mode: INTEGER)
			-- No description available.
			-- `f_enter_mode' [in].  
		do
			ccom_context_sensitive_help (initializer, f_enter_mode)
		end

feature {NONE}  -- Implementation

	delete_wrapper
			-- Delete wrapper
		do
			ccom_delete_iole_window_impl_proxy(initializer)
		end

feature {NONE}  -- Externals

	ccom_get_window (cpp_obj: POINTER; phwnd: CELL [POINTER])
			-- No description available.
		external
			"C++ [ecom_control_library::IOleWindow_impl_proxy %"ecom_control_library_IOleWindow_impl_proxy_s.h%"](EIF_OBJECT)"
		end

	ccom_context_sensitive_help (cpp_obj: POINTER; f_enter_mode: INTEGER)
			-- No description available.
		external
			"C++ [ecom_control_library::IOleWindow_impl_proxy %"ecom_control_library_IOleWindow_impl_proxy_s.h%"](EIF_INTEGER)"
		end

	ccom_delete_iole_window_impl_proxy (a_pointer: POINTER)
			-- Release resource
		external
			"C++ [delete ecom_control_library::IOleWindow_impl_proxy %"ecom_control_library_IOleWindow_impl_proxy_s.h%"]()"
		end

	ccom_create_iole_window_impl_proxy_from_pointer (a_pointer: POINTER): POINTER
			-- Create from pointer
		external
			"C++ [new ecom_control_library::IOleWindow_impl_proxy %"ecom_control_library_IOleWindow_impl_proxy_s.h%"](IUnknown *)"
		end

	ccom_item (cpp_obj: POINTER): POINTER
			-- Item
		external
			"C++ [ecom_control_library::IOleWindow_impl_proxy %"ecom_control_library_IOleWindow_impl_proxy_s.h%"]():EIF_POINTER"
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




end -- IOLE_WINDOW_IMPL_PROXY

