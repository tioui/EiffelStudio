indexing
	description: "An overlapped window with a frame."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_FRAME_WINDOW

inherit
	WEL_COMPOSITE_WINDOW

	WEL_WS_CONSTANTS
		export
			{NONE} all
		end

	WEL_CS_CONSTANTS
		export
			{NONE} all
		end

	WEL_IDI_CONSTANTS
		export
			{NONE} all
		end

	WEL_IDC_CONSTANTS
		export
			{NONE} all
		end

	WEL_COLOR_CONSTANTS
		export
			{NONE} all
		end

creation
	make_child, make_top

feature {NONE} -- Initialization

	make_child (a_parent: WEL_COMPOSITE_WINDOW; a_name: STRING) is
			-- Make the window as a child of `a_parent' and
			-- `a_name' as a title.
		require
			a_parent_not_void: a_parent /= Void
			a_parent_exists: a_parent.exists
			a_name_not_void: a_name /= Void
		do
			register_class
			internal_window_make (a_parent, a_name,
				default_style,
				default_x, default_y,
				default_width, default_height,
				default_id, default_pointer)
		ensure
			parent_set: parent = a_parent
			exists: exists
			name_set: text.is_equal (a_name)
		end

	make_top (a_name: STRING) is
			-- Make a top window (without parent) with `a_name'
			-- as a title.
		require
			a_name_not_void: a_name /= Void
		do
			register_class
			internal_window_make (Void, a_name,
				default_style,
				default_x, default_y,
				default_width, default_height,
				default_id, default_pointer)
		ensure
			parent_set: parent = Void
			exists: exists
			name_set: text.is_equal (a_name)
		end

feature {NONE} -- Default creation values

	default_style: INTEGER is
			-- Overlapped window style.
			-- By default, a frame window is not visible
			-- at the creation time. `show' needs to be called.
			-- This solution avoids a bad visual effect when
			-- the children are created one by one inside
			-- the window.
		once
			Result := Ws_overlappedwindow
		end

	default_x, default_y, default_width, default_height: INTEGER is
			-- Default position and dimension
		once
			Result := Cw_usedefault
		end

	default_id: INTEGER is
			-- No id
		once
			Result := 0
		end

feature {NONE} -- Standard window class values

	class_icon: WEL_ICON is
			-- Standard application icon
		once
			!! Result.make_by_predefined_id (Idi_application)
		ensure
			result_not_void: Result /= Void
			result_exists: Result.exists
		end

	class_cursor: WEL_CURSOR is
			-- Standard arrow cursor
		once
			!! Result.make_by_predefined_id (Idc_arrow)
		ensure
			result_not_void: Result /= Void
			result_exists: Result.exists
		end

	class_background: WEL_BRUSH is
			-- Standard window background color
		once
			!! Result.make_by_sys_color (Color_window + 1)
		ensure
			result_not_void: Result /= Void
			result_exists: Result.exists
		end

	class_style: INTEGER is
			-- Standard style
		once
			Result := Cs_hredraw + Cs_vredraw + Cs_dblclks
		end

	class_menu_name: STRING is
			-- No menu
		once
			!! Result.make (0)
		ensure
			result_not_void: Result /= Void
		end

	class_window_procedure: POINTER is
			-- Standard window procedure
		once
			Result := cwel_window_procedure_address
		ensure
			result_not_null: Result /= default_pointer
		end

feature {NONE} -- Implementation

	class_name: STRING is
			-- Window class name to create
		once
			Result := "WELFrameWindowClass"
		end

	register_class is
			-- Register the window class if
			-- the class is not already registered.
			-- The routines `class_style', `class_window_procedure',
			-- `class_icon', `class_cursor', `class_background', and
			-- `class_menu_name' are called before the registration
			-- to set all the window class information.
		local
			wnd_class: WEL_WND_CLASS
		do
			!! wnd_class.make (class_name)
			if not wnd_class.is_registered then
				wnd_class.set_style (class_style)
				wnd_class.set_window_procedure (class_window_procedure)
				wnd_class.set_icon (class_icon)
				wnd_class.set_cursor (class_cursor)
				wnd_class.set_background (class_background)
				wnd_class.set_menu_name (class_menu_name)
				wnd_class.register
			end
		end

end -- class FRAME_WINDOW

--|-------------------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1995, Interactive Software Engineering, Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Information e-mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|-------------------------------------------------------------------------
