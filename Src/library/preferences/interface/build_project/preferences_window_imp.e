note
	description: "[
		Objects that represent an EV_DIALOG.
		The original version of this class was generated by EiffelBuild.
		This class is the implementation of an EV_DIALOG generated by EiffelBuild.
		You should not modify this code by hand, as it will be re-generated every time
		 modifications are made to the project.
		 	]"
	generator: "EiffelBuild"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	PREFERENCES_WINDOW_IMP

inherit
	EV_DIALOG
		redefine
			create_interface_objects, initialize, is_in_default_state
		end

feature {NONE}-- Initialization

	frozen initialize
			-- Initialize `Current'.
		do
			Precursor {EV_DIALOG}


				-- Build widget structure.
			extend (l_ev_vertical_box_1)
			l_ev_vertical_box_1.extend (l_ev_horizontal_split_area_1)
			l_ev_horizontal_split_area_1.extend (left_list)
			l_ev_horizontal_split_area_1.extend (l_ev_vertical_box_2)
			l_ev_vertical_box_2.extend (l_ev_horizontal_box_1)
			l_ev_horizontal_box_1.extend (l_ev_frame_1)
			l_ev_horizontal_box_1.extend (l_ev_horizontal_box_2)
			l_ev_vertical_box_2.extend (split_area)
			split_area.extend (grid_container)
			split_area.extend (description_frame)
			description_frame.extend (l_ev_vertical_box_3)
			l_ev_vertical_box_3.extend (description_text)
			l_ev_vertical_box_1.extend (l_ev_horizontal_separator_1)
			l_ev_vertical_box_1.extend (l_ev_horizontal_box_3)
			l_ev_horizontal_box_3.extend (restore_button)
			l_ev_horizontal_box_3.extend (l_ev_cell_1)
			l_ev_horizontal_box_3.extend (close_button)

			l_ev_vertical_box_1.set_padding (5)
			l_ev_vertical_box_1.disable_item_expand (l_ev_horizontal_separator_1)
			l_ev_vertical_box_1.disable_item_expand (l_ev_horizontal_box_3)
			l_ev_horizontal_split_area_1.enable_item_expand (l_ev_vertical_box_2)
			l_ev_horizontal_split_area_1.disable_item_expand (left_list)
			left_list.set_minimum_width (200)
			l_ev_vertical_box_2.set_padding (5)
			l_ev_vertical_box_2.set_border_width (5)
			l_ev_vertical_box_2.disable_item_expand (l_ev_horizontal_box_1)
			split_area.enable_item_expand (description_frame)
			split_area.disable_item_expand (grid_container)
			grid_container.set_background_color (create {EV_COLOR}.make_with_8_bit_rgb (178, 178, 178))
			grid_container.set_minimum_width (350)
			grid_container.set_border_width (1)
			description_frame.set_text ("Details")
			l_ev_vertical_box_3.set_padding (5)
			l_ev_vertical_box_3.set_border_width (5)
			description_text.set_minimum_height (50)
			description_text.disable_edit
			l_ev_horizontal_box_3.set_padding (5)
			l_ev_horizontal_box_3.set_border_width (5)
			l_ev_horizontal_box_3.disable_item_expand (restore_button)
			l_ev_horizontal_box_3.disable_item_expand (close_button)
			restore_button.set_text ("Restore Defaults")
			close_button.set_text ("Close")
			close_button.set_minimum_width (80)
			set_minimum_width (640)
			set_minimum_height (480)
			set_title ("Display window")

			set_all_attributes_using_constants

				-- Call `user_initialization'.
			user_initialization
		end

	frozen create_interface_objects
			-- Create objects
		do

				-- Create all widgets.
			create l_ev_vertical_box_1
			create l_ev_horizontal_split_area_1
			create left_list
			create l_ev_vertical_box_2
			create l_ev_horizontal_box_1
			create l_ev_frame_1
			create l_ev_horizontal_box_2
			create split_area
			create grid_container
			create description_frame
			create l_ev_vertical_box_3
			create description_text
			create l_ev_horizontal_separator_1
			create l_ev_horizontal_box_3
			create restore_button
			create l_ev_cell_1
			create close_button

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
			user_create_interface_objects
		end


feature -- Access

	left_list: EV_TREE
	split_area: EV_VERTICAL_SPLIT_AREA
	grid_container: EV_VERTICAL_BOX
	description_frame: EV_FRAME
	description_text: EV_TEXT
	restore_button,
	close_button: EV_BUTTON

feature {NONE} -- Implementation

	l_ev_vertical_box_1, l_ev_vertical_box_2, l_ev_vertical_box_3: EV_VERTICAL_BOX
	l_ev_horizontal_split_area_1: EV_HORIZONTAL_SPLIT_AREA
	l_ev_horizontal_box_1,
	l_ev_horizontal_box_2, l_ev_horizontal_box_3: EV_HORIZONTAL_BOX
	l_ev_frame_1: EV_FRAME
	l_ev_horizontal_separator_1: EV_HORIZONTAL_SEPARATOR
	l_ev_cell_1: EV_CELL

