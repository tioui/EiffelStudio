indexing
	description: "EiffelVision widget, mswindows implementation."
	note: "The parent of a widget cannot be void, except for a%
		%  window. Therefore, each feature that call the parent%
		%  here need to be redefine by EV_TITLED_WINDOW to check if%
		%  parent is `Void'"
	note: "The current class would be the equivalent of a wel_window%
		% Yet, it doesn't inherit from wel_window. Then, all the%
		% feature we used are defined as deferred. They will be%
		% implemented directly by the heirs thanks to inheritance%
		% from a heir of wel_window."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_WIDGET_IMP

inherit
	EV_WIDGET_I
		redefine
			interface
		end

	EV_SIZEABLE_IMP
		redefine
			interface
		end

	EV_EVENT_HANDLER_IMP

	EV_WIDGET_EVENTS_CONSTANTS_IMP

	EV_PICK_AND_DROPABLE_IMP
		redefine	
			interface
		end

	EV_WEL_KEY_CONVERSION
		rename
			Key_down as Key_down_arrow,
			Key_up as Key_up_arrow
		end

	WEL_WINDOWS_ROUTINES
		export
			{NONE} all
		end

	WEL_WORD_OPERATIONS
		export
			{NONE} all
		end

	WEL_BIT_OPERATIONS
		export
			{NONE} all
		end
	
	WEL_CONSTANTS
		export
			{NONE} all
		end

feature {NONE} -- Initialization

	initialize  is
			-- Initialize `Current'.
		local
			win: EV_WINDOW_IMP
		do
			initialize_sizeable
			set_default_colors
			set_default_minimum_size
			win ?= Current
			if win = Void then
				-- If `Current' is not a window.
				--| All widgets are shown as default except
				--| EV_WINDOW AND EV_TITLED_WINDOW.
				show
			end
			is_initialized := True
		end

feature -- Access

	pointer_position: EV_COORDINATES is
			-- Position of the screen pointer relative to `Current'.
		local
			wel_point: WEL_POINT
		do
			create wel_point.make (0, 0)
			wel_point.set_cursor_position
			create Result.set (wel_point.x - interface.screen_x, wel_point.y -
				interface.screen_y)
		end

	pointer_style: EV_CURSOR is
			-- Pointer displayed when the pointing device is over `Current'.
		do
			Result := cursor_pixmap
		end

	background_color: EV_COLOR is
			-- Color used for the background of `Current'.
		do
			if background_color_imp /= Void then
				Result ?= background_color_imp.interface
			else
				Result := Void
			end
		end

	foreground_color: EV_COLOR is
			-- Color used for the foreground of `Current'.
		do
			if foreground_color_imp /= Void then
				Result ?= foreground_color_imp.interface
			else
				Result := Void
			end
		end

	top_level_window: EV_WINDOW is
			-- Top level window that contains `Current'.
		do
			Result ?= top_level_window_imp.interface
		end

	default_parent: EV_INTERNAL_SILLY_WINDOW_IMP is
			-- A default parent for creation of `Current'.
		once
			create Result.make_top ("Eiffel Vision default parent window")
		ensure
			valid_parent: Result /= Void
		end

	focus_on_widget: CELL [EV_WIDGET_IMP] is
			-- Widget that has currently the focus.
		once
			create Result.put (Void)
		end

	cursor_on_widget: CELL [EV_WIDGET_IMP] is
			-- This cell contains the widget_imp that currently
			-- has the pointer of the mouse. As it is a once 
			-- feature, it is a shared data.
			-- it is used for the `mouse_enter' and `mouse_leave'
			-- events.
		once
			create Result.put (Void)
		ensure then
			result_exists: Result /= Void
		end

	notebook_parent: ARRAYED_LIST[EV_NOTEBOOK_IMP] is
			-- Search recursively for the ancestors of type notebook.
			-- Result = list of notebook ancestors.
			-- Result can be empty.
		do
			if parent_imp /=Void then
				Result := parent_imp.notebook_parent
			end
		end

	parent: EV_CONTAINER is
			-- Parent of `Current'
		local
			agg_cell: EV_AGGREGATE_CELL
		do
			if parent_imp /= Void then
				Result := parent_imp.interface
			end

			agg_cell ?= Result
			if agg_cell /= Void then
				Result := agg_cell.real_parent
				check
					real_parent_not_void: Result /= Void
				end
			end
		end

	wel_width: INTEGER is
		deferred
		end

	width: INTEGER is
			-- Width of `Current'.
		do
			--|FIXME During the major changes to vision
			--|This code was changed to wel_width.max (minimum_width)
			--|It has been changed back, but could possibly violate some
			--|Tight assertions
			--|See assertions on EV_WIDGET and EV_WIDGET_I
			--|Needs to be changed so the user can never return a minimum height
			--|Less than the height

			Result := wel_width.max (minimum_width)
		end

	wel_height: INTEGER is
		deferred
		end

	height: INTEGER is
			-- Height of `Current'.
		do
			--|FIXME During the major changes to vision
			--|This code was changed to wel_height.max (minimum_height)
			--|It has been changed back, but could possibly violate some
			--|Tight assertions
			--|See assertions on EV_WIDGET and EV_WIDGET_I
			--|Needs to be changed so the user can never return a minimum height
			--|Less than the height

			Result := wel_height.max (minimum_height)
		end

	screen_x: INTEGER is
			-- Horizontal offset of `Current' relative to screen
		local
			wind: EV_WINDOW_IMP
		do
			wind ?= Current
			if wind /= Void then
				Result := x_position + wind.frame_width + wind.border_width - 1
			elseif parent /= Void
				then Result := x_position + parent.screen_x
			end
		end

	screen_y: INTEGER is
			-- Vertical offset of `Current' relative to screen. 
		local 
			wind: EV_WINDOW_IMP
		do 
			wind ?= Current
			if wind /= Void then
				Result := y_position + wind.title_height + wind.frame_height + 1
			elseif parent /= Void then
				Result := y_position + parent.screen_y
			end
		end

feature -- Status report

	destroyed: BOOLEAN is
			-- Is `Current' destroyed ?
		do
			Result := not exists
		end

	is_show_requested: BOOLEAN is
			-- Is `Current' displayed in its parent?
		do
			Result := flag_set (style, Wel_window_constants.Ws_visible)
		end

	managed: BOOLEAN is true

feature -- Status setting

	destroy is
			-- Destroy `Current', but set the parent sensitive
			-- in case it was set insensitive by the child.
		do
			if parent_imp /= Void then
				parent_imp.interface.prune (Current.interface)
			end
			if exists then
				wel_destroy
			end
			is_destroyed := True
			destroy_just_called := True
		end

	show is
			-- Show `Current'.
			-- Need to notify the parent.
		do
			show_window (wel_item, Wel_window_constants.Sw_show)
			if parent_imp /= Void then
				parent_imp.notify_change (1 + 2, Current)
			end
		end

	hide is
			-- Hide `Current'.
		do
			show_window (wel_item, Wel_window_constants.Sw_hide)
			if parent_imp /= Void then
				parent_imp.notify_change (1 + 2, Current)
			end
		end

	disable_sensitive is
			-- Set `Current' to insensitive mode if
			-- `flag'. This means that any events with an
			-- event type of KeyPress, KeyRelease,
			-- ButtonPress, ButtonRelease, MotionNotify,
			-- EnterNotify, LeaveNotify, FocusIn or
			-- FocusOut will not be dispatched to current
			-- widget and to all its children.  Set it to
			-- sensitive mode otherwise.
		do
				disable
		end

	enable_sensitive is
			-- Set `Current' to sensitive mode.
			--| See comment for `disable_sensitive'.
		do
			enable
		end

	set_default_minimum_size is
			-- Initialize the size of `Current'.
			-- Redefined by many widgets.
		do
			internal_set_minimum_size (0, 0)
		end

feature -- Element change

	set_parent (par: EV_CONTAINER) is
			-- Make `par' the new parent of `Current'.
			-- `par' can be Void then the parent is the
			-- default_parent.
		deferred
		end

	set_background_color (color: EV_COLOR) is
			-- Make `color' the new `background_color'
		do
			background_color_imp ?= color.implementation
			if is_displayed then
				-- If the widget is not hidden then invalidate.
				invalidate
			end
		end

	set_foreground_color (color: EV_COLOR) is
			-- Make `color' the new `foreground_color'
		do
			foreground_color_imp ?= color.implementation
			if is_displayed then
				-- If the widget is not hidden then invalidate.
				invalidate
			end
		end

