indexing

	description:	
		"Set execution format.";
	date: "$Date$";
	revision: "$Revision$"

deferred class
	
	EXEC_FORMAT

inherit

	FORMATTER
		rename
			init_from_tool as make
		redefine
			format, execute, tool
		end;
	SHARED_APPLICATION_EXECUTION;
	EXEC_MODES

feature -- Execution

	execute (argument: ANY) is
			-- Execute the command.
		local
			f: FOCUSABLE
		do
			if is_sensitive then
				if holder /= Void then
					f ?= holder.associated_button
				end
				if f /= Void then
					f.popdown
				end;
				if last_warner /= Void then
					last_warner.popdown
				end;
				format (Void);
				if argument = Format_and_run then
					tool.debug_run_cmd_holder.associated_command.execute (Void)
				end;
				tool.set_last_format (holder)
			end
		end;

feature -- Formatting

	format (stone: STONE) is
			-- Set the execution format to `stone'.
		do
			Application.set_execution_mode (execution_mode)
		end;

feature -- Properties

	tool: PROJECT_W;
			-- Project tool

feature {NONE} -- Attributes

	execution_mode: INTEGER is
			-- Mode of execution.
		deferred
		end;

	display_info (s: STONE) is
			-- Useless here.
		do
			-- Do Nothing
		end;

	title_part: STRING is
			-- Part of the title of the window.
		do
			Result := ""
		end;

end -- class EXEC_FORMAT
