indexing 
	description: "WIZARD_GENERATED_CODE_TYPE_DIALOG class created by Resource Bench."

class 
	WIZARD_GENERATED_CODE_TYPE_DIALOG

inherit
	WIZARD_DIALOG
		redefine
			setup_dialog,
			on_ok,
			notify
		end

	APPLICATION_IDS
		export
			{NONE} all
		end

creation
	make

feature {NONE} -- Initialization

	make (a_parent: WEL_COMPOSITE_WINDOW) is
			-- Create the dialog.
		require
			a_parent_not_void: a_parent /= Void
			a_parent_exists: a_parent.exists
		do
			make_by_id (a_parent, Wizard_generated_code_type_dialog_constant)
			create client_radio.make_by_id (Current, Client_radio_constant)
			create server_radio.make_by_id (Current, Server_radio_constant)
			create eiffel_code_compilation_check.make_by_id (Current, Eiffel_code_compilation_check_constant)
			create c_code_compilation_check.make_by_id (Current, C_code_compilation_check_constant)
			create in_process_check.make_by_id (Current, In_process_check_constant)
			create out_of_process_check.make_by_id (Current, out_of_process_check_constant)
			create id_ok.make_by_id (Current, Idok)
			create id_cancel.make_by_id (Current, Idcancel)
			create help_button.make_by_id (Current, Help_button_constant)
			help_topic_id := 732
			create id_back.make_by_id (Current, Id_back_constant)
		end

feature -- Behavior

	setup_dialog is
			-- Initialize dialog's controls.
		do
			Precursor {WIZARD_DIALOG}
			uncheck_all

			if shared_wizard_environment.new_eiffel_project then
				client_radio.disable
				server_radio.set_checked
			else
				if shared_wizard_environment.client then
					client_radio.set_checked
				end
			end

			if shared_wizard_environment.server or shared_wizard_environment.new_eiffel_project then
				server_radio.set_checked
			end
			if shared_wizard_environment.in_process_server then
				in_process_check.set_checked
			end
			if shared_wizard_environment.out_of_process_server then
				out_of_process_check.set_checked
			end
			if not shared_wizard_environment.compile_eiffel then
				eiffel_code_compilation_check.set_checked
			end
			if not shared_wizard_environment.compile_c then
				c_code_compilation_check.set_checked
			end
		end

	on_ok is
			-- Process Next button activation.
		do
			shared_wizard_environment.set_client_server (client_radio.checked, server_radio.checked)
			shared_wizard_environment.set_in_process_server (in_process_check.checked)
			shared_wizard_environment.set_out_of_process_server (out_of_process_check.checked)
			Shared_wizard_environment.set_compile_eiffel (not eiffel_code_compilation_check.checked)			
			Shared_wizard_environment.set_compile_c (not c_code_compilation_check.checked)
			Precursor {WIZARD_DIALOG}
		end

	notify (control: WEL_CONTROL; notify_code: INTEGER) is
			-- A `notify_code' is received for `control'.
		do
			if control = c_code_compilation_check then
				if c_code_compilation_check.checked then
					eiffel_code_compilation_check.set_checked
					eiffel_code_compilation_check.disable
				else
					if not Shared_wizard_environment.compile_eiffel then
						eiffel_code_compilation_check.set_checked
					else
						eiffel_code_compilation_check.set_unchecked
					end
					eiffel_code_compilation_check.enable
				end
			end
		end

feature -- Access

	client_radio: WEL_CHECK_BOX
			-- Client code generation check box

	server_radio: WEL_CHECK_BOX
			-- Server code generation check box

	eiffel_code_compilation_check: WEL_CHECK_BOX
			-- Eiffel code compilation check box

	c_code_compilation_check: WEL_CHECK_BOX
			-- Eiffel code compilation check box

	in_process_check: WEL_RADIO_BUTTON
			-- In process radio button

	out_of_process_check: WEL_RADIO_BUTTON
			-- Out of process radio button

feature {NONE} -- Implementation

	uncheck_all is
			-- Uncheck all buttons.
		do
			client_radio.set_unchecked
			server_radio.set_unchecked
			in_process_check.set_unchecked
			out_of_process_check.set_unchecked
		end

end -- class WIZARD_GENERATED_CODE_TYPE_DIALOG

--|-------------------------------------------------------------------
--| This class was automatically generated by Resource Bench
--| Copyright (C) 1996-1997, Interactive Software Engineering, Inc.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Information e-mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|-------------------------------------------------------------------
