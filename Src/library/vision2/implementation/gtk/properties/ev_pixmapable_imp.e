indexing
	description: 
		"Eiffel Vision pixmapable. GTK+ implementation."
	status: "See notice at end of class"
	keywords: "pixmap, bitmap, icon, graphic, image"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class
	EV_PIXMAPABLE_IMP
	
inherit
	EV_PIXMAPABLE_I
		redefine
			interface
		end

	EV_ANY_IMP
		redefine
			interface
		end

feature -- Initialization

	pixmapable_imp_initialize is
			-- Create a GtkHBox to hold a GtkPixmap.
		do
			pixmap_box := C.gtk_hbox_new (False, 0)
			C.gtk_widget_show (pixmap_box)
		end

feature -- Access

	pixmap: EV_PIXMAP is
			-- Pixmap that has been set.
		local
			p: POINTER
			imp: EV_PIXMAP_IMP
		do
			p := gtk_pixmap
			if p /= NULL then
				imp ?= eif_object_from_c (p)
				check
					imp_not_void: imp /= Void
				end
				Result := imp.interface
			end
		end

feature -- Element change

	set_pixmap (a_pixmap: EV_PIXMAP) is
			-- Assign `a_pixmap' to `pixmap'.
		local
			imp: EV_PIXMAP_IMP
			new_pixmap: EV_PIXMAP
		do
			remove_pixmap
			create new_pixmap
			new_pixmap.copy (a_pixmap)
			imp ?= new_pixmap.implementation
			C.gtk_container_add (pixmap_box, imp.c_object)
			C.gtk_widget_show (pixmap_box)		
		end

	remove_pixmap is
			-- Assign Void to `pixmap'.
		local
			p: POINTER
		do
			p := gtk_pixmap
			if p /= NULL then
				C.gtk_container_remove (pixmap_box, p)
			end
			C.gtk_widget_hide (pixmap_box)
		end

feature {NONE} -- Implementation

	gtk_pixmap: POINTER is
			-- Pointer to the GtkPixmap widget.
		do
			Result := C.gtk_container_children (pixmap_box)
			if Result /= NULL then
				Result := C.g_list_nth_data (Result, 0)
			end
		end

	pixmap_box: POINTER
			-- GtkHBox to hold the GtkPixmap.

feature {EV_ANY_I} -- Implementation

	interface: EV_PIXMAPABLE

end -- EV_PIXMAPABLE_IMP

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

