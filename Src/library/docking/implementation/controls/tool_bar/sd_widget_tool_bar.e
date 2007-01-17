indexing
	description: "[
					Tool bar that support SD_TOOL_BAR_WIDGET_ITEM.
					A decorator for SD_TOOL_BAR.
																	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_WIDGET_TOOL_BAR

inherit
	SD_TOOL_BAR
		rename
			make as make_tool_bar,
			implementation as implementation_not_use
		undefine
			create_implementation,
			is_in_default_state,
			is_equal
		redefine
			set_row_height,
			row_height,
			extend,
			force,
			prune,
			compute_minmum_size,
			wipe_out,
			items,
			has,
			item_x,
			item_y,
			update,
			is_row_height_set,
			is_row_height_valid,
			is_parent_set,
			is_start_x_set,
			is_start_y_set,
			enable_capture,
			disable_capture,
			has_capture,
			pointer_motion_actions,
			pointer_button_release_actions,
			pointer_button_press_actions,
			pointer_double_press_actions,
			expose_actions,
			draw_pixmap,
			clear_rectangle,
			redraw_rectangle,
			set_start_x,
			set_start_y,
			start_x,
			start_y,
			redraw_item,
			is_displayed
		end

	EV_FIXED
		rename
			extend as extend_fixed,
			wipe_out as wipe_out_fixed,
			has as has_fixed,
			prune as prune_fixed,
			force as force_fixed
		export
			{NONE} all
			{ANY} is_destroyed
		undefine
			enable_capture,
			disable_capture,
			has_capture,
			pointer_motion_actions,
			pointer_button_release_actions,
			pointer_button_press_actions,
			pointer_double_press_actions,
			is_displayed
		select
			implementation
		end

create
	make

feature {NONE} -- Initlization

	make (a_tool_bar: SD_TOOL_BAR) is
			-- Creation method.
		require
			not_void: a_tool_bar /= Void
		do
			default_create
			tool_bar := a_tool_bar

			extend_fixed (tool_bar)

			tool_bar.expose_actions.extend (agent on_tool_bar_expose_actions)
		ensure
			set: tool_bar = a_tool_bar
		end

feature -- Properties

	set_row_height (a_height: INTEGER) is
			-- Set height of row.
		do
			tool_bar.set_row_height (a_height)
		end

	row_height: INTEGER is
			--  Height of row.
		do
			Result := tool_bar.row_height
		end

feature -- Command

	extend (a_item: SD_TOOL_BAR_ITEM) is
			-- Extend `a_item'.
		local
			l_widget_item: SD_TOOL_BAR_WIDGET_ITEM
		do
			tool_bar.extend (a_item)
			l_widget_item ?= a_item
			if l_widget_item /= Void then
				extend_fixed (l_widget_item.widget)
				set_item_size (l_widget_item.widget, l_widget_item.widget.minimum_width, l_widget_item.widget.minimum_height)
			end
		end

	force (a_item: SD_TOOL_BAR_ITEM; a_index: INTEGER) is
			-- Extend `a_item' at `a_index'
		local
			l_widget_item: SD_TOOL_BAR_WIDGET_ITEM
		do
			tool_bar.force (a_item, a_index)
			l_widget_item ?= a_item
			if l_widget_item /= Void then
				extend_fixed (l_widget_item.widget)
				set_item_size (l_widget_item.widget, l_widget_item.widget.minimum_width, l_widget_item.widget.minimum_height)
			end
		end

	prune (a_item: SD_TOOL_BAR_ITEM) is
			-- Prune `a_item'
		local
			l_widget_item: SD_TOOL_BAR_WIDGET_ITEM
		do
			tool_bar.prune (a_item)
			l_widget_item ?= a_item
			if l_widget_item /= Void then
				prune_fixed (l_widget_item.widget)
			end
		end

	compute_minmum_size is
			-- Compute minimum size.
		do
			tool_bar.compute_minmum_size
			check has: has_fixed (tool_bar) end
			set_minimum_size (tool_bar.minimum_width, tool_bar.minimum_height)
			set_item_size (tool_bar, minimum_width, minimum_height)
		end

	wipe_out is
			-- Wipe out.
		do
			tool_bar.wipe_out
		end

	enable_capture is
			-- Enable capture.
		do
			tool_bar.enable_capture
		end

	disable_capture is
			-- Disable capture.
		do
			tool_bar.disable_capture
		end

feature -- Query

	items: ARRAYED_SET [SD_TOOL_BAR_ITEM] is
			-- All items in Current.
		do
			Result := tool_bar.items
		end

	has (a_item: SD_TOOL_BAR_ITEM): BOOLEAN is
			-- If Current has `a_item'?
		do
			Result := tool_bar.has (a_item)
		end

	pointer_motion_actions: EV_POINTER_MOTION_ACTION_SEQUENCE	is
			-- Pointer motion actions.
		do
			Result := tool_bar.pointer_motion_actions
		end

	pointer_button_release_actions: EV_POINTER_BUTTON_ACTION_SEQUENCE is
			-- Pointer button release actions.
		do
			Result := tool_bar.pointer_button_release_actions
		end

	pointer_button_press_actions: EV_POINTER_BUTTON_ACTION_SEQUENCE is
			-- Pointer button press actions.
		do
			Result := tool_bar.pointer_button_press_actions
		end

	pointer_double_press_actions: EV_POINTER_BUTTON_ACTION_SEQUENCE is
			-- Pointer button double press actions.
		do
			Result := tool_bar.pointer_double_press_actions
		end

	expose_actions: EV_GEOMETRY_ACTION_SEQUENCE is
			-- Expose actions.
		do
			Result := tool_bar.expose_actions
		end

