indexing
	description: "Implemented `IEiffelAssemblyProperties' Interface."
	Note: "Automatically generated by the EiffelCOM Wizard."

class
	IEIFFEL_ASSEMBLY_PROPERTIES_IMPL_PROXY

inherit
	IEIFFEL_ASSEMBLY_PROPERTIES_INTERFACE

	ECOM_QUERIABLE

creation
	make_from_other,
	make_from_pointer

feature {NONE}  -- Initialization

	make_from_pointer (cpp_obj: POINTER) is
			-- Make from pointer
		do
			initializer := ccom_create_ieiffel_assembly_properties_impl_proxy_from_pointer(cpp_obj)
			item := ccom_item (initializer)
		end

feature -- Access

	assembly_name: STRING is
			-- Assembly name.
		do
			Result := ccom_assembly_name (initializer)
		end

	assembly_version: STRING is
			-- Assembly version.
		do
			Result := ccom_assembly_version (initializer)
		end

	assembly_culture: STRING is
			-- Assembly culture.
		do
			Result := ccom_assembly_culture (initializer)
		end

	assembly_public_key_token: STRING is
			-- Assembly public key token
		do
			Result := ccom_assembly_public_key_token (initializer)
		end

	is_local: BOOLEAN is
			-- Is the assembly local
		do
			Result := ccom_is_local (initializer)
		end

	is_signed: BOOLEAN is
			-- Is the assembly local
		do
			Result := ccom_is_signed (initializer)
		end

	assembly_cluster_name: STRING is
			-- Assembly cluster name.
		do
			Result := ccom_assembly_cluster_name (initializer)
		end

	assembly_prefix: STRING is
			-- Prefix.
		do
			Result := ccom_assembly_prefix (initializer)
		end

feature -- Status Report

	last_error_code: INTEGER is
			-- Last error code.
		do
			Result := ccom_last_error_code (initializer)
		end

	last_error_description: STRING is
			-- Last error description.
		do
			Result := ccom_last_error_description (initializer)
		end

	last_error_help_file: STRING is
			-- Last error help file.
		do
			Result := ccom_last_error_help_file (initializer)
		end

	last_source_of_exception: STRING is
			-- Last source of exception.
		do
			Result := ccom_last_source_of_exception (initializer)
		end