feature -- Implementation

	background_color_imp: EV_COLOR_IMP
			-- Color used for the background of `Current'.

	foreground_color_imp: EV_COLOR_IMP
			-- Color used for the foreground of `Current'
			-- usually the text.

	parent_imp: EV_CONTAINER_IMP is
			-- Parent container of `Current'.
		do
			if wel_parent = default_parent then
				Result := Void
			else
				Result ?= wel_parent
			end
		end

feature {NONE} -- Implementation, mouse button events

	on_left_button_down (keys, x_pos, y_pos: INTEGER) is
			-- Executed when the left button is pressed.
		local
			pt: WEL_POINT
		do
			pt := client_to_screen (x_pos, y_pos)
			pnd_press (x_pos, y_pos, 1, pt.x, pt.y)
			interface.pointer_button_press_actions.call ([x_pos, y_pos, 1, 0.0,
				0.0, 0.0, pt.x, pt.y])
		end

	on_middle_button_down (keys, x_pos, y_pos: INTEGER) is
			-- Executed when the middle button is pressed.
		local
			pt: WEL_POINT
		do
			pt := client_to_screen (x_pos, y_pos)
			pnd_press (x_pos, y_pos, 2, pt.x, pt.y)
			interface.pointer_button_press_actions.call ([x_pos, y_pos, 2, 0.0,
				 0.0, 0.0, pt.x, pt.y])
		end
	
	on_right_button_down (keys, x_pos, y_pos: INTEGER) is
			-- Executed when the right button is pressed.
		local
			pt: WEL_POINT
		do
			pt := client_to_screen (x_pos, y_pos)
			pnd_press (x_pos, y_pos, 3, pt.x, pt.y)
			interface.pointer_button_press_actions.call ([x_pos, y_pos, 3, 0.0,
				0.0, 0.0, pt.x, pt.y])
		end

	on_left_button_up (keys, x_pos, y_pos: INTEGER) is
			-- Executed when the left button is released.
		local
			pt: WEL_POINT
		do
			create pt.make (x_pos, y_pos)
			pt := client_to_screen (x_pos, y_pos)
			check_drag_and_drop_release (x_pos, y_pos)
			interface.pointer_button_release_actions.call ([x_pos, y_pos, 1,
				0.0, 0.0, 0.0, pt.x, pt.y])
		end

	on_middle_button_up (keys, x_pos, y_pos: INTEGER) is
			-- Executed when the middle button is released.
		local
			pt: WEL_POINT
		do
			create pt.make (x_pos, y_pos)
			pt := client_to_screen (x_pos, y_pos)
			interface.pointer_button_release_actions.call ([x_pos, y_pos, 2,
				0.0, 0.0, 0.0, pt.x, pt.y])
		end

	on_right_button_up (keys, x_pos, y_pos: INTEGER) is
			-- Executed when the right button is released.
		local
			pt: WEL_POINT
		do
			create pt.make (x_pos, y_pos)
			pt := client_to_screen (x_pos, y_pos)
			interface.pointer_button_release_actions.call ([x_pos, y_pos, 3,
				0.0, 0.0, 0.0, pt.x, pt.y])
		end

	on_left_button_double_click (keys, x_pos, y_pos: INTEGER) is
			-- Executed when the right button is double clicked.
		local
			pt: WEL_POINT
		do
			create pt.make (x_pos, y_pos)
			pt := client_to_screen (x_pos, y_pos)
			interface.pointer_double_press_actions.call ([x_pos, y_pos, 1, 0.0,
				0.0, 0.0, pt.x, pt.y])
		end

	on_middle_button_double_click (keys, x_pos, y_pos: INTEGER) is
			-- Executed when the right button is double clicked.
		local
			pt: WEL_POINT
		do
			create pt.make (x_pos, y_pos)
			pt := client_to_screen (x_pos, y_pos)
			interface.pointer_double_press_actions.call ([x_pos, y_pos, 2, 0.0,
				0.0, 0.0, pt.x, pt.y])
		end

	on_right_button_double_click (keys, x_pos, y_pos: INTEGER) is
			-- Executed when the right button is double clicked.
		local
			pt: WEL_POINT
		do
			create pt.make (x_pos, y_pos)
			pt := client_to_screen (x_pos, y_pos)
			interface.pointer_double_press_actions.call ([x_pos, y_pos, 3, 0.0,
				0.0, 0.0, pt.x, pt.y])
		end

feature {NONE} -- Implementation, mouse move, enter and leave events

	client_to_screen (a_x, a_y: INTEGER): WEL_POINT is
			-- `Result' is absolute screen coordinates in pixels
			-- of coordinates `a_x', a_y_' on `Current'.
		local
			ww: WEL_WINDOW
		do
			create Result.make (a_x, a_y)
			ww ?= Current
			check
				wel_window_not_void: ww/= Void
			end
			Result.client_to_screen (ww)
		end

	on_mouse_move (keys, x_pos, y_pos: INTEGER) is
			-- Executed when the mouse move.
		local
			pt: WEL_POINT
		do
			pt := client_to_screen (x_pos, y_pos)
			if (is_transport_enabled and mode_is_drag_and_drop) or
				mode_is_pick_and_drop then
				pnd_motion (x_pos, y_pos, pt.x, pt.y)
			end
			if cursor_on_widget.item /= Current then
				if cursor_on_widget.item /= Void then
					cursor_on_widget.item.on_mouse_leave
				end
				cursor_on_widget.replace (Current)
				on_mouse_enter
			end
			interface.pointer_motion_actions.call ([x_pos, y_pos, 0.0, 0.0,
				0.0, pt.x, pt.y])
		end

	on_mouse_enter is
			-- Called when the mouse enters `Current'.
		do
			interface.pointer_enter_actions.call ([])
		end

feature {EV_WIDGET_IMP} -- on_mouse_leave must be visible 

	on_mouse_leave is
			-- Called when the mouse leaves `Current'.
			--| If the mouse leaves `Current' and moves over a window which
			--| is not part of the application then this will not be called, as
			--| Windows will not send the appropriate message to this window.
			--| This is standard windows behaviour.
		do
			interface.pointer_leave_actions.call ([])
		end

feature {NONE} -- Implementation, key events

	on_key_down (virtual_key, key_data: INTEGER) is
			-- Executed when a key is pressed.
		local
			key: EV_KEY
		do
			if valid_wel_code (virtual_key) then
				create key.make_with_code (key_code_from_wel (virtual_key))
				interface.key_press_actions.call ([key])
			end
		end

	on_key_up (virtual_key, key_data: INTEGER) is
			-- Executed when a key is released.
		local
			key: EV_KEY
		do
			if valid_wel_code (virtual_key) then
				create key.make_with_code (key_code_from_wel (virtual_key))
				interface.key_release_actions.call ([key])
			end
		end

	on_key_string (character_code, key_data: INTEGER) is
			-- Executed when a key is pressed.
		local	
			character_string: STRING
		do
			create character_string.make(1)
			character_string.append_character(character_code.ascii_char)
			interface.key_press_string_actions.call ([character_string])
		end

feature {NONE} -- Implementation, focus event

	on_set_focus is
			-- Called when a `Wm_setfocus' message is recieved.
		local
			notebooks: ARRAY[EV_NOTEBOOK_IMP]
			counter: INTEGER
			env: EV_ENVIRONMENT
			app: EV_APPLICATION
			app_imp: EV_APPLICATION_IMP
		do
			create env
			app := env.application
			app_imp ?= app.implementation
			app_imp.set_window_with_focus (top_level_window)
				focus_on_widget.put (Current)
				interface.focus_in_actions.call ([])
				notebooks := notebook_parent
				if notebooks /= Void then
					from
						counter := 1
					until
						counter = notebooks.count + 1
					loop
						notebooks.item (counter).set_ex_style (
							Wel_window_constants.Ws_ex_controlparent
							)
						counter := counter + 1
					end
				end
		end

	on_kill_focus is
			-- Called when a `Wm_killfocus' message is recieved.
		local
			notebooks: ARRAY[EV_NOTEBOOK_IMP]
			counter: INTEGER
		do
			interface.focus_out_actions.call ([])
			notebooks := notebook_parent
			if notebooks /= Void then
				from
					counter :=1
				until
					counter = notebooks.count + 1
				loop
					notebooks.item (counter).set_ex_style (0)
					counter := counter + 1
				end
			end
		end

feature {NONE} -- Implementation, cursor of the widget

	on_set_cursor (hit_code: INTEGER) is
			-- Called when a `Wm_setcursor' message is recieved.
			-- See class WEL_HT_CONSTANTS for valid `hit_code' values.
		local
			wel_cursor: WEL_CURSOR
			cursor_imp: EV_PIXMAP_IMP_STATE
		do
			if cursor_pixmap /= Void then
				cursor_imp ?= cursor_pixmap.implementation
				wel_cursor := cursor_imp.cursor
				if wel_cursor = Void then	
					wel_cursor := cursor_imp.build_cursor
				end
				wel_cursor.set
				set_message_return_value (1)
				disable_default_processing
			end
		end

feature {WEL_DISPATCHER} -- Message dispatcher

	window_process_message (hwnd: POINTER; msg,
			wparam, lparam: INTEGER): INTEGER is
			-- Call the routine `on_*' corresponding to the
			-- message `msg'.
		require
			exists: exists
		do
			if msg = wel_window_constants.Wm_mousemove then
				on_mouse_move (wparam,
					mouse_message_x (lparam),
					mouse_message_y (lparam))
			elseif msg = wel_window_constants.Wm_setcursor then
				on_set_cursor (cwin_lo_word (lparam))
			elseif msg = wel_window_constants.Wm_size then
				on_size (wparam,
					cwin_lo_word (lparam),
					cwin_hi_word (lparam))
			elseif msg = wel_window_constants.Wm_move then
				on_move (cwin_lo_word (lparam),
					cwin_hi_word (lparam))
			elseif msg = wel_window_constants.Wm_lbuttondown then
				on_left_button_down (wparam,
					mouse_message_x (lparam),
					mouse_message_y (lparam))
			elseif msg = wel_window_constants.wm_lbuttonup then
				on_left_button_up (wparam,
					mouse_message_x (lparam),
					mouse_message_y (lparam))
			elseif msg = wel_window_constants.Wm_lbuttondblclk then
				on_left_button_double_click (wparam,
					mouse_message_x (lparam),
					mouse_message_y (lparam))
			elseif msg = wel_window_constants.Wm_mbuttondown then
				on_middle_button_down (wparam,
					mouse_message_x (lparam),
					mouse_message_y (lparam))
			elseif msg = wel_window_constants.Wm_mbuttonup then
				on_middle_button_up (wparam,
					mouse_message_x (lparam),
					mouse_message_y (lparam))
			elseif msg = wel_window_constants.Wm_mbuttondblclk then
				on_middle_button_double_click (wparam,
					mouse_message_x (lparam),
					mouse_message_y (lparam))
			elseif msg = wel_window_constants.Wm_rbuttondown then
				on_right_button_down (wparam,
					mouse_message_x (lparam),
					mouse_message_y (lparam))
			elseif msg = wel_window_constants.Wm_rbuttonup then
				on_right_button_up (wparam,
					mouse_message_x (lparam),
					mouse_message_y (lparam))
			elseif msg = wel_window_constants.Wm_rbuttondblclk then
				on_right_button_double_click (wparam,
					mouse_message_x (lparam),
					mouse_message_y (lparam))
			elseif msg = wel_window_constants.Wm_notify then
				on_wm_notify (wparam, lparam)
			elseif msg = wel_window_constants.Wm_timer then
				on_timer (wparam)
			elseif msg = wel_window_constants.Wm_setfocus then
				on_set_focus
			elseif msg = wel_window_constants.Wm_killfocus then
				on_kill_focus
			elseif msg = wel_window_constants.Wm_keydown then
				on_key_down (wparam, lparam)
			elseif msg = wel_window_constants.Wm_keyup then
				on_key_up (wparam, lparam)
			elseif msg = wel_window_constants.Wm_char then
				on_key_string (wparam, lparam)
			elseif msg = wel_window_constants.Wm_showwindow then
				on_wm_show_window (wparam, lparam)
			elseif msg = wel_window_constants.Wm_destroy then
				on_wm_destroy
			else
				default_process_message (msg, wparam, lparam)
			end
		end

feature {NONE} -- Implementation, pick and drop

	widget_source: EV_WIDGET_IMP is
			-- Widget drag source used for transport.
		do
			Result := Current
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_WIDGET

feature -- Deferred features

	is_control_in_window (hwnd_control: POINTER): BOOLEAN is
			-- Is the control of handle `hwnd_control'
			-- located inside the current window?
		deferred
		end

	set_top_level_window_imp (a_window: EV_WINDOW_IMP) is
			-- Make `a_window' the new `top_level_window_imp'
			-- of `Current'.
		deferred
		end

	exists: BOOLEAN is
			-- Does the window exist?
		deferred
		end

	disable is
			-- Disable mouse and keyboard input
		deferred
		end

	enable is
			-- Enable mouse and keyboard input.
		deferred
		end

	on_size (size_type, a_width, a_height: INTEGER) is
			-- `Current' has been resized.
		do
			interface.resize_actions.call (
				[screen_x, screen_y, a_width, a_height]
			)
		end

	on_move (x_pos, y_pos: INTEGER) is
			-- Wm_move message.
		deferred
		end

	on_wm_show_window (wparam, lparam: INTEGER) is
			-- Wm_showwindow message
		deferred
		end

	on_wm_notify (wparam, lparam: INTEGER) is
			-- Wm_notify message
		deferred
		end

	on_wm_destroy is
			-- Wm_destroy message.
			-- The window must be unregistered
		deferred
		end

	on_timer (timer_id: INTEGER) is
			-- Wm_timer message.
		deferred
		end

	default_process_message (msg, wparam, lparam: INTEGER) is
			-- Process `msg' which has not been processed by
			-- `process_message'.
		deferred
		end

	wel_parent: WEL_WINDOW is
			-- The wel parent of `Current'.
		deferred
		end

	wel_set_parent (a_parent: WEL_WINDOW) is
			-- Set the wel parent of `Current'.
		deferred
		end

	default_style: INTEGER is
			-- Default style of `Current'.
		deferred
		end

	style: INTEGER is
			-- Current style of `Current'
		deferred
		end

	set_style (a_style: INTEGER) is
			-- Assign `a_Style' to `style' of `Current'.
		deferred
		end

	client_rect: WEL_RECT is
			-- Area used by `Current'.
		deferred
		end

	invalidate is
			-- Cause `Current' to re-draw.
		deferred
		end

	wel_destroy is
		deferred
		end	

	disable_default_processing is
		deferred
		end

	set_message_return_value (v: INTEGER) is
		deferred
		end

	wel_item: POINTER is
		deferred
		end

