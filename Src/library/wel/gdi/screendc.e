indexing
	description: "Screen device context."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_SCREEN_DC

inherit
	WEL_DISPLAY_DC

feature -- Basic operations

	get is
			-- Get the device context
		do
			item := cwin_get_dc (default_pointer)
		end

	release is
			-- Release the device context
		do
			unselect_all
			cwin_release_dc (default_pointer, item)
			item := default_pointer
		end

feature {NONE} -- Implementation

	destroy_item is
		do
			unselect_all
			cwin_release_dc (default_pointer, item)
			item := default_pointer
		end

end -- class WEL_SCREEN_DC

--|-------------------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1995-1997, Interactive Software Engineering, Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Information e-mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|-------------------------------------------------------------------------
