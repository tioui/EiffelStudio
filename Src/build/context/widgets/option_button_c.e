indexing
	description: "Context that represents an option button (EV_OPTION_BUTTON)."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	OPTION_BUTTON_C

inherit
	BUTTON_C
		redefine
			gui_object,
			symbol, type,
			add_pnd_callbacks,
			remove_pnd_callbacks,
			namer,
			eiffel_type,
			full_type_name
		end

	MENU_HOLDER_C
		undefine
			create_context,
			set_modified_flags,
			reset_modified_flags,
			is_able_to_be_grouped
		redefine
			gui_object,
			add_pnd_callbacks,
			remove_pnd_callbacks
		end

feature -- Type data

	symbol: EV_PIXMAP is
		do
			create Result.make_with_size (0, 0)
		end

	type: CONTEXT_TYPE [like Current] is
		do
			Result := context_catalog.menu_page.option_b_type
		end

feature {NONE} -- Pick and drop

	add_pnd_callbacks is
		local
			rcmd: EV_ROUTINE_COMMAND
		do
			{MENU_HOLDER_C} Precursor
			create rcmd.make (~process_type)
			gui_object.add_pnd_command (Pnd_types.menu_child_type, rcmd, Void)
		end

	remove_pnd_callbacks is
		do
			{MENU_HOLDER_C} Precursor
			gui_object.remove_pnd_commands (Pnd_types.menu_child_type)
		end

feature {NONE} -- Internal namer

	namer: NAMER is
		once
			create Result.make ("Option_button")
		end

feature -- Code generation

	eiffel_type: STRING is
		do
			Result := "EV_OPTION_BUTTON"
		end

	full_type_name: STRING is
		do
			Result := "Option button"
		end

feature -- Implementation

	gui_object: EV_OPTION_BUTTON

end -- class OPTION_BUTTON_C

