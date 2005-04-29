indexing
	description: "Objects that represent an EV_TITLED_WINDOW.%
		%The original version of this class was generated by EiffelBuild."
	date: "$Date$"
	revision: "$Revision$"

class
	GRID_TAB

inherit
	GRID_TAB_IMP
	
	GRID_ACCESSOR
		undefine
			copy, default_create, is_equal
		end
		
	PROFILING_SETTING
		undefine
			copy, default_create, is_equal
		end

feature {NONE} -- Initialization

	user_initialization is
			-- Called by `initialize'.
			-- Any custom user initialization that
			-- could not be performed in `initialize',
			-- (due to regeneration of implementation class)
			-- can be added here.
		local
			f_name: FILE_NAME
			list_item: EV_LIST_ITEM
		do
			grid.set_dynamic_content_function (agent compute_item)
			add_color_to_combo ((create {EV_STOCK_COLORS}).red, set_background_color_combo)
			add_color_to_combo ((create {EV_STOCK_COLORS}).green, set_background_color_combo)
			add_color_to_combo ((create {EV_STOCK_COLORS}).blue, set_background_color_combo)
			add_color_to_combo ((create {EV_STOCK_COLORS}).yellow, set_background_color_combo)
			add_color_to_combo ((create {EV_STOCK_COLORS}).white, set_background_color_combo)
			
				-- Now load pixmaps for exapnd/collapse nodes.
			expand1 := grid.expand_node_pixmap
			collapse1 := grid.collapse_node_pixmap
			create f_name.make_from_string (current_working_directory)
			f_name.extend ("icon_bpenabled.png")
			create expand2
			expand2.set_with_named_file (f_name.out)
			create f_name.make_from_string (current_working_directory)
			f_name.extend ("icon_bpdisabled.png")
			create collapse2
			collapse2.set_with_named_file (f_name)
			
			create f_name.make_from_string (current_working_directory)
			f_name.extend ("large_expand.png")
			create expand3
			expand3.set_with_named_file (f_name.out)
			create f_name.make_from_string (current_working_directory)
			f_name.extend ("large_collapse.png")
			create collapse3
			collapse3.set_with_named_file (f_name)
			
			create list_item.make_with_text ("9x9")
			list_item.set_pixmap (expand1)
			subnode_pixmaps_combo.extend (list_item)
			create list_item.make_with_text ("12x12")
			list_item.set_pixmap (expand2)
			subnode_pixmaps_combo.extend (list_item)
			create list_item.make_with_text ("32x32")
			list_item.set_pixmap (expand3)
			subnode_pixmaps_combo.extend (list_item)
		end
		
	expand1, expand2, expand3, collapse1, collapse2, collapse3: EV_PIXMAP

