indexing
	description: "Window which can be used to design custom control."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_CONTROL_WINDOW

inherit
	WEL_FRAME_WINDOW
		rename
			make_child as make
		redefine
			move_and_resize,
			move,
			minimal_width,
			minimal_height,
			default_style,
			class_name,
			class_background			
		end

creation
	make,
	make_with_coordinates

feature {NONE} -- Intialization

	make_with_coordinates (a_parent: WEL_COMPOSITE_WINDOW; a_name: STRING;
			a_x, a_y, a_width, a_height: INTEGER) is
			-- Make a control using `a_parent' as parent and
			-- `a_name' as name. `a_x', `a_y', `a_width', and
			-- `a_height' are used to place and size the control
			-- at the creation.
		require
			a_parent_not_void: a_parent /= Void
			a_parent_exists: a_parent.exists
			a_name_not_void: a_name /= Void
			a_width_small_enough: a_width <= maximal_width
			a_width_large_enough: a_width >= minimal_width
			a_height_small_enough: a_height <= maximal_height
			a_height_large_enough: a_height >= minimal_height
		do
			register_class
			internal_window_make (a_parent, a_name, default_style,
				a_x, a_y, a_width, a_height, default_id,
				default_pointer)
		ensure
			parent_set: parent = a_parent
			x_set: x = a_x
			y_set: y = a_y
			width_set: width = a_width
			height_set: height = a_height
		end

feature -- Status report

	minimal_width: INTEGER is
			-- Minimal width allowed for the window
		do
			Result := 0
		end

	minimal_height: INTEGER is
			-- Minimal height allowed for the window
		do
			Result := 0
		end

feature -- Basic operations

	move_and_resize (a_x, a_y, a_width, a_height: INTEGER; repaint: BOOLEAN) is
			-- Move the window to `a_x', `a_y' position and
			-- resize it with `a_width', `a_height'.
		do
			cwin_move_window (item, a_x, a_y, a_width, a_height,
				repaint)
		end

	move (a_x, a_y: INTEGER) is
			-- Move the window to `a_x', `a_y' position.
		do
			cwin_set_window_pos (item, default_pointer,
				a_x, a_y, 0, 0,
				Swp_nosize + Swp_nozorder + Swp_noactivate)
		end

feature {NONE} -- Implementation

	default_style: INTEGER is
			-- Child and visible style
		once
			Result := Ws_child + Ws_visible
		end

	class_background: WEL_BRUSH is
			-- Standard window background color
		once
			!! Result.make_by_sys_color (Color_window + 1)
		end

	class_name: STRING is
			-- Window class name to create
		once
			Result := "WELControlWindowClass"
		end

end -- class WEL_CONTROL_WINDOW

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
