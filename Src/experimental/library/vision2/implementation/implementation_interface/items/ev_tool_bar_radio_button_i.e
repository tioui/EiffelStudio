note
	description:
		" EiffelVision tool-bar radio button. implementation%
		% interface."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_TOOL_BAR_RADIO_BUTTON_I

inherit
	EV_TOOL_BAR_BUTTON_I
		redefine
			interface
		end

	EV_RADIO_PEER_I
		redefine
			interface
		end

	EV_SELECTABLE_I
		redefine
			interface
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_TOOL_BAR_RADIO_BUTTON note option: stable attribute end;

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




end -- class EV_TOOL_BAR_RADIO_BUTTON_I









