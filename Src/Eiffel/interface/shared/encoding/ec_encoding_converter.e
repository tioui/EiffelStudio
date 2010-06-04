note
	description: "Used in EiffelStudio to detect/convert text among encodings."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EC_ENCODING_CONVERTER

inherit
	ENCODING_CONVERTER

	ENCODING_HELPER

	EC_ENCODINGS
		export
			{NONE} all
		end

	SHARED_LOCALE
		export
			{NONE} all
		end

feature -- Access

	detected_encoding: attached ENCODING assign set_detected_encoding
			-- <Precursor>
		local
			l_encoding: detachable like internal_detected_encoding
		do
			l_encoding := internal_detected_encoding
			if l_encoding /= Void then
				Result := l_encoding
			else
				Result := default_encoding
				internal_detected_encoding := Result
			end
		ensure then
			internal_detected_encoding_set: internal_detected_encoding = Result
		end

	utf8_string (a_stream: STRING): STRING
			-- Detect encoding of `a_stream' and convert it into utf8.
		local
			l_encoding: attached like detected_encoding
		do
			detect_encoding (a_stream)
			l_encoding := detected_encoding
			if l_encoding.is_equal (utf8) then
					-- It is safe and much faster not to convert for now.
				Result := a_stream
			else
				l_encoding.convert_to (utf8, a_stream)
				if l_encoding.last_conversion_successful then
					Result := l_encoding.last_converted_string.as_string_8
				else
					Result := a_stream
				end
			end
		end

	utf32_string (a_stream: STRING): STRING_32
			-- <Precursor>
		local
			l_encoding: attached like detected_encoding
		do
			detect_encoding (a_stream)
			l_encoding := detected_encoding
			if l_encoding.is_equal (iso_8859_1) then
					-- It is safe and much faster not to convert for now.
				Result := a_stream.as_string_32
			else
				l_encoding.convert_to (utf32, a_stream)
				if l_encoding.last_conversion_successful then
					Result := l_encoding.last_converted_string.as_string_32
				else
					Result := a_stream.as_string_32
				end
			end
		end

	utf32_from_iso8259_1 (a_stream: STRING): STRING_32
			-- <Precursor>
		local
			l_encoding: attached like detected_encoding
		do
			l_encoding := iso_8859_1
			l_encoding.convert_to (utf32, a_stream)
			if l_encoding.last_conversion_successful then
				Result := l_encoding.last_converted_string.as_string_32
			else
				Result := a_stream.as_string_32
			end
		end

	utf32_to_file_encoding (a_str: STRING_32): STRING
			-- <precursor>
		do
			utf32.convert_to (utf8, a_str)
			if utf32.last_conversion_successful then
				Result := utf32.last_converted_stream
			else
				Result := a_str.as_string_8
			end
		end

feature -- Element change

	set_detected_encoding (a_encoding: attached like detected_encoding)
			-- Sets the detected encoding
		do
			internal_detected_encoding := a_encoding
		ensure
			detected_encoding_set: detected_encoding = a_encoding
		end

feature -- Basic operations

	detect_encoding (a_str: detachable STRING_GENERAL)
			-- <Precursor>
		do
			encoding_detector.detect (a_str)
			if encoding_detector.last_detection_successful then
				internal_detected_encoding := encoding_detector.detected_encoding
			else
				create internal_detected_encoding.make ({CODE_PAGE_CONSTANTS}.utf8)
			end
		end

feature {NONE} -- Implementation

	encoding_detector: attached ENCODING_DETECTOR
			-- Encoding detector
		once
			create {EC_SIMPLE_ENCODING_DETECTOR} Result
		end

feature {NONE} -- Implementation: Internal cache

	internal_detected_encoding: detachable like detected_encoding
			-- Mutable version of `detected_encoding'.

;note
	copyright:	"Copyright (c) 1984-2010, Eiffel Software"
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
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
