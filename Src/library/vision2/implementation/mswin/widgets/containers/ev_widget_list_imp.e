--| FIXME NOT_REVIEWED this file has not been reviewed
indexing
	description: 
		"EiffelVision widget list, mswin implementation."
	status: "See notice at end of class"
	id: "$Id:"
	date: "$Date:"
	revision: "$Revision:"

deferred class
	EV_WIDGET_LIST_IMP

inherit
	EV_WIDGET_LIST_I
		redefine
			interface
		end

	EV_CONTAINER_IMP
		redefine
			interface
		end

feature -- Access

	item: EV_WIDGET is
			-- Current item
		local
			w: EV_WIDGET
		do
			if ev_children.item /= Void then
				w ?= ev_children.item.interface
					check
						interface_not_void: w /= Void
					end
				Result := w
			end
		end

	cursor: CURSOR is
			-- Cursor
		do
			Result := ev_children.cursor
		end

	index: INTEGER is
			-- Index of current position
		do
			Result := ev_children.index
		end

	ev_children: ARRAYED_LIST [EV_WIDGET_IMP] is
			-- List of the children
		deferred
		end

feature -- Measurement

	count: INTEGER is
			-- Number of items.
		do
			Result := ev_children.count
		end

feature -- Status report

	valid_cursor (p: CURSOR): BOOLEAN is
			-- Is `p' a valid cursor position.
		do
			Result := ev_children.valid_cursor (p)
		end

feature -- Cursor movement

	back is
			-- Move to previous item.
		do
			ev_children.back
		end
	
	forth is
			-- Move cursor to next position.
		do
			ev_children.forth
		end

	go_to (p: CURSOR) is
			-- Move cursor to position `p'
		do
			ev_children.go_to (p)	
		end

	move (i: INTEGER) is
			-- Move cursor `i' positions.
		do
			ev_children.move (i)
		end

feature -- Element change

	extend (v: like item) is
			-- Add `v' to end.
			-- Do not move cursor.
		local
			w: EV_WIDGET_IMP
			ww: WEL_WINDOW
			was_after: BOOLEAN
		do
			w ?= v.implementation
			check
				new_item_implementation_not_void: w /= Void
			end
			was_after := ev_children.after
			ev_children.extend (w)
			if was_after then
				--| This is to work around a difference in behaviour of ARRAYED_LIST.
				ev_children.go_i_th (ev_children.count + 1)
			end
			ww ?= Current
			w.wel_set_parent (ww)
			w.set_top_level_window_imp (top_level_window_imp)
			notify_change (2 + 1)
			new_item_actions.call ([v])
		end

	replace (v: like item) is
			-- Replace current item by `v'.
		local
			ww: WEL_WINDOW
			child_imp: EV_WIDGET_IMP
			a_parent_imp: EV_CONTAINER_IMP
		do
			remove
			child_imp ?= v.implementation
			ev_children.put_left (child_imp)
			ev_children.move (-1)

			ww ?= Current
			child_imp.wel_set_parent (ww)
			child_imp.set_top_level_window_imp (top_level_window_imp)
			notify_change (2 + 1)
			new_item_actions.call ([item])
		end

	put_front (v: like item) is
			-- Add `v' to beginning.
			-- Do not move cursor.
		local
			w: EV_WIDGET_IMP
			ww: WEL_WINDOW
		do
			w ?= v.implementation
			check
				new_item_implementation_not_void: w /= Void
			end
			ev_children.put_front (w)
			notify_change (Nc_minsize)
			ww ?= Current
			w.wel_set_parent (ww)
			w.set_top_level_window_imp (top_level_window_imp)
			new_item_actions.call ([v])
		end

	put_right (v: like item) is
			-- Add `v' to the right of cursor position.
			-- Do not move cursor.
		local
			w: EV_WIDGET_IMP
			ww: WEL_WINDOW
		do
			w ?= v.implementation
			check
				new_item_implementation_not_void: w /= Void
			end
			ev_children.put_right (w)
			notify_change (Nc_minsize)
			ww ?= Current
			w.wel_set_parent (ww)
			w.set_top_level_window_imp (top_level_window_imp)
			new_item_actions.call ([v])
		end


feature -- Removal

	prune (v: like item) is
			-- Remove `v' if present.
		local
			v_imp: EV_WIDGET_IMP
			pos: INTEGER
			old_index: INTEGER
		do
			v_imp ?= v.implementation
			if ev_children.has (v_imp) then
				old_index := ev_children.index
				ev_children.start
				pos := ev_children.index_of (v_imp, 1)
				ev_children.go_i_th (pos)
				remove
				if old_index > pos then
					ev_children.go_i_th (old_index - 1)
				else
					ev_children.go_i_th (old_index)
				end
			end
		end

	remove is
			-- Remove current item.
			-- Move cursor to right neighbour.
			-- (or `after' if no right neighbour)
		local
			child_imp: EV_WIDGET_IMP
			a_parent_imp: EV_CONTAINER_IMP
			old_index: INTEGER
		do
			remove_item_actions.call ([item])
			old_index := index
			child_imp ?= item.implementation
			check
				cast_not_void: child_imp /= Void
			end
			a_parent_imp ?= child_imp.parent_imp
			check
				cast_not_void: a_parent_imp /= Void
			end
			a_parent_imp.remove_child (child_imp)
			ev_children.go_i_th (old_index)
		end

	remove_left is
			-- Remove item to the left of cursor position.
			-- Do not move cursor.
		local
			old_index: INTEGER
				-- `Index' value at entry.
		do
			old_index := index
			back
			remove
			ev_children.go_i_th (old_index - 1)
		end

	remove_right is
			-- Remove item the the right of cursor position.
			-- Do not move cursor.
		local
			old_index: INTEGER
				-- `Index' value at entry.
		do
				old_index := index
				forth
				remove
				ev_children.go_i_th (old_index)
		end

feature {NONE} -- Implementation

	interface: EV_WIDGET_LIST

end -- class EV_WIDGET_LIST_IMP
