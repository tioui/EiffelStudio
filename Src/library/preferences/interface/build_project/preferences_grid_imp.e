indexing
	description: "[
		Objects that represent an EV_DIALOG.
		The original version of this class was generated by EiffelBuild.
		This class is the implementation of an EV_DIALOG generated by EiffelBuild.
		You should not modify this code by hand, as it will be re-generated every time
		 modifications are made to the project.
		 	]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	PREFERENCES_GRID_IMP

inherit
	EV_DIALOG
		redefine
			initialize, is_in_default_state
		end

feature {NONE}-- Initialization

	initialize is
			-- Initialize `Current'.
		do
			Precursor {EV_DIALOG}
			
				-- Create all widgets.
			create l_ev_vertical_box_1
			create l_ev_vertical_box_2
			create l_ev_horizontal_box_1
			create l_ev_frame_1
			create l_ev_horizontal_box_2
			create filter_box
			create l_ev_label_1
			create filter_text_box
			create l_ev_tool_bar_1
			create view_toggle_button
			create split_area
			create l_ev_vertical_box_3
			create l_ev_frame_2
			create l_ev_vertical_box_4
			create grid_container
			create status_box
			create status_label
			create l_ev_vertical_box_5
			create l_ev_horizontal_box_3
			create l_ev_label_2
			create l_ev_horizontal_separator_1
			create l_ev_vertical_box_6
			create description_text
			create l_ev_horizontal_box_4
			create restore_button
			create l_ev_cell_1
			create close_button
			
				-- Build widget structure.
			extend (l_ev_vertical_box_1)
			l_ev_vertical_box_1.extend (l_ev_vertical_box_2)
			l_ev_vertical_box_2.extend (l_ev_horizontal_box_1)
			l_ev_horizontal_box_1.extend (l_ev_frame_1)
			l_ev_frame_1.extend (l_ev_horizontal_box_2)
			l_ev_horizontal_box_2.extend (filter_box)
			filter_box.extend (l_ev_label_1)
			filter_box.extend (filter_text_box)
			l_ev_horizontal_box_2.extend (l_ev_tool_bar_1)
			l_ev_tool_bar_1.extend (view_toggle_button)
			l_ev_vertical_box_2.extend (split_area)
			split_area.extend (l_ev_vertical_box_3)
			l_ev_vertical_box_3.extend (l_ev_frame_2)
			l_ev_frame_2.extend (l_ev_vertical_box_4)
			l_ev_vertical_box_4.extend (grid_container)
			l_ev_vertical_box_4.extend (status_box)
			status_box.extend (status_label)
			split_area.extend (l_ev_vertical_box_5)
			l_ev_vertical_box_5.extend (l_ev_horizontal_box_3)
			l_ev_horizontal_box_3.extend (l_ev_label_2)
			l_ev_horizontal_box_3.extend (l_ev_horizontal_separator_1)
			l_ev_vertical_box_5.extend (l_ev_vertical_box_6)
			l_ev_vertical_box_6.extend (description_text)
			l_ev_vertical_box_1.extend (l_ev_horizontal_box_4)
			l_ev_horizontal_box_4.extend (restore_button)
			l_ev_horizontal_box_4.extend (l_ev_cell_1)
			l_ev_horizontal_box_4.extend (close_button)
			
			create string_constant_set_procedures.make (10)
			create string_constant_retrieval_functions.make (10)
			create integer_constant_set_procedures.make (10)
			create integer_constant_retrieval_functions.make (10)
			create pixmap_constant_set_procedures.make (10)
			create pixmap_constant_retrieval_functions.make (10)
			create integer_interval_constant_retrieval_functions.make (10)
			create integer_interval_constant_set_procedures.make (10)
			create font_constant_set_procedures.make (10)
			create font_constant_retrieval_functions.make (10)
			create pixmap_constant_retrieval_functions.make (10)
			create color_constant_set_procedures.make (10)
			create color_constant_retrieval_functions.make (10)
			l_ev_vertical_box_1.set_padding (5)
			l_ev_vertical_box_1.disable_item_expand (l_ev_horizontal_box_4)
			l_ev_vertical_box_2.set_padding (5)
			l_ev_vertical_box_2.set_border_width (5)
			l_ev_vertical_box_2.disable_item_expand (l_ev_horizontal_box_1)
			l_ev_horizontal_box_1.set_padding (5)
			l_ev_horizontal_box_1.set_border_width (2)
			l_ev_horizontal_box_2.set_padding (5)
			l_ev_horizontal_box_2.set_border_width (5)
			l_ev_horizontal_box_2.disable_item_expand (l_ev_tool_bar_1)
			filter_box.disable_item_expand (l_ev_label_1)
			l_ev_label_1.set_text ("Filter:")
			view_toggle_button.set_text ("Flat View")
			view_toggle_button.set_tooltip ("Tree/Flat View")
			split_area.enable_item_expand (l_ev_vertical_box_3)
			split_area.disable_item_expand (l_ev_vertical_box_5)
			l_ev_vertical_box_4.disable_item_expand (status_box)
			grid_container.set_minimum_width (350)
			grid_container.set_border_width (1)
			status_box.set_padding (5)
			status_box.set_border_width (2)
			status_label.align_text_right
			l_ev_vertical_box_5.disable_item_expand (l_ev_horizontal_box_3)
			l_ev_horizontal_box_3.set_padding (5)
			l_ev_horizontal_box_3.set_border_width (2)
			l_ev_horizontal_box_3.disable_item_expand (l_ev_label_2)
			l_ev_label_2.set_text ("Description")
			l_ev_label_2.align_text_left
			l_ev_vertical_box_6.set_padding (5)
			l_ev_vertical_box_6.set_border_width (3)
			description_text.set_foreground_color (create {EV_COLOR}.make_with_8_bit_rgb (0, 0, 255))
			description_text.set_minimum_height (40)
			description_text.disable_edit
			l_ev_horizontal_box_4.set_padding (5)
			l_ev_horizontal_box_4.set_border_width (5)
			l_ev_horizontal_box_4.disable_item_expand (restore_button)
			l_ev_horizontal_box_4.disable_item_expand (close_button)
			restore_button.set_text ("Restore Defaults")
			restore_button.set_minimum_width (90)
			close_button.set_text ("Close")
			close_button.set_minimum_width (80)
			set_title ("Display window")
			
			set_all_attributes_using_constants
			
				-- Connect events.
				-- Close the application when an interface close
				-- request is recieved on `Current'. i.e. the cross is clicked.

				-- Call `user_initialization'.
			user_initialization
		end


feature -- Access

	restore_button, close_button: EV_BUTTON
	description_text: EV_TEXT
	view_toggle_button: EV_TOOL_BAR_BUTTON
	split_area: EV_VERTICAL_SPLIT_AREA
	filter_box,
	status_box: EV_HORIZONTAL_BOX
	grid_container: EV_VERTICAL_BOX
	status_label: EV_LABEL
	filter_text_box: EV_TEXT_FIELD

feature {NONE} -- Implementation

	l_ev_horizontal_separator_1: EV_HORIZONTAL_SEPARATOR
	l_ev_cell_1: EV_CELL
	l_ev_tool_bar_1: EV_TOOL_BAR
	l_ev_horizontal_box_1,
	l_ev_horizontal_box_2, l_ev_horizontal_box_3, l_ev_horizontal_box_4: EV_HORIZONTAL_BOX
	l_ev_vertical_box_1,
	l_ev_vertical_box_2, l_ev_vertical_box_3, l_ev_vertical_box_4, l_ev_vertical_box_5,
	l_ev_vertical_box_6: EV_VERTICAL_BOX
	l_ev_label_1, l_ev_label_2: EV_LABEL
	l_ev_frame_1, l_ev_frame_2: EV_FRAME

feature {NONE} -- Implementation

	is_in_default_state: BOOLEAN is
			-- Is `Current' in its default state?
		do
			-- Re-implement if you wish to enable checking
			-- for `Current'.
			Result := True
		end
	
	user_initialization is
			-- Feature for custom initialization, called at end of `initialize'.
		deferred
		end
	