feature {NONE} -- Feature that should be directly implemented by externals

	mouse_message_x (lparam: INTEGER): INTEGER is
			-- Encapsulation of the c_mouse_message_x function of
			-- WEL_WINDOW. Normaly, we should be able to have directly
			-- c_mouse_message_x deferred but it does not wotk because
			-- it would be implemented by an external.
		deferred
		end

	mouse_message_y (lparam: INTEGER): INTEGER is
			-- Encapsulation of the c_mouse_message_x function of
			-- WEL_WINDOW. Normaly, we should be able to have directly
			-- c_mouse_message_x deferred but it does not wotk because
			-- it would be implemented by an external.
		deferred
		end

feature -- Feature that should be directly implemented by externals

	show_window (hwnd: POINTER; cmd_show: INTEGER) is
			-- Encapsulation of the cwin_show_window function of
			-- WEL_WINDOW. Normaly, we should be able to have directly
			-- c_mouse_message_x deferred but it does not wotk because
			-- it would be implemented by an external.
		deferred
		end

end -- class EV_WIDGET_IMP

--|-----------------------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|-----------------------------------------------------------------------------

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.76  2000/06/07 17:27:58  oconnor
--| merged from DEVEL tag MERGED_TO_TRUNK_20000607
--|
--| Revision 1.75  2000/05/12 19:28:33  pichery
--| Protected `wel_destroy' with test on `exists'
--|
--| Revision 1.74  2000/05/03 20:13:24  brendel
--|
--| Revision 1.49.4.16  2000/06/05 21:08:03  manus
--| Updated call to `notify_parent' because it requires now an extra parameter which is
--| tells the parent which children did request the change. Usefull in case of NOTEBOOK
--| for performance reasons (See EV_NOTEBOOK_IMP log for more details)
--|
--| Revision 1.49.4.15  2000/05/30 16:46:53  rogers
--| Removed debugging io.putstrings from on_key_up and on_key_down.
--|
--| Revision 1.49.4.14  2000/05/30 16:20:33  rogers
--| Removed unreferenced local variables.
--|
--| Revision 1.49.4.13  2000/05/22 18:58:41  rogers
--| changed top_level_window: EV_TITLED_WINDOW to EV_WINDOW to fix bug in
--| creation of EV_WINDOW with the setting of the focus to that window.
--|
--| Revision 1.49.4.12  2000/05/20 00:25:03  rogers
--| Removed debuggging io.putstrings.
--|
--| Revision 1.49.4.10  2000/05/15 21:59:51  rogers
--| On_mouse_move now only calls pnd_motion if the transport is enabled
--| unless `Current' has drag and drop.
--|
--| Revision 1.49.4.9  2000/05/10 23:10:01  king
--| Integrated tooltipable changes
--|
--| Revision 1.49.4.8  2000/05/09 18:40:03  brendel
--| Whoops! Once again, we need HEIGHT->INTEGER and WIDTH->INTEGER!!!
--|
--| Revision 1.49.4.7  2000/05/08 22:13:17  brendel
--| Changed width and height again while waiting for a size specification.
--|
--| Revision 1.49.4.6  2000/05/05 22:30:39  pichery
--| Removed useless comment
--|
--| Revision 1.49.4.5  2000/05/04 17:34:07  brendel
--| Changed `width' and `height' back. Size can be less than minimum size.
--|
--| Revision 1.49.4.4  2000/05/04 04:25:39  pichery
--| Adaptation to the new EV_CURSOR class.
--|
--| Revision 1.49.4.3  2000/05/03 22:35:01  brendel
--| Fixed resize_actions.
--|
--| Revision 1.73  2000/05/03 16:57:04  rogers
--| Comments, formatting.
--|
--| Revision 1.72  2000/05/03 00:32:40  pichery
--| Changed constants retrieval
--|
--| Revision 1.71  2000/05/01 23:28:47  rogers
--| Implemented pointer_position.
--|
--| Revision 1.70  2000/05/01 19:33:59  pichery
--| Added feature `is_control_in_window' used
--| to determine if a certain control is contained
--| inside the current window.
--|
--| Revision 1.69  2000/04/29 03:21:26  pichery
--| Removed Constants from inheritance
--|
--| Revision 1.68  2000/04/27 16:33:08  rogers
--| On_left_button_up now calls check_drag_and_drop_release which
--| will end current drag and drop if underway.
--|
--| Revision 1.67  2000/04/14 20:54:20  brendel
--| Removed on_parented and on_orphaned.
--|
--| Revision 1.66  2000/04/10 17:04:19  rogers
--| Commented client to screen.
--|
--| Revision 1.65  2000/04/03 17:52:25  rogers
--| Fixed initialize so windows are no longer shown as default.
--|
--| Revision 1.64  2000/03/29 01:18:30  brendel
--| Improved `parent'.
--|
--| Revision 1.63  2000/03/23 23:23:41  brendel
--| Renamed on_contained to on_parented.
--| Added on_orphaned.
--|
--| Revision 1.62  2000/03/23 01:14:28  brendel
--| Widget is now only shown by default if it is not of type EV_TITLED_WINDOW
--| Removed obsolete accelerator code.
--| Cleaned up key event code.
--|
--| Revision 1.61  2000/03/21 02:29:07  brendel
--| Replaced unnecessary assignment attempt with assignment.
--|
--| Revision 1.60  2000/03/20 23:23:23  pichery
--| - Added `on_contained' notion. A widget is now notified when it is put
--|   in a container (usefull for pixmap)
--|
--| Revision 1.59  2000/03/17 23:24:49  brendel
--| Implemented recently changed key event to take EV_KEY.
--|
--| Revision 1.58  2000/03/17 23:02:51  rogers
--| Removed set_pointer_style and cursor_imp. They are now in
--| EV_PICK_AND_DROPABLE.
--|
--| Revision 1.57  2000/03/17 18:20:31  rogers
--| Implemented screen_x and screen_y as they are now deferred from EV_WIDGET_I.
--| Removed set_vertical_resize, set_horizontal_resize.
--|
--| Revision 1.56  2000/03/14 20:02:36  brendel
--| Rearranged initialization.
--|
--| Revision 1.55  2000/03/14 18:45:10  rogers
--| Uncommented pnd_press in on_right_button_down.
--|
--| Revision 1.54  2000/03/14 03:02:54  brendel
--| Merged changed from WINDOWS_RESIZING_BRANCH.
--|
--| Revision 1.53  2000/03/09 21:10:05  rogers
--| All calls to interface.pointer.button_***_actions are passes 0.0 instead of 
--| 0.
--|
--| Revision 1.52.2.2  2000/03/09 21:39:47  brendel
--| Replaced x with x_position and y with y_position.
--| Before, both were available.
--|
--| Revision 1.52.2.1  2000/03/09 17:53:04  brendel
--| Removed inheritance of EV_SIZEABLE_IMP.
--|
--| Revision 1.52  2000/02/19 06:34:13  oconnor
--| removed old command stuff
--|
--| Revision 1.51  2000/02/19 05:45:00  oconnor
--| released
--|
--| Revision 1.50  2000/02/14 11:40:42  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.49.6.17  2000/02/09 01:23:59  pichery
--| - implemented key_press_string_actions for Windows platforms
--|
--| Revision 1.49.6.16  2000/02/07 20:44:25  rogers
--| Removed old command association which is redundent now.
--|
--| Revision 1.49.6.15  2000/02/06 22:10:44  brendel
--| Changed 0 to 0.0 in call to action sequence where doubles where expected
--| instead of integers. (Fails on `valid_operands').
--|
--| Revision 1.49.6.14  2000/02/06 21:21:05  brendel
--| Fixed bug in call to pointer_motion_actions, where the 3rd, 4th and 5th
--| argument were integers instead of reals.
--|
--| Revision 1.49.6.13  2000/02/04 19:09:21  rogers
--| Replaced all references to displayed with is_displayed.
--|
--| Revision 1.49.6.12  2000/01/29 01:14:01  brendel
--| Added not yet implemented tootip features.
--|
--| Revision 1.49.6.11  2000/01/29 01:00:46  brendel
--| Changed removing of Current from parent when destroyed.
--|
--| Revision 1.49.6.10  2000/01/27 19:30:17  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.49.6.9  2000/01/26 20:00:43  brendel
--| Merged versions 1.49.1.6 and 1.49.1.8.
--|
--| Revision 1.49.6.6  2000/01/25 17:37:51  brendel
--| Removed code associated with old events.
--| Implementation and more removal is needed.
--|
--| Revision 1.49.6.5  2000/01/21 23:17:01  brendel
--| Removed deferred features set_capture and release_capture.
--|
--| Revision 1.49.6.4  2000/01/19 23:49:02  rogers
--| Added show to initialize, and added managed which means that all widgets
--| are automatically managed by their parents.
--|
--| Revision 1.49.6.3  1999/12/22 17:54:15  rogers
--| Implemented most of the mouse actions to use the new events.
--|
--| Revision 1.49.6.2  1999/12/17 01:00:56  rogers
--| Altered to fit in with the review branch. No inherits
--| EV_PICK_AND_DROPABLE instead of the two old pick and drop classe.
--| is_show_requested replaces shown.
--|
--| Revision 1.49.6.1  1999/11/24 17:30:23  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.49.2.3  1999/11/02 17:20:08  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
