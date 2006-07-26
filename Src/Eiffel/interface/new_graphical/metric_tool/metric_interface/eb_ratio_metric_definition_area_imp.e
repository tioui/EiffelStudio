indexing
	description: "[
		Objects that represent an EV_TITLED_WINDOW.
		The original version of this class was generated by EiffelBuild.
		This class is the implementation of an EV_TITLED_WINDOW generated by EiffelBuild.
		You should not modify this code by hand, as it will be re-generated every time
		 modifications are made to the project.
		 	]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EB_RATIO_METRIC_DEFINITION_AREA_IMP

inherit
	EV_VERTICAL_BOX
		redefine
			initialize, is_in_default_state
		end

feature {NONE}-- Initialization

	initialize is
			-- Initialize `Current'.
		do
			Precursor {EV_VERTICAL_BOX}
			
				-- Create all widgets.
			create definition_frame
			create l_ev_vertical_box_1
			create numerator_area
			create numerator_lbl
			create l_ev_frame_1
			create l_ev_horizontal_box_1
			create numerator_text
			create numerator_btn
			create l_ev_cell_1
			create numerator_target_pixmap
			create denominator_area
			create denominator_lbl
			create l_ev_frame_2
			create l_ev_horizontal_box_2
			create denominator_text
			create denominator_btn
			create l_ev_cell_2
			create denominator_target_pixmap
			create expression_area
			create l_ev_horizontal_box_3
			create expression_lbl
			create l_ev_cell_3
			create expression_text
			
				-- Build_widget_structure.
			extend (definition_frame)
			definition_frame.extend (l_ev_vertical_box_1)
			l_ev_vertical_box_1.extend (numerator_area)
			numerator_area.extend (numerator_lbl)
			numerator_area.extend (l_ev_frame_1)
			l_ev_frame_1.extend (l_ev_horizontal_box_1)
			l_ev_horizontal_box_1.extend (numerator_text)
			l_ev_horizontal_box_1.extend (numerator_btn)
			numerator_area.extend (l_ev_cell_1)
			numerator_area.extend (numerator_target_pixmap)
			l_ev_vertical_box_1.extend (denominator_area)
			denominator_area.extend (denominator_lbl)
			denominator_area.extend (l_ev_frame_2)
			l_ev_frame_2.extend (l_ev_horizontal_box_2)
			l_ev_horizontal_box_2.extend (denominator_text)
			l_ev_horizontal_box_2.extend (denominator_btn)
			denominator_area.extend (l_ev_cell_2)
			denominator_area.extend (denominator_target_pixmap)
			extend (expression_area)
			expression_area.extend (l_ev_horizontal_box_3)
			l_ev_horizontal_box_3.extend (expression_lbl)
			l_ev_horizontal_box_3.extend (l_ev_cell_3)
			expression_area.extend (expression_text)
			
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
			
			l_ev_vertical_box_1.set_padding_width (10)
			l_ev_vertical_box_1.set_border_width (5)
			l_ev_vertical_box_1.disable_item_expand (numerator_area)
			l_ev_vertical_box_1.disable_item_expand (denominator_area)
			numerator_area.set_padding_width (3)
			numerator_area.disable_item_expand (numerator_lbl)
			numerator_area.disable_item_expand (l_ev_frame_1)
			numerator_area.disable_item_expand (l_ev_cell_1)
			numerator_area.disable_item_expand (numerator_target_pixmap)
			numerator_lbl.set_text ("Numerator Metric:")
			numerator_lbl.set_minimum_width (100)
			numerator_lbl.align_text_left
			l_ev_frame_1.set_style (1)
			l_ev_horizontal_box_1.disable_item_expand (numerator_text)
			l_ev_horizontal_box_1.disable_item_expand (numerator_btn)
			numerator_text.set_minimum_width (150)
			numerator_text.disable_edit
			l_ev_cell_1.set_minimum_width (5)
			numerator_target_pixmap.set_minimum_width (16)
			numerator_target_pixmap.set_minimum_height (16)
			denominator_area.set_padding_width (3)
			denominator_area.disable_item_expand (denominator_lbl)
			denominator_area.disable_item_expand (l_ev_frame_2)
			denominator_area.disable_item_expand (l_ev_cell_2)
			denominator_area.disable_item_expand (denominator_target_pixmap)
			denominator_lbl.set_text ("Denominator Metric:")
			denominator_lbl.set_minimum_width (100)
			denominator_lbl.align_text_left
			l_ev_frame_2.set_style (1)
			l_ev_horizontal_box_2.disable_item_expand (denominator_text)
			l_ev_horizontal_box_2.disable_item_expand (denominator_btn)
			denominator_text.set_minimum_width (150)
			denominator_text.disable_edit
			l_ev_cell_2.set_minimum_width (5)
			denominator_target_pixmap.set_minimum_width (16)
			denominator_target_pixmap.set_minimum_height (16)
			expression_area.set_padding_width (3)
			expression_area.disable_item_expand (l_ev_horizontal_box_3)
			expression_area.disable_item_expand (expression_text)
			expression_lbl.set_text ("Expression:")
			expression_lbl.align_text_left
			expression_text.set_minimum_width (35)
			expression_text.set_minimum_height (35)
			expression_text.disable_edit
			set_padding_width (10)
			disable_item_expand (definition_frame)
			disable_item_expand (expression_area)
			
			set_all_attributes_using_constants
			
				--Connect events.
				-- Close the application when an interface close
				-- request is recieved on `Current'. i.e. the cross is clicked.

				-- Call `user_initialization'.
			user_initialization
		end


feature -- Access

	expression_text: EV_RICH_TEXT
	numerator_btn, denominator_btn: EV_BUTTON
	numerator_target_pixmap, denominator_target_pixmap: EV_PIXMAP
	numerator_area,
	denominator_area: EV_HORIZONTAL_BOX
	expression_area: EV_VERTICAL_BOX
	numerator_lbl, denominator_lbl, expression_lbl: EV_LABEL
	numerator_text,
	denominator_text: EV_TEXT_FIELD
	definition_frame: EV_FRAME

feature {NONE} -- Implementation

	l_ev_cell_1, l_ev_cell_2, l_ev_cell_3: EV_CELL
	l_ev_horizontal_box_1, l_ev_horizontal_box_2,
	l_ev_horizontal_box_3: EV_HORIZONTAL_BOX
	l_ev_vertical_box_1: EV_VERTICAL_BOX
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
			s: STRING_32
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
					
	string_constant_set_procedures: ARRAYED_LIST [PROCEDURE [ANY, TUPLE [STRING_GENERAL]]]
	string_constant_retrieval_functions: ARRAYED_LIST [FUNCTION [ANY, TUPLE [], STRING_32]]
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

end -- class EB_RATIO_METRIC_DEFINITION_AREA_IMP