feature -- Basic Operations

	set_assembly_prefix (return_value: STRING) is
			-- Prefix.
			-- `return_value' [in].  
		do
			ccom_set_assembly_prefix (initializer, return_value)
		end

feature {NONE}  -- Implementation

	delete_wrapper is
			-- Delete wrapper
		do
			ccom_delete_ieiffel_assembly_properties_impl_proxy(initializer)
		end

feature {NONE}  -- Externals

	ccom_assembly_name (cpp_obj: POINTER): STRING is
			-- Assembly name.
		external
			"C++ [ecom_eiffel_compiler::IEiffelAssemblyProperties_impl_proxy %"ecom_eiffel_compiler_IEiffelAssemblyProperties_impl_proxy.h%"](): EIF_REFERENCE"
		end

	ccom_assembly_version (cpp_obj: POINTER): STRING is
			-- Assembly version.
		external
			"C++ [ecom_eiffel_compiler::IEiffelAssemblyProperties_impl_proxy %"ecom_eiffel_compiler_IEiffelAssemblyProperties_impl_proxy.h%"](): EIF_REFERENCE"
		end

	ccom_assembly_culture (cpp_obj: POINTER): STRING is
			-- Assembly culture.
		external
			"C++ [ecom_eiffel_compiler::IEiffelAssemblyProperties_impl_proxy %"ecom_eiffel_compiler_IEiffelAssemblyProperties_impl_proxy.h%"](): EIF_REFERENCE"
		end

	ccom_assembly_public_key_token (cpp_obj: POINTER): STRING is
			-- Assembly public key token
		external
			"C++ [ecom_eiffel_compiler::IEiffelAssemblyProperties_impl_proxy %"ecom_eiffel_compiler_IEiffelAssemblyProperties_impl_proxy.h%"](): EIF_REFERENCE"
		end

	ccom_is_local (cpp_obj: POINTER): BOOLEAN is
			-- Is the assembly local
		external
			"C++ [ecom_eiffel_compiler::IEiffelAssemblyProperties_impl_proxy %"ecom_eiffel_compiler_IEiffelAssemblyProperties_impl_proxy.h%"](): EIF_BOOLEAN"
		end

	ccom_is_signed (cpp_obj: POINTER): BOOLEAN is
			-- Is the assembly local
		external
			"C++ [ecom_eiffel_compiler::IEiffelAssemblyProperties_impl_proxy %"ecom_eiffel_compiler_IEiffelAssemblyProperties_impl_proxy.h%"](): EIF_BOOLEAN"
		end

	ccom_assembly_cluster_name (cpp_obj: POINTER): STRING is
			-- Assembly cluster name.
		external
			"C++ [ecom_eiffel_compiler::IEiffelAssemblyProperties_impl_proxy %"ecom_eiffel_compiler_IEiffelAssemblyProperties_impl_proxy.h%"](): EIF_REFERENCE"
		end

	ccom_assembly_prefix (cpp_obj: POINTER): STRING is
			-- Prefix.
		external
			"C++ [ecom_eiffel_compiler::IEiffelAssemblyProperties_impl_proxy %"ecom_eiffel_compiler_IEiffelAssemblyProperties_impl_proxy.h%"](): EIF_REFERENCE"
		end

	ccom_set_assembly_prefix (cpp_obj: POINTER; return_value: STRING) is
			-- Prefix.
		external
			"C++ [ecom_eiffel_compiler::IEiffelAssemblyProperties_impl_proxy %"ecom_eiffel_compiler_IEiffelAssemblyProperties_impl_proxy.h%"](EIF_OBJECT)"
		end

	ccom_delete_ieiffel_assembly_properties_impl_proxy (a_pointer: POINTER) is
			-- Release resource
		external
			"C++ [delete ecom_eiffel_compiler::IEiffelAssemblyProperties_impl_proxy %"ecom_eiffel_compiler_IEiffelAssemblyProperties_impl_proxy.h%"]()"
		end

	ccom_create_ieiffel_assembly_properties_impl_proxy_from_pointer (a_pointer: POINTER): POINTER is
			-- Create from pointer
		external
			"C++ [new ecom_eiffel_compiler::IEiffelAssemblyProperties_impl_proxy %"ecom_eiffel_compiler_IEiffelAssemblyProperties_impl_proxy.h%"](IUnknown *)"
		end

	ccom_item (cpp_obj: POINTER): POINTER is
			-- Item
		external
			"C++ [ecom_eiffel_compiler::IEiffelAssemblyProperties_impl_proxy %"ecom_eiffel_compiler_IEiffelAssemblyProperties_impl_proxy.h%"]():EIF_POINTER"
		end

	ccom_last_error_code (cpp_obj: POINTER): INTEGER is
			-- Last error code
		external
			"C++ [ecom_eiffel_compiler::IEiffelAssemblyProperties_impl_proxy %"ecom_eiffel_compiler_IEiffelAssemblyProperties_impl_proxy.h%"]():EIF_INTEGER"
		end

	ccom_last_error_description (cpp_obj: POINTER): STRING is
			-- Last error description
		external
			"C++ [ecom_eiffel_compiler::IEiffelAssemblyProperties_impl_proxy %"ecom_eiffel_compiler_IEiffelAssemblyProperties_impl_proxy.h%"]():EIF_REFERENCE"
		end

	ccom_last_error_help_file (cpp_obj: POINTER): STRING is
			-- Last error help file
		external
			"C++ [ecom_eiffel_compiler::IEiffelAssemblyProperties_impl_proxy %"ecom_eiffel_compiler_IEiffelAssemblyProperties_impl_proxy.h%"]():EIF_REFERENCE"
		end

	ccom_last_source_of_exception (cpp_obj: POINTER): STRING is
			-- Last source of exception
		external
			"C++ [ecom_eiffel_compiler::IEiffelAssemblyProperties_impl_proxy %"ecom_eiffel_compiler_IEiffelAssemblyProperties_impl_proxy.h%"]():EIF_REFERENCE"
		end

end -- IEIFFEL_ASSEMBLY_PROPERTIES_IMPL_PROXY

