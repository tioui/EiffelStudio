indexing
	description: "Implemented `IEiffelHTMLDocGenerator' Interface."
	Note: "Automatically generated by the EiffelCOM Wizard."

class
	IEIFFEL_HTMLDOC_GENERATOR_IMPL_STUB

inherit
	IEIFFEL_HTMLDOC_GENERATOR_INTERFACE

	ECOM_STUB

feature -- Access

	is_loaded: BOOLEAN is
			-- Is the project loaded?
		do
			-- Put Implementation here.
		end

	is_corrupted: BOOLEAN is
			-- Is the project oorrupted?
		do
			-- Put Implementation here.
		end

	is_incompatible: BOOLEAN is
			-- Is the project incompatible with the current version of the compiled?
		do
			-- Put Implementation here.
		end

feature -- Basic Operations

	add_status_callback (new_callback: IEIFFEL_HTMLDOC_EVENTS_INTERFACE) is
			-- Add a callback interface.
			-- `new_callback' [in].  
		do
			-- Put Implementation here.
		end

	remove_status_callback (old_callback: IEIFFEL_HTMLDOC_EVENTS_INTERFACE) is
			-- Remove a callback interface.
			-- `old_callback' [in].  
		do
			-- Put Implementation here.
		end

	add_excluded_cluster (cluster_full_name: STRING) is
			-- Exclude a cluster from being generated.
			-- `cluster_full_name' [in].  
		do
			-- Put Implementation here.
		end

	remove_excluded_cluster (cluster_full_name: STRING) is
			-- Include a cluster to be generated.
			-- `cluster_full_name' [in].  
		do
			-- Put Implementation here.
		end

	generate (path: STRING) is
			-- Generate the HTML documents into path.
			-- `path' [in].  
		do
			-- Put Implementation here.
		end

	create_item is
			-- Initialize `item'
		do
			item := ccom_create_item (Current)
		end

feature {NONE}  -- Externals

	ccom_create_item (eif_object: IEIFFEL_HTMLDOC_GENERATOR_IMPL_STUB): POINTER is
			-- Initialize `item'
		external
			"C++ [new ecom_EiffelComCompiler::IEiffelHTMLDocGenerator_impl_stub %"ecom_EiffelComCompiler_IEiffelHTMLDocGenerator_impl_stub_s.h%"](EIF_OBJECT)"
		end

end -- IEIFFEL_HTMLDOC_GENERATOR_IMPL_STUB

