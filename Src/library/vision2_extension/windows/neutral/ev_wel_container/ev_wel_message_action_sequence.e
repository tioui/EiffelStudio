indexing
	description: "Action sequence for a WEL message."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EV_WEL_MESSAGE_ACTION_SEQUENCE

inherit
	EV_ACTION_SEQUENCE [TUPLE [POINTER, INTEGER, INTEGER, INTEGER]]
	
create
	default_create

create {EV_WEL_MESSAGE_ACTION_SEQUENCE}
	make_filled
	
feature
	
	force_extend (action: PROCEDURE [ANY, TUPLE]) is
			-- Extend without type checking.
		do
			extend (agent wrapper (?, ?, ?, ?, action))
		end

	wrapper (hwnd: POINTER; msg, wparam, lparam: INTEGER; action: PROCEDURE [ANY, TUPLE]) is
			-- Use this to circumvent tuple type checking. (at your own risk!)
			-- Calls `action' passing all other arguments.
		do
			action.call ([hwnd, msg, wparam, lparam])
		end

feature {NONE} -- Implementation

	new_filled_list (n: INTEGER): like Current is
			-- New list with `n' elements.
		do
			create Result.make_filled (n)
		end

end -- class EV_WEL_MESSAGE_ACTION_SEQUENCE

--|----------------------------------------------------------------
--| EiffelVision2 Extension: library of reusable components for ISE Eiffel.
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

