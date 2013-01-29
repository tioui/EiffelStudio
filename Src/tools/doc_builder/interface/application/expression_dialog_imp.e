note
	description: "Objects that represent an EV_DIALOG.%
		%The original version of this class was generated by EiffelBuild."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EXPRESSION_DIALOG_IMP

inherit
	EV_DIALOG
		redefine
			initialize, is_in_default_state
		end
			
	CONSTANTS
		undefine
			is_equal, default_create, copy
		end

-- This class is the implementation of an EV_DIALOG generated by EiffelBuild.
-- You should not modify this code by hand, as it will be re-generated every time
-- modifications are made to the project.

feature {NONE}-- Initialization

	initialize
			-- Initialize `Current'.
		do
			Precursor {EV_DIALOG}
			initialize_constants
			
				-- Create all widgets.
			create l_ev_vertical_box_1
			create notebook
			create l_ev_vertical_box_2
			create l_ev_horizontal_box_1
			create l_ev_label_1
			create l_ev_horizontal_separator_1
			create l_ev_horizontal_box_2
			create l_ev_cell_1
			create expression_list
			create l_ev_horizontal_box_3
			create l_ev_cell_2
			create expression_browse_button
			create save_expressions_button
			create l_ev_horizontal_box_4
			create l_ev_label_2
			create l_ev_horizontal_separator_2
			create l_ev_horizontal_box_5
			create l_ev_label_3
			create expression_text
			create l_ev_horizontal_box_6
			create l_ev_label_4
			create replacement_text
			create l_ev_horizontal_box_7
			create l_ev_cell_3
			create expression_button
			create xml_widget_box
			create l_ev_horizontal_box_8
			create l_ev_label_5
			create l_ev_horizontal_separator_3
			create xml_structure_list
			create l_ev_horizontal_box_9
			create l_ev_label_6
			create l_ev_horizontal_separator_4
			create l_ev_horizontal_box_10
			create l_ev_label_7
			create l_ev_horizontal_box_11
			create xml_name_check
			create xml_name_text
			create l_ev_horizontal_box_12
			create xml_expr_check
			create xml_expr_text
			create l_ev_horizontal_box_13
			create l_ev_label_8
			create l_ev_horizontal_separator_5
			create l_ev_vertical_box_3
			create all_open_radio
			create all_project_radio
			create l_ev_cell_4
			create l_ev_horizontal_box_14
			create l_ev_cell_5
			create apply_button
			create okay_button
			create cancel_button
			
				-- Build_widget_structure.
			extend (l_ev_vertical_box_1)
			l_ev_vertical_box_1.extend (notebook)
			notebook.extend (l_ev_vertical_box_2)
			l_ev_vertical_box_2.extend (l_ev_horizontal_box_1)
			l_ev_horizontal_box_1.extend (l_ev_label_1)
			l_ev_horizontal_box_1.extend (l_ev_horizontal_separator_1)
			l_ev_vertical_box_2.extend (l_ev_horizontal_box_2)
			l_ev_horizontal_box_2.extend (l_ev_cell_1)
			l_ev_vertical_box_2.extend (expression_list)
			l_ev_vertical_box_2.extend (l_ev_horizontal_box_3)
			l_ev_horizontal_box_3.extend (l_ev_cell_2)
			l_ev_horizontal_box_3.extend (expression_browse_button)
			l_ev_horizontal_box_3.extend (save_expressions_button)
			l_ev_vertical_box_2.extend (l_ev_horizontal_box_4)
			l_ev_horizontal_box_4.extend (l_ev_label_2)
			l_ev_horizontal_box_4.extend (l_ev_horizontal_separator_2)
			l_ev_vertical_box_2.extend (l_ev_horizontal_box_5)
			l_ev_horizontal_box_5.extend (l_ev_label_3)
			l_ev_horizontal_box_5.extend (expression_text)
			l_ev_vertical_box_2.extend (l_ev_horizontal_box_6)
			l_ev_horizontal_box_6.extend (l_ev_label_4)
			l_ev_horizontal_box_6.extend (replacement_text)
			l_ev_vertical_box_2.extend (l_ev_horizontal_box_7)
			l_ev_horizontal_box_7.extend (l_ev_cell_3)
			l_ev_horizontal_box_7.extend (expression_button)
			notebook.extend (xml_widget_box)
			xml_widget_box.extend (l_ev_horizontal_box_8)
			l_ev_horizontal_box_8.extend (l_ev_label_5)
			l_ev_horizontal_box_8.extend (l_ev_horizontal_separator_3)
			xml_widget_box.extend (xml_structure_list)
			xml_widget_box.extend (l_ev_horizontal_box_9)
			l_ev_horizontal_box_9.extend (l_ev_label_6)
			l_ev_horizontal_box_9.extend (l_ev_horizontal_separator_4)
			xml_widget_box.extend (l_ev_horizontal_box_10)
			l_ev_horizontal_box_10.extend (l_ev_label_7)
			xml_widget_box.extend (l_ev_horizontal_box_11)
			l_ev_horizontal_box_11.extend (xml_name_check)
			l_ev_horizontal_box_11.extend (xml_name_text)
			xml_widget_box.extend (l_ev_horizontal_box_12)
			l_ev_horizontal_box_12.extend (xml_expr_check)
			l_ev_horizontal_box_12.extend (xml_expr_text)
			l_ev_vertical_box_1.extend (l_ev_horizontal_box_13)
			l_ev_horizontal_box_13.extend (l_ev_label_8)
			l_ev_horizontal_box_13.extend (l_ev_horizontal_separator_5)
			l_ev_vertical_box_1.extend (l_ev_vertical_box_3)
			l_ev_vertical_box_3.extend (all_open_radio)
			l_ev_vertical_box_3.extend (all_project_radio)
			l_ev_vertical_box_1.extend (l_ev_cell_4)
			l_ev_vertical_box_1.extend (l_ev_horizontal_box_14)
			l_ev_horizontal_box_14.extend (l_ev_cell_5)
			l_ev_horizontal_box_14.extend (apply_button)
			l_ev_horizontal_box_14.extend (okay_button)
			l_ev_horizontal_box_14.extend (cancel_button)
			
			l_ev_vertical_box_1.set_padding_width (5)
			l_ev_vertical_box_1.set_border_width (2)
			l_ev_vertical_box_1.disable_item_expand (l_ev_horizontal_box_13)
			l_ev_vertical_box_1.disable_item_expand (l_ev_vertical_box_3)
			l_ev_vertical_box_1.disable_item_expand (l_ev_cell_4)
			l_ev_vertical_box_1.disable_item_expand (l_ev_horizontal_box_14)
			notebook.set_item_text (l_ev_vertical_box_2, "Regular Expressions")
			notebook.set_item_text (xml_widget_box, "XML Parsing")
			l_ev_vertical_box_2.set_padding_width (5)
			l_ev_vertical_box_2.set_border_width (2)
			l_ev_vertical_box_2.disable_item_expand (l_ev_horizontal_box_1)
			l_ev_vertical_box_2.disable_item_expand (l_ev_horizontal_box_2)
			l_ev_vertical_box_2.disable_item_expand (l_ev_horizontal_box_3)
			l_ev_vertical_box_2.disable_item_expand (l_ev_horizontal_box_4)
			l_ev_vertical_box_2.disable_item_expand (l_ev_horizontal_box_5)
			l_ev_vertical_box_2.disable_item_expand (l_ev_horizontal_box_6)
			l_ev_vertical_box_2.disable_item_expand (l_ev_horizontal_box_7)
			l_ev_horizontal_box_1.set_padding_width (5)
			l_ev_horizontal_box_1.set_border_width (2)
			l_ev_horizontal_box_1.disable_item_expand (l_ev_label_1)
			l_ev_label_1.set_text ("Regular Expressions")
			l_ev_label_1.align_text_left
			l_ev_horizontal_box_2.set_padding_width (5)
			l_ev_horizontal_box_2.set_border_width (2)
			l_ev_horizontal_box_3.set_padding_width (5)
			l_ev_horizontal_box_3.set_border_width (2)
			l_ev_horizontal_box_3.disable_item_expand (expression_browse_button)
			l_ev_horizontal_box_3.disable_item_expand (save_expressions_button)
			expression_browse_button.set_text (button_open_text)
			expression_browse_button.set_minimum_width (button_width)
			save_expressions_button.set_text (button_save_text)
			save_expressions_button.set_minimum_width (button_width)
			l_ev_horizontal_box_4.set_padding_width (5)
			l_ev_horizontal_box_4.set_border_width (2)
			l_ev_horizontal_box_4.disable_item_expand (l_ev_label_2)
			l_ev_label_2.set_text ("Add/Modify Expression")
			l_ev_label_2.align_text_left
			l_ev_horizontal_box_5.set_padding_width (5)
			l_ev_horizontal_box_5.set_border_width (2)
			l_ev_horizontal_box_5.disable_item_expand (l_ev_label_3)
			l_ev_label_3.set_text ("Expression")
			l_ev_label_3.align_text_left
			l_ev_horizontal_box_6.set_padding_width (5)
			l_ev_horizontal_box_6.set_border_width (2)
			l_ev_horizontal_box_6.disable_item_expand (l_ev_label_4)
			l_ev_label_4.set_text ("Replace with")
			l_ev_label_4.align_text_left
			l_ev_horizontal_box_7.set_padding_width (5)
			l_ev_horizontal_box_7.set_border_width (2)
			l_ev_horizontal_box_7.disable_item_expand (expression_button)
			expression_button.set_text (button_add_text)
			expression_button.set_minimum_width (button_width)
			xml_widget_box.set_padding_width (5)
			xml_widget_box.set_border_width (2)
			xml_widget_box.disable_item_expand (l_ev_horizontal_box_8)
			xml_widget_box.disable_item_expand (l_ev_horizontal_box_9)
			xml_widget_box.disable_item_expand (l_ev_horizontal_box_10)
			xml_widget_box.disable_item_expand (l_ev_horizontal_box_11)
			xml_widget_box.disable_item_expand (l_ev_horizontal_box_12)
			l_ev_horizontal_box_8.set_padding_width (5)
			l_ev_horizontal_box_8.set_border_width (2)
			l_ev_horizontal_box_8.disable_item_expand (l_ev_label_5)
			l_ev_label_5.set_text ("XML Elements")
			l_ev_label_5.align_text_left
			l_ev_horizontal_box_9.set_padding_width (5)
			l_ev_horizontal_box_9.set_border_width (2)
			l_ev_horizontal_box_9.disable_item_expand (l_ev_label_6)
			l_ev_label_6.set_text ("Actions")
			l_ev_label_6.align_text_left
			l_ev_horizontal_box_10.set_padding_width (5)
			l_ev_horizontal_box_10.set_border_width (2)
			l_ev_label_7.set_text ("On the selected item:")
			l_ev_label_7.align_text_left
			l_ev_horizontal_box_11.set_padding_width (5)
			l_ev_horizontal_box_11.set_border_width (2)
			l_ev_horizontal_box_11.disable_item_expand (xml_name_check)
			xml_name_check.enable_select
			xml_name_check.set_text ("Change name to ")
			l_ev_horizontal_box_12.set_padding_width (5)
			l_ev_horizontal_box_12.set_border_width (2)
			l_ev_horizontal_box_12.disable_item_expand (xml_expr_check)
			xml_expr_check.set_text ("Apply regular expression to content")
			l_ev_horizontal_box_13.set_padding_width (5)
			l_ev_horizontal_box_13.set_border_width (2)
			l_ev_horizontal_box_13.disable_item_expand (l_ev_label_8)
			l_ev_label_8.set_text ("Advanced")
			l_ev_label_8.align_text_left
			l_ev_vertical_box_3.set_padding_width (5)
			l_ev_vertical_box_3.set_border_width (2)
			l_ev_vertical_box_3.disable_item_expand (all_open_radio)
			all_open_radio.set_text ("Apply to all open documents")
			all_project_radio.set_text ("Apply to all project documents")
			l_ev_horizontal_box_14.set_padding_width (5)
			l_ev_horizontal_box_14.set_border_width (2)
			l_ev_horizontal_box_14.disable_item_expand (apply_button)
			l_ev_horizontal_box_14.disable_item_expand (okay_button)
			l_ev_horizontal_box_14.disable_item_expand (cancel_button)
			apply_button.set_text (button_apply_text)
			apply_button.set_minimum_width (button_width)
			okay_button.set_text (button_ok_text)
			okay_button.set_minimum_width (button_width)
			cancel_button.set_text (button_cancel_text)
			cancel_button.set_minimum_width (button_width)
			set_minimum_width (dialog_wide_width)
			set_minimum_height (dialog_tall_height)
			disable_user_resize
			set_title ("Parser Tool")
			
				--Connect events.
				-- Close the application when an interface close
				-- request is received on `Current'. i.e. the cross is clicked.

				-- Call `user_initialization'.
			user_initialization
		end

feature -- Access

	l_ev_horizontal_separator_1: EV_HORIZONTAL_SEPARATOR
	l_ev_horizontal_separator_2: EV_HORIZONTAL_SEPARATOR
	l_ev_horizontal_separator_3: EV_HORIZONTAL_SEPARATOR
	l_ev_horizontal_separator_4: EV_HORIZONTAL_SEPARATOR
	l_ev_horizontal_separator_5: EV_HORIZONTAL_SEPARATOR
	expression_list: EV_MULTI_COLUMN_LIST
	l_ev_cell_1: EV_CELL
	l_ev_cell_2: EV_CELL
	l_ev_cell_3: EV_CELL
	l_ev_cell_4: EV_CELL
	l_ev_cell_5: EV_CELL
	expression_browse_button: EV_BUTTON
	save_expressions_button: EV_BUTTON
	expression_button: EV_BUTTON
	apply_button: EV_BUTTON
	okay_button: EV_BUTTON
	cancel_button: EV_BUTTON
	notebook: EV_NOTEBOOK
	l_ev_horizontal_box_1: EV_HORIZONTAL_BOX
	l_ev_horizontal_box_2: EV_HORIZONTAL_BOX
	l_ev_horizontal_box_3: EV_HORIZONTAL_BOX
	l_ev_horizontal_box_4: EV_HORIZONTAL_BOX
	l_ev_horizontal_box_5: EV_HORIZONTAL_BOX
	l_ev_horizontal_box_6: EV_HORIZONTAL_BOX
	l_ev_horizontal_box_7: EV_HORIZONTAL_BOX
	l_ev_horizontal_box_8: EV_HORIZONTAL_BOX
	l_ev_horizontal_box_9: EV_HORIZONTAL_BOX
	l_ev_horizontal_box_10: EV_HORIZONTAL_BOX
	l_ev_horizontal_box_11: EV_HORIZONTAL_BOX
	l_ev_horizontal_box_12: EV_HORIZONTAL_BOX
	l_ev_horizontal_box_13: EV_HORIZONTAL_BOX
	l_ev_horizontal_box_14: EV_HORIZONTAL_BOX
	l_ev_vertical_box_1: EV_VERTICAL_BOX
	l_ev_vertical_box_2: EV_VERTICAL_BOX
	xml_widget_box: EV_VERTICAL_BOX
	l_ev_vertical_box_3: EV_VERTICAL_BOX
	xml_name_check: EV_CHECK_BUTTON
	xml_expr_check: EV_CHECK_BUTTON
	all_open_radio: EV_CHECK_BUTTON
	all_project_radio: EV_CHECK_BUTTON
	l_ev_label_1: EV_LABEL
	l_ev_label_2: EV_LABEL
	l_ev_label_3: EV_LABEL
	l_ev_label_4: EV_LABEL
	l_ev_label_5: EV_LABEL
	l_ev_label_6: EV_LABEL
	l_ev_label_7: EV_LABEL
	l_ev_label_8: EV_LABEL
	xml_structure_list: EV_TREE
	expression_text: EV_TEXT_FIELD
	replacement_text: EV_TEXT_FIELD
	xml_name_text: EV_TEXT_FIELD
	xml_expr_text: EV_TEXT_FIELD

feature {NONE} -- Implementation

	is_in_default_state: BOOLEAN
			-- Is `Current' in its default state?
		do
			-- Re-implement if you wish to enable checking
			-- for `Current'.
			Result := True
		end
	
	user_initialization
			-- Feature for custom initialization, called at end of `initialize'.
		deferred
		end
	
note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"
end -- class EXPRESSION_DIALOG_IMP
