--| FIXME Not for release
--| FIXME NOT_REVIEWED this file has not been reviewed
indexing
	description:
		"EiffelVision tree-item, gtk implementation"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_TREE_ITEM_IMP

inherit
	EV_TREE_ITEM_I
		redefine
			interface
		end
	
	EV_SIMPLE_ITEM_IMP
		redefine
			interface,
			initialize
		end

	EV_ITEM_LIST_IMP [EV_TREE_ITEM]
		redefine
			interface,
			add_to_container,
			remove_item_from_position,
			reorder_child
		end

	--EV_PICK_AND_DROPABLE_IMP

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Create the tree item.
		do
			base_make (an_interface)
			set_c_object (C.gtk_tree_item_new)
			list_widget := C.gtk_tree_new
			C.gtk_widget_ref (list_widget)
		end

	initialize is
			-- Set up action sequence connection and `Precursor' initialization,
			-- create item box to hold label and pixmap.
		do
			--{EV_PRIMITIVE_IMP} Precursor
			pixmapable_imp_initialize
			textable_imp_initialize
			initialize_item_box
			--connect_signal_to_actions ("clicked", interface.press_actions)
			is_initialized := True
			align_text_left
		end

	initialize_item_box is
			-- Create and initialize item box.
		local
			box: POINTER
		do
			box := C.gtk_hbox_new (False, 0)
			C.gtk_container_add (c_object, box)
			C.gtk_widget_show (box)
			C.gtk_box_pack_start (box, pixmap_box, False, False, 0)
			C.gtk_widget_hide (pixmap_box)
			C.gtk_box_pack_start (box, text_label, True, True, 2)
			C.gtk_widget_hide (text_label)
		ensure
			item_box /= default_pointer
		end

feature -- Status report

	parent_tree: EV_TREE is
		do
			if tree_widget_imp /= Void then
				Result := tree_widget_imp.interface
			end
		end

	is_selected: BOOLEAN is
			-- Is the item selected?
		do
			--| FIXME IEK Implement
		end

	is_expanded: BOOLEAN is
			-- is the item expanded ?
		do
			Result := C.gtk_tree_item_struct_expanded (c_object).to_boolean
		end

feature -- Status setting

	set_selected (flag: BOOLEAN) is
			-- Select the item if `flag', unselect it otherwise.
		do
			if (flag) then
				C.gtk_tree_item_select (c_object)
			else
				C.gtk_tree_item_deselect (c_object)
			end
		end
	
	set_expand (flag: BOOLEAN) is
			-- Expand the item if `flag', collapse it otherwise.
		do
			if flag then
				C.gtk_tree_item_expand (c_object)
			else
				C.gtk_tree_item_collapse (c_object)
			end
		end

feature {NONE} -- Implementation

	add_to_container (v: like item) is
			-- Add `v' to tree items tree.
		local
			item_imp: EV_TREE_ITEM_IMP
		do
			if count = 0 then	
				C.gtk_tree_item_set_subtree (c_object, list_widget)
			end

			item_imp ?= v.implementation
			item_imp.set_tree_widget_imp (tree_widget_imp)
			C.gtk_widget_show (item_imp.c_object)
			C.gtk_tree_append (list_widget, item_imp.c_object)
		end

	remove_item_from_position (a_position: INTEGER) is
			-- Remove item at `a_position'
		local
			item_imp: EV_TREE_ITEM_IMP
		do
			item_imp ?= interface.i_th (a_position).implementation
			item_imp.set_tree_widget_imp (Void)	
			Precursor (a_position)
		end

	reorder_child (v: like item; a_position: INTEGER) is
			-- Move `v' to `a_position' in container.
		local
			imp: EV_TREE_ITEM_IMP
		do
			imp ?= v.implementation
			C.gtk_tree_remove_item (list_widget, imp.c_object)
			C.gtk_tree_insert (list_widget, imp.c_object, a_position - 1)
		end

	item_box: POINTER is
			-- GTKHbox in tree item.
			-- Holds pixmap and label.
		do
			Result := C.gtk_container_children (c_object)
			Result := C.g_list_nth_data (Result, 0)
		end

	gtk_reorder_child (a_container, a_child: POINTER; a_position: INTEGER) is
			-- Move `a_child' to `a_position' in `a_container'.
		do
			check dont_call: False end
		end

	list_widget: POINTER

feature {EV_ANY_I} -- Implementation

	interface: EV_TREE_ITEM

	tree_widget_imp: EV_TREE_IMP

	set_tree_widget_imp (tree_imp: EV_TREE_IMP) is
			-- Set the root tree imp for current.
		do
			tree_widget_imp := tree_imp
		end
	
end -- class EV_TREE_ITEM_IMP

--!-----------------------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-2000 Interactive Software Engineering Inc.
--! All rights reserved. Duplication and distribution prohibited.
--! May be used only with ISE Eiffel, under terms of user license. 
--! Contact ISE for any other use.
--!
--! Interactive Software Engineering Inc.
--! ISE Building, 2nd floor
--! 270 Storke Road, Goleta, CA 93117 USA
--! Telephone 805-685-1006, Fax 805-685-6869
--! Electronic mail <info@eiffel.com>
--! Customer support e-mail <support@eiffel.com>
--! For latest info see award-winning pages: http://www.eiffel.com
--!-----------------------------------------------------------------------------

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.31  2000/02/22 21:36:42  king
--| Initial implementation to fit with new structure
--|
--| Revision 1.30  2000/02/22 18:39:34  oconnor
--| updated copyright date and formatting
--|
--| Revision 1.29  2000/02/14 11:40:27  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.28.6.2  2000/01/27 19:29:26  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.28.6.1  1999/11/24 17:29:44  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.28.2.3  1999/11/09 16:53:14  oconnor
--| reworking dead object cleanup
--|
--| Revision 1.28.2.2  1999/11/02 17:20:02  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
