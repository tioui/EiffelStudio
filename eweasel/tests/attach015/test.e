﻿class TEST

create
	make

feature {NONE} -- Creation

	make
			-- Run tests.
		do
			test (Current, Current)
		end

feature {NONE} -- Test

	test (v, w: detachable ANY)
		do
			io.put_string ("Keyword%N")
			report (00, (v /= Void and w /= Void) and then (v.out /= Void and w.out /= Void))
			report (01, not (v = Void or w = Void) and then (v.out /= Void and w.out /= Void))
			report (02, (v /= Void and then w /= Void) and then (v.out /= Void and w.out /= Void))
			report (03, not (v = Void or else w = Void) and then (v.out /= Void and w.out /= Void))
			report (04, (v = Void or w = Void) or else v.out /= Void and w.out /= Void)
			report (05, not (v /= Void and w /= Void) or else v.out /= Void and w.out /= Void)
			report (06, (v = Void or else w = Void) or else v.out /= Void and w.out /= Void)
			report (07, not (v /= Void and then w /= Void) or else v.out /= Void and w.out /= Void)
			report (08, (v /= Void implies w = Void) or else v.out /= Void or else w.out /= Void)
			report (09, not not(v /= Void implies w = Void) or else v.out /= Void or else w.out /= Void)
			io.put_string ("Symbol%N")
			report (10, (v /= Void and w /= Void) and then (v.out /= Void and w.out /= Void))
			report (11, ¬ (v = Void or w = Void) and then (v.out /= Void and w.out /= Void))
			report (12, (v /= Void and then w /= Void) and then (v.out /= Void and w.out /= Void))
			report (13, ¬ (v = Void or else w = Void) and then (v.out /= Void and w.out /= Void))
			report (14, (v = Void or w = Void) or else v.out /= Void and w.out /= Void)
			report (15, ¬ (v /= Void and w /= Void) or else v.out /= Void and w.out /= Void)
			report (16, (v = Void or else w = Void) or else v.out /= Void and w.out /= Void)
			report (17, ¬ (v /= Void and then w /= Void) or else v.out /= Void and w.out /= Void)
			report (18, (v /= Void implies w = Void) or else v.out /= Void or else w.out /= Void)
			report (19, ¬ ¬(v /= Void implies w = Void) or else v.out /= Void or else w.out /= Void)
			io.put_string ("Identifier%N")
			report (20, (v /= Void and w /= Void) and then (v.out /= Void and w.out /= Void))
			report (21, (v = Void or w = Void).negated and then (v.out /= Void and w.out /= Void))
			report (22, (v /= Void and then w /= Void) and then (v.out /= Void and w.out /= Void))
			report (23, (v = Void or else w = Void).negated and then (v.out /= Void and w.out /= Void))
			report (24, (v = Void or w = Void) or else v.out /= Void and w.out /= Void)
			report (25, (v /= Void and w /= Void).negated or else v.out /= Void and w.out /= Void)
			report (26, (v = Void or else w = Void) or else v.out /= Void and w.out /= Void)
			report (27, (v /= Void and then w /= Void).negated or else v.out /= Void and w.out /= Void)
			report (28, (v /= Void implies w = Void) or else v.out /= Void or else w.out /= Void)
			report (29, (v /= Void implies w = Void).negated.negated or else v.out /= Void or else w.out /= Void)

		end

feature {NONE} -- Output

	report (i: NATURAL_8; v: BOOLEAN)
			-- Report that test `i' has completed with value `v'.
		do
			io.put_string ("Test ")
			io.put_string (i.out)
			io.put_string (": ")
			io.put_string (if v then "OK" else "FAILED" end)
			io.put_new_line
		end
		
end