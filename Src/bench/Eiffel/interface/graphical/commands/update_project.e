indexing

	description:	
		"Command to update the Eiffel.";
	date: "$Date$";
	revision: "$Revision$"

class UPDATE_PROJECT

inherit

	SHARED_APPLICATION_EXECUTION;
	SHARED_EIFFEL_PROJECT;
	PROJECT_CONTEXT;
	ICONED_COMMAND
		redefine
			text_window
		end;
	SHARED_RESCUE_STATUS;
	SHARED_FORMAT_TABLES;
	SHARED_BENCH_RESOURCES;
	WARNER_CALLBACKS
		rename
			execute_warner_help as choose_template,
			execute_warner_ok as warner_ok
		end

creation

	make

feature -- Initialization

	make (c: COMPOSITE; a_text_window: TEXT_WINDOW) is
			-- Initialize the command, and set an action.
		do
			init (c, a_text_window);
			set_action ("!c<Btn1Down>", Current, generate_code_only)
		end;

feature -- Callbacks

	choose_template is
		do
			system_tool.display;
			load_default_ace;
		end;

	warner_ok (argument: ANY) is
		do
			name_chooser.set_window (text_window);
			name_chooser.call (Current)
		end;

feature -- Properties

	symbol: PIXMAP is
			-- Pixmap for the button.
		once
			Result := bm_Update
		end;

	text_window: PROJECT_TEXT;
			-- Text of the project tool.

feature -- Status Setting

	set_run_after_melt (b: BOOLEAN) is
			-- Request for the system to be executed after a
			-- successful melt compilation or not.
			-- Assign `b' to `run_after_melt'.
		do
			run_after_melt2 := b
		end;

