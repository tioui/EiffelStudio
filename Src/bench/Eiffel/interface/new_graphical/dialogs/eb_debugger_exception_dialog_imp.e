indexing
	description: "Objects that represent an EV_DIALOG.%
		%The original version of this class was generated by EiffelBuild."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EB_DEBUGGER_EXCEPTION_DIALOG_IMP

inherit
	EB_DIALOG_CONSTANTS

feature -- Access

	window: EV_DIALOG
		-- `Result' is widget with which `Current' is implemented

-- This class is the implementation of an EV_DIALOG generated by EiffelBuild.
-- You should not modify this code by hand, as it will be re-generated every time
-- modifications are made to the project.

feature {NONE}-- Initialization

	initialize is
			-- Initialize `Current'.
		do
			initialize_constants
			
				-- Create all widgets.
			create l_ev_vertical_box_1
			create l_ev_horizontal_box_1
			create l_ev_label_1
			create l_ev_cell_1
			create wrapping_button
			create message_text
			create details_box
			create details_text
			create l_ev_horizontal_box_2
			create l_ev_cell_2
			create l_ev_button_1
			create l_ev_cell_3
			create l_ev_button_2
			create l_ev_cell_4
			
				-- Build_widget_structure.
			window.extend (l_ev_vertical_box_1)
			l_ev_vertical_box_1.extend (l_ev_horizontal_box_1)
			l_ev_horizontal_box_1.extend (l_ev_label_1)
			l_ev_horizontal_box_1.extend (l_ev_cell_1)
			l_ev_horizontal_box_1.extend (wrapping_button)
			l_ev_vertical_box_1.extend (message_text)
			l_ev_vertical_box_1.extend (details_box)
			details_box.extend (details_text)
			l_ev_vertical_box_1.extend (l_ev_horizontal_box_2)
			l_ev_horizontal_box_2.extend (l_ev_cell_2)
			l_ev_horizontal_box_2.extend (l_ev_button_1)
			l_ev_horizontal_box_2.extend (l_ev_cell_3)
			l_ev_horizontal_box_2.extend (l_ev_button_2)
			l_ev_horizontal_box_2.extend (l_ev_cell_4)
			
			l_ev_vertical_box_1.set_padding_width (tiny_padding)
			l_ev_vertical_box_1.set_border_width (small_padding)
			l_ev_vertical_box_1.disable_item_expand (l_ev_horizontal_box_1)
			l_ev_vertical_box_1.disable_item_expand (details_box)
			l_ev_vertical_box_1.disable_item_expand (l_ev_horizontal_box_2)
			l_ev_horizontal_box_1.disable_item_expand (l_ev_label_1)
			l_ev_horizontal_box_1.disable_item_expand (wrapping_button)
			l_ev_label_1.set_text (" Exception message from debugger")
			l_ev_label_1.set_minimum_height (20)
			wrapping_button.enable_select
			wrapping_button.set_text ("wrap")
			message_text.set_minimum_width (300)
			message_text.set_minimum_height (80)
			message_text.disable_edit
			details_box.set_text ("Additional details")
			l_ev_horizontal_box_2.set_padding_width (tiny_padding)
			l_ev_horizontal_box_2.set_border_width (small_padding)
			l_ev_horizontal_box_2.disable_item_expand (l_ev_button_1)
			l_ev_horizontal_box_2.disable_item_expand (l_ev_button_2)
			l_ev_button_1.set_text ("Save")
			l_ev_button_1.set_minimum_width (default_button_width)
			l_ev_button_2.set_text (close_string)
			l_ev_button_2.set_minimum_width (default_button_width)
			window.set_minimum_width (400)
			window.set_title ("Debugger :: Exception message")
			
				--Connect events.
			wrapping_button.select_actions.extend (agent set_wrapping_mode)
			l_ev_button_1.select_actions.extend (agent save_exception_message)
			l_ev_button_2.select_actions.extend (agent close_dialog)
				-- Close the application when an interface close
				-- request is recieved on `Current'. i.e. the cross is clicked.

				-- Call `user_initialization'.
			user_initialization
		end

feature -- Basic operation

	show is
			-- Show `Current'.
		do
			window.show
		end

feature -- Access

	wrapping_button: EV_CHECK_BUTTON
	message_text: EV_TEXT
	details_text: EV_LABEL
	details_box: EV_FRAME

feature {NONE} -- Implementation

	l_ev_vertical_box_1: EV_VERTICAL_BOX
	l_ev_horizontal_box_1, l_ev_horizontal_box_2: EV_HORIZONTAL_BOX
	l_ev_label_1: EV_LABEL
	l_ev_button_1,
	l_ev_button_2: EV_BUTTON
	l_ev_cell_1, l_ev_cell_2, l_ev_cell_3, l_ev_cell_4: EV_CELL

feature {NONE} -- Implementation

	is_in_default_state: BOOLEAN is
			-- Is `Current' in its default state?
		do
			-- Re-implement if you wish to enable checking
			-- for `Current'.
			Result := True
		end
	
	user_initialization is
			-- Feature for custom initialization, called at end of `initialize'.
		deferred
		end
	
	set_wrapping_mode is
			-- Called by `select_actions' of `wrapping_button'.
		deferred
		end
	
	save_exception_message is
			-- Called by `select_actions' of `l_ev_button_1'.
		deferred
		end
	
	close_dialog is
			-- Called by `select_actions' of `l_ev_button_2'.
		deferred
		end
	

end -- class EB_DEBUGGER_EXCEPTION_DIALOG_IMP
