indexing
	description: "Context that represents a drawing area (EV_DRAWING_AREA)."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	DRAWING_AREA_C

inherit
	PRIMITIVE_C
		redefine
			gui_object
		end

feature -- Type data

	symbol: EV_PIXMAP is
		do
			create Result.make_with_size (0, 0)
		end

	type: CONTEXT_TYPE [like Current] is
		do
			Result := main_window.context_catalog.primitive_page.draw_area_type
		end

feature -- GUI object creation

	create_gui_object (a_parent: EV_CONTAINER) is
		do
			create gui_object.make (a_parent)
		end

feature {NONE} -- Internal namer

	namer: NAMER is
		once
			create Result.make ("Drawing_area")
		end

feature -- Code generation

	eiffel_type: STRING is "EV_DRAWING_AREA"

	full_type_name: STRING is "Drawing area"

feature -- Implementation

	gui_object: EV_DRAWING_AREA

end -- class DRAWING_AREA_C

