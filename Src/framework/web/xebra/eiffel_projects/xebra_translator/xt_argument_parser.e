note
	description: "[
		Parses command line arguments that configure the translator.
	]"
	legal: "See notice at end of class."
	status: "Community Preview 1.0"
	date: "$Date$"
	revision: "$Revision$"

class
	XT_ARGUMENT_PARSER

inherit
	ARGUMENT_OPTION_PARSER
		rename
			make as make_option_parser
		end

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize the argument parser.
		do
			make_option_parser (False)
			set_is_showing_argument_usage_inline (False)
		end

feature -- Access

feature -- Status report

	project_name: STRING
			-- The name of the project
		require
			is_successful: is_successful
		do
			Result := ""
			if attached option_of_name (project_name_switch) as l_option then
				Result := l_option.value
			end
		ensure
			not_result_is_detached_or_empty: Result /= Void and then not Result.is_empty
		end

	force: BOOLEAN
			-- Should the files be generated by force?
		require
			is_successful: is_successful
		do
			Result := has_option (force_switch)
		end

	lib_path: FILE_NAME
			-- The xebra library path
		require
			is_successful: is_successful
		do
			create Result.make
			if attached option_of_name (lib_path_switch) as l_option then
				create Result.make_from_string (l_option.value)
			end
		ensure
			not_result_is_detached_or_empty: Result /= Void and then not Result.is_empty
		end


	output_path: FILE_NAME
			-- The output_path
		require
			is_successful: is_successful
		do
			create Result.make
			if attached option_of_name (output_path_switch) as l_option then
				create Result.make_from_string (l_option.value)
			end
		ensure
			not_result_is_detached_or_empty: Result /= Void and then not Result.is_empty
		end

	input_path: FILE_NAME
			-- The input_path
		require
			is_successful: is_successful
		do
			create Result.make
			if attached option_of_name (input_path_switch) as l_option then
				create Result.make_from_string (l_option.value)
			end
		ensure
			not_result_is_detached_or_empty: Result /= Void and then not Result.is_empty
		end

	debug_level: INTEGER
			-- The debug_level
		require
			is_successful: is_successful
		do
			Result := 0
			if has_option (debug_level_switch) and then attached option_of_name (debug_level_switch) as l_option then
				if l_option.value.is_integer then
					Result := l_option.value.to_integer
				end
			end
		end

feature {NONE} -- Access: Usage

	name: STRING = "Xebra Translator"
			-- <Precursor>

	version: STRING
			-- <Precursor>
		once
			Result := {XU_CONSTANTS}.Version
		end

	copyright: STRING = "Copyright Eiffel Software 2009-2018. All Rights Reserved."
			-- <Precursor>

	switches: ARRAYED_LIST [ARGUMENT_SWITCH]
			-- <Precursor>
		once
			create Result.make (1)
			Result.extend (create {ARGUMENT_VALUE_SWITCH}.make (project_name_switch, "Specifies the name of the project", False, False, "project_name", "Project name", False))
			Result.extend (create {ARGUMENT_SWITCH}.make (force_switch, "Specifies if the files should be generated regardless", True, False))
			Result.extend (create {ARGUMENT_FILE_OR_DIRECTORY_SWITCH}.make (input_path_switch, "Specifies the path to the directory with the input files", False, False, "input_path", "The input directory path", False))
			Result.extend (create {ARGUMENT_FILE_OR_DIRECTORY_SWITCH}.make (output_path_switch, "Specifies the path to the directory where the generated files will be written.", False, False, "ouput_path", "The output path", False))
			Result.extend (create {ARGUMENT_FILE_OR_DIRECTORY_SWITCH}.make (lib_path_switch, "Specifies the path to the directory where the xebra libraries are located.", False, False, "lib", "The xebra libraries directory", False))
			Result.extend (create {ARGUMENT_INTEGER_SWITCH}.make
			 (debug_level_switch, "Specifies a debug level.%N%T1: Start and stop of overall application" +
														  "%N%T2: Application configuration" +
														  "%N%T3: Start and stop of main components" +
														  "%N%T4: Information about tasks that are performed" +
														  "%N%T5: Information about subtasks that are performed" +
														  "%N%T6: Very verbose information about subtasks that are performed", True, False, "debug_level", "The debug level (1-6)", False))
		end

feature {NONE} -- Switches

	project_name_switch: STRING = "n|project_name"
	force_switch: STRING = "f|force"
	input_path_switch: STRING = "i|input_path"
	output_path_switch: STRING = "o|output_path"
	lib_path_switch: STRING = "l|library_path"
	debug_level_switch: STRING = "d|debug_level"

note
	copyright: "Copyright (c) 1984-2011, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
