indexing
	description: "Objects that represent an EV_TITLED_WINDOW.%
		%The original version of this class was generated by EiffelBuild."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_METRIC_CALCULATION_RESULT_AREA

inherit
	EB_METRIC_CALCULATION_RESULT_AREA_IMP

	EB_METRIC_INTERFACE_PROVIDER
		undefine
			is_equal,
			copy,
			default_create
		end

	EB_CONSTANTS
		undefine
			is_equal,
			copy,
			default_create
		end

	EB_METRIC_INTERFACE_PROVIDER
		undefine
			is_equal,
			copy,
			default_create
		end

	EVS_GRID_TWO_WAY_SORTING_ORDER
		undefine
			is_equal,
			copy,
			default_create
		end

	EB_SHARED_WRITER
		undefine
			is_equal,
			copy,
			default_create
		end

	QL_SHARED_NAMES
		undefine
			is_equal,
			copy,
			default_create
		end

	EB_SHARED_WRITER
		undefine
			is_equal,
			copy,
			default_create
		end

	EB_SHARED_PREFERENCES
		undefine
			is_equal,
			copy,
			default_create
		end

	EB_RECYCLABLE
		undefine
			is_equal,
			copy,
			default_create
		end

	SHARED_EDITOR_DATA
		undefine
			is_equal,
			copy,
			default_create
		end

	EB_METRIC_TOOL_INTERFACE
		undefine
			is_equal,
			copy,
			default_create
		end

	EB_DOCKING_NAMES
		undefine
			is_equal,
			copy,
			default_create
		end

create
	make

