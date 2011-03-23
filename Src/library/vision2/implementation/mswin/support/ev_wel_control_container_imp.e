note
	description:
		"A common class for the heirs of the WEL_CONTROL_WINDOW."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_WEL_CONTROL_CONTAINER_IMP

inherit

	WEL_CONTROL_WINDOW
		rename
			make as wel_make,
			parent as wel_parent,
			set_parent as wel_set_parent,
			shown as is_displayed,
			destroy as wel_destroy,
			item as wel_item,
			enabled as is_sensitive,
			width as wel_width,
			height as wel_height,
			resize as wel_resize,
			move as wel_move,
			move_and_resize as wel_move_and_resize,
			x as x_position,
			y as y_position,
			text as wel_text,
			set_text as wel_set_text,
			has_capture as wel_has_capture
		undefine
			set_width,
			set_height,
			on_left_button_down,
			on_middle_button_down,
			on_right_button_down,
			on_left_button_up,
			on_middle_button_up,
			on_right_button_up,
			on_left_button_double_click,
			on_middle_button_double_click,
			on_right_button_double_click,
			on_mouse_move,
			on_mouse_wheel,
			on_key_down,
			on_key_up,
			on_set_focus,
			on_kill_focus,
			on_desactivate,
			on_set_cursor,
			on_draw_item,
			background_brush,
			on_color_control,
 			on_wm_vscroll,
 			on_wm_hscroll,
			on_char,
			show,
			hide,
			on_destroy,
			on_size,
			x_position,
			y_position,
			on_notify,
			on_sys_key_down,
			on_sys_key_up,
			default_process_message
		redefine
			default_style,
			default_ex_style,
			class_name,
			class_style,
			on_erase_background,
			on_window_pos_changing,
			on_window_pos_changed
		end

feature {NONE} -- Initialization

	make
			-- Create `Current' with `default_parent'.
		do
			wel_make (default_parent, "")
		end

feature {NONE} -- Implementation

	top_level_window_imp: detachable WEL_WINDOW
			-- Top level window that contains `Current'.

feature {NONE} -- WEL Implementation

	class_style: INTEGER
			-- Standard style used to create the window class.
			-- Can be redefined to return a user-defined style.
		once
			Result := Cs_dblclks
		end

	default_style: INTEGER
			-- Default style used by windows at creation.
		do
			Result := Ws_child | Ws_clipchildren | ws_clipsiblings | Ws_visible
		end

	default_ex_style: INTEGER
			-- Extended style used by windows at creation.
		do
			Result := Ws_ex_controlparent
		end

	class_name: STRING_32
			-- Window class name to create.
		do
			Result := generator
		end

	application_imp: EV_APPLICATION_IMP
			-- Access to the current application
		deferred
		end

	on_erase_background (paint_dc: WEL_PAINT_DC; invalid_rect: WEL_RECT)
			-- Wm_erasebkgnd message.
			-- May be redefined to paint something on
			-- the `paint_dc'. `invalid_rect' defines
			-- the invalid rectangle of the client area that
			-- needs to be repainted.
		local
			bk_brush: detachable WEL_BRUSH
			theme_drawer: EV_THEME_DRAWER_IMP
		do
			bk_brush := background_brush
			check bk_brush /= Void end
			theme_drawer := application_imp.theme_drawer
			theme_drawer.draw_widget_background (current_as_container, paint_dc, invalid_rect, bk_brush)
			disable_default_processing
			set_message_return_value (to_lresult (1))
			bk_brush.delete
		end

	is_resized_width_larger: BOOLEAN
			-- Is current resizing making current larger in width?
		do
			Result := (ev_resizing_flags & ev_resizing_width_larger_flag) /= 0
		end

	is_resized_height_larger: BOOLEAN
			-- Is current resizing making current larger in height?	
		do
			Result := (ev_resizing_flags & ev_resizing_height_larger_flag) /= 0
		end

	ev_resizing_flags: NATURAL_8
	ev_resizing_width_larger_flag: NATURAL_8 = 0x1
	ev_resizing_height_larger_flag: NATURAL_8 = 0x2
		-- Used by on_window_pos_changing to determine if the move and resize handling needs to be propagated.

	on_window_pos_changing (a_wp: WEL_WINDOW_POS)
			-- <Precursor>
		local
			l_rect: WEL_RECT
			l_flags: like ev_resizing_flags
		do
				-- Reset move and resize flags
			l_rect := client_rect
			if a_wp.width > l_rect.width then
				l_flags := ev_resizing_width_larger_flag
			end
			if a_wp.height > l_rect.height then
				l_flags := l_flags | ev_resizing_height_larger_flag
			end
			ev_resizing_flags := l_flags
				-- Disabling the default processing also returns `0' to Windows.
			disable_default_processing
		end

	on_window_pos_changed (a_wp: WEL_WINDOW_POS)
			-- <Precursor>
		local
			l_width, l_height: INTEGER
		do
				-- We don't need to handle `on_move' as descendents do not use it.
			if (a_wp.flags & swp_nosize) = 0 then
				l_width := a_wp.width
				l_height := a_wp.height
				a_wp.set_item (default_pointer)
				on_size (0, l_width, l_height)
			end
			ev_resizing_flags := 0
				-- Disabling the default processing also returns `0' to Windows.
			disable_default_processing
				-- To let the caller know that we have received the message
			internal_wm_size_called := True
		end

	current_as_container: EV_CONTAINER_IMP
			-- Result is `Current' as a container.
		local
			l_result: detachable EV_CONTAINER_IMP
		do
			l_result ?= Current
			check l_result /= Void end
			Result := l_result
		end