feature {NONE} -- Implementation

	reset_debugger is
			-- Kill the application, if it is running.
		do
			if Application.is_running then
				Application.kill
			end;
		end;

	compile (argument: ANY) is
			-- Compile, in the one way or the other.
		local
			rescued: BOOLEAN;
			temp: STRING;
			title: STRING
		do
			if not rescued then
				reset_debugger;
				error_window.clear_window;
				set_global_cursor (watch_cursor);
				project_tool.set_changed (true);
				perform_compilation (argument);
				if Eiffel_project.successful then
						-- If a freezing already occured (due to a new external
						-- or new derivation of SPECIAL), no need to freeze again.
					project_tool.set_changed (false);
					project_tool.set_icon_name (Eiffel_system.name);
					title := clone (l_Project);
					title.append (": ");
					title.append (Project_directory);
					project_tool.set_title (title);
					if Eiffel_project.save_error then
						!! temp.make (0);
						temp.append ("Could not write to ");
						temp.append (Project_file_name);
						temp.append ("%NPlease check permissions and disk space%
									%%NThen press ");
						temp.append (command_name);
						temp.append (" again%N");
						error_window.put_string (temp);
					else
						if not finalization_error then
							launch_c_compilation (argument)
						end
					end;
				end;
				tool_resynchronization (argument)
			else
					-- The project may be corrupted => the project
					-- becomes read-only.
				warner (text_window).gotcha_call (w_Project_may_be_corrupted);
			end;
			error_window.display;
			restore_cursors
		rescue
			if not resources.get_boolean (r_Fail_on_rescue, False) then
				if original_exception = Io_exception then
						-- We probably don't have the write permissions
						-- on the server files.
					rescued := true;
					retry
				end
			end
		end;

	tool_resynchronization (argument: ANY) is
			-- Resynchronize class, feature and system tools.
			-- Clear the format_context buffers.
		local
			saved_msg, messages: STRING;
			er_w: TEXT_WINDOW
		do
				-- `image' is a once function which will be overewritten
				-- during the resynchronization of the class and feature
				-- tools. We need a copy of it to keep track of various
				-- error messages generated by the compilation.
			er_w ?= error_window;
			messages := er_w.image;
			!! saved_msg.make (messages.count);
			saved_msg.append (messages);
			Window_manager.class_win_mgr.synchronize;
			Window_manager.routine_win_mgr.synchronize;
			if system_tool.realized and then system_tool.shown then
				system_tool.set_default_format;
				system_tool.synchronize
			end;
			messages.wipe_out;
			messages.append (saved_msg);

				-- Clear the format_context buffers.
			clear_format_tables
		end;

	launch_c_compilation (argument: ANY) is
			-- Launch the C compilation.
		do
			error_window.put_string ("System recompiled%N");
			if start_c_compilation then
				if Eiffel_project.freezing_occurred then
					error_window.put_string
						("System had to be frozen to include new externals.%N%
							%Background C compilation launched.%N");
					Eiffel_project.call_finish_freezing (True)
				end;
			end;
		end;

	confirm_and_compile (argument: ANY) is
			-- Ask for a confirmation, and thereafter compile.
		do
			if
				not Application.is_running or else
				(argument /= Void and
				argument = last_confirmer and end_run_confirmed)
			then
				compile (argument);
				if 
					run_after_melt and then
					Eiffel_project.lace_file_name /= Void and then
					Eiffel_project.successful and 
					not Eiffel_project.freezing_occurred
				then
						-- The system has been successfully melted.
						-- The system can be executed as required.
					text_window.tool.debug_run_command.execute (text_window)
				end
			else
				end_run_confirmed := true;
				confirmer (text_window).call (Current,
						"Recompiling project will end current run.%N%
						%Start compilation anyway?", "Compile")
			end
		end;

	perform_compilation (argument: ANY) is
			-- The real compilation. (This is melting.)
		do
			Eiffel_project.melt
		end

	load_default_ace is
			-- Load the default ace file.
		require
			project_tool.initialized
		local
			file_name: STRING;
		do
			!!file_name.make (50);
			file_name.append (Default_ace_name);
			system_tool.text_window.show_file_content (file_name);
			system_tool.text_window.set_changed (True)
		end;

feature {NONE} -- Attributes

	not_saved: BOOLEAN is
			-- Has the text of some tool been edited and not saved?
		do
			Result := window_manager.class_win_mgr.changed or
				system_tool.text_window.changed
		end;

	finalization_error: BOOLEAN is
			-- Has a validity error been detected during the
			-- finalization? This happens with DLE dealing
			-- with statically bound feature calls
		do
		end;

	end_run_confirmed: BOOLEAN;
			-- Was the last confirmer popped up to confirm the end of run?

	start_c_compilation: BOOLEAN;
			-- Do we have to start the C compilation after C Code generation?

	run_after_melt: BOOLEAN;
			-- Should we execute the system after sucessful melt?

	run_after_melt2: BOOLEAN;
			-- Should we execute the system after sucessful melt?
			-- This boolean value is only reliable at the beginning
			-- of the execution of this command. After a warning or
			-- confirmation panel has been popped up, this value
			-- can be cleared by the caller. To prevent that, we
			-- keep track of that value in `run_after_melt' at the 
			-- beginning of the execution, so that we can still 
			-- rely on it after a confirmation when we resume 
			-- (i.e. re-execute) the command

	retried: BOOLEAN;
			-- Is this already tried?

	compilation_allowed: BOOLEAN is
			-- Is a compilation allowed?
		do
			Result := True
		end

	c_code_directory: STRING is
			-- Directory where the C code is stored.
		do
			Result := Workbench_generation_path
		end;

	command_name: STRING is
			-- Name of the command.
		do
			Result := l_Update
		end;

feature {NONE} -- Implementation; Execution

	work (argument: ANY) is
			-- Recompile the project.
		local
			fn: STRING;
			f: PLAIN_TEXT_FILE;
			temp: STRING
			arg: ANY
		do
			if argument = generate_code_only then
				arg := text_window
				start_c_compilation := False;
				run_after_melt := false
			else
				if argument = text_window then
					start_c_compilation := True;
						-- Should we execute the system after sucessful melt?
						-- (See header comment of `run_after_melt2'.)
					run_after_melt := run_after_melt2
				end;
				arg := argument
			end
			if Eiffel_project.is_read_only then
				warner (text_window).gotcha_call (w_Cannot_compile)
			elseif project_tool.initialized then
				if not_saved and arg = text_window then
					end_run_confirmed := false;
					confirmer (text_window).call (Current,
						"Some files have not been saved.%N%
						%Start compilation anyway?", "Compile")
				elseif compilation_allowed then
					if Eiffel_project.lace_file_name /= Void then
						confirm_and_compile (arg);
						if resources.get_boolean (r_Raise_on_error, true) then
							project_tool.raise
						end
					elseif arg = Void then
						choose_template
					elseif arg = last_warner then
						warner_ok (arg);
					elseif arg = name_chooser then
						fn := clone (name_chooser.selected_file);
						if not fn.empty then
							!! f.make (fn);
							if
								f.exists and then 
								f.is_readable and then 
								f.is_plain
							then
								Eiffel_project.set_lace_file_name (fn);
								work (Current)
							elseif f.exists and then not f.is_plain then
								warner (text_window).custom_call (Current,
								w_Not_a_file_retry (fn), " OK ", Void, "Cancel")
							else
								warner (text_window).custom_call
									(Current, w_Cannot_read_file_retry (fn),
									" OK ", Void, "Cancel");
							end
						else
							warner (text_window).custom_call (Current,
								w_Not_a_file_retry (fn), " OK ", Void, "Cancel")
						end
					else
						warner (text_window).custom_call (Current,
							l_Specify_ace, "Choose", "Template", "Cancel");
					end;
				else
					warner (text_window).custom_call (Void,
						w_Melt_only, " OK ", Void, Void);
				end
			end;
		end;

end -- class UPDATE_PORJECT
