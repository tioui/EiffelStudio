indexing
	description: "Objects that represent an EV_TITLED_WINDOW.%
		%The original version of this class was generated by EiffelBuild."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_METRIC_EVALUATION_PANEL

inherit
	EB_METRIC_EVALUATION_PANEL_IMP

	EB_CONSTANTS
		undefine
			is_equal,
			copy,
			default_create
		end

	QL_SHARED_UNIT
		undefine
			is_equal,
			copy,
			default_create
		end

	EB_METRIC_PANEL
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

	EB_METRIC_SHARED
		undefine
			is_equal,
			copy,
			default_create
		end

	EXCEPTIONS
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

	SHARED_WORKBENCH
		undefine
			is_equal,
			copy,
			default_create
		end

create
	make

feature{NONE} -- Initialization

	make (a_tool: like metric_tool) is
			-- Initialize `metric_tool' with `a_tool'.
		require
			a_tool_attached: a_tool /= Void
		do
			metric_tool := a_tool
			on_stop_metric_evaluation_agent := agent on_stop_metric_evaluation
			on_unit_order_change_agent := agent on_unit_order_change
			create detailed_result_btn.make (preferences.metric_tool_data.keep_metric_detailed_result_preference)
			create filter_result_btn.make (preferences.metric_tool_data.filter_invisible_result_preference)
			create auto_go_to_result_btn.make (preferences.metric_tool_data.automatic_go_to_result_panel_preference)
			create show_percent_btn.make (preferences.metric_tool_data.display_percentage_for_ratio_preference)
			install_agents (metric_tool)
			install_metric_history_agent
			on_process_gui_agent := agent on_process_gui
			create {QL_TARGET_DOMAIN_GENERATOR} domain_generator_internal
			default_create
			set_is_metric_reloaded (True)
			set_is_send_to_history_status_up_to_date (False)
		ensure
			metric_tool_set: metric_tool = a_tool
			domain_generator_internal_attached: domain_generator_internal /= Void
			on_stop_metric_evaluation_agent_attached: on_stop_metric_evaluation_agent /= Void
			on_process_gui_agent_attached: on_process_gui_agent /= Void
		end

