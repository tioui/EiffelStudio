note
	description: "[
					Generated by EiffelRibbon tool
					Don't edit this file, since it will be replaced by EiffelRibbon tool
					generated files everytime
																							]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	TAB_SPLIT_BUTTON_IMP

inherit
	EV_RIBBON_TAB

feature {NONE} -- Initialization

	create_interface_objects
			-- Create objects
		do
			create group_split_button.make_with_command_list (<<{COMMAND_NAME_CONSTANTS}.group_split_button>>)
			create group_split_button_2.make_with_command_list (<<{COMMAND_NAME_CONSTANTS}.group_split_button_2>>)

			create groups.make (1)
			groups.extend (group_split_button)
			groups.extend (group_split_button_2)

		end

feature -- Query
	group_split_button: GROUP_SPLIT_BUTTON
	group_split_button_2: GROUP_SPLIT_BUTTON_2


end