feature {NONE} -- Implementation

	is_in_default_state: BOOLEAN
			-- Is `Current' in its default state?
		do
			Result := True
		end

	user_create_interface_objects
			-- Feature for custom user interface object creation, called at end of `create_interface_objects'.
		deferred
		end

	user_initialization
			-- Feature for custom initialization, called at end of `initialize'.
		deferred
		end

feature {NONE} -- Constant setting

	frozen set_attributes_using_string_constants
			-- Set all attributes relying on string constants to the current
			-- value of the associated constant.
		local
			s: detachable STRING_32
		do
			from
				string_constant_set_procedures.start
			until
				string_constant_set_procedures.off
			loop
				string_constant_retrieval_functions.i_th (string_constant_set_procedures.index).call (Void)
				s := string_constant_retrieval_functions.i_th (string_constant_set_procedures.index).last_result
				if s /= Void then
					string_constant_set_procedures.item.call ([s])
				end
				string_constant_set_procedures.forth
			end
		end

	frozen set_attributes_using_integer_constants
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

	frozen set_attributes_using_pixmap_constants
			-- Set all attributes relying on pixmap constants to the current
			-- value of the associated constant.
		local
			p: detachable EV_PIXMAP
		do
			from
				pixmap_constant_set_procedures.start
			until
				pixmap_constant_set_procedures.off
			loop
				pixmap_constant_retrieval_functions.i_th (pixmap_constant_set_procedures.index).call (Void)
				p := pixmap_constant_retrieval_functions.i_th (pixmap_constant_set_procedures.index).last_result
				if p /= Void then
					pixmap_constant_set_procedures.item.call ([p])
				end
				pixmap_constant_set_procedures.forth
			end
		end

	frozen set_attributes_using_font_constants
			-- Set all attributes relying on font constants to the current
			-- value of the associated constant.
		local
			f: detachable EV_FONT
		do
			from
				font_constant_set_procedures.start
			until
				font_constant_set_procedures.off
			loop
				font_constant_retrieval_functions.i_th (font_constant_set_procedures.index).call (Void)
				f := font_constant_retrieval_functions.i_th (font_constant_set_procedures.index).last_result
				if f /= Void then
					font_constant_set_procedures.item.call ([f])
				end
				font_constant_set_procedures.forth
			end
		end

	frozen set_attributes_using_color_constants
			-- Set all attributes relying on color constants to the current
			-- value of the associated constant.
		local
			c: detachable EV_COLOR
		do
			from
				color_constant_set_procedures.start
			until
				color_constant_set_procedures.off
			loop
				color_constant_retrieval_functions.i_th (color_constant_set_procedures.index).call (Void)
				c := color_constant_retrieval_functions.i_th (color_constant_set_procedures.index).last_result
				if c /= Void then
					color_constant_set_procedures.item.call ([c])
				end
				color_constant_set_procedures.forth
			end
		end

	frozen set_all_attributes_using_constants
			-- Set all attributes relying on constants to the current
			-- calue of the associated constant.
		do
			set_attributes_using_string_constants
			set_attributes_using_integer_constants
			set_attributes_using_pixmap_constants
			set_attributes_using_font_constants
			set_attributes_using_color_constants
		end

	string_constant_set_procedures: ARRAYED_LIST [PROCEDURE [ANY, TUPLE [READABLE_STRING_GENERAL]]]
	string_constant_retrieval_functions: ARRAYED_LIST [FUNCTION [ANY, TUPLE, STRING_32]]
	integer_constant_set_procedures: ARRAYED_LIST [PROCEDURE [ANY, TUPLE [INTEGER]]]
	integer_constant_retrieval_functions: ARRAYED_LIST [FUNCTION [ANY, TUPLE, INTEGER]]
	pixmap_constant_set_procedures: ARRAYED_LIST [PROCEDURE [ANY, TUPLE [EV_PIXMAP]]]
	pixmap_constant_retrieval_functions: ARRAYED_LIST [FUNCTION [ANY, TUPLE, EV_PIXMAP]]
	integer_interval_constant_retrieval_functions: ARRAYED_LIST [FUNCTION [ANY, TUPLE, INTEGER]]
	integer_interval_constant_set_procedures: ARRAYED_LIST [PROCEDURE [ANY, TUPLE [INTEGER_INTERVAL]]]
	font_constant_set_procedures: ARRAYED_LIST [PROCEDURE [ANY, TUPLE [EV_FONT]]]
	font_constant_retrieval_functions: ARRAYED_LIST [FUNCTION [ANY, TUPLE, EV_FONT]]
	color_constant_set_procedures: ARRAYED_LIST [PROCEDURE [ANY, TUPLE [EV_COLOR]]]
	color_constant_retrieval_functions: ARRAYED_LIST [FUNCTION [ANY, TUPLE, EV_COLOR]]

	frozen integer_from_integer (an_integer: INTEGER): INTEGER
			-- Return `an_integer', used for creation of
			-- an agent that returns a fixed integer value.
		do
			Result := an_integer
		end

note
	copyright: "Copyright (c) 1984-2014, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
