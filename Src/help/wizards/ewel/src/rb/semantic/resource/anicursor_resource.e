indexing
	description: "xxx"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"
--  Anicursor_resource -> "ANICURSOR" Load_and_mem filename

class ANICURSOR_RESOURCE

inherit
	S_ANICURSOR_RESOURCE
		redefine 
			pre_action, post_action
		end

	TABLE_OF_SYMBOLS

create
	make

feature 

	pre_action is
		local
			anicursor: TDS_ANICURSOR

		do     
			create anicursor.make
			anicursor.set_id (tds.last_token)
			tds.insert_resource (anicursor)

			tds.set_current_resource (anicursor)
		end

	post_action is
		local
			anicursor: TDS_ANICURSOR
		do
			anicursor ?= tds.current_resource
			anicursor.set_filename (tds.last_token)
		end

indexing
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
end -- class ANICURSOR_RESOURCE

