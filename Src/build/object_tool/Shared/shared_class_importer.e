note
	description: "Class containing shared structures used to import %
				% classes of the application in EiffelBuild."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	id: "$Id$"
	revision: "$Revision$"

class
	SHARED_CLASS_IMPORTER

feature

	class_list: ARRAYED_LIST [APPLICATION_CLASS]
			-- List of known classes of the application.
		once
			create Result.make (0)
		end
		
	class_type_name: STRING
		once
			create Result.make (0)
		end
		
	set_class_type_name (new_string: STRING)
			--
		do
			class_type_name.append_string (new_string)
		end
		
	new_name: STRING
			--
		do
			Result := "Argument" + acounter.out
			acounter := acounter + 1
		end
		
	acounter: INTEGER;

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


end -- class SHARED_CLASS_IMPORTER