feature {NONE} -- Initialization

	user_initialization is
			-- Called by `initialize'.
			-- Any custom user initialization that
			-- could not be performed in `initialize',
			-- (due to regeneration of implementation class)
			-- can be added here.
		local
			l_text: EV_TEXT
		do
			unit_lbl.set_text (metric_names.l_unit_colon)

				-- Setup basic metric definition area.
			create metric_definer.make (metric_tool, Current, new_mode, class_unit)
			metric_definer.change_actions_internal.extend (agent on_definition_change)
			metric_definer.name_area.hide
			criterion_area.extend (metric_definer.widget)

				-- Initialize unit list.
			initialize_unit

				-- Setup metric list grid.	
			create metric_selector.make (False)
			grid_wrapper.extend (metric_selector)
			grid_wrapper.set_minimum_width (200)

				-- Setup domain selector.
			create domain_selector
			domain_selector.setup_delayed_domain_item_buttons (True, False, False)
			metric_domain_selector_area.extend (domain_selector)
			domain_selector.domain_change_actions.extend (agent on_domain_change)
			metric_selector.metric_selected_actions.extend (agent on_metric_selected)
			metric_selector.group_selected_actions.extend (agent on_metric_selected (Void))
			metric_selector.double_click_actions.extend (agent on_pointer_double_click_on_metric_item)

				-- Setup sensitivity and background color for text fields
			metric_value_text.disable_edit
			create l_text
			metric_value_text.set_background_color (l_text.background_color)

				-- Setup run tool bar
			run_metric_btn.set_pixmap (pixmaps.icon_pixmaps.debug_run_icon)
			run_metric_btn.set_tooltip (metric_names.f_run)
			run_metric_btn.select_actions.extend (agent on_run_metric)
			run_metric_btn.disable_sensitive

			stop_metric_btn.set_pixmap (pixmaps.icon_pixmaps.debug_stop_icon)
			stop_metric_btn.disable_sensitive
			stop_metric_btn.set_tooltip (metric_names.f_stop)
			stop_metric_btn.select_actions.extend (agent on_stop_metric_evaluation_button_pressed)

			detailed_result_btn.set_pixmap (pixmaps.icon_pixmaps.metric_run_and_show_details_icon)
			detailed_result_btn.set_tooltip (metric_names.f_keep_metric_detailed_result)

			go_to_definition_btn.select_actions.extend (agent on_go_to_definition_button_pressed)
			go_to_definition_btn.remove_text
			go_to_definition_btn.set_pixmap (pixmaps.icon_pixmaps.command_go_to_definition_icon)
			go_to_definition_btn.set_tooltip (metric_names.f_go_to_definition)
			go_to_definition_btn.enable_sensitive

			quick_metric_btn.set_pixmap (pixmaps.icon_pixmaps.metric_quick_icon)

			quick_metric_btn.select_actions.extend (agent on_quick_metric_button_pressed (Void))
			quick_metric_btn.disable_select
			quick_metric_btn.set_tooltip (metric_names.f_quick_metric_definition)
			quick_metric_btn.drop_actions.extend (agent on_create_quick_metric)

			send_to_history_btn.set_pixmap (pixmaps.icon_pixmaps.metric_send_to_archive_icon)
			send_to_history_btn.set_tooltip (metric_names.f_send_to_history)
			send_to_history_btn.select_actions.extend (agent on_send_metric_to_history)

			choose_input_domain_lbl.set_text (metric_names.l_select_input_domain)
			choose_metric_lbl.set_text (metric_names.l_select_metric)
			metric_value_lbl.set_text (metric_names.e_value)
			attach_non_editable_warning_to_text (metric_names.t_text_not_editable, metric_value_text, metric_tool_window)
			choose_input_domain_lbl.set_text (metric_names.t_select_source_domain)
			choose_metric_lbl.set_text (metric_names.t_select_metric)

			filter_result_btn.set_tooltip (metric_names.f_filter_result)
			filter_result_btn.set_pixmap (pixmaps.icon_pixmaps.metric_filter_icon)

			show_percent_btn.set_text ("%%")
			show_percent_btn.set_tooltip (metric_names.f_display_in_percentage)
			show_percent_btn.select_actions.extend (agent refresh_metric_text)

			auto_go_to_result_btn.set_pixmap (pixmaps.icon_pixmaps.context_link_icon)
			auto_go_to_result_btn.set_tooltip (metric_names.f_auto_go_to_result)

			append_drop_actions (
				<<
					toolbar_empty_area,
					grid_wrapper_empty_area,
					metric_definition_empty_area,
					main_area_cell,
					choose_metric_lbl_cell,
					metric_definer.criterion_definition_empty_area,
					metric_definer.expression_lbl_empty_area
				>>,
				metric_tool
			)
			metric_value_text.set_font (bold_font)
			preferences.metric_tool_data.unit_order_preference.change_actions.extend (on_unit_order_change_agent)
			option_tool_bar.extend (detailed_result_btn)
			option_tool_bar.extend (filter_result_btn)
			synchronize_tool_bar.extend (auto_go_to_result_btn)
			percentage_tool_bar.extend (show_percent_btn)
			percentage_tool_bar.wipe_out
			send_to_history_btn.disable_sensitive
			set_is_reload_metric_definer_safe (True)
		end

