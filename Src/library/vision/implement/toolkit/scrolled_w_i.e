-- Eiffel class generated by the 2.3 to 3 translator.

--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- General scrollled window implementation.

indexing

	date: "$Date$";
	revision: "$Revision$"

deferred class SCROLLED_W_I 

inherit

	MANAGER_I



	
feature 

	working_area: WIDGET is
			-- Working area of window which will
			-- be moved using scrollbars
		deferred
		end; -- working_area

	set_working_area (a_widget: WIDGET) is
			-- Set work area of windon to `a_widget'.
		require
			not_a_widget_void: not (a_widget = Void)
		deferred
		ensure
			working_area = a_widget
		end -- set_working_area

end -- class SCROLLED_W_I
