indexing

	description:	
		"Command to display clusters in lists.";
	date: "$Date$";
	revision: "$Revision$"

class SHOW_CLUSTERS 

inherit

	FILTERABLE
		redefine
			dark_symbol, display_temp_header, post_fix
		end

creation

	make

feature -- Properties

	symbol: PIXMAP is 
		once 
			Result := bm_Showclusters 
		end;
 
	dark_symbol: PIXMAP is 
		once 
			Result := bm_Dark_showclusters 
		end;
 
feature {NONE} -- Properties

	name: STRING is
		do
			Result := l_Showclusters
		end;

	title_part: STRING is
		do
			Result := l_Clusters_of
		end;

	post_fix: STRING is "clu";

feature {NONE} -- Attributes

	create_structured_text (c: CLASSC_STONE): STRUCTURED_TEXT is
			-- Show universe: clusters in class lists.
		local
			cmd: E_SHOW_CLUSTERS
		do
			!! Result.make;
			!! cmd.make (Result);
			cmd.execute
		end;

feature {NONE} -- Implementation

	display_temp_header (stone: STONE) is
			-- Display a temporary header during the format processing.
		do
			tool.set_title ("Exploring the system's clusters...")
		end;

end