feature {SD_TOOL_BAR_DRAWER_I, SD_TOOL_BAR_ZONE}

	draw_pixmap (a_x, a_y: INTEGER; a_pixmap: EV_PIXMAP) is
			-- Draw `a_pixmap' at `a_x', `a_y'.
		do
			tool_bar.draw_pixmap (a_x, a_y, a_pixmap)
		end

	clear_rectangle (a_x, a_y, a_width, a_height: INTEGER) is
			-- Clear rectangle area.
		do
			tool_bar.clear_rectangle (a_x, a_y, a_width, a_height)
		end

	redraw_rectangle (a_x, a_y, a_width, a_height: INTEGER) is
			-- Redraw rectangle area.
		do
			tool_bar.redraw_rectangle (a_x, a_y, a_width, a_height)
		end

feature -- Contract support

	is_row_height_set (a_new_height: INTEGER): BOOLEAN is
			-- If `a_new_height' equal `row_height'?
		do
			Result := tool_bar.row_height = a_new_height
		end

	is_row_height_valid (a_height: INTEGER): BOOLEAN is
			-- If `a_height' equal `row_height'?
		do
			Result := tool_bar.row_height = a_height
		end

	is_parent_set (a_item: SD_TOOL_BAR_ITEM): BOOLEAN is
			-- If `a_item' parent equal `tool_bar'?
		do
			Result := a_item.tool_bar = tool_bar
		end

	is_start_x_set (a_x: INTEGER): BOOLEAN is
			-- If `a_x' equal `start_x' of `tool_bar'?
		do
			Result := tool_bar.is_start_x_set (a_x)
		end

	is_start_y_set (a_y: INTEGER): BOOLEAN is
			-- If `a_y' equal `start_y' of `tool_bar'?
		do
			Result := tool_bar.is_start_y_set (a_y)
		end

	is_displayed: BOOLEAN is
			-- If Current displayed?
		do
			Result := tool_bar.is_displayed
		end

	has_capture: BOOLEAN is
			-- If Current has capture?
		do
			Result := tool_bar.has_capture
		end

feature {SD_TOOL_BAR_DRAWER_IMP, SD_TOOL_BAR_ITEM, SD_TOOL_BAR} -- Internal issues

	item_x (a_item: SD_TOOL_BAR_ITEM): INTEGER is
			-- Item x position on Current.
		do
			Result := tool_bar.item_x (a_item)
		end

	item_y (a_item: SD_TOOL_BAR_ITEM): INTEGER is
			-- Item y position on Current.
		do
			Result := tool_bar.item_y (a_item)
		end

	update is
			-- Redraw item(s) which `is_need_redraw'
		do
			tool_bar.update
		end

	set_start_x (a_x: INTEGER) is
			-- Set `start_x'
		do
			tool_bar.set_start_x (a_x)
		end

	set_start_y (a_y: INTEGER) is
			-- Set `start_y'
		do
			tool_bar.set_start_y (a_y)
		end

	start_x: INTEGER is
			-- Set `internal_start_x' of `tool_bar'.
		do
			Result := tool_bar.start_x
		end

	start_y: INTEGER is
			-- Set `internal_start_y' of `tool_bar'.
		do
			Result := tool_bar.start_y
		end

feature {NONE} -- Implementation

	redraw_item (a_item: SD_TOOL_BAR_ITEM) is
			-- Redraw `a_item'
		local
			l_item: SD_TOOL_BAR_WIDGET_ITEM
		do
			l_item ?= a_item
			if l_item = Void then
				tool_bar.redraw_item (a_item)
			end
		end

	tool_bar: SD_TOOL_BAR
			-- Tool bar which decorated by Current.

	on_tool_bar_expose_actions (a_x: INTEGER; a_y: INTEGER; a_width: INTEGER; a_height: INTEGER) is
			-- Handle tool bar expose actions.
		local
			l_item: SD_TOOL_BAR_WIDGET_ITEM
			l_items: ARRAYED_LIST [SD_TOOL_BAR_ITEM]
			l_item_x, l_item_y: INTEGER
		do
			from
				l_items := items
				l_items.start
			until
				l_items.after
			loop
				l_item ?= l_items.item
				if l_item /= Void and then l_item.has_rectangle (create {EV_RECTANGLE}.make (a_x, a_y, a_width, a_height)) then
					l_item_x := item_x (l_item)
					l_item_y := item_y (l_item)
					if l_item_x /= l_item.widget.x_position or else l_item_y /= l_item.widget.y_position then
						set_item_position (l_item.widget, l_item_x, l_item_y)
					end
				end
				l_items.forth
			end
		end

invariant
	not_void: tool_bar /= Void

indexing
	library:	"SmartDocking: Library of reusable components for Eiffel."
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end
