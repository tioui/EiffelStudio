indexing

	description: "Nested queries example."
	production: "EiffelStore"
	Status: "See notice at end of class";
	date: "$Date$"
	revision: "$Revision$"

deferred class TEST inherit

	RDB_HANDLE

feature

	session: DB_CONTROL

	selection: DB_SELECTION
        
	make is
		local
			tmp_string: STRING
			my_action: ACTION_1_I
		do
				-- Ask for user's name and password
			io.putstring ("Database user authentication:%N")
			io.putstring ("Name: ")
			io.readline
			tmp_string := clone (io.laststring)
			io.putstring ("Password: ")
			io.readline
			login (tmp_string, io.laststring)
			set_base
			!! session.make
			session.connect
			if session.is_connected then
				io.putstring ("Database used: ")
				io.putstring (session_database.name)
				io.new_line
				!! selection.make
				!! my_action.make (selection)
				selection.set_action (my_action)
				selection.query (select_string)
				if session.is_ok then
					selection.load_result
				end
				session.disconnect
			else
				io.error.putstring ("Invalid user/password!%N")
			end
		end

	select_string: STRING is
		deferred
		ensure
			result_not_void: Result /= Void
		end

end -- class TEST


--|----------------------------------------------------------------
--| EiffelStore: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1995, Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <eiffel@eiffel.com>
--|----------------------------------------------------------------
