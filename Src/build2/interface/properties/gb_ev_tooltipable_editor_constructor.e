indexing
	description: "Builds an attrribute editor for modification of objects of type EV_TOOLTIPABLE."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	GB_EV_TOOLTIPABLE_EDITOR_CONSTRUCTOR
	
inherit
	GB_EV_EDITOR_CONSTRUCTOR
		undefine
			default_create
		end
		
feature -- Access

	ev_type: EV_TOOLTIPABLE
		-- Vision2 type represented by `Current'.
		
	type: STRING is "EV_TOOLTIPABLE"
		-- String representation of object_type modifyable by `Current'.

	attribute_editor: GB_OBJECT_EDITOR_ITEM is
			-- A vision2 component to enable modification
			-- of items held in `objects'.
		local
			label: EV_LABEL
		do
			create Result
			initialize_attribute_editor (Result)
			create tooltip_entry.make (Current, Result, tooltip_string, Gb_ev_tooltipable_tooltip , Gb_ev_tooltipable_tooltip_tooltip,
				agent set_tooltip (?), agent validate_true (?), single_line_entry)

			update_attribute_editor
			disable_all_items (Result)
			align_labels_left (Result)
		end
		
	update_attribute_editor is
			-- Update status of `attribute_editor' to reflect information
			-- from `objects.first'.
		do
			tooltip_entry.set_text (first.tooltip)
		end
		
feature {NONE} -- Implementation
	
	tooltip_entry: GB_STRING_INPUT_FIELD
		-- Holds the text to be used for the tooltip.
		
	set_tooltip (a_tooltip: STRING) is
			-- Assign text of `tooltip_entry' to tooltip of all objects.
		do
			if not a_tooltip.is_empty then
				for_all_objects (agent {EV_TOOLTIPABLE}.set_tooltip (a_tooltip))
			else
				for_all_objects (agent {EV_TOOLTIPABLE}.remove_tooltip)
			end
		end

	Tooltip_string: STRING is "Tooltip"

end -- class GB_EV_TOOLTIPABLE_EDITOR_CONSTRUCTOR
