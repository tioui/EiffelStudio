indexing
	description:
		" A class that handle the menu items inside a%
		% container. Ancestor of EV_CONTAINER_IMP."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_MENU_ITEM_HANDLER_IMP

feature {NONE} -- Initialization

	initialize is
			-- Create the hash-table.
		do
			create menu_items.make (1)
		end

feature -- Access

	menu_items: HASH_TABLE [EV_MENU_ITEM_IMP, INTEGER]
			-- List of all the children

feature -- Basic operations

	update_menu is
			-- Graphical update of the menu
		do
			if has_menu then
				draw_menu
			end
		end

	register_item (item_imp: EV_MENU_ITEM_IMP) is
			-- Register the given item and sub-items in the
			-- general list
		local
			ht: HASH_TABLE [EV_MENU_ITEM_IMP, INTEGER]
			cc: ARRAYED_LIST [EV_ITEM_IMP]
			it: EV_MENU_ITEM_IMP
		do
			-- Initializations
			cc := item_imp.children
			if menu_items = Void then
				initialize
			end
			ht := menu_items

			-- Then, we register the item.
			ht.put (item_imp, item_imp.id)
			if cc /= Void then
				from
					cc.start
				until
					cc.after
				loop
					it ?= cc.item
					if it /= Void then
						ht.put (it, it.id)
					end
					cc.forth
				end
			end
		end

	unregister_item (item_imp: EV_MENU_ITEM_IMP) is
			-- Register the given item and sub-items in the
			-- general list
		local
			ht: HASH_TABLE [EV_MENU_ITEM_IMP, INTEGER]
			cc: ARRAYED_LIST [EV_ITEM_IMP]
			it: EV_MENU_ITEM_IMP
		do
			-- Initializations
			ht := menu_items
			cc := item_imp.children

			-- Remove the item ans sub-items.
			ht.remove (item_imp.id)
			if cc /= Void then
				from
					cc.start
				until
					cc.after
				loop
					it ?= cc.item
					if it /= Void then
						ht.remove (it.id)
					end
					cc.forth
				end
			end

			-- If the hash-table is empty, we destroy it.
			if ht.empty then
				ht := Void
			end
		end

feature {NONE} -- WEL Implementation

	on_menu_command (menu_id: INTEGER) is
			-- The `menu_id' has been choosen from the menu.
			-- If this feature is called, it means that the 
			-- child is a menu.
		do
			menu_items.item(menu_id).on_activate
		end

feature {EV_POPUP_MENU_IMP} -- Deferred features

	has_menu: BOOLEAN is
			-- Does the window have a menu?
		deferred
		end

	draw_menu is
			-- Draw the menu bar associated with the window.
		deferred
		end

end -- class EV_MENU_ITEM_HANDLER_IMP

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
