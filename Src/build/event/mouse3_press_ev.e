indexing
	description: "Widget mouse button 3 press event."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	MOUSE3_PRESS_EV

inherit
	EVENT

creation
	make

feature -- Access

	identifier: INTEGER is
		do
			Result := - Event_const.mouse3_press_ev_id
		end

	symbol: EV_PIXMAP is
		do
			Result := Pixmaps.mouse3_press_pixmap
		end

	internal_name: STRING is
		do
			Result := Event_const.mouse3_press_label
		end

	eiffel_text: STRING is "add_button_press_command (3, "

end -- class MOUSE3_PRESS_EV

