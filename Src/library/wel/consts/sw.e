indexing
	description: "ShowWindow (SW) constants."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_SW_CONSTANTS

feature -- Access

	Sw_hide: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"SW_HIDE"
		end

	Sw_minimize: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"SW_MINIMIZE"
		end

	Sw_restore: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"SW_RESTORE"
		end

	Sw_shownormal: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"SW_SHOWNORMAL"
		end

	Sw_show: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"SW_SHOW"
		end

	Sw_showmaximized: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"SW_SHOWMAXIMIZED"
		end

	Sw_showminimized: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"SW_SHOWMINIMIZED"
		end

	Sw_showminnoactive: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"SW_SHOWMINNOACTIVE"
		end

	Sw_showna: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"SW_SHOWNA"
		end

	Sw_shownoactivate: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"SW_SHOWNOACTIVATE"
		end

	Sw_parentclosing: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"SW_PARENTCLOSING"
		end

	Sw_parentopening: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"SW_PARENTOPENING"
		end

end -- class WEL_SW_CONSTANTS

--|-------------------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1995, Interactive Software Engineering, Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Information e-mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|-------------------------------------------------------------------------