feature -- Status report

	is_cancel_evaluation_requested: BOOLEAN
			-- Is cancel metric evaluation requested?

	is_using_quick_metric: BOOLEAN is
			-- Is using quick metric?
		do
			Result := quick_metric_btn.is_selected
		end

	is_stopped_by_eiffel_compilation: BOOLEAN
			-- Is metric evaluation stopped by Eiffel compilation?

	is_quick_metric_initialized: BOOLEAN
			-- Is quick metric initialized?

	is_original_starter: BOOLEAN
			-- Is this panel the original panel in which metric evaluation starts?

	is_last_evaluation_successful: BOOLEAN
			-- Is last metric evaluation successful?
			-- Successful means metric evaluation finished, i.e., no termination (either by user or by Eiffel compilation),
			-- no error occurred.	

	is_send_to_history_status_up_to_date: BOOLEAN
			-- Is status of `send_to_history_btn' up-to-date?

	is_result_filtered_for_last_metric: BOOLEAN
			-- Is result filtered for last calculated metric?

feature -- Access

	last_input_domain: EB_METRIC_DOMAIN
			-- Input domain when last metric is evaluated

	last_value: DOUBLE
			-- Value of last calculated metric

	last_metric: EB_METRIC
			-- Last calculated metric.
			-- This exists even if the original metric has been removed from metric definition panel.

	last_calculation_time: DATE_TIME
			-- Time when last metric calculation started

feature -- Basic operations

	set_is_original_starter (b: BOOLEAN) is
			-- Set `is_original_starter' with `b'.
		do
			is_original_starter := b
		ensure
			is_original_starter_set: is_original_starter = b
		end

	set_is_stopped_by_eiffel_compilation (b: BOOLEAN) is
			-- Set `is_stopped_by_eiffel_compilation' with `b'.
		do
			is_stopped_by_eiffel_compilation := b
		ensure
			is_stopped_by_eiffel_compilation_set: is_stopped_by_eiffel_compilation = b
		end

	set_is_cancel_evaluation_requested (b: BOOLEAN) is
			-- Set `is_cancel_evaluation_requested' with `b'.
		do
			is_cancel_evaluation_requested := b
		ensure
			is_cancel_evaluation_requested_set: is_cancel_evaluation_requested = b
		end

	set_is_last_evaluation_successful (b: BOOLEAN) is
			-- Set `is_last_evaluation_successful' with `b'.
		do
			is_last_evaluation_successful := b
		ensure
			is_last_evaluation_successful_set: is_last_evaluation_successful = b
		end

	set_last_input_domain (a_domain: like last_input_domain) is
			-- Set `last_input_domain' with `a_domain'.
		do
			last_input_domain := a_domain
		ensure
			last_input_domain_set: last_input_domain = a_domain
		end

	set_last_metric (a_metric: like last_metric) is
			-- Set `last_metric' with `a_metric'.
		do
			last_metric := a_metric
		ensure
			last_metric_set: last_metric = a_metric
		end

	set_last_value (a_value: like last_value) is
			-- Set `last_value' with `a_value'.
		do
			last_value := a_value
		ensure
			last_value_set: last_value = a_value
		end

	set_last_calculation_time (a_time: like last_calculation_time) is
			-- Set `last_calculation_time' with `a_time'.
		do
			last_calculation_time := a_time
		ensure
			last_calculation_time_set: last_calculation_time = a_time
		end

	set_is_send_to_history_status_up_to_date (b: BOOLEAN) is
			-- Set `is_send_to_history_status_up_to_date' with `b'.
		do
			is_send_to_history_status_up_to_date := b
		ensure
			is_send_to_history_status_up_to_date_set: is_send_to_history_status_up_to_date = b
		end

	set_is_result_filtered_for_last_metric (b: BOOLEAN) is
			-- Set `is_result_filtered_for_last_metric' with `b'.
		do
			is_result_filtered_for_last_metric := b
		ensure
			is_result_filtered_for_last_metric_set: is_result_filtered_for_last_metric = b
		end

	force_drop_stone (a_stone: STONE) is
			-- Force to drop `a_stone' in `domain_selector'.
		do
			domain_selector.on_drop (a_stone)
		end

