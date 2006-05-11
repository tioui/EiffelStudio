indexing
	description: "Names and descriptions for configuration components."
	date: "$Date$"
	revision: "$Revision$"

class
	CONF_INTERFACE_NAMES

feature {NONE} -- Section names

	section_general: STRING is "General"
	section_dotnet: STRING is ".NET"
	section_advanced: STRING is "Advanced"
	section_file_pattern: STRING is "File Pattern"

feature {NONE} -- System names and descriptions

	system_name_name: STRING is "Name"
	system_name_description: STRING is "Name of the system."
	system_description_name: STRING is "Description"
	system_description_description: STRING is "Description of the system."
	system_library_target_name: STRING is "Library target"
	system_library_target_description: STRING is "Target used if system is used as a library."
	system_uuid_name: STRING is "UUID"
	system_uuid_description: STRING is "Unique identifier for the system."
	system_targets_name: STRING is "Targets"
	system_targets_description: STRING is "Targets of the system."

feature {NONE} -- Target names and descriptions

	target_name_name: STRING is "Name"
	target_name_description: STRING is "Name of the target."
	target_description_name: STRING is "Description"
	target_description_description: STRING is "Description of the target."
	target_base_name: STRING is "Base target"
	target_base_description: STRING is "Base target of this target."
	target_compilation_type_name: STRING is "Compilation type"
	target_compilation_type_description: STRING is "Type of compilation."
	target_compilation_type_standard: STRING is "Standard (C/byte code)"
	target_compilation_type_dotnet: STRING is ".NET (msil)"
	target_executable_name: STRING is "Output name"
	target_executable_description: STRING is "Name of the generated binary."
	target_root_name: STRING is "Root"
	target_root_description: STRING is "Root cluster, class, feature of the system."
	target_version_name: STRING is "Version"
	target_version_description: STRING is "Version information."
	target_product_name: STRING is "Product"
	target_product_description: STRING is "Name of the product."
	target_company_name: STRING is "Company"
	target_company_description: STRING is "Name of the company."
	target_copyright_name: STRING is "Copyright"
	target_copyright_description: STRING is "Copyright of this product."
	target_trademark_name: STRING is "Trademark"
	target_trademark_description: STRING is "Trademark of this product."
	target_dialog_root_cluster: STRING is "Root cluster"
	target_dialog_root_class: STRING is "Root class"
	target_dialog_root_feature: STRING is "Root feature"
	target_dialog_root_all: STRING is "Compile all classes"
	target_excludes_name: STRING is "Excludes"
	target_excludes_description: STRING is "Regular expression that exclude subfolders and/or files."
	target_includes_name: STRING is "Includes"
	target_includes_description: STRING is "Regular expression that include subfolders and/or files which where excluded by an exclude pattern."

	target_address_expression_name: STRING is "Address expression"
	target_address_expression_description: STRING is " "
	target_array_optimization_name: STRING is "Array optimization"
	target_array_optimization_description: STRING is " "
	target_check_generic_creation_constraint_name: STRING is "Check generic creation constraints"
	target_check_generic_creation_constraint_description: STRING is " "
	target_check_vape_name: STRING is "Check vape"
	target_check_vape_description: STRING is " "
	target_console_application_name: STRING is "Console application"
	target_console_application_description: STRING is " "
	target_cls_compliant_name: STRING is "CLS compliant"
	target_cls_compliant_description: STRING is " "
	target_dead_code_removal_name: STRING is "Dead code removal"
	target_dead_code_removal_description: STRING is " "
	target_dotnet_naming_convention_name: STRING is "Dotnet naming convention"
	target_dotnet_naming_convention_description: STRING is " "
	target_dynamic_runtime_name: STRING is "Dynamic runtime"
	target_dynamic_runtime_description: STRING is " "
	target_exception_trace_name: STRING is "Exception trace"
	target_exception_trace_description: STRING is " "
	target_full_type_checking_name: STRING is "Full type checking"
	target_full_type_checking_description: STRING is " "
	target_il_verifiable_name: STRING is "IL verifiable"
	target_il_verifiable_description: STRING is " "
	target_inlining_name: STRING is "Inlinining"
	target_inlining_description: STRING is " "
	target_inlining_size_name: STRING is "Inlining size"
	target_inlining_size_description: STRING is " "
	target_line_generation_name: STRING is "Line generation"
	target_line_generation_description: STRING is " "
	target_metadata_cache_path_name: STRING is "Metadata cache path"
	target_metadata_cache_path_description: STRING is " "
	target_msil_assembly_compatibility_name: STRING is "MSIL assembly compatibility"
	target_msil_assembly_compatibility_description: STRING is " "
	target_msil_classes_per_module_name: STRING is "MSIL classes per module"
	target_msil_classes_per_module_description: STRING is " "
	target_msil_clr_version_name: STRING is "MSIL CLR version"
	target_msil_clr_version_description: STRING is " "
	target_msil_culture_name: STRING is "MSIL culture"
	target_msil_culture_description: STRING is " "
	target_msil_generation_type_name: STRING is "MSIL generation type"
	target_msil_generation_type_description: STRING is " "
	target_msil_key_file_name_name: STRING is "MSIL key file"
	target_msil_key_file_name_description: STRING is " "
	target_msil_use_optimized_precompile_name: STRING is "Use optimized precompile"
	target_msil_use_optimized_precompile_description: STRING is " "
	target_multithreaded_name: STRING is "Multithreaded"
	target_multithreaded_description: STRING is " "
	target_old_verbatim_strings_name: STRING is "Old verbatim strings"
	target_old_verbatim_strings_description: STRING is " "
	target_platform_name: STRING is "Platform"
	target_platform_description: STRING is "Override the detected platform to use in conditions."
	target_external_runtime_name: STRING is "External runtime"
	target_external_runtime_description: STRING is " "
	target_shared_library_definition_name: STRING is "Shared library definition"
	target_shared_library_definition_description: STRING is " "
	target_use_cluster_name_as_namespace_name: STRING is "Use cluster name as namespace"
	target_use_cluster_name_as_namespace_description: STRING is " "
	target_use_all_cluster_name_as_namespace_name: STRING is "Use recursive cluster name as namespace"
	target_use_all_cluster_name_as_namespace_description: STRING is " "

feature {NONE} -- Option names and descriptions

	option_require_name: STRING is "Require"
	option_require_description: STRING is "Evaluate precondition assertions."
	option_ensure_name: STRING is "Ensure"
	option_ensure_description: STRING is "Evaluate postcondition assertions."
	option_check_name: STRING is "Check"
	option_check_description: STRING is "Evaluate check assertions."
	option_invariant_name: STRING is "Invariant"
	option_invariant_description: STRING is "Evaluate invariant assertions."
	option_loop_name: STRING is "Loop"
	option_loop_description: STRING is "Evaluate loop assertions."

	option_warnings_name: STRING is "Enabled"
	option_warnings_description: STRING is "Are warnings enabled?"

feature {NONE} -- Validation warnings

	library_target_override: STRING is "Library target can not be used because it contains overrides which is forbidden."
	target_move_up_extends: STRING is "Target can not be moved up because it extends the target that is above it."
	target_move_down_extends: STRING is "Target can not be moved down because the target below it extends this target."
	target_add_duplicate: STRING is "Can not add target because there is already a target with the same name."
	target_remove_library_target: STRING is "Target can not be rmeoved because it is the library target."
	target_remove_extends (other_target: STRING): STRING is
		do
			Result := "Target can not be removed because "+other_target+" extends it."
		end

	target_name_duplicate: STRING is "Can not rename target because there is already a target with the new name."

end
