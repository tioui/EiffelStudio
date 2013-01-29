note
	description: "Objects that represent an EV_TITLED_WINDOW.%
		%The original version of this class was generated by EiffelBuild."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WIZARD_MAIN_WINDOW_IMP

inherit
	EV_TITLED_WINDOW
		redefine
			initialize, is_in_default_state
		end

	WIZARD_CONSTANTS
		undefine
			is_equal, default_create, copy
		end

-- This class is the implementation of an EV_TITLED_WINDOW generated by EiffelBuild.
-- You should not modify this code by hand, as it will be re-generated every time
-- modifications are made to the project.

feature {NONE}-- Initialization

	initialize
			-- Initialize `Current'.
		do
			Precursor {EV_TITLED_WINDOW}
			initialize_constants

				-- Create all widgets.
			create menu
			create file_menu
			create exit_menu_item
			create help_menu
			create help_menu_item
			create l_ev_menu_separator_1
			create about_menu_item
			create notebook
			create settings_box
			create settings_inner_box
			create project_frame
			create project_outter_box
			create project_box
			create l_ev_vertical_box_1
			create l_ev_cell_1
			create project_button
			create project_type_frame
			create project_type_box
			create project_type_label
			create project_type_buttons_box
			create project_types_padding_cell
			create project_type_internal_buttons_box
			create com_client_project_radio_button
			create com_server_project_radio_button
			create eiffel_project_radio_button
			create l_ev_cell_2
			create general_settings_frame
			create general_settings_box
			create eiffel_project_box
			create com_project_box
			create settings_padding_cell
			create settings_bottom_box
			create l_ev_horizontal_separator_1
			create buttons_box
			create left_padding_cell
			create first_generate_button
			create l_ev_horizontal_box_1
			create right_padding_cell
			create next_button
			create generation_options_outter_box
			create generation_options_inner_box
			create component_type_outter_box
			create component_type_frame
			create component_type_box
			create component_type_label
			create component_type_hbox
			create component_type_padding_cell
			create component_type_vbox
			create in_process_radio_button
			create out_of_process_radio_button
			create generation_options_frame
			create generation_options_box
			create destination_folder_box
			create compilation_box
			create compile_label
			create compile_box
			create compile_padding_cell
			create compile_buttons_box
			create compile_c_code_check_button
			create compile_eiffel_check_button
			create backup_box
			create backup_label
			create backup_inner_box
			create backup_padding_cell
			create backup_buttons_box
			create cleanup_radio_button
			create backup_radio_button
			create overwrite_radio_button
			create generation_options_padding_cell
			create general_options_bottom_box
			create separator
			create general_options_bottom_buttons_box
			create l_ev_horizontal_box_2
			create previous_button
			create l_ev_cell_3
			create second_generate_button
			create l_ev_cell_4
			create output_box

				-- Build_widget_structure.
			set_menu_bar (menu)
			menu.extend (file_menu)
			file_menu.extend (exit_menu_item)
			menu.extend (help_menu)
			help_menu.extend (help_menu_item)
			help_menu.extend (l_ev_menu_separator_1)
			help_menu.extend (about_menu_item)
			extend (notebook)
			notebook.extend (settings_box)
			settings_box.extend (settings_inner_box)
			settings_inner_box.extend (project_frame)
			project_frame.extend (project_outter_box)
			project_outter_box.extend (project_box)
			project_outter_box.extend (l_ev_vertical_box_1)
			l_ev_vertical_box_1.extend (l_ev_cell_1)
			l_ev_vertical_box_1.extend (project_button)
			settings_inner_box.extend (project_type_frame)
			project_type_frame.extend (project_type_box)
			project_type_box.extend (project_type_label)
			project_type_box.extend (project_type_buttons_box)
			project_type_buttons_box.extend (project_types_padding_cell)
			project_type_buttons_box.extend (project_type_internal_buttons_box)
			project_type_internal_buttons_box.extend (com_client_project_radio_button)
			project_type_internal_buttons_box.extend (com_server_project_radio_button)
			project_type_internal_buttons_box.extend (eiffel_project_radio_button)
			project_type_buttons_box.extend (l_ev_cell_2)
			settings_inner_box.extend (general_settings_frame)
			general_settings_frame.extend (general_settings_box)
			general_settings_box.extend (eiffel_project_box)
			general_settings_box.extend (com_project_box)
			settings_box.extend (settings_padding_cell)
			settings_box.extend (settings_bottom_box)
			settings_bottom_box.extend (l_ev_horizontal_separator_1)
			settings_bottom_box.extend (buttons_box)
			buttons_box.extend (left_padding_cell)
			buttons_box.extend (first_generate_button)
			buttons_box.extend (l_ev_horizontal_box_1)
			l_ev_horizontal_box_1.extend (right_padding_cell)
			l_ev_horizontal_box_1.extend (next_button)
			notebook.extend (generation_options_outter_box)
			generation_options_outter_box.extend (generation_options_inner_box)
			generation_options_inner_box.extend (component_type_outter_box)
			component_type_outter_box.extend (component_type_frame)
			component_type_frame.extend (component_type_box)
			component_type_box.extend (component_type_label)
			component_type_box.extend (component_type_hbox)
			component_type_hbox.extend (component_type_padding_cell)
			component_type_hbox.extend (component_type_vbox)
			component_type_vbox.extend (in_process_radio_button)
			component_type_vbox.extend (out_of_process_radio_button)
			generation_options_inner_box.extend (generation_options_frame)
			generation_options_frame.extend (generation_options_box)
			generation_options_box.extend (destination_folder_box)
			generation_options_box.extend (compilation_box)
			compilation_box.extend (compile_label)
			compilation_box.extend (compile_box)
			compile_box.extend (compile_padding_cell)
			compile_box.extend (compile_buttons_box)
			compile_buttons_box.extend (compile_c_code_check_button)
			compile_buttons_box.extend (compile_eiffel_check_button)
			generation_options_box.extend (backup_box)
			backup_box.extend (backup_label)
			backup_box.extend (backup_inner_box)
			backup_inner_box.extend (backup_padding_cell)
			backup_inner_box.extend (backup_buttons_box)
			backup_buttons_box.extend (cleanup_radio_button)
			backup_buttons_box.extend (backup_radio_button)
			backup_buttons_box.extend (overwrite_radio_button)
			generation_options_outter_box.extend (generation_options_padding_cell)
			generation_options_outter_box.extend (general_options_bottom_box)
			general_options_bottom_box.extend (separator)
			general_options_bottom_box.extend (general_options_bottom_buttons_box)
			general_options_bottom_buttons_box.extend (l_ev_horizontal_box_2)
			l_ev_horizontal_box_2.extend (previous_button)
			l_ev_horizontal_box_2.extend (l_ev_cell_3)
			general_options_bottom_buttons_box.extend (second_generate_button)
			general_options_bottom_buttons_box.extend (l_ev_cell_4)
			notebook.extend (output_box)

			file_menu.set_text ("File")
			exit_menu_item.set_text ("Exit")
			help_menu.set_text ("Help")
			help_menu_item.set_text ("Help")
			help_menu_item.set_pixmap (help_png)
			about_menu_item.set_text ("About")
			settings_box.set_padding_width (5)
			settings_box.disable_item_expand (settings_inner_box)
			settings_box.disable_item_expand (settings_bottom_box)
			settings_inner_box.set_padding_width (7)
			settings_inner_box.set_border_width (5)
			settings_inner_box.disable_item_expand (project_frame)
			settings_inner_box.disable_item_expand (project_type_frame)
			settings_inner_box.disable_item_expand (general_settings_frame)
			project_frame.set_text ("Project")
			project_outter_box.set_padding_width (5)
			project_outter_box.set_border_width (7)
			project_outter_box.disable_item_expand (l_ev_vertical_box_1)
			l_ev_vertical_box_1.disable_item_expand (project_button)
			project_button.disable_sensitive
			project_button.set_text ("Delete")
			project_button.set_minimum_width (100)
			project_type_frame.set_text ("Project Type")
			project_type_box.set_padding_width (7)
			project_type_box.set_border_width (7)
			project_type_label.set_text ("What would you like to do?")
			project_type_label.align_text_left
			project_type_buttons_box.disable_item_expand (project_types_padding_cell)
			project_types_padding_cell.set_minimum_width (30)
			com_client_project_radio_button.set_text ("Access an existing COM component")
			com_server_project_radio_button.set_text ("Create a new COM component")
			eiffel_project_radio_button.set_text ("Add a COM interface to an existing (non-.NET) Eiffel project")
			general_settings_frame.set_text ("Component Information")
			general_settings_box.set_padding_width (7)
			general_settings_box.set_border_width (7)
			settings_bottom_box.set_padding_width (7)
			settings_bottom_box.disable_item_expand (l_ev_horizontal_separator_1)
			settings_bottom_box.disable_item_expand (buttons_box)
			buttons_box.set_padding_width (7)
			buttons_box.set_border_width (7)
			buttons_box.disable_item_expand (first_generate_button)
			left_padding_cell.set_minimum_width (100)
			first_generate_button.set_text ("Generate")
			first_generate_button.set_minimum_width (100)
			l_ev_horizontal_box_1.disable_item_expand (next_button)
			next_button.set_text ("Next >>")
			next_button.set_minimum_width (100)
			generation_options_outter_box.set_padding_width (5)
			generation_options_outter_box.disable_item_expand (generation_options_inner_box)
			generation_options_outter_box.disable_item_expand (general_options_bottom_box)
			generation_options_inner_box.set_padding_width (7)
			generation_options_inner_box.set_border_width (5)
			generation_options_inner_box.disable_item_expand (component_type_outter_box)
			generation_options_inner_box.disable_item_expand (generation_options_frame)
			component_type_outter_box.disable_item_expand (component_type_frame)
			component_type_frame.set_text ("Component Type")
			component_type_box.set_padding_width (7)
			component_type_box.set_border_width (7)
			component_type_label.set_text ("A COM component can either be out-of-process (i.e. an executable that runs in a separate process)%Nor in-process (i.e. a DLL that is loaded in the client process). Is the COM component:")
			component_type_label.align_text_left
			component_type_hbox.disable_item_expand (component_type_padding_cell)
			component_type_padding_cell.set_minimum_width (10)
			component_type_vbox.disable_item_expand (in_process_radio_button)
			component_type_vbox.disable_item_expand (out_of_process_radio_button)
			in_process_radio_button.set_text ("In-process (*.dll)")
			out_of_process_radio_button.set_text ("Out-of-process (*.exe)")
			generation_options_frame.set_text ("Generation Options")
			generation_options_box.set_padding_width (7)
			generation_options_box.set_border_width (7)
			generation_options_box.disable_item_expand (destination_folder_box)
			generation_options_box.disable_item_expand (compilation_box)
			compilation_box.set_padding_width (5)
			compilation_box.disable_item_expand (compile_label)
			compilation_box.disable_item_expand (compile_box)
			compile_label.set_text ("By default the EiffelCOM wizard compiles the generated Eiffel and C code.%NCompiling the Eiffel code requires compiling the C code.")
			compile_label.align_text_left
			compile_box.disable_item_expand (compile_padding_cell)
			compile_padding_cell.set_minimum_width (10)
			compile_buttons_box.disable_item_expand (compile_c_code_check_button)
			compile_buttons_box.disable_item_expand (compile_eiffel_check_button)
			compile_c_code_check_button.enable_select
			compile_c_code_check_button.set_text ("Compile C code")
			compile_eiffel_check_button.enable_select
			compile_eiffel_check_button.set_text ("Compile Eiffel code")
			backup_box.set_padding_width (5)
			backup_box.disable_item_expand (backup_label)
			backup_box.disable_item_expand (backup_inner_box)
			backup_label.set_text ("The Wizard can delete all files in the destination folder before generating new files.%NAlternatively, it can backup files it overwrites or just overwrite them with no backup.")
			backup_label.align_text_left
			backup_inner_box.disable_item_expand (backup_padding_cell)
			backup_padding_cell.set_minimum_width (10)
			backup_buttons_box.disable_item_expand (backup_radio_button)
			cleanup_radio_button.set_text ("Clean destination folder prior to generation")
			backup_radio_button.set_text ("Backup overwritten files by adding the extension '.bac'")
			overwrite_radio_button.set_text ("Overwrite existing files")
			general_options_bottom_box.set_padding_width (7)
			general_options_bottom_box.disable_item_expand (separator)
			general_options_bottom_box.disable_item_expand (general_options_bottom_buttons_box)
			general_options_bottom_buttons_box.set_padding_width (7)
			general_options_bottom_buttons_box.set_border_width (7)
			general_options_bottom_buttons_box.disable_item_expand (second_generate_button)
			l_ev_horizontal_box_2.disable_item_expand (previous_button)
			previous_button.set_text ("<< Previous")
			previous_button.set_minimum_width (100)
			second_generate_button.set_text ("Generate")
			second_generate_button.set_minimum_width (100)
			l_ev_cell_4.set_minimum_width (100)
			set_title ("EiffelCOM Wizard 2.0")

				--Connect events.
			exit_menu_item.select_actions.extend (agent on_exit)
			help_menu_item.select_actions.extend (agent on_help)
			about_menu_item.select_actions.extend (agent on_about)
			project_button.select_actions.extend (agent on_project_button_select)
			com_client_project_radio_button.select_actions.extend (agent on_select_com_client)
			com_server_project_radio_button.select_actions.extend (agent on_select_com_server)
			eiffel_project_radio_button.select_actions.extend (agent on_select_eiffel_project)
			first_generate_button.select_actions.extend (agent on_generate)
			next_button.select_actions.extend (agent on_next)
			in_process_radio_button.select_actions.extend (agent on_select_in_process)
			out_of_process_radio_button.select_actions.extend (agent on_select_out_of_process)
			compile_c_code_check_button.select_actions.extend (agent on_select_compile_c)
			compile_eiffel_check_button.select_actions.extend (agent on_select_compile_eiffel)
			cleanup_radio_button.select_actions.extend (agent on_select_cleanup)
			backup_radio_button.select_actions.extend (agent on_select_backup)
			overwrite_radio_button.select_actions.extend (agent on_select_overwrite)
			previous_button.select_actions.extend (agent on_previous)
			second_generate_button.select_actions.extend (agent on_generate)
				-- Close the application when an interface close
				-- request is received on `Current'. i.e. the cross is clicked.

				-- Call `user_initialization'.
			user_initialization
		end

feature -- Access

	exit_menu_item, help_menu_item, about_menu_item: EV_MENU_ITEM
	project_box: WIZARD_FIELD_BOX
	notebook: EV_NOTEBOOK
	destination_folder_box: WIZARD_FOLDER_PATH_BOX
	compile_c_code_check_button,
	compile_eiffel_check_button: EV_CHECK_BUTTON
	separator: EV_HORIZONTAL_SEPARATOR
	file_menu, help_menu: EV_MENU
	com_client_project_radio_button,
	com_server_project_radio_button, eiffel_project_radio_button, in_process_radio_button,
	out_of_process_radio_button, cleanup_radio_button, backup_radio_button, overwrite_radio_button: EV_RADIO_BUTTON
	menu: EV_MENU_BAR
	com_project_box: WIZARD_COM_PROJECT_BOX
	settings_box,
	settings_inner_box, project_type_box, project_type_internal_buttons_box, general_settings_box,
	settings_bottom_box, generation_options_outter_box, generation_options_inner_box,
	component_type_outter_box, component_type_box, component_type_vbox, generation_options_box,
	compilation_box, compile_buttons_box, backup_box, backup_buttons_box, general_options_bottom_box: EV_VERTICAL_BOX
	project_outter_box,
	project_type_buttons_box, buttons_box, component_type_hbox, compile_box, backup_inner_box,
	general_options_bottom_buttons_box: EV_HORIZONTAL_BOX
	output_box: WIZARD_OUTPUT_BOX
	project_type_label, component_type_label,
	compile_label, backup_label: EV_LABEL
	project_button, first_generate_button, next_button,
	previous_button, second_generate_button: EV_BUTTON
	project_frame, project_type_frame, general_settings_frame,
	component_type_frame, generation_options_frame: EV_FRAME
	project_types_padding_cell, settings_padding_cell,
	left_padding_cell, right_padding_cell, component_type_padding_cell, compile_padding_cell,
	backup_padding_cell, generation_options_padding_cell: EV_CELL
	eiffel_project_box: WIZARD_EIFFEL_PROJECT_BOX

feature {NONE} -- Implementation

	l_ev_horizontal_separator_1: EV_HORIZONTAL_SEPARATOR
	l_ev_vertical_box_1: EV_VERTICAL_BOX
	l_ev_horizontal_box_1, l_ev_horizontal_box_2: EV_HORIZONTAL_BOX
	l_ev_menu_separator_1: EV_MENU_SEPARATOR
	l_ev_cell_1,
	l_ev_cell_2, l_ev_cell_3, l_ev_cell_4: EV_CELL

feature {NONE} -- Implementation

	is_in_default_state: BOOLEAN
			-- Is `Current' in its default state?
		do
			-- Re-implement if you wish to enable checking
			-- for `Current'.
			Result := True
		end

	user_initialization
			-- Feature for custom initialization, called at end of `initialize'.
		deferred
		end

	on_exit
			-- Called by `select_actions' of `exit_menu_item'.
		deferred
		end

	on_help
			-- Called by `select_actions' of `help_menu_item'.
		deferred
		end

	on_about
			-- Called by `select_actions' of `about_menu_item'.
		deferred
		end

	on_project_button_select
			-- Called by `select_actions' of `project_button'.
		deferred
		end

	on_select_com_client
			-- Called by `select_actions' of `com_client_project_radio_button'.
		deferred
		end

	on_select_com_server
			-- Called by `select_actions' of `com_server_project_radio_button'.
		deferred
		end

	on_select_eiffel_project
			-- Called by `select_actions' of `eiffel_project_radio_button'.
		deferred
		end

	on_generate
			-- Called by `select_actions' of `first_generate_button'.
		deferred
		end

	on_next
			-- Called by `select_actions' of `next_button'.
		deferred
		end

	on_select_in_process
			-- Called by `select_actions' of `in_process_radio_button'.
		deferred
		end

	on_select_out_of_process
			-- Called by `select_actions' of `out_of_process_radio_button'.
		deferred
		end

	on_select_compile_c
			-- Called by `select_actions' of `compile_c_code_check_button'.
		deferred
		end

	on_select_compile_eiffel
			-- Called by `select_actions' of `compile_eiffel_check_button'.
		deferred
		end

	on_select_cleanup
			-- Called by `select_actions' of `cleanup_radio_button'.
		deferred
		end

	on_select_backup
			-- Called by `select_actions' of `backup_radio_button'.
		deferred
		end

	on_select_overwrite
			-- Called by `select_actions' of `overwrite_radio_button'.
		deferred
		end

	on_previous
			-- Called by `select_actions' of `previous_button'.
		deferred
		end


note
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
end -- class WIZARD_MAIN_WINDOW_IMP
