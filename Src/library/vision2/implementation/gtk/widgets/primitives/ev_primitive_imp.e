indexing
	description: 
		"EiffelVision primitive, GTK+ implementation."
	status: "See notice at end of class"
	keywords: "primitive, base, widget"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class
	EV_PRIMITIVE_IMP
	
inherit
	EV_PRIMITIVE_I
		redefine
			interface
		end
	
	EV_WIDGET_IMP
		redefine
			interface
		end

	EV_TOOLTIPABLE_IMP
		redefine
			interface
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_PRIMITIVE

end -- class EV_PRIMITIVE_IMP

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
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

