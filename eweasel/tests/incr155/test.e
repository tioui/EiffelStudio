
--| Copyright (c) 1993-2017 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST
creation 
	make
feature
	make is
		do
			!!x
			io.put_string (x.weasel.generating_type.name_32.as_string_8); io.new_line
  		end
			
	x: TEST1 [SEQ_STRING]
			
end