feature {NONE} -- Constant setting

	set_attributes_using_string_constants is
			-- Set all attributes relying on string constants to the current
			-- value of the associated constant.
		local
			s: STRING
		do
			from
				string_constant_set_procedures.start
			until
				string_constant_set_procedures.off
			loop
				string_constant_retrieval_functions.i_th (string_constant_set_procedures.index).call (Void)
				s := string_constant_retrieval_functions.i_th (string_constant_set_procedures.index).last_result
				string_constant_set_procedures.item.call ([s])
				string_constant_set_procedures.forth
			end
		end
		
	set_attributes_using_integer_constants is
			-- Set all attributes relying on integer constants to the current
			-- value of the associated constant.
		local
			i: INTEGER
			arg1, arg2: INTEGER
			int: INTEGER_INTERVAL
		do
			from
				integer_constant_set_procedures.start
			until
				integer_constant_set_procedures.off
			loop
				integer_constant_retrieval_functions.i_th (integer_constant_set_procedures.index).call (Void)
				i := integer_constant_retrieval_functions.i_th (integer_constant_set_procedures.index).last_result
				integer_constant_set_procedures.item.call ([i])
				integer_constant_set_procedures.forth
			end
			from
				integer_interval_constant_retrieval_functions.start
				integer_interval_constant_set_procedures.start
			until
				integer_interval_constant_retrieval_functions.off
			loop
				integer_interval_constant_retrieval_functions.item.call (Void)
				arg1 := integer_interval_constant_retrieval_functions.item.last_result
				integer_interval_constant_retrieval_functions.forth
				integer_interval_constant_retrieval_functions.item.call (Void)
				arg2 := integer_interval_constant_retrieval_functions.item.last_result
				create int.make (arg1, arg2)
				integer_interval_constant_set_procedures.item.call ([int])
				integer_interval_constant_retrieval_functions.forth
				integer_interval_constant_set_procedures.forth
			end
		end
		
	set_attributes_using_pixmap_constants is
			-- Set all attributes relying on pixmap constants to the current
			-- value of the associated constant.
		local
			p: EV_PIXMAP
		do
			from
				pixmap_constant_set_procedures.start
			until
				pixmap_constant_set_procedures.off
			loop
				pixmap_constant_retrieval_functions.i_th (pixmap_constant_set_procedures.index).call (Void)
				p := pixmap_constant_retrieval_functions.i_th (pixmap_constant_set_procedures.index).last_result
				pixmap_constant_set_procedures.item.call ([p])
				pixmap_constant_set_procedures.forth
			end
		end
		
	set_attributes_using_font_constants is
			-- Set all attributes relying on font constants to the current
			-- value of the associated constant.
		local
			f: EV_FONT
		do
			from
				font_constant_set_procedures.start
			until
				font_constant_set_procedures.off
			loop
				font_constant_retrieval_functions.i_th (font_constant_set_procedures.index).call (Void)
				f := font_constant_retrieval_functions.i_th (font_constant_set_procedures.index).last_result
				font_constant_set_procedures.item.call ([f])
				font_constant_set_procedures.forth
			end	
		end
		
	set_attributes_using_color_constants is
			-- Set all attributes relying on color constants to the current
			-- value of the associated constant.
		local
			c: EV_COLOR
		do
			from
				color_constant_set_procedures.start
			until
				color_constant_set_procedures.off
			loop
				color_constant_retrieval_functions.i_th (color_constant_set_procedures.index).call (Void)
				c := color_constant_retrieval_functions.i_th (color_constant_set_procedures.index).last_result
				color_constant_set_procedures.item.call ([c])
				color_constant_set_procedures.forth
			end
		end
		
	set_all_attributes_using_constants is
			-- Set all attributes relying on constants to the current
			-- calue of the associated constant.
		do
			set_attributes_using_string_constants
			set_attributes_using_integer_constants
			set_attributes_using_pixmap_constants
			set_attributes_using_font_constants
			set_attributes_using_color_constants
		end
					
	string_constant_set_procedures: ARRAYED_LIST [PROCEDURE [ANY, TUPLE [STRING]]]
	string_constant_retrieval_functions: ARRAYED_LIST [FUNCTION [ANY, TUPLE [], STRING]]
	integer_constant_set_procedures: ARRAYED_LIST [PROCEDURE [ANY, TUPLE [INTEGER]]]
	integer_constant_retrieval_functions: ARRAYED_LIST [FUNCTION [ANY, TUPLE [], INTEGER]]
	pixmap_constant_set_procedures: ARRAYED_LIST [PROCEDURE [ANY, TUPLE [EV_PIXMAP]]]
	pixmap_constant_retrieval_functions: ARRAYED_LIST [FUNCTION [ANY, TUPLE [], EV_PIXMAP]]
	integer_interval_constant_retrieval_functions: ARRAYED_LIST [FUNCTION [ANY, TUPLE [], INTEGER]]
	integer_interval_constant_set_procedures: ARRAYED_LIST [PROCEDURE [ANY, TUPLE [INTEGER_INTERVAL]]]
	font_constant_set_procedures: ARRAYED_LIST [PROCEDURE [ANY, TUPLE [EV_FONT]]]
	font_constant_retrieval_functions: ARRAYED_LIST [FUNCTION [ANY, TUPLE [], EV_FONT]]
	color_constant_set_procedures: ARRAYED_LIST [PROCEDURE [ANY, TUPLE [EV_COLOR]]]
	color_constant_retrieval_functions: ARRAYED_LIST [FUNCTION [ANY, TUPLE [], EV_COLOR]]
	
	integer_from_integer (an_integer: INTEGER): INTEGER is
			-- Return `an_integer', used for creation of
			-- an agent that returns a fixed integer value.
		do
			Result := an_integer
		end

end -- class PREFERENCES_GRID_IMP