feature -- Actions

	on_metric_selected (a_metric: EB_METRIC) is
			-- Action to be performed when a metric is selected in `metric_selector'
		do
			set_is_up_to_date (False)
			update_ui
		end

	on_run_metric is
			-- Action to be performed when run a metric			
			-- If `a_detailed' is True, record detailed result when calculating `current_metric'.
		require
			is_runnable: is_metric_runnable
		local
			l_retried: BOOLEAN
			l_value: DOUBLE
			l_metric: like current_selected_metric
			l_input_domain: EB_METRIC_DOMAIN
			l_value_string: STRING_32
		do
			if not l_retried then
				set_is_last_evaluation_successful (False)
				l_metric := current_selected_metric
				l_input_domain := domain_selector.domain
				set_last_input_domain (l_input_domain)
				set_last_metric (l_metric)
				set_last_calculation_time (create {DATE_TIME}.make_now)
				metric_manager.on_metric_evaluation_starts (Current)
				setup_evaluation_environment (True)
				set_is_result_filtered_for_last_metric (filter_result_btn.is_selected)
				if filter_result_btn.is_selected then
					l_metric.enable_filter_result
				else
					l_metric.disable_filter_result
				end

					-- Setup metric evaluator.
				if l_metric.is_basic then
					if detailed_result_btn.is_selected then
						l_metric.enable_fill_domain
					else
						l_metric.disable_fill_domain
					end
				else
					l_metric.disable_fill_domain
				end

				l_value := l_metric.value_item (l_input_domain)
				set_last_value (l_value)
				set_is_last_evaluation_successful (True)
				display_status_message ("")
				set_metric_value (metric_value (l_value, show_percent_btn.is_sensitive and then show_percent_btn.is_selected), l_value)

					-- Setup metric tool title.
				create l_value_string.make (10)
				l_value_string.append_double (l_value)
				metric_tool.set_title (l_value_string)

				if l_metric.is_fill_domain_enabled then
					metric_tool.register_metric_result_for_display (l_metric, l_input_domain, l_value, l_metric.last_result_domain, last_calculation_time, False, is_result_filtered_for_last_metric)
				else
					metric_tool.register_metric_result_for_display (l_metric, l_input_domain, l_value, Void, last_calculation_time, False, is_result_filtered_for_last_metric)
				end
			end
			setup_evaluation_environment (False)
			metric_manager.on_metric_evaluation_stops (Current)
			if is_last_evaluation_successful and then auto_go_to_result_btn.is_selected then
				metric_tool.go_to_result
			end
		rescue
			l_retried := True
			display_status
			set_metric_value (metric_names.e_undefined_value, Void)
			metric_tool.set_title (Void)
			setup_evaluation_environment (False)
			metric_manager.on_metric_evaluation_stops (Current)
			retry
		end

	on_stop_metric_evaluation (a_item: QL_ITEM) is
			-- Action to be performed when metric evaluation is stopped
		do
			if is_cancel_evaluation_requested then
				if is_stopped_by_eiffel_compilation then
					stop_metric_evaluation (metric_names.e_interrupted_by_compile)
				else
					stop_metric_evaluation (metric_names.e_interrupted_by_user)
				end
			end
		end

	on_stop_metric_evaluation_button_pressed is
			-- Action to be performed when stop button is pressed.
		do
			is_cancel_evaluation_requested := True
		end

	on_go_to_definition_button_pressed is
			-- Action to be performed when "Go to definition" button is pressed
		local
			l_current_metric: like current_selected_metric
		do
			l_current_metric := current_selected_metric
			if is_using_quick_metric then
				if l_current_metric /= Void then
					metric_tool.go_to_definition (l_current_metric, True)
					uuid_internal := Void
				end
			else
				if
					metric_selector.last_selected_metric /= Void and then
					metric_manager.has_metric (metric_selector.last_selected_metric)
				then
					metric_tool.go_to_definition (metric_manager.metric_with_name (metric_selector.last_selected_metric), False)
				end
			end
		end

	on_pointer_double_click_on_metric_item (a_name: STRING) is
			-- Action to be performed when pointer double clicks on a metric named `a_name' in `metric_selector'.
		require
			a_name_attached: a_name /= Void
		do
			if metric_manager.has_metric (a_name) then
				metric_tool.go_to_definition (metric_manager.metric_with_name (a_name), False)
			end
		end

	on_unit_selection_change is
			-- Action to be performed when selection in `unit_combo' changes
		local
			l_unit: QL_METRIC_UNIT
		do
			metric_definer.set_mode (metric_definer.new_mode)
			l_unit ?= unit_combo.selected_item.data
			check l_unit /= Void end
			metric_definer.initialize_editor (Void, metric_definer.edit_mode, l_unit, uuid)
		end

	on_quick_metric_button_pressed (a_metric: EB_METRIC_BASIC) is
			-- Action to be performed when "Quick metric" button is pressed
		do
			if quick_metric_btn.is_selected then
				if not is_quick_metric_initialized then
					check unit_combo.retrieve_item_by_data (class_unit, False) /= Void end
					unit_combo.retrieve_item_by_data (class_unit, False).enable_select
					on_unit_selection_change
					is_quick_metric_initialized := True
				end
				if a_metric /= Void and then a_metric.unit.scope /= Void and then a_metric.criteria /= Void then
					unit_combo.select_actions.block
					unit_combo.retrieve_item_by_data (a_metric.unit, False).enable_select
					unit_combo.select_actions.resume
					metric_definer.set_uuid (uuid)
					metric_definer.set_unit (a_metric.unit)
					metric_definer.set_mode (metric_definer.new_mode)
					metric_definer.load_criterion (a_metric.identical_new_instance.criteria)
				end
				on_metric_selected (quick_metric (Void, False))
				metric_definition_area.show
				metric_selection_area.hide
			else
				metric_definition_area.hide
				metric_selection_area.show
				metric_selector.try_to_selected_last_metric
			end
		end

	on_definition_change (a_criterion: EB_METRIC_CRITERION) is
			-- Action to be performed when definition in `metric_definer' change.
		do
			set_is_reload_metric_definer_safe (False)
			on_metric_selected (quick_metric (a_criterion, True))
			set_is_reload_metric_definer_safe (True)
			metric_definer.resize_criterion_grid_column (1, 0)
			metric_definer.resize_criterion_grid_column (2, 0)
		end

	on_domain_change (a_domain: EB_METRIC_DOMAIN) is
			-- Action to be performed when domain in `domain_selector' changes
		do
			set_is_up_to_date (False)
			update_ui
		end

	on_send_metric_to_history is
			-- Action to be performed to send last calculated metric to history
		do
			check
				last_metric /= Void
				last_input_domain /= Void
				last_calculation_time /= Void
			end
			metric_tool.on_send_metric_value_in_history (
				create {EB_METRIC_ARCHIVE_NODE}.make (last_metric.name, metric_type_id (last_metric), last_calculation_time, last_value, last_input_domain, uuid_gen.generate_uuid.out, is_result_filtered_for_last_metric),
				Current
			)
		end

	on_metric_renamed (a_old_name, a_new_name: STRING) is
			-- Action to be performed when a metric with `a_old_name' has been renamed to `a_new_name'.
		do
		end

	on_create_quick_metric (a_pebble: ANY) is
			-- Action to be performed when a pebble is dropped on `quick_metric_btn'.
			-- If the pebble is a metric, then prompt quick metric definer and use that metric as a template.
		local
			l_metric: EB_METRIC_BASIC
		do
			l_metric ?= a_pebble
			if l_metric /= Void and then l_metric.unit.scope /= Void then
				quick_metric_btn.select_actions.block
				quick_metric_btn.enable_select
				on_quick_metric_button_pressed (l_metric)
				quick_metric_btn.select_actions.resume
			end
		end

feature {NONE} -- Implementation/Data

	domain_generator_internal: QL_DOMAIN_GENERATOR
			-- Domain generator used to setup metric evaluation

	uuid: UUID is
			-- Current UUID used for quick metric
		local
			l_uuid_generator: UUID_GENERATOR
		do
			if uuid_internal = Void then
				create l_uuid_generator
				uuid_internal := l_uuid_generator.generate_uuid
			end
			Result := uuid_internal
		ensure
			result_attached: Result /= Void
		end

	detailed_result_btn: EB_PREFERENCED_TOOL_BAR_TOGGLE_BUTTON
	filter_result_btn: EB_PREFERENCED_TOOL_BAR_TOGGLE_BUTTON
	auto_go_to_result_btn: EB_PREFERENCED_TOOL_BAR_TOGGLE_BUTTON
	show_percent_btn: EB_PREFERENCED_TOOL_BAR_TOGGLE_BUTTON
		-- Buttons used in tool bar

	on_stop_metric_evaluation_agent: PROCEDURE [ANY, TUPLE [a_item: QL_ITEM]]
			-- Agent of `stop_metric_evaluation_agnet'

	on_process_gui_agent: PROCEDURE [ANY, TUPLE [a_item: QL_ITEM]]
			-- Agent of `process_gui'

	uuid_internal: like uuid
			-- Implementation of `uuid'	

	domain_selector: EB_METRIC_DOMAIN_SELECTOR
			-- Domain selector

	metric_selector: EB_METRIC_SELECTOR
			-- Metric selector

	metric_definer: EB_BASIC_METRIC_DEFINITION_AREA
			-- Basic metric definition area

	quick_metric (a_criterion: EB_METRIC_CRITERION; a_appliable: BOOLEAN): like current_selected_metric is
			-- Metric defined in quick metric panel
			-- If `a_appliable' is True, use `a_criterion' as default criterion for the metric,
			-- otherwise, read criterion directly from `metric_definer'.
		local
			l_metric: EB_METRIC_BASIC
			l_unit: QL_METRIC_UNIT
		do
			l_unit ?= unit_combo.selected_item.data
			check l_unit /= Void end
			create l_metric.make (metric_manager.next_metric_name_with_unit (l_unit), l_unit, uuid)
			if a_appliable then
				l_metric.set_criteria (a_criterion)
			else
				l_metric.set_criteria (metric_definer.criterion)
			end
			Result := l_metric
		ensure
			result_attached: Result /= Void
		end

feature {NONE} -- Implementation

	setup_evaluation_environment (a_start: BOOLEAN) is
			-- Setup metric evaluation environment.
			-- If `a_start' is True, setup before metric evaluation, otherwise, setup after metric evaluation.
		local
			l_generator: like domain_generator_internal
			l_tick_actions: ACTION_SEQUENCE [TUPLE [QL_ITEM]]
		do
			l_generator := domain_generator_internal
			l_tick_actions := l_generator.tick_actions
			if a_start then
				l_generator.set_interval (20)
				if not l_tick_actions.has (on_process_gui_agent) then
					l_tick_actions.extend (on_process_gui_agent)
				end
				if not l_tick_actions.has (on_stop_metric_evaluation_agent) then
					l_tick_actions.extend (on_stop_metric_evaluation_agent)
				end
			else
				l_tick_actions.prune_all (on_stop_metric_evaluation_agent)
				l_tick_actions.prune_all (on_process_gui_agent)
				l_generator.set_interval (20)
			end
		end

	refresh_metric_text is
			-- Refresh text displayed in metric value text field.			
		local
			l_double: DOUBLE_REF
		do
			l_double ?= metric_value_text.data
			if l_double /= Void then
				metric_value_text.set_text (metric_value (l_double, show_percent_btn.is_selected))
			end
		end

	initialize_unit is
			-- Initialize `unit_combo'.
		local
			l_list_item: EV_LIST_ITEM
			l_unit_list: LIST [TUPLE [unit: QL_METRIC_UNIT; pixmap: EV_PIXMAP]]
		do
			l_unit_list := unit_list (False)
			from
				l_unit_list.start
			until
				l_unit_list.after
			loop
				create l_list_item.make_with_text (unit_name_table.item (l_unit_list.item.unit))
				l_list_item.set_data (l_unit_list.item.unit)
				l_list_item.set_pixmap (l_unit_list.item.pixmap)
				unit_combo.extend (l_list_item)
				l_unit_list.forth
			end
			unit_combo.select_actions.extend (agent on_unit_selection_change)
		end

	stop_metric_evaluation (a_msg: STRING_GENERAL) is
			-- Stop metric evaluation.
			-- `a_msg' contains reason for the stoppage.
		require
			a_msg_attached: a_msg /= Void
		local
			l_domain_generator: like domain_generator_internal
		do
			domain_generator_internal.error_handler.insert_interrupt_error (a_msg)
			is_cancel_evaluation_requested := False
		rescue
			l_domain_generator := domain_generator_internal
			if l_domain_generator.error_handler.has_error then
				display_status_message (l_domain_generator.error_handler.error_list.last.out)
			end
		end

	display_status is
			-- Display status.
		local
			l_domain_generator: QL_DOMAIN_GENERATOR
		do
			l_domain_generator := domain_generator_internal
			if l_domain_generator.error_handler.has_error then
				display_status_message (l_domain_generator.error_handler.error_list.last.out)
			else
				display_status_message (tag_name)
			end
		end

	set_metric_value (a_value: STRING_GENERAL; a_data: ANY) is
			-- Set `a_value' into `metric_value_text'.
		require
			a_value_attached: a_value /= Void
		do
			metric_value_text.set_text (a_value)
			metric_value_text.set_data (a_data)
		end

