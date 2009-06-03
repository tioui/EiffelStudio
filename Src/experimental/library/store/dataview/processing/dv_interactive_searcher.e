note
	description: "Objects that enable user to perform a database selection%
			%determined at run-time."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	DV_INTERACTIVE_SEARCHER

inherit
	DV_SEARCHER
		redefine
			can_be_activated
		end

create
	make

feature -- Initialization

	make
			-- Initialize.
		do
		end

feature -- Status report

	can_be_activated: BOOLEAN
			-- Can component be activated?
		do
			Result := Precursor and then
					control /= Void and then
					column_selector /= Void and then
					value_selector /= Void
		end

	is_activated: BOOLEAN
			-- Is component activated?

feature -- Basic operations

	set_control (a_ctrl: DV_SENSITIVE_CONTROL)
			-- Set `a_ctrl' to trigger a search.
		require
			not_void: a_ctrl /= Void
		do
			control := a_ctrl
			control.set_action (agent read)
		end

	set_column_selector (a_col_selector: DV_SENSITIVE_INTEGER)
			-- Set column selector to `a_col_selector'.
		require
			not_void: a_col_selector /= Void
		do
			column_selector := a_col_selector
		end
	
	set_value_selector (a_val_selector: DV_SENSITIVE_STRING)
			-- Set value selector to `a_val_selector'.
		require
			not_void: a_val_selector /= Void
		do
			value_selector := a_val_selector
		end
	
	set_qualification_selector (a_qual_selector: DV_SENSITIVE_INTEGER)
			-- Set qualification selector to `a_qual_selector'.
		require
			not_void: a_qual_selector /= Void
		do
			qualification_selector := a_qual_selector
		end

	set_case_selector (a_case_selector: DV_SENSITIVE_CHECK)
			-- Set case selector to `a_case_selector'.
		require
			not_void: a_case_selector /= Void
		do
			case_selector := a_case_selector
		end

	read
			-- Read the database according to qualifying clause.
		require
			is_activated: is_activated
		do
			set_new_search_parameters
			db_table_component.display (refresh)
		end

feature {DV_COMPONENT} -- Basic operations

	activate
			-- Activate component.
		do
			is_activated := True
		end

	refresh: ARRAYED_LIST [DB_TABLE]
			-- Return tablerows corresponding to last database reading, i.e.
			-- table rows may have changed but query is the same.
		local
			database_handler: ABSTRACT_DB_TABLE_MANAGER
		do
			database_handler := db_table_component.database_handler
			database_handler.prepare_select_with_table (table_code)
			database_handler.add_specific_qualifier (last_column, last_value, last_qualification, last_case)
			database_handler.load_result
			if database_handler.has_error then
				db_table_component.warning_handler.call ([database_handler.error_message])
				create Result.make (0)
			else
				Result := database_handler.database_result_list
			end
		end

feature {NONE} -- Implementation

	control: DV_SENSITIVE_CONTROL
			-- Triggers the search.
			
	column_selector: DV_SENSITIVE_INTEGER
			-- Provides the column of the qualifier.
	
	value_selector: DV_SENSITIVE_STRING
			-- Provides the value of the qualifier.

	qualification_selector: DV_SENSITIVE_INTEGER
			-- Provides the type of qualifier

	case_selector: DV_SENSITIVE_CHECK
			-- Provides the case sensitiveness.

	last_column: INTEGER
			-- Last searched column value.

	last_value: STRING
			-- Last searched qualifying value.

	last_qualification: INTEGER
			-- Qualifying type of last search.

	last_case: BOOLEAN
			-- Was last search case sensitive?

	set_new_search_parameters
			-- Set new search parameters from parameters
			-- providers.
		do
			last_column := column_selector.value
			last_value := value_selector.value
			if last_value = Void then
				last_value := ""
			end
			if qualification_selector /= Void then
				last_qualification := qualification_selector.value
			end
			if case_selector /= Void then
				last_case := case_selector.checked
			end
		end

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"





end -- class DV_INTERACTIVE_SEARCHER