feature {NONE} -- Implementation

	is_header_displayed_button_selected is
			-- Called by `select_actions' of `is_header_displayed_button'.
		do
			if is_header_displayed_button.is_selected then
				grid.show_header
			else
				grid.hide_header
			end
		end

	is_tree_enabled_button_selected is
			-- Called by `select_actions' of `is_tree_enabled_button'.
		do
			if is_tree_enabled_button.is_selected then
				grid.enable_tree
			else
				grid.disable_tree
			end
		end

	new_label_button_selected is
			-- Called by `select_actions' of `new_label_button'.
		local
			new_label_item_dialog: NEW_ITEM_DIALOG
		do
			create new_label_item_dialog
			new_label_item_dialog.show_relative_to_window (main_window)
		end
		
	is_vertical_divider_displayed_button_selected is
			-- Called by `select_actions' of `is_vertical_divider_displayed_button'.
		do
			if is_vertical_divider_displayed_button.is_selected then
				grid.enable_resizing_divider
				is_vertical_divider_dashed_button.enable_sensitive
				is_vertical_divider_solid_button.enable_sensitive
			else
				grid.disable_resizing_divider
				is_vertical_divider_dashed_button.disable_sensitive
				is_vertical_divider_solid_button.disable_sensitive
			end
		end
		
	is_vertical_divider_solid_button_selected is
			-- Called by `select_actions' of `is_vertical_divider_solid_button'.
		do
			grid.enable_solid_resizing_divider
		end
	
	is_vertical_divider_dashed_button_selected is
			-- Called by `select_actions' of `is_vertical_divider_dashed_button'.
		do
			grid.disable_solid_resizing_divider
		end
		
	is_horizontal_scrolling_per_item_selected is
			-- Called by `select_actions' of `is_horizontal_scrolling_per_item'.
		do
			if is_horizontal_scrolling_per_item.is_selected then
				grid.enable_horizontal_scrolling_per_item
			else
				grid.disable_horizontal_scrolling_per_item
			end
		end
	
	is_vertical_scrolling_per_item_selected is
			-- Called by `select_actions' of `is_vertical_scrolling_per_item'.
		do
			if is_vertical_scrolling_per_item.is_selected then
				grid.enable_vertical_scrolling_per_item
			else
				grid.disable_vertical_scrolling_per_item
			end
		end
		
	is_row_height_fixed_selected is
			-- Called by `select_actions' of `is_row_height_fixed'.
		do
			if is_row_height_fixed.is_selected then
				grid.enable_row_height_fixed
				fixed_row_height_spin_button.enable_sensitive
			else
				grid.disable_row_height_fixed
				fixed_row_height_spin_button.disable_sensitive
			end
		end
	
	fixed_row_height_spin_button_changed (a_value: INTEGER) is
			-- Called by `change_actions' of `fixed_row_height_spin_button'.
		do
			grid.set_row_height (a_value)
		end
		
	is_partially_dynamic_selected is
			-- Called by `select_actions' of `is_partically_dynamic'.
		do
			if is_partially_dynamic.is_selected then
				grid.enable_partial_dynamic_content
				resize_rows_columns_box.enable_sensitive
				is_completely_dynamic.select_actions.block
				is_completely_dynamic.disable_select
				is_completely_dynamic.select_actions.resume
			else
				if not is_completely_dynamic.is_selected then
					resize_rows_columns_box.disable_sensitive
					grid.disable_dynamic_content
				end
			end
		end
	
	is_completely_dynamic_selected is
			-- Called by `select_actions' of `is_completely_dynamic'.
		do
			if is_completely_dynamic.is_selected then
				grid.enable_complete_dynamic_content
				resize_rows_columns_box.enable_sensitive
				is_partially_dynamic.select_actions.block
				is_partially_dynamic.disable_select
				is_partially_dynamic.select_actions.resume
			else
				if not is_partially_dynamic.is_selected then
					resize_rows_columns_box.disable_sensitive
					grid.disable_dynamic_content
				end
			end
		end

	resize_columns_to_button_selected is
			-- Called by `select_actions' of `resize_columns_to_button'.
		do
			if resize_columns_to_button.is_selected then
				resize_columns_to_entry.enable_sensitive
				resize_columns_to_entry.change_actions.call ([resize_columns_to_entry.value])
			else
				resize_columns_to_entry.disable_sensitive
			end
		end
	
	resize_columns_to_entry_selected (a_value: INTEGER) is
			-- Called by `change_actions' of `resize_columns_to_entry'.
		do
			grid.set_column_count_to (a_value)
		end
		
	resize_row_to_button_selected is
			-- Called by `select_actions' of `resize_rows_to_button'.
		do
			if resize_rows_to_button.is_selected then
				resize_rows_to_entry.enable_sensitive
				resize_rows_to_entry.change_actions.call ([resize_rows_to_entry.value])
			else
				resize_rows_to_entry.disable_sensitive
			end
		end
	
	resize_rows_to_entry_changed (a_value: INTEGER) is
			-- Called by `change_actions' of `resize_rows_to_entry'.
		do
			grid.set_row_count_to (a_value)
		end
		
	add_items (an_xcount, a_ycount: INTEGER) is
			--
		local
			l_ycount, l_xcount: INTEGER
			grid_label_item: EV_GRID_LABEL_ITEM
		do
			from
				l_ycount := 1
			until
				l_ycount > a_ycount
			loop
				from
					l_xcount := 1
				until
					l_xcount > an_xcount
				loop
					create grid_label_item
					grid_label_item.set_text ("Item" + " " + l_xcount.out + ", " + l_ycount.out)
					grid.set_item (l_xcount, l_ycount, grid_label_item)
					l_xcount := l_xcount + 1
				end
				l_ycount := l_ycount + 1
			end
		end
		
		
	misc_button_selected is
			-- Called by `select_actions' of `misc_button'.
		local
			counter: INTEGER
			counter2: INTEGER
			time1, time2: DATE_TIME
			grid_label_item: EV_GRID_LABEL_ITEM
		do
			create time1.make_now
			add_items (5, 400)			
			grid.column (1).set_title ("One")
			grid.column (2).set_title ("Two")
			grid.column (3).set_title ("Three")
			grid.column (4).set_title ("Four")
			grid.column (5).set_title ("Five")
			grid.enable_tree
			grid.row (1).add_subrow (grid.row (2))
			grid.row (1).add_subrow (grid.row (3))
			grid.row (3).add_subrow (grid.row (4))
			grid.row (4).add_subrow (grid.row (5))
			grid.row (5).add_subrow (grid.row (6))
			grid.row (6).add_subrow (grid.row (7))
			grid.row (7).add_subrow (grid.row (8))
			grid.row (8).add_subrow (grid.row (9))
			grid.row (9).add_subrow (grid.row (10))
			from
				counter := 11
			until
				counter > 26
			loop
				grid.row (1).add_subrow (grid.row (counter))
				counter := counter + 1
			end
			from
				counter := 27
			until
				counter > 31
			loop
				grid.row (counter - 1).add_subrow (grid.row (counter))
				counter := counter + 1
			end