feature {NONE} -- Recycle

	internal_recycle is
			-- To be called when the button has became useless.
		do
			preferences.metric_tool_data.unit_order_preference.change_actions.prune_all (on_unit_order_change_agent)

			detailed_result_btn.recycle
			filter_result_btn.recycle
			auto_go_to_result_btn.recycle
			show_percent_btn.recycle
			uninstall_agents (metric_tool)
			uninstall_metric_history_agent
		end

feature{NONE} -- Actions

	on_project_loaded is
			-- Action to be performed when project loaded
		do
			set_is_up_to_date (False)
			update_ui
		end

	on_project_unloaded is
			-- Action to be performed when project unloaded
		do
			set_is_up_to_date (False)
			update_ui
		end

	on_compile_start is
			-- Action to be performed when Eiffel compilation starts
		do
			if is_metric_evaluating then
				set_is_stopped_by_eiffel_compilation (True)
				on_stop_metric_evaluation_button_pressed
				metric_manager.on_metric_evaluation_stops (Current)
			end
			set_is_up_to_date (False)
			update_ui
		end

	on_compile_stop is
			-- Action to be performed when Eiffel compilation stops
		do
			set_is_up_to_date (False)
			set_is_metric_reloaded (True)
			update_ui
		end

	on_metric_evaluation_start (a_data: ANY) is
			-- Action to be performed when metric evaluation starts
			-- `a_data' can be the metric tool panel from which metric evaluation starts.
		local
			l_panel: like Current
		do
			l_panel ?= a_data
			set_is_original_starter (l_panel /= Void and then (l_panel = Current))
			set_is_stopped_by_eiffel_compilation (False)
			set_is_cancel_evaluation_requested (False)
			set_is_up_to_date (False)
			update_ui
		end

	on_metric_evaluation_stop (a_data: ANY) is
			-- Action to be performed when metric evaluation stops
			-- `a_data' can be the metric tool panel from which metric evaluation stops.
		local
			l_panel: like Current
		do
			set_is_up_to_date (False)
			l_panel ?= a_data
			set_is_send_to_history_status_up_to_date (not (l_panel /= Void and then l_panel = Current))
			update_ui
		end

	on_archive_calculation_start (a_data: ANY) is
			-- Action to be performed when metric archive calculation starts
			-- `a_data' can be the metric tool panel from which metric archive calculation starts.
		do
			set_is_up_to_date (False)
			update_ui
		end

	on_archive_calculation_stop (a_data: ANY) is
			-- Action to be performed when metric archive calculation stops
			-- `a_data' can be the metric tool panel from which metric archive calculation stops.
		do
			set_is_up_to_date (False)
			update_ui
		end

	on_metric_loaded is
			-- Action to be performed when metrics loaded in `metric_manager'
		do
			set_is_metric_reloaded (True)
			set_is_up_to_date (False)
			update_ui
		end

	on_history_recalculation_start (a_data: ANY) is
			-- Action to be performed when archive history recalculation starts
			-- `a_data' can be the metric tool panel from which metric history recalculation starts.
		do
			set_is_up_to_date (False)
			update_ui
		end

	on_history_recalculation_stop (a_data: ANY) is
			-- Action to be performed when archive history recalculation stops
			-- `a_data' can be the metric tool panel from which metric history recalculation stops.
		do
			set_is_up_to_date (False)
			update_ui
		end

	on_metric_sent_to_history (a_archive: EB_METRIC_ARCHIVE_NODE; a_panel: ANY) is
			-- Action to be performed when metric calculation information contained in `a_archive' has been sent to history
		do
			set_is_up_to_date (False)
			set_is_send_to_history_status_up_to_date (False)
			update_ui
		end

