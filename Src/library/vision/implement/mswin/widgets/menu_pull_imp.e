indexing
    status: "See notice at end of class";
    date: "$Date$";
    revision: "$Revision$"

class
	MENU_PULL_IMP

inherit
	PULLDOWN_IMP
		redefine
			realize_current, insensitive,
			destroy
		end

	MENU_PULL_I

	SIZEABLE_WINDOWS

creation
	make

feature -- Initialization

	make (a_pulldown: MENU_PULL; man: BOOLEAN; oui_parent: MENU) is
			-- Create a menu_pull.
		do
			!! private_attributes
			parent ?= oui_parent.implementation
			check
				valid_parent: parent /= Void
			end
			set_x (parent.x)
			set_y (parent.y)
			managed := man
			text := a_pulldown.identifier
			!! menu_button.make (text, oui_parent)
			menu_button.attach_menu (a_pulldown)
		end

	realize_current is
			-- Realize current widget.
		local
			mw: MENU_IMP
		do
			mw ?= parent
			realized := True
			if mw /= Void and then mw.realized then
				associated_root ?= mw.associated_root
				mw.add_a_child (Current)
				if insensitive then
					set_insensitive (True)
				end
				if associated_shell.has_menu then
					associated_shell.wel_draw_menu
				end
			end
		end

	create_menu is
			-- Create the menu.
		do
			wel_make
		end

feature -- Status report

	insensitive: BOOLEAN is
			-- Is Current insensitive?
		do
			Result := private_attributes.insensitive
		end

feature -- Element change

	insert_button (b: BUTTON_IMP; b_id: INTEGER) is
			-- Insert a button in the menu.
		require
			button_not_void: b /= Void
		do
			insert_string (b.text, index_of (b) - unmanaged_count (b) - 1, b_id)
		end

	set_text (t: STRING) is
			-- Set `text' to `t'
		do
			text := t
			menu_button.set_text (t)
			if realized and then managed then
				set_managed (False)
				set_managed (True)
			end
		end

feature -- Removal

	destroy (wid_list: LINKED_LIST [WIDGET]) is
			-- Destroy Current.
		local
			ww: WIDGET_IMP
		do
			if managed then
				set_managed (False)
			end
			if exists then
				wel_destroy
			end
			from
				wid_list.start
			until
				wid_list.after
			loop
				ww ?= wid_list.item.implementation
				actions_manager_list.deregister (ww)
				wid_list.forth
			end
		end

feature {NONE} -- Implementation

	set_default_size is
			-- Useless here
		do
		end

	text: STRING 

end -- class MENU_PULL_IMP

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
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

