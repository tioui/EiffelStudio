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
	MAIN_WINDOW_IMP

inherit
	EV_TITLED_WINDOW
		redefine
			initialize, is_in_default_state
		end
			
	CONSTANTS
		undefine
			is_equal, default_create, copy
		end

feature {NONE}-- Initialization

	initialize is
			-- Initialize `Current'.
		local
			internal_font: EV_FONT
		do
			Precursor {EV_TITLED_WINDOW}
			initialize_constants
			
				-- Create all widgets.
			create l_ev_vertical_box_1
			create l_ev_horizontal_split_area_1
			create l_ev_vertical_box_2
			create l_ev_frame_1
			create process_area
			create select_and_start
			create recursively_process_check_button
			create stop_when_post_parsing_failed_button
			create l_ev_frame_2
			create copyright_list
			create l_ev_vertical_split_area_1
			create l_ev_frame_3
			create l_ev_vertical_box_3
			create save_bar
			create save_button
			create save_as_button
			create copyright_text
			create l_ev_frame_4
			create l_ev_vertical_box_4
			create output_text
			create status_label
			create l_ev_horizontal_box_1
			create eiffel_icon_frame
			create instructions_label
			
				-- Build widget structure.
			extend (l_ev_vertical_box_1)
			l_ev_vertical_box_1.extend (l_ev_horizontal_split_area_1)
			l_ev_horizontal_split_area_1.extend (l_ev_vertical_box_2)
			l_ev_vertical_box_2.extend (l_ev_frame_1)
			l_ev_frame_1.extend (process_area)
			process_area.extend (select_and_start)
			process_area.extend (recursively_process_check_button)
			process_area.extend (stop_when_post_parsing_failed_button)
			l_ev_vertical_box_2.extend (l_ev_frame_2)
			l_ev_frame_2.extend (copyright_list)
			l_ev_horizontal_split_area_1.extend (l_ev_vertical_split_area_1)
			l_ev_vertical_split_area_1.extend (l_ev_frame_3)
			l_ev_frame_3.extend (l_ev_vertical_box_3)
			l_ev_vertical_box_3.extend (save_bar)
			save_bar.extend (save_button)
			save_bar.extend (save_as_button)
			l_ev_vertical_box_3.extend (copyright_text)
			l_ev_vertical_split_area_1.extend (l_ev_frame_4)
			l_ev_frame_4.extend (l_ev_vertical_box_4)
			l_ev_vertical_box_4.extend (output_text)
			l_ev_vertical_box_4.extend (status_label)
			l_ev_vertical_box_1.extend (l_ev_horizontal_box_1)
			l_ev_horizontal_box_1.extend (eiffel_icon_frame)
			l_ev_horizontal_box_1.extend (instructions_label)
			
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
			l_ev_vertical_box_1.disable_item_expand (l_ev_horizontal_box_1)
			l_ev_horizontal_split_area_1.disable_item_expand (l_ev_vertical_box_2)
			l_ev_horizontal_split_area_1.enable_item_expand (l_ev_vertical_split_area_1)
			l_ev_vertical_box_2.set_minimum_width (160)
			l_ev_vertical_box_2.set_padding (2)
			l_ev_vertical_box_2.set_border_width (2)
			l_ev_vertical_box_2.disable_item_expand (l_ev_frame_1)
			l_ev_frame_1.set_text ("Process")
			process_area.set_border_width (2)
			process_area.disable_item_expand (select_and_start)
			select_and_start.set_text ("Select & Start")
			select_and_start.set_minimum_height (46)
			recursively_process_check_button.enable_select
			recursively_process_check_button.set_text ("Recursively")
			recursively_process_check_button.set_tooltip ("Recursively process directory?")
			stop_when_post_parsing_failed_button.set_text ("Stop when post parsing fails")
			l_ev_frame_2.set_text ("Select Copyright")
			l_ev_vertical_split_area_1.enable_item_expand (l_ev_frame_3)
			l_ev_vertical_split_area_1.disable_item_expand (l_ev_frame_4)
			l_ev_frame_3.set_text ("Copyright")
			l_ev_vertical_box_3.set_border_width (2)
			l_ev_vertical_box_3.disable_item_expand (save_bar)
			save_button.set_text ("Save")
			save_as_button.set_text ("Save As...")
			copyright_text.set_foreground_color (create {EV_COLOR}.make_with_8_bit_rgb (128, 0, 0))
			create internal_font
			internal_font.set_family ({EV_FONT_CONSTANTS}.Family_typewriter)
			internal_font.set_weight ({EV_FONT_CONSTANTS}.Weight_regular)
			internal_font.set_shape ({EV_FONT_CONSTANTS}.Shape_regular)
			internal_font.set_height_in_points (8)
			internal_font.preferred_families.extend ("Courier New")
			copyright_text.set_font (internal_font)
			l_ev_frame_4.set_text ("Output")
			integer_constant_set_procedures.extend (agent l_ev_frame_4.set_minimum_height (?))
			integer_constant_retrieval_functions.extend (agent out_put_text_height)
			l_ev_vertical_box_4.set_border_width (2)
			l_ev_vertical_box_4.disable_item_expand (status_label)
			create internal_font
			internal_font.set_family ({EV_FONT_CONSTANTS}.Family_sans)
			internal_font.set_weight ({EV_FONT_CONSTANTS}.Weight_regular)
			internal_font.set_shape ({EV_FONT_CONSTANTS}.Shape_regular)
			internal_font.set_height_in_points (12)
			internal_font.preferred_families.extend ("Cordia New")
			output_text.set_font (internal_font)
			output_text.disable_edit
			status_label.align_text_left
			l_ev_horizontal_box_1.disable_item_expand (eiffel_icon_frame)
			eiffel_icon_frame.set_minimum_width (96)
			eiffel_icon_frame.set_minimum_height (96)
			instructions_label.align_text_left
			set_minimum_width (400)
			set_minimum_height (300)
			set_title ("Eiffel Copyright")
			
			set_all_attributes_using_constants
			
				-- Connect events.
			select_and_start.select_actions.extend (agent on_select_and_start)
			save_button.select_actions.extend (agent on_save)
			save_as_button.select_actions.extend (agent on_save_as)
			copyright_text.change_actions.extend (agent on_text_changed)
			focus_in_actions.extend (agent on_focus)
			close_request_actions.extend (agent on_close)
				-- Close the application when an interface close
				-- request is recieved on `Current'. i.e. the cross is clicked.

				-- Call `user_initialization'.
			user_initialization
		end


feature -- Access

	save_bar: EV_TOOL_BAR
	copyright_list: EV_LIST
	select_and_start: EV_BUTTON
	copyright_text, output_text: EV_TEXT
	save_button,
	save_as_button: EV_TOOL_BAR_BUTTON
	process_area, eiffel_icon_frame: EV_VERTICAL_BOX
	recursively_process_check_button,
	stop_when_post_parsing_failed_button: EV_CHECK_BUTTON
	status_label, instructions_label: EV_LABEL

feature {NONE} -- Implementation

	l_ev_horizontal_split_area_1: EV_HORIZONTAL_SPLIT_AREA
	l_ev_vertical_split_area_1: EV_VERTICAL_SPLIT_AREA
	l_ev_horizontal_box_1: EV_HORIZONTAL_BOX
	l_ev_vertical_box_1,
	l_ev_vertical_box_2, l_ev_vertical_box_3, l_ev_vertical_box_4: EV_VERTICAL_BOX
	l_ev_frame_1, l_ev_frame_2,
	l_ev_frame_3, l_ev_frame_4: EV_FRAME

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
	
	on_select_and_start is
			-- Called by `select_actions' of `select_and_start'.
		deferred
		end
	
	on_save is
			-- Called by `select_actions' of `save_button'.
		deferred
		end
	
	on_save_as is
			-- Called by `select_actions' of `save_as_button'.
		deferred
		end
	
	on_text_changed is
			-- Called by `change_actions' of `copyright_text'.
		deferred
		end
	
	on_focus is
			-- Called by `focus_in_actions' of `Current'.
		deferred
		end
	
	on_close is
			-- Called by `close_request_actions' of `Current'.
		deferred
		end
	
	
feature {NONE} -- Constant setting

	set_attributes_using_string_constants is
			-- Set all attributes relying on string constants to the current
			-- value of the associated constant.
		local
			s: STRING_GENERAL
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
	string_constant_retrieval_functions: ARRAYED_LIST [FUNCTION [ANY, TUPLE [], STRING_GENERAL]]
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

end
