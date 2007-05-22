indexing
	description: "Objects that represent an EV_TITLED_WINDOW.%
		%The original version of this class was generated by EiffelBuild."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	TRANSFORM_PANEL

inherit
	TRANSFORM_PANEL_IMP

	DOCKING_MANAGER_HODLER
		undefine
			default_create, copy, is_equal
		end

create
	make

feature {NONE} -- Initialization

	make (a_manager: SD_DOCKING_MANAGER; a_window: like window) is
			-- Set `docking_manager' with `a_manager'.
		require
			a_manager_not_void: a_manager /= Void
		do
			default_create
			docking_manager := a_manager
			window := a_window
		ensure
			docking_manager_not_void: docking_manager /= Void
			window_not_void: window /= Void
		end

feature {NONE} -- Initialization

	user_initialization is
			-- Called by `initialize'.
			-- Any custom user initialization that
			-- could not be performed in `initialize',
			-- (due to regeneration of implementation class)
			-- can be added here.
		do
			type_editor_radio_button.enable_select
			top_radio_button.enable_select
		end

feature -- Status changes

	content_focused (a_content: SD_CONTENT) is
			-- Content focused.'
		require
			a_content_not_void: a_content /= Void
		do
			update_by_content (a_content)
		end

feature {NONE} -- Implementation

	on_apply is
			-- Called by `select_actions' of `apply_button'.
		local
			l_content: SD_CONTENT
			l_warning_dialog: EV_WARNING_DIALOG
			l_type: INTEGER
			l_direction: INTEGER
			l_selected_content: SD_CONTENT
			l_is_left: BOOLEAN
			l_float_x, l_float_y: INTEGER
		do
			l_content := docking_manager.focused_content
			if l_content /= Void then
					-- Change type
				l_type := selected_type
				l_content.set_type (l_type)

				if top_radio_button.is_selected then
					l_direction := selected_direction
					l_content.set_top (l_direction)
				elseif relative_radio_button.is_selected then
					l_direction := selected_direction
					if existing_contents_list.selected_item /= Void then
						l_selected_content ?= existing_contents_list.selected_item.data
					end
					if l_direction /= 0 and then l_selected_content /= Void and then l_selected_content.state_value /= {SD_ENUMERATION}.auto_hide then
						l_content.set_relative (l_selected_content, l_direction)
					end
				elseif tab_with_radio_button.is_selected then
					if left_radio_button.is_selected then
						l_is_left := True
					elseif right_radio_button.is_selected then
						l_is_left := False
					end
					if existing_contents_list.selected_item /= Void then
						l_selected_content ?= existing_contents_list.selected_item.data
					end
					if l_selected_content /= Void and then l_content.target_content_zone_parent_exist (l_selected_content) then
						l_content.set_tab_with (l_selected_content, l_is_left)
					end
				elseif auto_hide_radio_button.is_selected then
					l_direction := selected_direction
					if l_direction /= 0 then
						l_content.set_auto_hide (l_direction)
					end
				elseif float_radio_button.is_selected then
					l_float_x := screen_x_button.value
					l_float_y := screen_y_button.value
					l_content.set_floating (l_float_x, l_float_y)
				elseif default_editor_radio_button.is_selected and then l_content.manager_has_place_holder and then l_content.type = {SD_ENUMERATION}.editor then
					l_content.set_default_editor_position
				end
			else
				create l_warning_dialog.make_with_text ("No focused docking content!")
				l_warning_dialog.show_modal_to_window (window)
			end
		end

	selected_direction: INTEGER is
			-- Selected direction
		do
			if up_radio_button.is_selected then
				Result := {SD_ENUMERATION}.top
			elseif down_radio_button.is_selected then
				Result := {SD_ENUMERATION}.bottom
			elseif left_radio_button.is_selected then
				Result := {SD_ENUMERATION}.left
			elseif right_radio_button.is_selected then
				Result := {SD_ENUMERATION}.right
			end
		end

	selected_type: INTEGER is
			-- Selected type
		do
			if type_editor_radio_button.is_selected then
				Result := {SD_ENUMERATION}.editor
			elseif type_tool_radio_button.is_selected then
				Result := {SD_ENUMERATION}.tool
			elseif type_place_holder_radio_button.is_selected then
				Result := {SD_ENUMERATION}.place_holder
			end
		end

	refresh
			-- Called by `select_actions' of `refresh_button.'
		local
			l_content: SD_CONTENT
		do
			l_content := docking_manager.focused_content
			update_by_content (l_content)
		end

	update_by_content (a_content: SD_CONTENT) is
			-- Update by content
		local
			l_contents: ACTIVE_LIST [SD_CONTENT]
			l_item: EV_LIST_ITEM
			l_content: SD_CONTENT
		do
			if a_content /= Void then
				if a_content.type = {SD_ENUMERATION}.editor then
					type_editor_radio_button.enable_select
				elseif a_content.type = {SD_ENUMERATION}.tool then
					type_tool_radio_button.enable_select
				elseif a_content.type = {SD_ENUMERATION}.place_holder then
					type_place_holder_radio_button.enable_select
				else
					check
						Error: False
					end
				end
			end

				-- Build content lists.
			existing_contents_list.wipe_out
			l_contents := docking_manager.contents
			from
				l_contents.start
			until
				l_contents.after
			loop
				l_content := l_contents.item
				if l_content.type = {SD_ENUMERATION}.place_holder then
					create l_item.make_with_text ("Place Holder")
				else
					create l_item.make_with_text (l_content.short_title)
				end
				l_item.set_data (l_content)
				existing_contents_list.extend (l_item)
				l_contents.forth
			end

			-- Other status now is not able to retrieved.
		end

	on_top_radio_button_selected
			-- Called by `select_actions' of `top_radio_button.'
		do
			direction_frame.enable_sensitive
			up_radio_button.enable_sensitive
			down_radio_button.enable_sensitive
			screen_position_frame.disable_sensitive
			existing_contents_frame.disable_sensitive
		end

	on_tab_with_radio_button_selected
			-- Called by `select_actions' of `tab_with_radio_button.'
		do
			direction_frame.enable_sensitive
			up_radio_button.disable_sensitive
			down_radio_button.disable_sensitive
			screen_position_frame.disable_sensitive
			existing_contents_frame.enable_sensitive
		end

	on_relative_radio_button_selected
			-- Called by `select_actions' of `relative_radio_button.'
		do
			direction_frame.enable_sensitive
			up_radio_button.enable_sensitive
			down_radio_button.enable_sensitive
			screen_position_frame.disable_sensitive
			existing_contents_frame.enable_sensitive
		end

	on_auto_hide_radio_button_selected
			-- Called by `select_actions' of `auto_hide_radio_button.'
		do
			direction_frame.enable_sensitive
			up_radio_button.enable_sensitive
			down_radio_button.enable_sensitive
			screen_position_frame.disable_sensitive
			existing_contents_frame.disable_sensitive
		end

	on_float_radio_button_selected
			-- Called by `select_actions' of `float_radio_button.'
		do
			direction_frame.disable_sensitive
			screen_position_frame.enable_sensitive
			existing_contents_frame.disable_sensitive
		end

	on_default_editor_button_selected
			-- Called by `select_actions' of `default_editor_radio_button.'
		do
			direction_frame.disable_sensitive
			screen_position_frame.disable_sensitive
			existing_contents_frame.disable_sensitive
		end

	type_editor_radio_button_selected is
			-- Called by `select_actions' of `type_editor_radio_button'.
		do
			default_editor_radio_button.enable_sensitive
		end

	type_tool_radio_button_selected is
			-- Called by `select_actions' of `type_tool_radio_button'.
		do
			default_editor_radio_button.disable_sensitive
		end

	type_place_holder_radio_button_selected is
			-- Called by `select_actions' of `type_place_holder_radio_button'.
		do
			default_editor_radio_button.disable_sensitive
		end

indexing
	library:   "EiffelBase: Library of reusable components for Eiffel."
	copyright: "Copyright (c) 1984-2006, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			356 Storke Road, Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
