-- Formatters to which a filter is applicable

deferred class FILTERABLE

inherit

	FORMATTER
		redefine
			filter
		end

feature

	filter (filtername: STRING) is
			-- Filter the `Current' format with `filtername'.
		local
			new_text: STRING;
			root_stone: STONE
		do
			root_stone := text_window.root_stone;
			if root_stone /= Void then
				set_global_cursor (watch_cursor);
				new_text := filtered_text (root_stone, filtername);
				if new_text /= Void then
					text_window.clear_text;
					text_window.set_text (new_text);
					text_window.set_changed (false);
					display_filter_header (root_stone, filtername);
					text_window.set_file_name (filtered_file_name (root_stone, filtername))
					text_window.set_editable;
					filter_name := clone (filtername);
					filtered := true
				end;
				restore_cursors
			end
		end;

	filtered_text (stone: STONE; filtername: STRING): STRING is
			-- Output of `filtername' applied to `stone'
			-- (Void if the filter is not readable)
		require
			stone_not_void: stone /= Void;
			filtername_not_void: filtername /= Void
		local
			full_pathname: FILE_NAME;
			filter_file: PLAIN_TEXT_FILE;
			context: FORMAT_CONTEXT;
			text_filter: TEXT_FILTER
		do
			if filtername.empty then
				warner (text_window).gotcha_call (w_No_filter_selected)
			else
				!!full_pathname.make_from_string (filter_path);
				full_pathname.set_file_name (filtername);
				full_pathname.add_extension ("fil");
				!!filter_file.make (full_pathname);
				if filter_file.exists and then filter_file.is_readable then
					!!text_filter.make_from_filename (full_pathname);
					file_suffix := text_filter.file_suffix;
					context := filter_context (stone);
					text_filter.process_text (context.text);
					Result := text_filter.image
				else
					warner (text_window).gotcha_call 
						(w_Cannot_read_filter (full_pathname))
				end
			end
		end;

	filtered_file_name (stone: STONE; filtername: STRING): STRING is
			-- Name of the file where the filtered output text will be stored
			-- (classname.file_suffix or classname.filtername)
		require
			stone_not_void: stone /= Void;
			filtername_not_void: filtername /= Void
		local
			filed_stone: FILED_STONE;
			fname: FILE_NAME;
			i: INTEGER;
			fsuffix: STRING
		do
			filed_stone ?= stone;
			if filed_stone /= Void then
				Result := clone (filed_stone.file_name);
					--| remove the extension
				from
					i := Result.count
				until 
					i = 0 or else Result.item (i) = '.'
				loop
					i := i - 1
				end;
				if i /= 0 and i >= Result.count - 3 then
					Result.head (i - 1)
				end;

				!!fname.make_from_string (Result);
				if file_suffix /= Void then
					if not file_suffix.empty then
						fname.add_extension (file_suffix)
					end
				else
					fsuffix := clone (filtername);
					fsuffix.head (3);
					fsuffix.to_lower;
					if not fsuffix.empty then
						fname.add_extension (fsuffix)
					end
				end;
				Result := fname
			else
				!!Result.make (0)
			end
		end;

	temp_filtered_file_name (stone: STONE; filtername: STRING): STRING is
			-- Name of the file where the filtered output text will be
			-- temporary stored (tem_dir/classname.file_suffix or 
			-- temp_dir/classname.filtername)
		require
			stone_not_void: stone /= Void;
			filtername_not_void: filtername /= Void
		local
			fname: FILE_NAME;
			fsuffix: STRING;
			class_stone: CLASSC_STONE
		do
			class_stone ?= stone;
			if class_stone /= Void then
				!!fname.make_from_string (tmp_directory);
				fname.set_file_name (class_stone.class_c.class_name);
				if file_suffix /= Void then
					if not file_suffix.empty then
						fname.add_extension (file_suffix)
					end
				else
					fsuffix := clone (filtername);
					fsuffix.head (3);
					fsuffix.to_lower;
					if not fsuffix.empty then
						fname.add_extension (fsuffix)
					end
				end;
				Result := fname
			else
				!! Result.make (0);
			end
		end;

	filter_name: STRING;
			-- Name of the last filter applied

	file_suffix: STRING;
			-- Suffix of the file name where the filtered output text is stored;
			-- Void if it has not been specified in the filter specification

feature {NONE}

	filter_context (stone: STONE): FORMAT_CONTEXT is
		require
			not_stone_void: stone /= Void
		deferred
		end;

	display_filter_header (stone: STONE; filtername: STRING) is
			-- Show header.
		require
			stone_not_void: stone /= Void;
			filtername_not_void: filtername /= Void
		local
			new_title: STRING
		do
			!!new_title.make (50);
			new_title.append (title_part);
			new_title.append (stone.signature);
			new_title.append (" (");
			new_title.append (filtername);
			new_title.append (" format)");
			text_window.display_header (new_title)
		end;

end -- class FILTERABLE