--			grid.insert_new_row_parented (33, grid.row (32))
			from
				counter := 35
			until
				counter = 100
			loop
				grid.row (counter).add_subrow (grid.row (counter + 1))
				counter := counter + 1
			end
			grid.insert_new_row (110)
			grid.set_item (3, 110, create {EV_GRID_LABEL_ITEM}.make_with_text ("Deep subnode"))
			grid.row (109).add_subrow (grid.row (110))
			
			from
				counter := 111
			until
				counter = 113
			loop
				grid.insert_new_row (counter)
				grid.set_item (3, counter, create {EV_GRID_LABEL_ITEM}.make_with_text ("Subnode"))
				grid.row (counter - 1).add_subrow (grid.row (counter))
				counter := counter + 1
			end
			from
				counter := 113
			until
				counter = 121
			loop
				grid.remove_item (1, counter)
				grid.remove_item (2, counter)
				grid.remove_item (3, counter)
				grid.remove_item (4, counter)
				grid.set_item (5, counter, create {EV_GRID_LABEL_ITEM}.make_with_text ("Subnode"))
				grid.row (112).add_subrow (grid.row (counter))
				counter := counter + 1
			end
			grid.remove_item (1, 121)
			grid.remove_item (2, 121)
			grid.row (112).add_subrow (grid.row (121))
			from
				counter := 122
			until
				counter = 128
			loop
				grid.remove_item (1, counter)
				grid.remove_item (2, counter)
				grid.remove_item (3, counter)
				grid.set_item (3, counter, create {EV_GRID_LABEL_ITEM}.make_with_text ("Subnode"))
				grid.row (counter - 1).add_subrow (grid.row (counter))
				counter := counter + 1
			end
			
			fixme ("Uncomment this code and replace that just above to show a redrawing bug.")
