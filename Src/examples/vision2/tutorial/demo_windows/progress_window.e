indexing
	description:
		"The demo that goes with the progress bar demo";
	date: "$Date$";
	revision: "$Revision$"

class
	PROGRESS_WINDOW

inherit

	EV_VERTICAL_PROGRESS_BAR
		redefine
			make
		end

	DEMO_WINDOW

creation
	make

feature {NONE} -- Initialization

	make (par: EV_CONTAINER) is
			-- Create the demo in `par'.
			-- We create the box first without parent because it
			-- is faster.
		local
			hbox: EV_HORIZONTAL_BOX
			vbox: EV_VERTICAL_BOX
			lab: EV_LABEL
			cmd: EV_ROUTINE_COMMAND
		do
			{EV_VERTICAL_PROGRESS_BAR} Precursor (Void)

			make_with_range (par, 0, 100)
			-- Set the tabs for the action window
			set_gauge_tabs
			create progress_tab.make(Void)
			tab_list.extend(progress_tab)
			create action_window.make(Current,tab_list)

			set_parent (par)
		end

	set_tabs is
			-- Set the tabs for the action window.
		do
		end

feature -- Access

	progress_tab: PROGRESS_TAB

end -- class PROGRESS_WINDOW

--|----------------------------------------------------------------
--| EiffelVision Tutorial: Example for the ISE EiffelVision library.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------