feature {NONE} -- Initialization

	make (a_tool: like metric_tool; a_panel: like metric_panel) is
			-- Initialize `metric_tool' with `a_tool'.
		require
			a_tool_attached: a_tool /= Void
			a_panel_attached: a_panel /= Void
		do
			create show_percentage_btn.make (preferences.metric_tool_data.display_percentage_for_ratio_preference)
			create maximize_result_btn
			create result_grid.make (a_tool.develop_window, tool_drop_actions (a_tool))
			result_grid.enable_use_fixed_fonts
			maximize_result_preference_change_agent := agent on_maximize_result_preference_change
			preferences.metric_tool_data.metric_information_in_result_panel_preference.change_actions.extend (maximize_result_preference_change_agent)
			set_metric_tool (a_tool)
			metric_panel := a_panel
			is_first_display := True
			default_create
		ensure
			metric_tool_attached: metric_tool = a_tool
			metric_panel_attached: metric_panel /= Void
		end

	user_initialization is
			-- Called by `initialize'.
			-- Any custom user initialization that
			-- could not be performed in `initialize',
			-- (due to regeneration of implementation class)
			-- can be added here.
		local
			l_text: EV_TEXT_FIELD
			l_font: EV_FONT
			l_maximized: BOOLEAN
		do
				-- Setup `input_grid'.			
			create input_grid
			input_grid.hide_header
			input_grid.set_column_count_to (1)
			input_grid.set_row_count_to (1)
			input_grid.set_minimum_height (40)
			input_grid.set_focused_selection_color (editor_preferences.selection_background_color)
			input_grid_area.extend (input_grid)
			input_grid.enable_selection_on_single_button_click
			grid_support := new_grid_support (input_grid)
			grid_support.enable_grid_item_pnd_support
			grid_support.set_context_menu_factory_function (agent (metric_tool.develop_window.menus).context_menu_factory)

			result_grid_area.extend (result_grid.widget)

				-- Delete following in docking EiffelStudio.
			append_drop_actions (
				<<
					information_bar_empty_area,
					input_grid,
					input_cell,
					empty_cell,
					result_cell
				>>,
				metric_tool
				)
			create l_text
			metric_name_text.set_background_color (l_text.background_color)
			metric_name_text.pointer_double_press_actions.extend (agent on_pointer_double_click_on_metric_name_text)
			attach_non_editable_warning_to_text (metric_names.t_text_not_editable, metric_name_text, metric_tool_window)
			attach_non_editable_warning_to_text (metric_names.t_text_not_editable, value_text, metric_tool_window)
			value_text.set_background_color (l_text.background_color)

			update_warning_area.hide
			update_warning_lbl.set_text (metric_names.t_result_not_up_to_date)
			update_warning_lbl.set_tooltip (metric_names.f_run_metric_again)
			update_warning_pixmap.copy (pixmaps.icon_pixmaps.general_warning_icon)
			update_warning_pixmap.set_tooltip (metric_names.f_run_metric_again)

			send_to_history_btn.set_pixmap (pixmaps.icon_pixmaps.metric_send_to_archive_icon)
			send_to_history_btn.set_tooltip (metric_names.f_send_to_history)
			send_to_history_btn.select_actions.extend (agent on_send_metric_to_history)

			show_percentage_btn.set_text ("%%")
			show_percentage_btn.set_tooltip (metric_names.f_display_in_percentage)
			show_percentage_btn.select_actions.extend (agent on_show_percentage_changes)

			ratio_btn_toolbar.extend (show_percentage_btn)
			create l_font
			l_font.set_weight ({EV_FONT_CONSTANTS}.weight_bold)
			value_text.set_font (l_font)

			maximize_result_btn.select_actions.extend (agent on_maximize_result_area)
			tool_bar.extend (maximize_result_btn)
			l_maximized := preferences.metric_tool_data.metric_information_in_result_panel_preference.value
			is_maximize_set := not l_maximized
			set_maximize_status (l_maximized)

			clear_result_btn.set_tooltip (metric_names.t_clear_result)
			clear_result_btn.set_pixmap (pixmaps.icon_pixmaps.general_reset_icon)
			clear_result_btn.select_actions.extend (agent on_clear_detailed_result)
		ensure then
			input_grid_attached: input_grid /= Void
		end

feature -- Result loading

	load_metric_result (a_metric: EB_METRIC; a_input: EB_METRIC_DOMAIN; a_value: DOUBLE; a_result: QL_DOMAIN) is
			-- Load metric result `a_result' from `a_metric' calculated over domain `a_input' into `input_grid'.
			-- `a_result' is Void indicates no detailed result available.
		require
			a_metric_attached: a_metric /= Void
			a_input_attached: a_input /= Void
		do
			if a_metric.is_ratio then
				ratio_btn_toolbar.show
			else
				ratio_btn_toolbar.hide
			end
			load_metric_information (a_metric, a_value)
			load_input_information (a_input)
			load_detailed_result_information (a_result)
		end

	load_metric_information (a_metric: EB_METRIC; a_value: DOUBLE) is
			-- Load basic information of `a_metric'.
		require
			a_metric_attached: a_metric /= Void
		local
			l_tooltip: STRING
			l_value_str: STRING
		do
			metric_name_text.set_text (a_metric.name)
			if metric_manager.has_metric (a_metric.name) then
				l_tooltip := metric_tooltip (a_metric, True)
				if not l_tooltip.is_empty then
					metric_name_text.set_tooltip (l_tooltip)
				end
			end
			type_name_text.set_text (displayed_name (name_of_metric_type (metric_type_id (a_metric))))
			type_pixmap.copy (pixmap_from_metric_type (metric_type_id (a_metric)))
			unit_name_text.set_text (unit_name_table.item (a_metric.unit))
			unit_pixmap.copy (pixmap_from_unit (a_metric.unit))
			l_value_str := metric_value (a_value, a_metric.is_ratio and then show_percentage_btn.is_selected)
			value_text.set_text (l_value_str)
			result_lbl.set_text (l_value_str)
			value_text.set_data (a_value)

			if a_metric.is_ratio then
				show_percentage_btn.enable_sensitive
				if is_first_display then
					is_first_display := False
					show_percentage_btn.enable_select
				end
			else
				show_percentage_btn.disable_sensitive
			end
		end

	load_input_information (a_input: EB_METRIC_DOMAIN) is
			-- Load source domain information.
		require
			a_input_attached: a_input /= Void
		local
			l_item: EB_METRIC_GRID_DOMAIN_ITEM [ANY]
		do
			create l_item.make (a_input)
			input_grid.set_item (1, 1, l_item)
			input_grid.column (1).resize_to_content
		end

	load_detailed_result_information (a_result: QL_DOMAIN) is
			-- Load detailed result from `a_result'.
		do
			result_grid.update (Void, a_result)
		end

feature{NONE} -- Implementation/Access

	grid_support: like new_grid_support
			-- Grid support.

	input_grid: ES_GRID
			-- Grid to display input

	result_grid: EB_CLASS_BROWSER_DOMAIN_VIEW
			-- Result grid

	metric_panel: EB_METRIC_RESULT_AREA
			-- Metric panel to which current is attached

	show_percentage_btn: EB_PREFERENCED_TOOL_BAR_TOGGLE_BUTTON
			-- Button to indicate if percentage should be displayed for ratio metric result

	maximize_result_btn: EV_TOOL_BAR_BUTTON
			-- Button to maximize/restore result grid

	maximize_result_preference_change_agent: PROCEDURE [ANY, TUPLE]
			-- Agent of `on_maximize_result_preference_change'

