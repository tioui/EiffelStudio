indexing

	description: "Figures which have a background color";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class

	BACKGROUND 

feature -- Access 

	background_color: COLOR;
			-- background color of current figure

feature -- Element change

	set_background_color (a_color: COLOR) is
			-- Set `background_color' to `a_color'.
		do
			background_color := a_color;
		ensure
			background_color = a_color
		end

end -- class BACKGROUND

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|	http://www.eiffel.com
--|----------------------------------------------------------------

