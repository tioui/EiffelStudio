note
	description : "[
				Specific implementation of HTTP_CLIENT based on Eiffel cURL library
				
				WARNING: Do not forget to have the dynamic libraries libcurl (.dll or .so) 
				and related accessible to the executable (i.e in same directory, or in the PATH)
			]"
	author      : "$Author$"
	date        : "$Date$"
	revision    : "$Revision$"

class
	LIBCURL_HTTP_CLIENT

inherit
	HTTP_CLIENT

create
	default_create,
	make

feature {NONE} -- Initialization

	make
			-- Initialize `Current'.
		do
			default_create
		end

feature -- Status

	new_session (a_base_url: READABLE_STRING_8): LIBCURL_HTTP_CLIENT_SESSION
		do
			create Result.make (a_base_url)
		end

note
	copyright: "2011-2015, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
