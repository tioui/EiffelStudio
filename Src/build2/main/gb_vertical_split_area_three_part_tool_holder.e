indexing
	description: "Objects that represent a vertical split area which holds%
		%three objects of type GB_TOOL_HOLDER."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_VERTICAL_SPLIT_AREA_THREE_PART_TOOL_HOLDER

inherit
	EV_VERTICAL_BOX
	
	GB_TOOL_HOLDER_PARENT
		undefine
			default_create, is_equal, copy
		end
	
create
	make_with_tools
	
feature {NONE} -- Initialization

	make_with_tools (tool1, tool2, tool3: EV_WIDGET; title1, title2, title3: STRING) is
			-- Create `Current' and extend with `first_tool' and `second_holder'.
			-- Assign `title1' to `tool1' and `title2' to `tool2'.
		do
			default_create
			create split_area
			extend (split_area)
			create first_holder.make_with_tool (tool1, title1)
			split_area.extend (first_holder)
			create nested_split_area
			split_area.extend (nested_split_area)
			split_area.enable_item_expand (split_area.first)
			split_area.disable_item_expand (split_area.second)
			create second_holder.make_with_tool (tool2, title2)
			nested_split_area.extend (second_holder)
			create third_holder.make_with_tool (tool3, title3)
			nested_split_area.extend (third_holder)
			nested_split_area.enable_item_expand (nested_split_area.first)
			nested_split_area.disable_item_expand (nested_split_area.second)
		end
		
feature -- Access

	first_holder: GB_TOOL_HOLDER
	
	second_holder: GB_TOOL_HOLDER
	
	third_holder: GB_TOOL_HOLDER

feature -- Basic operation

	set_split_position (value: INTEGER) is
			-- Set split position of `split_area' to `value'.
		do
			split_area.set_split_position (value)
		end
			
	minimize_tool (tool_holder: GB_TOOL_HOLDER)	 is
			-- Minimize `tool_holder'.
		do
			--| FIXME Implement. The commented code is
			--| from GB_VERTICAL_SPLIT_AREA_TOOL_HOLDER
			--| and not applicable to `Current'
--			update_restore_position
--			if tool_holder.maximized then
--				tool_holder.disable_maximized
--				tool_holder.reset_maximize_button
--				if tool_holder = first_holder then
--					split_area.set_second (second_holder)
--				else
--					split_area.set_first (first_holder)
--				end
--			end
--			if not tool_holder.minimized then
--				if tool_holder = first_holder then
--					if second_holder.minimized then
--						second_holder.disable_minimized
--						second_holder.reset_minimize_button
--						remove_second_cell
--					end
--					split_area.prune (first_holder)
--					add_first_cell
--				else
--					if first_holder.minimized then
--						first_holder.disable_minimized
--						first_holder.reset_minimize_button
--						remove_first_cell
--					end
--					split_area.prune (second_holder)
--					add_second_cell
--				end
--			else
--				if tool_holder = first_holder then
--					remove_first_cell
--				else
--					remove_second_cell
--				end
--				split_area.set_split_position (restore_position.min (split_area.maximum_split_position))
--			end
		end
		
	maximize_tool (tool_holder: GB_TOOL_HOLDER) is
			-- Maximize `tool_holder'.
		do
			--| FIXME Implement. The commented code is
			--| from GB_VERTICAL_SPLIT_AREA_TOOL_HOLDER
			--| and not applicable to `Current'
--			update_restore_position
--			
--				-- If the other tool is minimized, then
--				-- we need to restore its state first.
--			if tool_holder = first_holder then
--				if second_holder.minimized then
--					remove_second_cell
--					second_holder.disable_minimized
--					second_holder.reset_minimize_button
--				end
--			else
--				if first_holder.minimized then
--					remove_first_cell
--					first_holder.disable_minimized
--					first_holder.reset_minimize_button
--				end
--			end
--			
--				-- If the tool is currently minimized then
--				-- we must disable this.
--			if tool_holder.minimized then
--				tool_holder.disable_minimized
--				tool_holder.reset_minimize_button
--				if tool_holder = first_holder then
--					remove_first_cell
--				else
--					remove_second_cell
--				end
--			end
--			if not tool_holder.maximized then
--				if tool_holder = first_holder then
--					split_area.prune (second_holder)
--				else
--					split_area.prune (first_holder)
--				end
--			else
--				if tool_holder = first_holder then
--					split_area.extend (second_holder)
--				else
--					split_area.extend (first_holder)
--				end
--				split_area.set_split_position (restore_position.min (split_area.maximum_split_position))
--			end
		end

feature {NONE} -- Implementation

		split_area: GB_VERTICAL_SPLIT_AREA
			-- Split are used in `Current'.
			
		nested_split_area: GB_VERTICAL_SPLIT_AREA
			-- Split area contained in `split_area'.
		
--		restore_position: INTEGER
--			-- Position to restore splitter to.
--		
--		update_restore_position is
--				-- If both tools are in `split_area' then assign the split
--				-- position to `restore_position'.
--			do
--				if split_area.has (first_holder) and split_area.has (second_holder) then
--					restore_position := split_area.split_position
--				end
--			end
--			
--		add_first_cell is
--				-- Create a temporary cell to hold `first_holder'
--				-- while it is minimized.
--			require
--				first_not_parented: first_holder.parent = Void
--			local
--				a_cell: EV_CELL
--			do
--				create a_cell
--				go_i_th (1)
--				put_left (a_cell)
--				disable_item_expand (a_cell)
--				a_cell.extend (first_holder)
--			end
--			
--		add_second_cell is
--				-- Create a temporary cell to hold `second_holder'
--				-- while it is minimized.
--			require
--				second_not_parented: second_holder.parent = Void
--			local
--				a_cell: EV_CELL
--			do
--				create a_cell
--				extend (a_cell)
--				disable_item_expand (a_cell)
--				a_cell.extend (second_holder)
--			end
--			
--		remove_first_cell is
--				-- Remove temporary cell holdding `first_holder'
--				-- and restore `first_holder' into `split_area'.
--			local
--				a_cell: EV_CELL
--			do
--				a_cell ?= i_th (1)
--				check
--					item_is_a_cell: a_cell /= Void
--				end
--				a_cell.parent.prune (a_cell)
--				a_cell.wipe_out
--				split_area.set_first (first_holder)
--			end
--			
--		remove_second_cell is
--				-- Remove temporary cell holdding `second_holder'
--				-- and restore `second_holder' into `split_area'.
--			local
--				a_cell: EV_CELL
--			do
--				a_cell ?= i_th (count)
--				check
--					item_is_a_cell: a_cell /= Void
--				end
--				a_cell.parent.prune (a_cell)
--				a_cell.wipe_out
--				split_area.set_second (second_holder)
--			end

end -- class GB_SPLIT_AREA_THREE_PART_TOOL_HOLDER