--			from
--				counter := 121
--			until
--				counter = 128
--			loop
--				grid.remove_item (1, counter)
--				grid.remove_item (2, counter)
--				grid.set_item (3, counter, create {EV_GRID_LABEL_ITEM}.make_with_text ("Subnode"))
--				grid.row (110).add_subrow (grid.row (counter))
--				counter := counter + 1
--			end

			
			from
				counter := 150
			until
				counter > 155
			loop
				grid.insert_new_row (counter + 1)
				grid.set_item (1, counter + 1, create {EV_GRID_LABEL_ITEM}.make_with_text ("Subnode"))
				grid.row (150).add_subrow (grid.row (counter + 1))
				
				counter := counter + 1
			end
			
				-- Now perform a heavy test of the vertical tree lines.
			from
				counter := 160
			until
				counter = 259
			loop
				grid.row (counter).add_subrow (grid.row (counter + 1))
				counter := counter + 1
			end
			from
				counter := 259
				counter2 := 259
			until
				counter = 359
			loop
				grid.row (counter2).add_subrow (grid.row (counter + 1))
				counter := counter + 1
				counter2 := counter2 - 1
			end
			create time2.make_now
			set_status_message (("Items added in : " + ((time2.fine_second - time1.fine_second).out)))
			from
				counter := 1
			until
				counter > grid.row_count
			loop
				grid_label_item ?= grid.item (1, counter)
				if grid_label_item /= Void then
					grid_label_item.set_background_color (light_red)
				end
				counter := counter + 1				
			end
			from
				counter := 1
			until
				counter > grid.row_count
			loop
				grid_label_item ?= grid.item (1, counter)
				if grid_label_item /= Void then
					grid_label_item.set_pixmap (image1)
				end

				grid_label_item ?= grid.item (4, counter)
				if grid_label_item /= Void then
					grid_label_item.set_pixmap (image2)
				end
				counter := counter + 1
			end
		end
		
	compute_item (an_x, a_y: INTEGER): EV_GRID_ITEM is
			--
		local
			drawable_item: EV_DRAWABLE_GRID_ITEM
		do
			if an_x = 2 then
				do_nothing
			end
			if a_y \\ 2 = 1 then
				create {EV_GRID_LABEL_ITEM} Result.make_with_text ("Item at position : " + an_x.out + ", " + a_y.out)
			else
				create drawable_item
				drawable_item.expose_actions.extend (agent draw_grid_item (?, ?, ?, ?, ?, drawable_item))
				Result := drawable_item
			end
		end
		
	draw_grid_item (an_x, a_y, a_width, a_height: INTEGER; drawable: EV_DRAWABLE; an_item: EV_DRAWABLE_GRID_ITEM) is
			--
		local
			back_color: EV_COLOR
		do
			if back_color = Void then
				back_color := grid.background_color
			end
			drawable.set_foreground_color (back_color)
			drawable.fill_rectangle (an_x, a_y, a_width, a_height)
			drawable.set_foreground_color (create {EV_COLOR}.make_with_8_bit_rgb (((a_y + an_x).abs // 8) \\ 255, ((a_y + an_x).abs // 8) \\ 255, ((a_y + an_x).abs // 8) \\ 255))
			drawable.fill_ellipse (an_x, a_y, a_width, a_height)
		end
		
	set_selected_row_as_subnode_button_selected is
			-- Called by `select_actions' of `set_selected_row_as_subnode_button'.
		local
			selected_items: ARRAYED_LIST [EV_GRID_ITEM]
			selected_rows: ARRAYED_LIST [EV_GRID_ROW]
			current_row: EV_GRID_ROW
		do
			if grid.is_multiple_item_selection_enabled then
				selected_items := grid.selected_items
			else
				selected_rows := grid.selected_rows
				from
					selected_rows.start
				until
					selected_rows.off
				loop
					current_row := selected_rows.item
					grid.row (current_row.index - 1).add_subrow (current_row)
					selected_rows.forth
				end
			end
		end

	subrow_indent_button_changed (a_value: INTEGER) is
			-- Called by `change_actions' of `subrow_indent_button'.
		do
			grid.set_subrow_indent (a_value)
		end
		
	set_background_color_button_selected is
			-- Called by `select_actions' of `set_background_color_button'.
		do
		end
	
	set_background_color_combo_selected is
			-- Called by `select_actions' of `set_background_color_combo'.
		local
			selected_items: ARRAYED_LIST [EV_GRID_ITEM]
			color: EV_COLOR
		do
			color ?= set_background_color_combo.selected_item.data
			if set_tree_node_connector_button.is_selected then
				grid.set_tree_node_connector_color (color)
			elseif set_background_of_selection_button.is_selected then
				selected_items := grid.selected_items
				if not selected_items.is_empty then
					from
						selected_items.start
					until
						selected_items.off
					loop
						selected_items.item.set_background_color (color)
						selected_items.forth
					end
				end
			end
		end
		
	subnode_pixmaps_combo_selected is
			-- Called by `select_actions' of `subnode_pixmaps_combo'.
		local
			l_index: INTEGER
		do
			l_index := subnode_pixmaps_combo.index_of (subnode_pixmaps_combo.selected_item, 1)
			if l_index = 1 then
				grid.set_node_pixmaps (expand1, collapse1)
			elseif l_index = 2 then
				grid.set_node_pixmaps (expand2, collapse2)
			elseif l_index = 3 then
				grid.set_node_pixmaps (expand3, collapse3)
			end
		end
		
	expand_all_button_selected is
			-- Called by `select_actions' of `expand_all_button'.
		local
			counter: INTEGER
			current_row: EV_GRID_ROW
		do
			from
				counter := 1
			until
				counter > grid.row_count
			loop
				current_row := grid.row (counter)
				if current_row.subrow_count > 0 then
					current_row.expand			
				end
				counter := counter + 1
			end
		end
	
	collapse_all_button_selected is
			-- Called by `select_actions' of `collapse_all_button'.
		local
			counter: INTEGER
			current_row: EV_GRID_ROW
		do
			from
				counter := 1
			until
				counter > grid.row_count
			loop
				current_row := grid.row (counter)
				if current_row.subrow_count > 0 then
					current_row.collapse			
				end
				counter := counter + 1
			end
		end
		
	tree_lines_enabled_selected is
			-- Called by `select_actions' of `tree_lines_enabled'.
		do
			if tree_lines_enabled.is_selected then
				grid.show_tree_node_connectors
			else
				grid.hide_tree_node_connectors
			end
		end
		
	custom_button_selected is
			-- Called by `select_actions' of `custom_button'.
		local
			l_item: EV_GRID_ITEM
			r, row: EV_GRID_ROW
			grid_label_item: EV_GRID_LABEL_ITEM
			counter: INTEGER
		do
--			l_item := grid.item_at_virtual_position (200, 16)
--			misc_button_selected
--			grid.column (3).set_width (200)
--			grid.column (4).set_width (200)
--			grid.enable_horizontal_scrolling_per_item

--			grid.enable_tree
--			grid.set_item (1, 1, create {EV_GRID_LABEL_ITEM}.make_with_text ("An item"))
--			grid.set_item (1, 2, create {EV_GRID_LABEL_ITEM}.make_with_text ("An item"))
--			grid.set_item (2, 1, create {EV_GRID_LABEL_ITEM}.make_with_text ("An item"))
--			grid.set_item (2, 2, create {EV_GRID_LABEL_ITEM}.make_with_text ("An item"))
--			r := grid.row (grid.row_count)
--			grid.insert_new_row (r.index + 1)
--            row := grid.row (r.index + 1)
--			r.add_subrow (row)            
--                -- and then create the item
--            create grid_label_item
--            grid_label_item.set_text ("POP")
--            row.set_item (1, grid_label_item)


--			grid.insert_new_row (r.index + 2)
			
--			r.add_subrow (row)  
			grid.enable_tree
--			grid.set_item (8, 1, create {EV_GRID_LABEL_ITEM}.make_with_text ("Sub Sub row"))
--			grid.set_item (1, 2, create {EV_GRID_LABEL_ITEM}.make_with_text ("Parent Row"))
--			grid.set_item (4, 3, create {EV_GRID_LABEL_ITEM}.make_with_text ("Sub row"))
--			grid.set_item (8, 4, create {EV_GRID_LABEL_ITEM}.make_with_text ("Sub Sub row"))
--			grid.row (2).add_subrow (grid.row (3))
--			grid.row (3).add_subrow (grid.row (4))
--			grid.row (4).set_item (5, create {EV_GRID_LABEL_ITEM}.make_with_text ("New item"))
--			grid.row (4).set_item (4, create {EV_GRID_LABEL_ITEM}.make_with_text ("New item"))
----			grid.set_item (4, 4, create {EV_GRID_LABEL_ITEM}.make_with_text ("New item"))
--			grid.row (4).set_item (4, create {EV_GRID_LABEL_ITEM}.make_with_text ("New item"))
--			--grid.column (3).set_item (4, create {EV_GRID_LABEL_ITEM}.make_with_text ("New item"))
--			grid.column (4).set_item (4, create {EV_GRID_LABEL_ITEM}.make_with_text ("New item"))


--			-- Test 3
--			grid.set_item (1, 1, create {EV_GRID_LABEL_ITEM}.make_with_text ("Top level 1"))
--			from
--				counter := 2
--			until
--				counter > 5
--			loop
--				grid.set_item (1, counter, create {EV_GRID_LABEL_ITEM}.make_with_text ("Sub row " + counter.out))
--				grid.row (counter - 1).add_subrow (grid.row (counter))
--				counter := counter + 1
--			end
--			grid.set_item (1, 6, create {EV_GRID_LABEL_ITEM}.make_with_text ("New Row 6"))
--			grid.set_item (2, 6, create {EV_GRID_LABEL_ITEM}.make_with_text ("New Row 6"))
--			grid.remove_row (5)

			--Test 4
--			grid.set_item (1, 1, create {EV_GRID_LABEL_ITEM}.make_with_text ("Top level 1"))
--			grid.row (1).ensure_expandable
--			grid.row_expand_actions.extend (agent expand_row)


--			-- Test 5
--				grid.enable_tree
--            grid.enable_partial_dynamic_content
--            grid.set_column_count_to (3)
--            grid.set_dynamic_content_function (agent compute_grid_item (grid, ?, ?))
--            grid.set_row_count_to (10)

--			-- Test 6
--			grid.enable_tree
--            grid.enable_partial_dynamic_content
--            grid.set_column_count_to (3)
--            grid.set_dynamic_content_function (agent compute_grid_item (grid, ?, ?))
--            grid.set_row_count_to (1)
--            create grid_label_item.make_with_text ("Root dynamic node")
--            grid.set_item (1, 1, grid_label_item)
--			grid.row (1).ensure_expandable
--            grid.row_expand_actions.extend (agent add_subrows)


--			-- Test 7
--			grid.enable_tree
--			grid.set_item (1, 1, create {EV_GRID_LABEL_ITEM}.make_with_text ("Top level 1"))

			-- Test 8
--			grid.enable_tree
--			grid.set_item (1, 1, create {EV_GRID_LABEL_ITEM}.make_with_text ("Top level 1"))
--			grid.set_item (1, 2, create {EV_GRID_LABEL_ITEM}.make_with_text ("Subrow"))
--			grid.row (1).add_subrow (grid.row (2))
--			grid.row (1).ensure_expandable

--			-- Test 9
--			grid.enable_tree
--			grid.set_item (1, 1, create {EV_GRID_LABEL_ITEM}.make_with_text ("Top level 1"))
--			grid.set_item (3, 1, create {EV_GRID_LABEL_ITEM}.make_with_text ("Top level 1"))
--			grid.insert_new_row_parented (2, grid.row (1))

			-- Test 9
--			create grid_label_item
--			grid_label_item.set_text ("A text")

			-- Test 10
--			grid.enable_tree
--			grid.set_item (1, 1, create {EV_GRID_LABEL_ITEM}.make_with_text ("Top level 1"))
--			grid.set_item (3, 1, create {EV_GRID_LABEL_ITEM}.make_with_text ("Top level 1"))
--			grid.insert_new_row_parented (2, grid.row (1))

			-- Test 11
--			add_items (10, 10)
--			grid.set_item (3, 3, Void)
--			grid.column (5).set_item (5, Void)
--			grid.row (7).set_item (7, Void)
--			grid.row (7).clear
--			grid.column (5).clear
--			grid.clear

			-- Test 12
			add_items (10, 10)
			grid.insert_new_row_parented (6, grid.row (5))
			grid.row (6).set_item (3, create {EV_GRID_LABEL_ITEM}.make_with_text ("An item"))
			grid.row (6).insert_subrow (1)
			grid.row (6).subrow (1).set_item (3, create {EV_GRID_LABEL_ITEM}.make_with_text ("Second item"))
			grid.row (6).insert_subrow (1)
			grid.row (6).subrow (1).set_item (3, create {EV_GRID_LABEL_ITEM}.make_with_text ("First item"))
			grid.row (6).insert_subrow (3)
			grid.row (6).subrow (3).set_item (3, create {EV_GRID_LABEL_ITEM}.make_with_text ("Third item"))
			grid.row (6).insert_subrow (4)
			grid.row (6).subrow (4).set_item (3, create {EV_GRID_LABEL_ITEM}.make_with_text ("Fourth item"))
			grid.row (6).insert_subrow (1)
			grid.row (6).subrow (1).set_item (3, create {EV_GRID_LABEL_ITEM}.make_with_text ("Sneaky Final first item"))
			grid.row (6).subrow (1).ensure_expandable
			grid.row_expand_actions.extend (agent expand_row2)
		end

	expand_row2 (a_row: EV_GRID_ROW) is
			--
		local
			counter: INTEGER
		do
			if a_row.index = 7 then
				from
					counter := 1
				until
					counter = 100
				loop
					grid.row (7).insert_subrow (1)
					grid.row (7).subrow (1).set_item (3, create {EV_GRID_LABEL_ITEM}.make_with_text ("counter " + counter.out))
					counter := counter + 1
				end
			end
		end
		
		
	add_subrows (a_row: EV_GRID_ROW) is
			--
		local
			counter: INTEGER
		do
			from
				counter := 1
			until
				counter > 200
			loop
				grid.insert_new_row_parented (a_row.index + a_row.subrow_count + 1, a_row)
				counter := counter + 1
			end
		end
		
		
	compute_grid_item (g: EV_GRID; c,r: INTEGER): EV_GRID_ITEM is
		local
			label_item: EV_GRID_LABEL_ITEM
			time: DATE_TIME
	    do
	    	create time.make_now
	 		create label_item.make_with_text (time.out)
	    	Result := label_item
	    end

		
	expand_row (a_row: EV_GRID_ROW) is
			--
		local
			counter: INTEGER
			l_item: EV_GRID_LABEL_ITEM
			new_row: EV_GRID_ROW
		do
			if a_row.subrow_count = 0 then
				from
					counter := 1
				until
					counter > 20
				loop
					create l_item.make_with_text ("Item " + counter.out)
					grid.insert_new_row_parented (a_row.index + a_row.subrow_count + 1, a_row)
					new_row := grid.row (a_row.index + a_row.subrow_count)
					new_row.set_item (1, l_item)
					new_row.ensure_expandable
					counter := counter + 1
				end
			end
		end
		
		
	draw_tree_check_button_selected is
			-- Called by `select_actions' of `draw_tree_check_button'.
		do
			if draw_tree_check_button.is_selected then
				grid.disable_selection_on_click
				grid.pointer_motion_actions.wipe_out
				grid.pointer_button_press_actions.wipe_out
				grid.pointer_button_release_actions.wipe_out
				grid.pointer_button_press_actions.extend (agent draw_tree_item_press)
				grid.pointer_button_release_actions.extend (agent draw_tree_item_release)
				grid.pointer_motion_actions.extend (agent draw_tree_item_motion)
			else
				grid.enable_selection_on_click
				grid.pointer_motion_actions.wipe_out
				grid.pointer_button_press_actions.wipe_out
				grid.pointer_button_release_actions.wipe_out
			end
		end
		
	offsets: ARRAY [INTEGER]	
	
	start_x, start_y: INTEGER
	
	start_item: EV_GRID_ITEM
	
	max_set: INTEGER
		
	draw_tree_item_press (an_x, a_y, button: INTEGER; an_item: EV_GRID_ITEM) is
			--
		do
			if button = 1 and an_item /= Void then
				create offsets.make (1, 100)
				start_x := an_x
				start_y := a_y
				start_item := an_item
				max_set := 0
			else
				start_item := Void
			end
		end
		
		
	draw_tree_item_release (an_x, a_y, button: INTEGER; an_item: EV_GRID_ITEM) is
			--
		local
			counter: INTEGER
			current_indent: INTEGER
			previous_indent: INTEGER
			new_row: EV_GRID_ROW
			parent_row: EV_GRID_ROW
			column_to_check: INTEGER
			column_counter: INTEGER
			total_column_indent: INTEGER
			row_counter: INTEGER
			i: INTEGER
			j: INTEGER
			found: BOOLEAN
			new_row_index: INTEGER
		do
			if button = 1 then

				previous_indent := 0
				from
					counter := 1
				until
					counter > max_set
				loop
					
					current_indent := offsets.item (counter) - start_x
					if offsets.item (counter) = 360 then
						do_nothing
					end

				--	grid.insert_new_row (start_item.row.index + counter)
				--	new_row := grid.row (start_item.row.index + counter)
					new_row_index := start_item.row.index + counter
					
					current_indent := current_indent.max (0)
					parent_row := Void
					column_to_check := start_item.column.index
					total_column_indent := 0
					from
						column_counter := column_to_check
					until
						column_counter > grid.column_count or total_column_indent > current_indent
					loop
						if current_indent > total_column_indent then
							column_to_check := column_counter
						end						
						total_column_indent := total_column_indent + grid.column (column_counter).width
						column_counter := column_counter + 1
					end
					i := 0
					from
						j := 1
					until
						j = column_to_check
					loop
						i := i + grid.column (j).width
						j := j + 1
					end
					found := False
					if parent_row = Void then		
						from
							row_counter := new_row_index - 1
						until
							found or row_counter = start_item.row.index
						loop
							if (grid.item (column_to_check, row_counter) /= Void and grid.row (row_counter).index + grid.row (row_counter).subrow_count_recursive + 1 = new_row_index) then
								if (grid.item (column_to_check, row_counter)).horizontal_indent <= offsets.item (counter) - i then--current_indent then
									--parent_row := grid.row (counter2)
									found := True
								end						
							end
							if not found then
								row_counter := row_counter - 1
							end
						end
						parent_row := grid.row (row_counter)
					end
					
					
					
--					i < row_count and row (i - 1).parent_row_root /= Void and row (i).parent_row_root /= Void implies row (i - 1).parent_row_root /= row (i).parent_row_root
--					grid.insert_new_row (start_item.row.index + counter)
					grid.insert_new_row_parented (new_row_index, parent_row)
					new_row := grid.row (start_item.row.index + counter)
					grid.set_item (column_to_check, new_row_index, create {EV_GRID_LABEL_ITEM}.make_with_text (offsets.item (counter).out))
--					parent_row.add_subrow (new_row)
					if not parent_row.is_expanded then
						parent_row.expand
					end
					counter := counter + 1
					previous_indent := current_indent
				end
				start_item := Void
				draw_tree_check_button.disable_select
			end
		end
		
		
	draw_tree_item_motion (an_x, a_y: INTEGER; an_item: EV_GRID_ITEM) is
			--
		local
			distance_down: INTEGER
			item_index: INTEGER
		do
			if start_item /= Void then
				distance_down := a_y - start_item.virtual_y_position
				item_index := (distance_down // 16) + 1
				if item_index >= offsets.count or else offsets @ item_index < an_x then
					offsets.force (an_x, item_index)
					max_set := item_index.max (item_index)
				end
			end
		end
		
	red: EV_COLOR is
			--
		once
			Result := (create {EV_STOCK_COLORS}).red
		end
		
	enable_pick_and_drop_button_selected is
			-- Called by `select_actions' of `enable_pick_and_drop_button'.
		do
			if enable_pick_and_drop_button.is_selected then
					-- Enable grid item PND
				grid.set_item_pebble_function (agent item_pebble_function)
				grid.set_item_veto_pebble_function (agent item_veto_pebble_function)
				grid.item_drop_actions.extend (agent item_drop_actions)				
			else
					-- Disable grid item PND
				grid.set_item_pebble_function (Void)
				grid.set_item_veto_pebble_function (Void)
				grid.item_drop_actions.wipe_out
			end
		end

	item_pebble_function (a_item: EV_GRID_ITEM): ANY is
			-- Return the text of `a_item' as pebble for Pick And Drop if `a_item' is an EV_GRID_LABEL_ITEM .
		local
			lab_item: EV_GRID_LABEL_ITEM
		do
			lab_item ?= a_item
			if lab_item /= Void then
				Result := lab_item.text
			end
		end

	item_veto_pebble_function (a_item: EV_GRID_ITEM; a_pebble: ANY): BOOLEAN is
			-- Only allow drops on EV_GRID_LABEL_ITEMS.
		local
			lab_item: EV_GRID_LABEL_ITEM
		do
			lab_item ?= a_item
			Result := lab_item /= Void
		end

	item_drop_actions (a_item: EV_GRID_LABEL_ITEM; a_pebble: STRING) is
			-- Set the text to `a_pebble'  if indeed `a_item' is an EV_GRID_ITEM
		do
			if a_item /= Void then
				a_item.set_text (a_pebble)
			end
		end
		
end -- class GRID_TAB

