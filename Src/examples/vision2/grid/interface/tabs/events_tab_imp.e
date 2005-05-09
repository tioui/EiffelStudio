indexing
	description: "Objects that represent an EV_TITLED_WINDOW.%
		%The original version of this class was generated by EiffelBuild."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EVENTS_TAB_IMP

inherit
	EV_VERTICAL_BOX
		redefine
			initialize, is_in_default_state
		end
			
	CONSTANTS
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
			create no_events_button
			create enable_event_tracking
			create event_list
			create l_ev_table_1
			create highlight_items_on_motion
			create show_events_in_items
			
				-- Build_widget_structure.
			extend (no_events_button)
			extend (enable_event_tracking)
			extend (event_list)
			extend (l_ev_table_1)
			
			no_events_button.set_text ("No Event Connection")
			enable_event_tracking.set_text ("Enable Event Tracking")
			event_list.disable_sensitive
			l_ev_table_1.resize (1, 2)
			l_ev_table_1.set_row_spacing (box_padding)
			l_ev_table_1.set_column_spacing (box_padding)
				-- Insert and position all children of `l_ev_table_1'.
			l_ev_table_1.put_at_position (highlight_items_on_motion, 1, 1, 1, 1)
			l_ev_table_1.put_at_position (show_events_in_items, 1, 2, 1, 1)
			l_ev_table_1.merge_radio_button_groups (Current)
			highlight_items_on_motion.set_text ("Highlight Items on Motion")
			show_events_in_items.set_text ("Show Events in Items")
			set_padding_width (box_padding)
			set_border_width (box_padding)
			disable_item_expand (no_events_button)
			disable_item_expand (enable_event_tracking)
			disable_item_expand (l_ev_table_1)
			merge_radio_button_groups (l_ev_table_1)
			
				--Connect events.
			no_events_button.select_actions.extend (agent no_events_button_selected)
			enable_event_tracking.select_actions.extend (agent enable_event_tracking_selected)
			highlight_items_on_motion.select_actions.extend (agent highlight_items_on_motion_selected)
			show_events_in_items.select_actions.extend (agent show_events_in_items_selected)
				-- Close the application when an interface close
				-- request is recieved on `Current'. i.e. the cross is clicked.

				-- Call `user_initialization'.
			user_initialization
		end

feature -- Access

	no_events_button, enable_event_tracking, highlight_items_on_motion, show_events_in_items: EV_RADIO_BUTTON
	event_list: EV_LIST

feature {NONE} -- Implementation

	l_ev_table_1: EV_TABLE

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
	
	no_events_button_selected is
			-- Called by `select_actions' of `no_events_button'.
		deferred
		end
	
	enable_event_tracking_selected is
			-- Called by `select_actions' of `enable_event_tracking'.
		deferred
		end
	
	highlight_items_on_motion_selected is
			-- Called by `select_actions' of `highlight_items_on_motion'.
		deferred
		end
	
	show_events_in_items_selected is
			-- Called by `select_actions' of `show_events_in_items'.
		deferred
		end
	

end -- class EVENTS_TAB_IMP
