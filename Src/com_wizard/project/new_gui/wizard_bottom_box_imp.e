indexing
	description: "Objects that represent an EV_TITLED_WINDOW.%
		%The original version of this class was generated by EiffelBuild."

deferred class
	WIZARD_BOTTOM_BOX_IMP

inherit
	EV_VERTICAL_BOX
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

	initialize is
			-- Initialize `Current'.
		do
			Precursor {EV_VERTICAL_BOX}
			initialize_constants
			
				-- Create all widgets.
			create separator
			create buttons_box
			create left_padding_cell
			create next_button
			create right_padding_cell
			
				-- Build_widget_structure.
			extend (separator)
			extend (buttons_box)
			buttons_box.extend (left_padding_cell)
			buttons_box.extend (next_button)
			buttons_box.extend (right_padding_cell)
			
			set_padding_width (7)
			disable_item_expand (separator)
			disable_item_expand (buttons_box)
			buttons_box.set_padding_width (7)
			buttons_box.set_border_width (7)
			buttons_box.disable_item_expand (next_button)
			next_button.set_text ("Next >>")
			next_button.set_minimum_width (100)
			
				--Connect events.
			next_button.select_actions.extend (agent on_next)
				-- Close the application when an interface close
				-- request is recieved on `Current'. i.e. the cross is clicked.

				-- Call `user_initialization'.
			user_initialization
		end

feature -- Access

	separator: EV_HORIZONTAL_SEPARATOR
	buttons_box: EV_HORIZONTAL_BOX
	left_padding_cell, right_padding_cell: EV_CELL
	next_button: EV_BUTTON

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
	
	on_next is
			-- Called by `select_actions' of `next_button'.
		deferred
		end
	

end -- class WIZARD_BOTTOM_BOX_IMP
