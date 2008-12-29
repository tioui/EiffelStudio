note
	description	: "Owner-draw Static control"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_WEL_STATIC_OWNERDRAW

inherit
	WEL_STATIC
		redefine
			text,
			set_text,
			default_style,
			text_length
		end

create
	make,
	make_by_id

feature -- Status report

	text_length: INTEGER
			-- Text length
		do
			if internal_text /= Void then
				Result := internal_text.count
			else
				Result := 0
			end
		end

feature -- Access

	text: STRING_32
			-- Window text
		do
			if internal_text /= Void then
				Result := internal_text.twin
			else
				Result := ""
			end
		end

feature -- Element change

	set_text (a_new_text: STRING_GENERAL)
			-- Set the window text
		do
			if a_new_text /= Void then
				internal_text := a_new_text.twin
			else
				internal_text := Void
			end
		end

feature {NONE} -- Implementation

	internal_text: STRING_32
			-- Text set to this control. When we use the SS_OWNERDRAW
			-- flag, Windows does not handle the text anymore.

	default_style: INTEGER
			-- Default style used to create the control
		once
			Result := Precursor + Ss_ownerdraw
		end

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class EV_WEL_STATIC_OWNERDRAW

