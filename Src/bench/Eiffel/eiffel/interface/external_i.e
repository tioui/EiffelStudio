-- Internal representation of an external

class EXTERNAL_I 

inherit

	PROCEDURE_I
		rename
			transfer_to as procedure_transfer_to
		redefine
			melt, execution_unit, generate,
			access, is_external, new_rout_unit
		end;

	PROCEDURE_I
		redefine
			transfer_to,
			melt, execution_unit, generate,
			access, is_external, new_rout_unit
		select
			transfer_to
		end;
	
feature -- external characteristics

	has_macro: BOOLEAN;
		-- Does the external declaration include a macro

	has_signature: BOOLEAN;
		-- Does the external declaration include a signature ?

	has_argument_list: BOOLEAN;
		-- Does the signature include arguments ?

	has_result_type: BOOLEAN;
		-- Does the signature include a result type ?

	has_include_list: BOOLEAN;
		-- Does the external declaration include a list of include files ?

	macro_type: STRING;
		-- Type of macro; the name shoud be changed into macro_type or type_name

	macro_file_name: STRING;
		-- File name including the macro definition

	arg_list: ARRAY[STRING];
		-- List of arguments for the signature

	result_type: STRING;
		-- Result type of signature

	include_list: ARRAY[STRING];
		-- List of include files

	set_external_characteristics (source: EXTERNAL_AS) is
		-- Set local external characteristics according to the EXTERNAL_AS ones
		local
			ext_lang: EXTERNAL_LANG_AS;
		do
			ext_lang := source.language_name
			has_macro := ext_lang.has_macro;
			has_signature := ext_lang.has_signature;
			has_argument_list := ext_lang.has_argument_list;
			has_result_type := ext_lang.has_result_type;
			has_include_list := ext_lang.has_include_list;
			macro_type := ext_lang.macro_type;
			macro_file_name := ext_lang.macro_file_name;
			arg_list := ext_lang.arg_list;
			result_type := ext_lang.result_type;
			include_list := ext_lang.include_list;
		end;

feature 

	alias_name: STRING;
			-- Alias for the external

	encapsulated: BOOLEAN;
			-- Has the feature some assertion declared ?

	c_type: STRING;
			-- C type specified for declaring the external routine

	set_alias_name (s: STRING) is
			-- Assign `s' to `alias_name'.
		do
			alias_name := s;
		end;

	set_encapsulated (b: BOOLEAN) is
			-- Assign `b' to `encapsulated'.
		do
			encapsulated := b;
		end;

	set_c_type (s: STRING) is
			-- Assign `s' to `c_type'.	
		do
			c_type := s;
		end;

	is_external: BOOLEAN is
			-- Is the feature an external one ?
		do
			Result := True;
		end;

	external_name: STRING is
			-- External name
		do
			if alias_name = Void then
				Result := feature_name;
			else
				Result := alias_name;
			end;
		end;

	access (access_type: TYPE_I): ACCESS_B is
			-- Byte code access for current feature
		local
			external_b: EXTERNAL_B;
		do
			!!external_b;
			external_b.init (Current);
			external_b.set_type (access_type);
			external_b.set_external_name (external_name);
			external_b.set_encapsulated (encapsulated);
			Result := external_b;
		end;

	transfer_to (other: like Current) is
			-- Transfer datas form `other' into Current
		do
			procedure_transfer_to (other);
			other.set_alias_name (alias_name);
			other.set_encapsulated (encapsulated);
			other.set_c_type (c_type);
		end;

	new_rout_unit: EXTERNAL_UNIT is
			-- New external unit
		do
			!!Result;
			Result.set_body_index (body_index);
			Result.set_type (type.actual_type);
			Result.set_written_in (written_in);
			Result.set_pattern_id (pattern_id);
			Result.set_external_name (external_name);
		end;

	replicated: FEATURE_I is
			-- Replication
		local
			rep: R_EXTERNAL_I
		do
			!!rep;
			transfer_to (rep);
			rep.set_code_id (new_code_id);
			Result := rep;
		end;

	unselected (in: INTEGER): FEATURE_I is
			-- Unselected feature
		local
			unselect: D_EXTERNAL_I
		do
			!!unselect;
			transfer_to (unselect);
			unselect.set_access_in (in);
			Result := unselect;
		end;

	generate (class__type: CLASS_TYPE; file: INDENT_FILE) is
			-- Generate feature written in `class__type' in `file'.
		do
			-- Do nothing
		end;

	execution_unit (cl_type: CLASS_TYPE): EXT_EXECUTION_UNIT is
			-- Execution unit
		do
			!!Result.make (cl_type, Current);
		end; 

	melt (dispatch: DISPATCH_UNIT; exec: EXECUTION_UNIT) is
			-- Generate byte code for the current feature
		do
				-- No byte code for externals
			Dispatch_table.mark_melted (dispatch);
				-- An external cannot be melted: no insertion of `exec' in
				-- `Execution_table'.
		end;

end
