indexing
	description: "Context that represents a vertical box."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	VERTICAL_BOX_C

inherit
	BOX_C
		redefine
			gui_object
		end

feature -- GUI object creation

	create_gui_object (a_parent: EV_CONTAINER) is
		do
			create gui_object.make (a_parent)
			gui_object.set_border_width (5)
			gui_object.set_spacing (5)
		end

feature -- Type data

	symbol: EV_PIXMAP is
		do
			create Result.make_with_size (0, 0)
		end

	type: CONTEXT_TYPE [like Current] is
		do
			Result := context_catalog.container_page.vbox_type
		end

feature {NONE} -- Internal namer

	namer: NAMER is
		once
			create Result.make ("Vertical box")
		end

feature -- Code generation

	eiffel_type: STRING is "EV_VERTICAL_BOX"

	full_type_name: STRING is "Vertical box"

feature -- Implementation

	gui_object: EV_VERTICAL_BOX

end -- class VERTICAL_BOX_C