feature {NONE} -- Deferred features

	default_parent: WEL_FRAME_WINDOW
			-- Parent of `Current' when a parent is required and has not
			-- been specified.
		deferred
		end

feature {NONE} -- Features that should be directly implemented by externals.

	get_wm_hscroll_code (wparam, lparam: POINTER): INTEGER
			-- Encapsulation of the external cwin_get_wm_hscroll_code.
		do
			Result := cwin_get_wm_hscroll_code (wparam, lparam)
		end

	get_wm_hscroll_hwnd (wparam, lparam: POINTER): POINTER
			-- Encapsulation of the external cwin_get_wm_hscroll_hwnd
		do
			Result := cwin_get_wm_hscroll_hwnd (wparam, lparam)
		end

	get_wm_hscroll_pos (wparam, lparam: POINTER): INTEGER
			-- Encapsulation of the external cwin_get_wm_hscroll_pos
		do
			Result := cwin_get_wm_hscroll_pos (wparam, lparam)
		end

	get_wm_vscroll_code (wparam, lparam: POINTER): INTEGER
			-- Encapsulation of the external cwin_get_wm_vscroll_code.
		do
			Result := cwin_get_wm_vscroll_code (wparam, lparam)
		end

	get_wm_vscroll_hwnd (wparam, lparam: POINTER): POINTER
			-- Encapsulation of the external cwin_get_wm_vscroll_hwnd
		do
			Result := cwin_get_wm_vscroll_hwnd (wparam, lparam)
		end

	get_wm_vscroll_pos (wparam, lparam: POINTER): INTEGER
			-- Encapsulation of the external cwin_get_wm_vscroll_pos
		do
			Result := cwin_get_wm_vscroll_pos (wparam, lparam)
		end

	cwin_get_next_dlgtabitem (hdlg, hctl: POINTER; previous: BOOLEAN): POINTER
			-- SDK GetNextDlgGroupItem
		external
			"C [macro <wel.h>] (HWND, HWND, BOOL): HWND"
		alias
			"GetNextDlgTabItem"
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




end -- class EV_WEL_CONTROL_CONTAINER_IMP











