indexing
	description: "Implementation interface of a pick and drop source."
	status: "See notice at end of class"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_PND_SOURCE_IMP

inherit
	EV_PND_SOURCE_I

	EV_EVENT_HANDLER_IMP

feature {EV_PND_SOURCE_I} -- Implementation

	initialize_transport (args: EV_ARGUMENT2 [EV_INTERNAL_COMMAND, EV_COMMAND]; data: EV_BUTTON_EVENT_DATA) is
			-- Initialize the pick and drop mechanism.
		do
			check
				To_implement: False
			end
		end

	remove_pick_and_drop is
			-- Remove pick and drop command.
		do
			check
				To_implement: False
			end
		end

	terminate_transport (cmd: EV_INTERNAL_COMMAND) is
			-- Terminate the pick and drop mechanim.
		do
			check
				To_implement: False
			end
		end

	widget_source: EV_WIDGET_IMP is
			-- Widget drag source used for transport
		do
			check
				To_implement: False
			end
		end


end -- class EV_PND_SOURCE_I

--!----------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-1999 Interactive Software Engineering Inc.
--! All rights reserved. Duplication and distribution prohibited.
--! May be used only with ISE Eiffel, under terms of user license. 
--! Contact ISE for any other use.
--!
--! Interactive Software Engineering Inc.
--! ISE Building, 2nd floor
--! 270 Storke Road, Goleta, CA 93117 USA
--! Telephone 805-685-1006, Fax 805-685-6869
--! Electronic mail <info@eiffel.com>
--! Customer support e-mail <support@eiffel.com>
--! For latest info see award-winning pages: http://www.eiffel.com
--!----------------------------------------------------------------
