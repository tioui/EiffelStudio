class TEST

create
	make

feature {NONE} -- Creation

	make
		do
			proc
			proc
			;(agent do proc end).do_nothing
		end

feature {TEST} -- Access

	proc
			-- An obsolete procedure.
		obsolete "Use something else. [$(DATE)]"
		do
		end


end
