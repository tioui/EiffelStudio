indexing
	description	: "Wizard Step."
	author		: "Generated by the Wizard wizard"
	revision	: "1.0.0"

class
	WIZARD_FOURTH_STATE

inherit
	WIZARD_INTERMEDIARY_STATE_WINDOW
		redefine
			update_state_information,
			proceed_with_current_info,
			build
		end

	GB_SHARED_TOOLS
	
	GB_WIDGET_UTILITIES
	
	GB_SHARED_COMMAND_HANDLER
	
	GB_SHARED_XML_HANDLER

create
	make

feature -- Basic Operation

	build is 
			-- Build entries.
		do 
			command_handler.update
			graphically_replace_window (main_window, first_window)
			if not xml_handler.components_loaded then
				xml_handler.load_components	
			end
			set_updatable_entries(<<>>)
		end

	proceed_with_current_info is
			-- User has clicked next, go to next step.
		do
			Precursor
			proceed_with_new_state(create {WIZARD_FINAL_STATE}.make(wizard_information))
		end

	update_state_information is
			-- Check User Entries
		do
			Precursor
		end

feature {NONE} -- Implementation

	display_state_text is
			-- Set the messages for this state.
		do
			title.set_text ("Add Your Title Here (Step 5).")
			subtitle.set_text ("Add your subtitle here.")
			message.set_text ("Add your message for this step here.")
		end

end -- class WIZARD_FOURTH_STATE
