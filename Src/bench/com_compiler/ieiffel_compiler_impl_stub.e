indexing
	description: "Implemented `IEiffelCompiler' Interface."
	Note: "Automatically generated by the EiffelCOM Wizard."

class
	IEIFFEL_COMPILER_IMPL_STUB

inherit
	IEIFFEL_COMPILER_INTERFACE

	ECOM_STUB

feature -- Access

	is_successful: BOOLEAN is
			-- Was last compilation successful?
		do
			-- Put Implementation here.
		end

	freezing_occurred: BOOLEAN is
			-- Did last compile warrant a call to finish_freezing?
		do
			-- Put Implementation here.
		end

	compiler_version: STRING is
			-- Compiler version.
		do
			-- Put Implementation here.
		end

	ise_eiffel: STRING is
			-- Return ISE_EIFFEL environment var.
		do
			-- Put Implementation here.
		end

	freeze_command_name: STRING is
			-- Eiffel Freeze command name
		do
			-- Put Implementation here.
		end

	freeze_command_arguments: STRING is
			-- Eiffel Freeze command arguments
		do
			-- Put Implementation here.
		end

	has_signable_generation: BOOLEAN is
			-- Is the compiler a trial version.
		do
			-- Put Implementation here.
		end

	output_pipe_name: STRING is
			-- Output pipe's name
		do
			-- Put Implementation here.
		end

	is_output_piped: BOOLEAN is
			-- Is compiler output sent to pipe `output_pipe_name'
		do
			-- Put Implementation here.
		end

feature -- Basic Operations

	compile is
			-- Compile.
		do
			-- Put Implementation here.
		end

	finalize is
			-- Finalize.
		do
			-- Put Implementation here.
		end

	precompile is
			-- Precompile.
		do
			-- Put Implementation here.
		end

	compile_to_pipe is
			-- Compile with piped output.
		do
			-- Put Implementation here.
		end

	finalize_to_pipe is
			-- Finalize with piped output.
		do
			-- Put Implementation here.
		end

	precompile_to_pipe is
			-- Precompile with piped output.
		do
			-- Put Implementation here.
		end

	expand_path (a_path: STRING): STRING is
			-- Takes a path and expands it using the env vars.
			-- `a_path' [in].  
		do
			-- Put Implementation here.
		end

	generate_msil_keyfile (filename: STRING) is
			-- Generate a cyrptographic key filename.
			-- `filename' [in].  
		do
			-- Put Implementation here.
		end

	remove_file_locks is
			-- Remove file locks
		do
			-- Put Implementation here.
		end

	set_output_pipe_name (return_value: STRING) is
			-- Set output pipe's name
			-- `return_value' [in].  
		do
			-- Put Implementation here.
		end

	create_item is
			-- Initialize `item'
		do
			item := ccom_create_item (Current)
		end

feature {NONE}  -- Externals

	ccom_create_item (eif_object: IEIFFEL_COMPILER_IMPL_STUB): POINTER is
			-- Initialize `item'
		external
			"C++ [new ecom_eiffel_compiler::IEiffelCompiler_impl_stub %"ecom_eiffel_compiler_IEiffelCompiler_impl_stub_s.h%"](EIF_OBJECT)"
		end

end -- IEIFFEL_COMPILER_IMPL_STUB

