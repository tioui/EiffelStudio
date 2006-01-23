indexing
	description: "Implemented `IOleInPlaceObject' Interface."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	Note: "Automatically generated by the EiffelCOM Wizard."

class
	IOLE_IN_PLACE_OBJECT_IMPL_PROXY

inherit
	IOLE_IN_PLACE_OBJECT_INTERFACE

	ECOM_QUERIABLE

create
	make_from_other,
	make_from_pointer

feature {NONE}  -- Initialization

	make_from_pointer (cpp_obj: POINTER) is
			-- Make from pointer
		do
			initializer := ccom_create_iole_in_place_object_impl_proxy_from_pointer(cpp_obj)
			item := ccom_item (initializer)
		end

feature -- Basic Operations

	get_window (phwnd: CELL [POINTER]) is
			-- No description available.
			-- `phwnd' [out].  
		do
			ccom_get_window (initializer, phwnd)
		end

	context_sensitive_help (f_enter_mode: INTEGER) is
			-- No description available.
			-- `f_enter_mode' [in].  
		do
			ccom_context_sensitive_help (initializer, f_enter_mode)
		end

	in_place_deactivate is
			-- No description available.
		do
			ccom_in_place_deactivate (initializer)
		end

	uideactivate is
			-- No description available.
		do
			ccom_uideactivate (initializer)
		end

	set_object_rects (lprc_pos_rect: TAG_RECT_RECORD; lprc_clip_rect: TAG_RECT_RECORD) is
			-- No description available.
			-- `lprc_pos_rect' [in].  
			-- `lprc_clip_rect' [in].  
		do
			ccom_set_object_rects (initializer, lprc_pos_rect.item, lprc_clip_rect.item)
		end

	reactivate_and_undo is
			-- No description available.
		do
			ccom_reactivate_and_undo (initializer)
		end

feature {NONE}  -- Implementation

	delete_wrapper is
			-- Delete wrapper
		do
			ccom_delete_iole_in_place_object_impl_proxy(initializer)
		end

feature {NONE}  -- Externals

	ccom_get_window (cpp_obj: POINTER; phwnd: CELL [POINTER]) is
			-- No description available.
		external
			"C++ [ecom_control_library::IOleInPlaceObject_impl_proxy %"ecom_control_library_IOleInPlaceObject_impl_proxy_s.h%"](EIF_OBJECT)"
		end

	ccom_context_sensitive_help (cpp_obj: POINTER; f_enter_mode: INTEGER) is
			-- No description available.
		external
			"C++ [ecom_control_library::IOleInPlaceObject_impl_proxy %"ecom_control_library_IOleInPlaceObject_impl_proxy_s.h%"](EIF_INTEGER)"
		end

	ccom_in_place_deactivate (cpp_obj: POINTER) is
			-- No description available.
		external
			"C++ [ecom_control_library::IOleInPlaceObject_impl_proxy %"ecom_control_library_IOleInPlaceObject_impl_proxy_s.h%"]()"
		end

	ccom_uideactivate (cpp_obj: POINTER) is
			-- No description available.
		external
			"C++ [ecom_control_library::IOleInPlaceObject_impl_proxy %"ecom_control_library_IOleInPlaceObject_impl_proxy_s.h%"]()"
		end

	ccom_set_object_rects (cpp_obj: POINTER; lprc_pos_rect: POINTER; lprc_clip_rect: POINTER) is
			-- No description available.
		external
			"C++ [ecom_control_library::IOleInPlaceObject_impl_proxy %"ecom_control_library_IOleInPlaceObject_impl_proxy_s.h%"](ecom_control_library::tagRECT *,ecom_control_library::tagRECT *)"
		end

	ccom_reactivate_and_undo (cpp_obj: POINTER) is
			-- No description available.
		external
			"C++ [ecom_control_library::IOleInPlaceObject_impl_proxy %"ecom_control_library_IOleInPlaceObject_impl_proxy_s.h%"]()"
		end

	ccom_delete_iole_in_place_object_impl_proxy (a_pointer: POINTER) is
			-- Release resource
		external
			"C++ [delete ecom_control_library::IOleInPlaceObject_impl_proxy %"ecom_control_library_IOleInPlaceObject_impl_proxy_s.h%"]()"
		end

	ccom_create_iole_in_place_object_impl_proxy_from_pointer (a_pointer: POINTER): POINTER is
			-- Create from pointer
		external
			"C++ [new ecom_control_library::IOleInPlaceObject_impl_proxy %"ecom_control_library_IOleInPlaceObject_impl_proxy_s.h%"](IUnknown *)"
		end

	ccom_item (cpp_obj: POINTER): POINTER is
			-- Item
		external
			"C++ [ecom_control_library::IOleInPlaceObject_impl_proxy %"ecom_control_library_IOleInPlaceObject_impl_proxy_s.h%"]():EIF_POINTER"
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




end -- IOLE_IN_PLACE_OBJECT_IMPL_PROXY

