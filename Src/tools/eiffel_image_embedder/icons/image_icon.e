note
	description: "This class is generated by PNGEiffelCode"
	status: "See notice at end of class."
	legal: "See notice at end of class."

class
	IMAGE_ICON

inherit
	EV_PIXMAP

create
	make_top_to_bottom,
	make_left_to_right,
	make_bottom_to_top,
	make_right_to_left

feature {NONE} -- Initialization

	make_top_to_bottom (discard_color: EV_COLOR)
			-- Initialization
		do
			make_with_size (14, 14)
			discard_color_internal := discard_color
			draw_direction := 1
			draw
		end

	make_left_to_right (discard_color: EV_COLOR)
			-- Initialization
		do
			make_with_size (14, 14)
			discard_color_internal := discard_color
			draw_direction := 2
			draw
		end

	make_bottom_to_top (discard_color: EV_COLOR)
			-- Initialization
		do
			make_with_size (14, 14)
			discard_color_internal := discard_color
			draw_direction := 3
			draw
		end

	make_right_to_left (discard_color: EV_COLOR)
			-- Initialization
		do
			make_with_size (14, 14)
			discard_color_internal := discard_color
			draw_direction := 4
			draw
		end

feature {NONE} -- Implementation

	draw
			-- Draw current.
		local
			i, j, t_count, colors_count, max_len: INTEGER
		do
			build_colors

			colors_count := colors.count
			max_len := width.max (height)
			from
				j := 0
			until
				j >= colors_count
			loop
				from
					i := 0
					t_count := colors.item (j).count // 3
				until
					i >= t_count
				loop
					if discard_color_internal /= Void implies not (colors.item (j).item (3 * i) = discard_color_internal.red_8_bit and colors.item (j).item (3 * i + 1) = discard_color_internal.green_8_bit and colors.item (j).item (3 * i + 2) = discard_color_internal.blue_8_bit) then
						set_foreground_color (create {EV_COLOR}.make_with_8_bit_rgb (colors.item (j).item (3 * i), colors.item (j).item (3 * i + 1), colors.item (j).item (3 * i + 2)))
						inspect draw_direction
						when 1 then
								-- Draw top to bottom.
							draw_point (i, j)
						when 2 then
								-- Draw left to right.
							draw_point (j, max_len - i - 1)
						when 3 then
								-- Draw bottom to top.
							draw_point (t_count - i - 1, colors_count - j + 1)
						when 4 then
								-- Draw right to left.
							draw_point (colors_count - j + 1, i)
						end
					end
					i := i + 1
				end
				j := j + 1
			end
			colors := Void
		end

	build_colors
			-- Build `colors'.
		do
			create colors.make (14)
			colors.put (<<148, 170, 214, 148, 170, 214, 148, 170, 214, 148, 170, 214, 148, 170, 198, 148, 162, 198, 132, 154, 198, 132, 146, 198, 115, 138, 181, 115, 130, 181, 99, 121, 165, 99, 121, 165, 82, 113, 165, 82, 105, 165>>, 0)
			colors.put (<<148, 170, 214, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 247, 251, 255, 247, 243, 255, 231, 243, 255, 231, 235, 255, 214, 227, 255, 49, 73, 132>>, 1)
			colors.put (<<148, 170, 214, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 247, 219, 214, 214, 97, 49, 214, 97, 49, 214, 203, 214, 214, 227, 255, 165, 186, 231, 33, 73, 132>>, 2)
			colors.put (<<148, 170, 214, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 247, 251, 255, 214, 97, 49, 255, 235, 198, 255, 195, 115, 214, 81, 33, 198, 219, 255, 165, 178, 231, 33, 73, 132>>, 3)
			colors.put (<<148, 170, 198, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 247, 251, 255, 247, 243, 255, 214, 97, 49, 255, 195, 115, 214, 146, 66, 198, 81, 33, 198, 211, 255, 165, 178, 214, 33, 65, 132>>, 4)
			colors.put (<<148, 162, 198, 255, 255, 255, 255, 255, 255, 255, 255, 255, 247, 251, 255, 247, 243, 255, 231, 243, 255, 214, 203, 214, 214, 81, 33, 198, 81, 33, 181, 178, 214, 181, 203, 255, 148, 170, 214, 33, 65, 132>>, 5)
			colors.put (<<132, 154, 198, 255, 255, 255, 255, 255, 255, 231, 227, 247, 115, 130, 165, 115, 130, 165, 214, 219, 247, 214, 227, 255, 198, 219, 255, 198, 211, 255, 181, 203, 255, 181, 203, 255, 148, 162, 198, 33, 65, 132>>, 6)
			colors.put (<<132, 146, 198, 255, 255, 255, 231, 227, 247, 115, 130, 165, 231, 235, 247, 214, 219, 247, 66, 81, 99, 165, 178, 214, 66, 81, 99, 66, 81, 99, 165, 178, 231, 165, 195, 255, 148, 154, 198, 33, 56, 132>>, 7)
			colors.put (<<115, 138, 181, 231, 227, 247, 115, 130, 165, 231, 235, 247, 231, 235, 247, 214, 211, 247, 181, 186, 214, 82, 89, 115, 181, 195, 214, 181, 195, 214, 0, 0, 0, 165, 186, 247, 132, 154, 181, 16, 56, 132>>, 8)
			colors.put (<<115, 130, 181, 115, 130, 165, 247, 243, 247, 247, 243, 255, 214, 227, 247, 165, 178, 231, 181, 186, 231, 148, 170, 214, 82, 89, 115, 165, 170, 198, 148, 162, 181, 0, 0, 0, 132, 146, 181, 16, 56, 132>>, 9)
			colors.put (<<99, 121, 165, 255, 251, 255, 247, 243, 255, 214, 227, 247, 165, 186, 231, 148, 170, 214, 148, 162, 214, 148, 162, 198, 115, 130, 165, 49, 65, 82, 115, 130, 148, 115, 121, 148, 0, 0, 0, 16, 48, 132>>, 10)
			colors.put (<<99, 121, 165, 247, 243, 247, 214, 219, 247, 181, 195, 231, 148, 170, 214, 148, 162, 214, 132, 154, 198, 115, 138, 181, 115, 130, 165, 82, 97, 132, 49, 65, 82, 82, 89, 115, 66, 81, 99, 16, 48, 115>>, 11)
			colors.put (<<82, 113, 165, 214, 227, 247, 165, 186, 214, 132, 154, 198, 132, 146, 198, 115, 138, 181, 115, 130, 165, 99, 113, 148, 99, 105, 148, 82, 97, 132, 66, 81, 99, 49, 56, 82, 49, 56, 82, 16, 48, 115>>, 12)
			colors.put (<<82, 105, 165, 49, 73, 132, 33, 73, 132, 33, 73, 132, 33, 65, 132, 33, 65, 132, 33, 65, 132, 33, 56, 132, 16, 56, 132, 16, 56, 132, 16, 48, 132, 16, 48, 115, 16, 48, 115, 16, 48, 115>>, 13)
		end

	draw_direction : INTEGER

	colors: SPECIAL [SPECIAL [INTEGER]]

	discard_color_internal: EV_COLOR;


note
	copyright: "Copyright (c) 1984-2007, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- IMAGE_ICON
