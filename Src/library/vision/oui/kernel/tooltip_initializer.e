indexing

	description: 
		"Initializes focusable elements. Actually the main %
		%reason for this class is to store the attribute of type %
		%WEL_TOOLTIP so it will be collected automatically when %
		%the window is destroyed.%
		%Also it defines and initializes FOCUS_LABEL ";
	status: "See notice at end of class";		
	date: "$Date$";
	revision: "$Revision$"

class TOOLTIP_INITIALIZER

create 
	tooltip_initialize

feature {NONE} -- Initialization

	tooltip_initialize (widget: COMPOSITE) is
			-- initialize tooltip
			-- argument should be current widget (one inheriting from TOOLTIP_INITIALIZER)
		require
			widget_not_void: widget /= void
		do
			tooltip_parent := widget
			create {FOCUS_LABEL} label.initialize (widget)
		end	

feature -- Actual realization
	
	tooltip_realize is
			-- realize tooltip behavior
		require
			label_not_void: label /= void
		do
			label.initialize_focusables (Current)
		end

feature -- Status report

	tooltip: ANY
			-- Stored value of tooltip

feature -- Status setting

	set_tooltip (arg: ANY) is
		do
			tooltip := arg
		end;

feature -- Properties

	tooltip_parent: COMPOSITE 
			-- Parent of the tooltip window 

	label: FOCUS_LABEL_I
			-- Label used to show the explanation

end -- class TOOLTIP_INITIALIZER

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

