indexing
	description: "Implemented `IEiffelSystemBrowser' Interface."
	Note: "Automatically generated by the EiffelCOM Wizard."

class
	IEIFFEL_SYSTEM_BROWSER_IMPL_STUB

inherit
	IEIFFEL_SYSTEM_BROWSER_INTERFACE

	ECOM_STUB

feature -- Access

	system_classes: IENUM_EIFFEL_CLASS_INTERFACE is
			-- List of classes in system.
		do
			-- Put Implementation here.
		end

	class_count: INTEGER is
			-- Number of classes in system.
		do
			-- Put Implementation here.
		end

	system_clusters: IENUM_CLUSTER_INTERFACE is
			-- List of system's clusters.
		do
			-- Put Implementation here.
		end

	external_clusters: IENUM_CLUSTER_INTERFACE is
			-- List of system's external clusters.
		do
			-- Put Implementation here.
		end

	assemblies: IENUM_ASSEMBLY_INTERFACE is
			-- Returns all of the assemblies in an enumerator
		do
			-- Put Implementation here.
		end

	cluster_count: INTEGER is
			-- Number of top-level clusters in system.
		do
			-- Put Implementation here.
		end

	root_cluster: IEIFFEL_CLUSTER_DESCRIPTOR_INTERFACE is
			-- Number of top-level clusters in system.
		do
			-- Put Implementation here.
		end

feature -- Basic Operations

	cluster_descriptor (cluster_name: STRING): IEIFFEL_CLUSTER_DESCRIPTOR_INTERFACE is
			-- Cluster descriptor.
			-- `cluster_name' [in].  
		do
			-- Put Implementation here.
		end

	class_descriptor (class_name1: STRING): IEIFFEL_CLASS_DESCRIPTOR_INTERFACE is
			-- Class descriptor.
			-- `class_name1' [in].  
		do
			-- Put Implementation here.
		end

	feature_descriptor (class_name1: STRING; feature_name: STRING): IEIFFEL_FEATURE_DESCRIPTOR_INTERFACE is
			-- Feature descriptor.
			-- `class_name1' [in].  
			-- `feature_name' [in].  
		do
			-- Put Implementation here.
		end

	search_classes (a_string: STRING; is_substring: BOOLEAN): IENUM_EIFFEL_CLASS_INTERFACE is
			-- Search classes with names matching `a_string'.
			-- `a_string' [in].  
			-- `is_substring' [in].  
		do
			-- Put Implementation here.
		end

	search_features (a_string: STRING; is_substring: BOOLEAN): IENUM_FEATURE_INTERFACE is
			-- Search feature with names matching `a_string'.
			-- `a_string' [in].  
			-- `is_substring' [in].  
		do
			-- Put Implementation here.
		end

	description_from_dotnet_type (a_assembly_name: STRING; a_full_dotnet_type: STRING): STRING is
			-- Retrieve description from dotnet type
			-- `a_assembly_name' [in].  
			-- `a_full_dotnet_type' [in].  
		do
			-- Put Implementation here.
		end

	description_from_dotnet_feature (a_assembly_name: STRING; a_full_dotnet_type: STRING; a_feature_signature: STRING): STRING is
			-- Retrieve description from dotnet feature
			-- `a_assembly_name' [in].  
			-- `a_full_dotnet_type' [in].  
			-- `a_feature_signature' [in].  
		do
			-- Put Implementation here.
		end

	create_item is
			-- Initialize `item'
		do
			item := ccom_create_item (Current)
		end

feature {NONE}  -- Externals

	ccom_create_item (eif_object: IEIFFEL_SYSTEM_BROWSER_IMPL_STUB): POINTER is
			-- Initialize `item'
		external
			"C++ [new ecom_eiffel_compiler::IEiffelSystemBrowser_impl_stub %"ecom_eiffel_compiler_IEiffelSystemBrowser_impl_stub_s.h%"](EIF_OBJECT)"
		end

end -- IEIFFEL_SYSTEM_BROWSER_IMPL_STUB

