indexing
	description: "Objects that represent an EV_TITLED_WINDOW.%
		%The original version of this class was generated by EiffelBuild."
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_MAIN_WINDOW

inherit
	WIZARD_MAIN_WINDOW_IMP

	WIZARD_VALIDITY_CHECKER
		undefine
			default_create,
			copy,
			is_equal
		end

feature {NONE} -- Initialization
	
	user_initialization is
			-- called by `initialize'.
			-- Any custom user initialization that
			-- could not be performed in `initialize',
			-- (due to regeneration of implementation class)
			-- can be added here.
		do
			initialize_checker
			close_request_actions.extend (agent on_exit)
			com_project_box.hide
			settings_bottom_box.setup (agent notebook.select_item (generation_options_outter_box), "Next  >>")
			general_options_bottom_box.setup (agent on_generate, "Generate")
			destination_folder_box.setup ("Generate files into:", "destination_key", "Browse for destination folder", agent is_valid_destination_folder)
			custom_marshaller_path_box.setup ("Path to custom marshaller DLL:", "marshaller_key", agent is_valid_marshaller, create {ARRAYED_LIST [TUPLE [STRING, STRING]]}.make_from_array (<<["*.dll","DLL file (*.dll)"]>>), "Browse for custom marshaller DLL")
			set_validator (agent initialize_generate_button)
			eiffel_project_box.set_validator (agent initialize_generate_button)
			com_project_box.set_validator (agent initialize_generate_button)
		end

feature {NONE} -- Implementation

	on_open is
			-- Called by `select_actions' of `open_menu_item'.
		do
		end

	on_save is
			-- Called by `select_actions' of `save_menu_item'.
		do
		end

	on_help is
			-- Called by `select_actions' of `help_menu_item'.
		do
		end

	on_select_eiffel_project is
			-- Called by `select_actions' of `eiffel_project_radio_button'.
		do
			com_project_box.hide
			eiffel_project_box.show
			initialize_generate_button
		end

	on_select_com_server is
			-- Called by `select_actions' of `com_server_project_radio_button'.
		do
			eiffel_project_box.hide
			com_project_box.show
			initialize_generate_button
		end

	on_select_com_client is
			-- Called by `select_actions' of `com_client_project_radio_button'.
		do
			eiffel_project_box.hide
			com_project_box.show
			initialize_generate_button
		end

	on_select_automation is
			-- Called by `select_actions' of `automation_radio_button'.
		do
			custom_marshaller_path_box.disable_sensitive
			initialize_generate_button
		end

	on_select_virtual_universal is
			-- Called by `select_actions' of `virtual_universal_radio_button'.
		do
			custom_marshaller_path_box.disable_sensitive
			initialize_generate_button
		end

	on_select_virtual_custom is
			-- Called by `select_actions' of `virtual_custom_radio_button'.
		do
			custom_marshaller_path_box.enable_sensitive
			initialize_generate_button
		end

	on_no_c_compilation is
			-- Called by `select_actions' of `compile_c_code_check_button'.
			-- Disable no Eiffel compilation check box if selected.
		do
			if compile_c_code_check_button.is_selected then
				compile_eiffel_check_button_was_selected := compile_eiffel_check_button.is_selected
				compile_eiffel_check_button.enable_select
				compile_eiffel_check_button.disable_sensitive
			else
				if not compile_eiffel_check_button_was_selected then
					compile_eiffel_check_button.disable_select
				end
				compile_eiffel_check_button.enable_sensitive
			end
		end

	on_open_folder is
			-- Called by `select_actions' of `open_button'.
		do
		end

	on_open_eiffelstudio is
			-- Called by `select_actions' of `open_eiffel_studio_button'.
		do
		end

	on_exit is
			-- Called by `select_actions' of `exit_button'.
		do
			eiffel_project_box.save_values;
			((create {EV_ENVIRONMENT}).application).destroy
		end

	on_generate is
			-- Check that all required info is there and start generation.
		require
			is_valid: is_valid
		do
			notebook.select_item (output_box)
			eiffel_project_box.save_values
			start_generation
		end

feature {NONE} -- Implementation

	start_generation is
			-- Start files generation
		do
			output_box.display_title ("Starting generation")
		end
		
	is_valid_destination_folder (a_folder: STRING): BOOLEAN is
			-- Check whether destination folder is correctly initialized.
		do
			Result := is_valid_folder (a_folder)
			set_error (Result, "Invalid destination folder")
		end

	is_valid_marshaller (a_file: STRING): BOOLEAN is
			-- Is `a_file' a valid marshaller file?
		do
			Result := not virtual_custom_radio_button.is_selected or else is_valid_file (a_file)
			set_error (Result, "Invalid marshaller file")
		end		

	initialize_generate_button is
			-- Add and remove dummy error to trigger initialization of Generate button sensitivity state.
		do
			general_options_bottom_box.enable_button (is_valid and
				(not eiffel_project_box.is_show_requested or eiffel_project_box.is_valid) and
				(not com_project_box.is_show_requested or com_project_box.is_valid))
		end
		
feature {NONE} -- Private Access

	compile_eiffel_check_button_was_selected: BOOLEAN
			-- Save state of compile eiffel check box to restore it when enabled again

	is_valid_eiffel_project: BOOLEAN
			-- Are settings for Eiffel project valid?

	is_valid_com_project: BOOLEAN
			-- Are settings for COM project valid?

end -- class WIZARD_MAIN_WINDOW