feature -- Refresh

	refresh_grid is
			-- Refresh result grid.
		do
			result_grid.refresh
		end

feature{NONE} -- Implementation/Status report

	is_maximize_set: BOOLEAN
			-- Should detailed metric result grid should be displayed in maximized status?
			-- If True, only metric result grid is displayed.
			-- If False, metric information, metric input domain will be also displayed.

	is_first_display: BOOLEAN
			-- Is first display metric result?

feature{NONE} -- Implementation

	on_pointer_double_click_on_metric_name_text (a_x, a_y, a_button: INTEGER; a_x_tilt, a_y_tilt, a_pressure: DOUBLE; a_screen_x, a_screen_y: INTEGER) is
			-- Action to be performed when pointer double clicks on `metric_name_text'
		local
			l_metric: EB_METRIC
			l_metric_name: STRING
		do
			if a_button = 1 then
				l_metric_name := metric_name_text.text
				if metric_manager.has_metric (l_metric_name) then
					l_metric := metric_manager.metric_with_name (l_metric_name)
					metric_tool.go_to_definition (l_metric, False)
				end
			end
		end

	on_show_percentage_changes is
			-- Action to be performed when selection status of `show_percentage_btn' changes
		local
			l_double: DOUBLE_REF
		do
			if show_percentage_btn.is_sensitive then
				l_double ?= value_text.data
				if l_double /= Void then
					value_text.set_text (metric_value (l_double.item, show_percentage_btn.is_selected))
				end
			end
			if preferences.metric_tool_data.is_percentage_for_ratio_displayed /= show_percentage_btn.is_selected then
				preferences.metric_tool_data.display_percentage_for_ratio_preference.set_value (show_percentage_btn.is_selected)
			end
		end

	on_maximize_result_area is
			-- Action to be performed to maximize/restore metric result grid.
		do
			set_maximize_status (not is_maximize_set)
		end

	on_send_metric_to_history is
			-- Action to be performed to send last calculated metric value in history
		do
			metric_panel.on_send_metric_to_history
		end

	on_maximize_result_preference_change is
			-- Action to be performed when maximize result grid preference change from outside.
		do
			if preferences.metric_tool_data.metric_information_in_result_panel_preference.value /= is_maximize_set then
				set_maximize_status (preferences.metric_tool_data.metric_information_in_result_panel_preference.value)
			end
		end

	on_clear_detailed_result is
			-- Action to be performed to clear detailed result
		local
			l_domain: QL_DOMAIN
		do
			l_domain ?= result_grid.data
			if l_domain /= Void then
				l_domain.wipe_out
				result_grid.update (Void, l_domain)
			end
		end

feature{NONE} -- Implementation

	set_maximize_status (b: BOOLEAN) is
			-- Set `is_maximize_set' with `b'.
		do
			if is_maximize_set /= b then
				is_maximize_set := b
				if is_maximize_set then
					maximize_result_btn.set_pixmap (pixmaps.mini_pixmaps.toolbar_restore_icon)
					maximize_result_btn.set_tooltip (tooltip_mini_toolbar_restore)
					metric_area.hide
					input_area.hide
					result_lbl.show
				else
					maximize_result_btn.set_pixmap (pixmaps.mini_pixmaps.toolbar_maximize_icon)
					maximize_result_btn.set_tooltip (tooltip_mini_toolbar_maximize)
					metric_area.show
					input_area.show
					result_lbl.hide
				end
				if preferences.metric_tool_data.metric_information_in_result_panel_preference.value /= is_maximize_set then
					preferences.metric_tool_data.metric_information_in_result_panel_preference.set_value (is_maximize_set)
				end
			end
		ensure
			maximize_status_set: is_maximize_set = b
		end

feature {NONE} -- Recycle

	internal_recycle is
			-- To be called when the button has became useless.
		do
			preferences.metric_tool_data.metric_information_in_result_panel_preference.change_actions.prune_all (maximize_result_preference_change_agent)
			show_percentage_btn.recycle
			result_grid.recycle
			grid_support.desynchronize_color_or_font_change_with_editor
			grid_support.desynchronize_scroll_behavior_with_editor
		end

invariant
	input_grid_attached: input_grid /= Void
	metric_panel_attached: metric_panel /= Void
	show_percentage_btn_attached: show_percentage_btn /= Void
	maximize_result_btn_attached: maximize_result_btn /= Void
	maximize_result_preference_change_agent_attached: maximize_result_preference_change_agent /= Void
	result_grid_attached: result_grid /= Void

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class EB_METRIC_CALCULATION_RESULT_AREA

