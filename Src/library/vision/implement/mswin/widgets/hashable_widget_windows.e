indexing 
	description: "Hashing routines for a Widget";
	status: "See notice at end of class"; 
	date: "$Date$"; 
	revision: "$Revision$" 

class
	HASHABLE_WIDGET_WINDOWS

inherit
	HASHABLE

feature -- Access

	hash_code: INTEGER 
			-- Hash code

feature {ACTIONS_MANAGER}

	set_hash_code is
			-- Set the hash code of the widget		
		do
			if hash_code = 0 then
				hash_code := hash_code_generator.value
				hash_code_generator.next
			end
		end

feature {NONE} -- Implemementation

	hash_code_generator: INTEGER_GENERATOR_WINDOWS is
			-- Generator for hash code values
		once
			!! Result.make (1, 32767 * 32766)
		end

end -- class HASHABLE_WIDGET_WINDOWS

--|---------------------------------------------------------------- 
--| EiffelVision: library of reusable components for ISE Eiffel 3. 
--| Copyright (C) 1989, 1991, 1993, 1994, Interactive Software 
--|   Engineering Inc. 
--| All rights reserved. Duplication and distribution prohibited. 
--| 
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA 
--| Telephone 805-685-1006 
--| Fax 805-685-6869 
--| Electronic mail <info@eiffel.com> 
--| Customer support e-mail <support@eiffel.com> 
--|----------------------------------------------------------------
