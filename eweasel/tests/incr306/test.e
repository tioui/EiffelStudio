
--| Copyright (c) 1993-2017 University of Southern California, Eiffel Software and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST
create
	make

feature
	make is
		do
			print (({TEST2} / Void) = Void); io.new_line
		end

	x: TEST2
end
