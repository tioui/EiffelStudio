indexing
	description: "Class which is responsible for "
	author: "pascalf"
	date: "$Date$"
	revision: "$Revision$"

class
	SAVE_PREFERENCES

inherit
	CONSTANTS

feature -- Initialization

	initialize (win: PREFERENCE_WINDOW) is 
		-- Initialize
		require
			window_exists: win /= Void
			file_name_exists: win.file_name /= Void
		do 
			caller := win
			!! file_name.make_from_string(win.file_name)
			table := resources.resource_structure.table
		end

feature -- Execution

	save is
		-- Save Preferences.
		local
			file: RAW_FILE
			s: STRING
			error: BOOLEAN
		do
			create file.make (file_name)
			if file.exists then
				file.open_read
				file.read_stream (file.count)
				!! s.make(file.count)
				s.append (file.last_string)
				error := update_values(s)
				file.close
				if not error then
					file.wipe_out
					file.open_write
					file.putstring(s)
					file.close
				end		
			end
		end

	update_values(s: STRING): BOOLEAN is
		-- Update the values of Preferences.
		require
			not_void: s /= Void
			table_exists: table /= Void
		local
			s1: STRING
			i: INTEGER
		do
			from
				table.start
			until
				table.after or Result 
			loop
				s1 := table.key_for_iteration
				i := s.substring_index(s1,1)
				if i>0 and then i+s1.count<s.count then
					i := i+s1.count
					Result := update_value(i,s,table.item_for_iteration)
				else
					Result := TRUE
				end
				table.forth
			end
		end

	update_value(indice: INTEGER; s: STRING;r: RESOURCE): BOOLEAN is
		-- Update the value which is supposed to just after indice 'indice'
		require
			not_void: r /= Void and s /= Void and then not s.empty
			indice_possible: indice >0 and indice < s.count
		local
			s1,type: STRING
			i,j: INTEGER
			st: STRING_RESOURCE
			col: COLOR_RESOURCE
			fon: FONT_RESOURCE
			int: INTEGER_RESOURCE
			boo: BOOLEAN_RESOURCE	
		do
			st ?= r
			col ?= r
			fon ?= r
			int ?= r
			boo ?= r
			if col /= Void then
				type := "COLOR"
			elseif fon /= Void then
				type := "FONT"
			elseif st /= Void then
				type := "STRING"
			elseif int /= Void then
				type := "INTEGER"
			elseif boo /= Void then
				type := "BOOLEAN"
			end
			check
				type_not_void: type /= Void
			end
			i := s.substring_index(type,indice)
			j := s.substring_index("</TEXT>",indice)
			if i<j and i+type.count<s.count then
				i := i+ type.count
				j := s.substring_index("<",i+1)
				if i>j-2 or j=0 or i=0 then
					Result := FALSE
				else
					--s1 := s.substring(i+1,j-1)
					s.replace_substring(r.value,i+1,j-1)
				end
			else
				-- This means there is no value here to deal with.
				Result := FALSE
			end
		end

feature -- Implementation

	caller: PREFERENCE_WINDOW
		-- Caller Window.

	file_name: FILE_NAME
		-- File Name associated with the preferences.

	table: RESOURCES_TABLE
		-- Resources Table.

invariant
	file_name_exists: file_name /= Void
	caller_exists: caller /= Void
end -- class SAVE_PREFERENCES
