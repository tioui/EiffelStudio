indexing

	description:
		"Resource category for general resources.";
	date: "$Date$";
	revision: "$Revision$"

class GENERAL_CATEGORY

inherit
	RESOURCE_CATEGORY;
	EIFFEL_ENV
		rename
			filter_path as env_filter_path,
			profile_path as env_profile_path,
			tmp_directory as env_tmp_directory
		end

creation
	make


feature {NONE} -- Initialization

	make is
			-- Initialize Current
		do
			!! users.make;
			!! modified_resources.make
		end

feature {TTY_RESOURCES} -- Initialization

	initialize (rt: RESOURCE_TABLE) is
			-- Initialize all resources valid for Current.
		do
			!! tab_step.make ("tab_step", rt, 4);
			!! editor.make ("editor", rt, "vi");
			!! filter_path.make ("filter_directory", rt, env_filter_path);
			!! profile_path.make ("profile_directory", rt, env_profile_path);
			!! tmp_path.make ("temporary_directory", rt, env_tmp_directory);
			!! shell_command.make ("shell_command", 
					rt, "xterm -geometry 80x40 -e vi +$line $target");
			!! project_shell_command.make 	
				("project_tool_shell_command", rt, "netscape");
			!! filter_name.make ("filter_name", rt, "PostScript");
			!! filter_command.make ("filter_command", rt, "");
			!! active_drag_and_drop.make ("active_drag_and_drop", rt, True);
			!! history_size.make ("history_size", rt, 10)
			!! default_window_position.make 
				("default_window_position", rt, False);
			!! window_free_list_number.make ("window_free_list_number", rt, 2);
			!! color_list.make ("color_list", rt,
					<<"black", "white", "red", "blue", "green", "yellow", "brown", "cyan">>);
		end

feature -- Validation

	valid (a_resource: RESOURCE): BOOLEAN is
			-- Is `a_resource' valid for Current?
		do
			Result := True
		end

feature -- Resources

	tab_step: INTEGER_RESOURCE;
	editor: STRING_RESOURCE;
	filter_path: STRING_RESOURCE;
	profile_path: STRING_RESOURCE;
	tmp_path: STRING_RESOURCE;
	project_shell_command: STRING_RESOURCE;
	shell_command: STRING_RESOURCE;
	filter_name: STRING_RESOURCE;
	filter_command: STRING_RESOURCE;
	active_drag_and_drop: BOOLEAN_RESOURCE;
	history_size: INTEGER_RESOURCE;
	default_window_position: BOOLEAN_RESOURCE;
	window_free_list_number: INTEGER_RESOURCE;
	color_list: ARRAY_RESOURCE

end -- class GENERAL_CATEGORY
