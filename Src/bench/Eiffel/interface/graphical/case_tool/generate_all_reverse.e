indexing
	description: "";
	date: "$Date$";
	revision: "$Revision$"

class 
	GENERATE_ALL_REVERSE
inherit

	CASE_COMMAND2

creation

	make

feature
	execute ( a: ANY ) is 
	local
		aa : GRAPHICAL_DEGREE_OUTPUT
		bb : WARNER_W
		format_case: FORMAT_CASE_STORAGE
	do
		!! aa
		!! bb.make ( case_window )
		!! format_case.make (bb,
			aa,TRUE)
		format_case.execute
		case_window.unrealize
	end

end -- class GENERATE_ALL_REVERSE
