indexing
	description: "Paragraph format mask (PFM) constants for the rich edit %
		%control."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_PFM_CONSTANTS

feature -- Access

	Pfm_startindent: INTEGER is
			-- The dxStartIndent member is valid.
		external
			"C [macro <redit.h>]"
		alias
			"PFM_STARTINDENT"
		end

	Pfm_rightindent: INTEGER is
			-- The dxRightIndent member is valid.
		external
			"C [macro <redit.h>]"
		alias
			"PFM_RIGHTINDENT"
		end

	Pfm_offset: INTEGER is
			-- The dxStartIndent member is valid and specifies
			-- a relative value.
		external
			"C [macro <redit.h>]"
		alias
			"PFM_OFFSET"
		end

	Pfm_alignment: INTEGER is
			-- The wAlignment member is valid.
		external
			"C [macro <redit.h>]"
		alias
			"PFM_ALIGNMENT"
		end

	Pfm_tabstops: INTEGER is
			-- The cTabStobs and rgxTabStops members are valid.
		external
			"C [macro <redit.h>]"
		alias
			"PFM_TABSTOPS"
		end

	Pfm_numbering: INTEGER is
			-- The wNumbering member is valid.
		external
			"C [macro <redit.h>]"
		alias
			"PFM_NUMBERING"
		end

	Pfm_offsetindent: INTEGER is
			-- The dxOffset member is valid.
		external
			"C [macro <redit.h>]"
		alias
			"PFM_OFFSETINDENT"
		end

end -- class WEL_PFM_CONSTANTS

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
