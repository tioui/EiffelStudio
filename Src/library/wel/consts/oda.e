indexing
	description: "Owner Draw Action (ODA) constants."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_ODA_CONSTANTS

feature -- Access

	Oda_drawentire: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"ODA_DRAWENTIRE"
		end

	Oda_select: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"ODA_SELECT"
		end

	Oda_focus: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"ODA_FOCUS"
		end

end -- class WEL_ODA_CONSTANTS

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