feature-- UI Update

	current_selected_metric: EB_METRIC is
			-- Current selected metric
			-- Either a selected metric in `metric_selector' or current quick metric.
			-- Void if no selected metric is available.
		do
			if is_using_quick_metric then
				Result := quick_metric (Void, False)
			else
				Result := metric_selector.selected_metric
			end
		end

	is_selected_metric_valid: BOOLEAN is
			-- Is current selected metric valid?
		local
			l_metric: like current_selected_metric
		do
			l_metric := current_selected_metric
			if l_metric /= Void then
				if is_using_quick_metric then
					metric_validity_checker.check_metric_validity (l_metric, True)
					Result := not metric_validity_checker.has_error
				else
					Result := metric_manager.is_metric_valid (l_metric.name)
				end
			end
		end

	is_selected_input_domain_valid: BOOLEAN is
			-- Is currently selected input domain in `domain_selector' is valid?
		do
			Result := domain_selector.domain.is_valid
		end

	is_metric_runnable: BOOLEAN is
			-- Is metric runnable?
		do
			Result := is_selected_metric_valid and then is_selected_input_domain_valid
		end

	is_reload_metric_definer_safe: BOOLEAN
			-- Is it safe to reload `metric_definer'?

	set_is_reload_metric_definer_safe (b: BOOLEAN) is
			-- Set `is_reload_metric_definer_safe' with `b'.
		do
			is_reload_metric_definer_safe := b
		ensure
			is_reload_metric_definer_safe_set: is_reload_metric_definer_safe = b
		end

	update_ui is
			-- Update interface
		local
			l_metric: like current_selected_metric
		do
			if is_selected and then not is_up_to_date then
				if is_eiffel_compiling or is_archive_calculating or is_history_recalculationg_running or not is_project_loaded then
						-- If no project loaded or eiffel compilation or archive calculation is undergoing, disable current panel
					disable_sensitive
				else
					enable_sensitive
					if is_metric_evaluating then
							-- When metric evaluation is undergoing.
						quick_metric_btn.disable_sensitive
						filter_result_btn.disable_sensitive
						run_metric_btn.disable_sensitive
						auto_go_to_result_btn.disable_sensitive
						metric_definition_area.disable_sensitive
						metric_selection_area.disable_sensitive
						detailed_result_btn.disable_sensitive
						domain_selector.disable_sensitive
						send_to_history_btn.disable_sensitive
						if is_original_starter then
							stop_metric_btn.enable_sensitive
							metric_value_text.set_text (metric_names.e_evaluating_value)
						else
							stop_metric_btn.disable_sensitive
						end
					else
						metric_tool.load_metrics_and_display_error (False, metric_names.t_loading_metrics)
						if not metric_tool.is_metric_validation_checked.item then
							metric_tool.check_metric_validation (metric_tool.develop_window)
						end
						if is_metric_reloaded then
							set_is_metric_reloaded (False)
							metric_selector.load_metrics (True)
							metric_selector.try_to_selected_last_metric
						end
						quick_metric_btn.enable_sensitive
						filter_result_btn.enable_sensitive
						auto_go_to_result_btn.enable_sensitive
						domain_selector.enable_sensitive
						domain_selector.block_domain_change_actions
						domain_selector.refresh
						domain_selector.resume_domain_change_actions
						metric_selection_area.enable_sensitive
						metric_definition_area.enable_sensitive
						stop_metric_btn.disable_sensitive
						if metric_definer.is_editor_initialized then
							if is_reload_metric_definer_safe then
								metric_definer.change_actions.block
								metric_definer.change_actions_internal.block
								metric_definer.load_metric (metric_definer.metric, False)
								metric_definer.change_actions_internal.resume
								metric_definer.change_actions.resume
							end
						end
						l_metric := current_selected_metric
						if l_metric /= Void and then l_metric.is_ratio then
							if show_percent_btn.data = Void then
								show_percent_btn.set_data (True)
							end
							if percentage_tool_bar.is_empty then
								percentage_tool_bar.extend (show_percent_btn)
							end
							show_percent_btn.enable_sensitive
						else
							show_percent_btn.disable_sensitive
							percentage_tool_bar.wipe_out
						end
						if l_metric /= Void then
							if l_metric.is_basic then
								detailed_result_btn.enable_sensitive
							else
								detailed_result_btn.disable_sensitive
							end
						end
						if is_metric_runnable then
							run_metric_btn.enable_sensitive
						else
							run_metric_btn.disable_sensitive
						end
						if not is_send_to_history_status_up_to_date then
							if is_original_starter and then (is_last_evaluation_successful and then not last_metric_value_historyed) then
								send_to_history_btn.enable_sensitive
							else
								send_to_history_btn.disable_sensitive
							end
							set_is_send_to_history_status_up_to_date (True)
						end
					end
				end
				set_is_up_to_date (True)
			end
		end

invariant
	metric_tool_attached: metric_tool /= Void
	domain_generator_internal_attached: domain_generator_internal /= Void
	on_stop_metric_evaluation_agent_attached: on_stop_metric_evaluation_agent /= Void
	on_process_gui_agent_attached: on_process_gui_agent /= Void
	on_unit_order_change_agent_attached: on_unit_order_change_agent /= Void
	detailed_result_btn_attached: detailed_result_btn /= Void
	filter_result_btn_attached: filter_result_btn /= Void
	auto_go_to_result_btn_attached: auto_go_to_result_btn /= Void
	show_percent_btn_attached: show_percent_btn /= Void

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


end -- class EB_METRIC_EVALUATION_PANEL

