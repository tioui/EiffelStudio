indexing
	description: "Eiffel Project HTML Documentation Generator. Eiffel language compiler library. Help file: "
	Note: "Automatically generated by the EiffelCOM Wizard."

deferred class
	IEIFFEL_HTML_DOCUMENTATION_GENERATOR_INTERFACE

inherit
	ECOM_INTERFACE

feature -- Status Report

	add_excluded_cluster_user_precondition (bstr_full_cluster_name: STRING): BOOLEAN is
			-- User-defined preconditions for `add_excluded_cluster'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	remove_excluded_cluster_user_precondition (bstr_full_cluster_name: STRING): BOOLEAN is
			-- User-defined preconditions for `remove_excluded_cluster'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	start_generation_user_precondition (bstr_generation_path: STRING): BOOLEAN is
			-- User-defined preconditions for `start_generation'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	advise_status_callback_user_precondition (p_ieiffel_html_documentation_events: IEIFFEL_HTML_DOCUMENTATION_EVENTS_INTERFACE): BOOLEAN is
			-- User-defined preconditions for `advise_status_callback'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	unadvise_status_callback_user_precondition (p_ieiffel_html_documentation_events: IEIFFEL_HTML_DOCUMENTATION_EVENTS_INTERFACE): BOOLEAN is
			-- User-defined preconditions for `unadvise_status_callback'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

feature -- Basic Operations

	add_excluded_cluster (bstr_full_cluster_name: STRING) is
			-- Exclude a cluster from being generated.
			-- `bstr_full_cluster_name' [in].  
		require
			add_excluded_cluster_user_precondition: add_excluded_cluster_user_precondition (bstr_full_cluster_name)
		deferred

		end

	remove_excluded_cluster (bstr_full_cluster_name: STRING) is
			-- Include a cluster to be generated.
			-- `bstr_full_cluster_name' [in].  
		require
			remove_excluded_cluster_user_precondition: remove_excluded_cluster_user_precondition (bstr_full_cluster_name)
		deferred

		end

	start_generation (bstr_generation_path: STRING) is
			-- Generate the HTML documents into path.
			-- `bstr_generation_path' [in].  
		require
			start_generation_user_precondition: start_generation_user_precondition (bstr_generation_path)
		deferred

		end

	advise_status_callback (p_ieiffel_html_documentation_events: IEIFFEL_HTML_DOCUMENTATION_EVENTS_INTERFACE) is
			-- Add a callback interface.
			-- `p_ieiffel_html_documentation_events' [in].  
		require
			advise_status_callback_user_precondition: advise_status_callback_user_precondition (p_ieiffel_html_documentation_events)
		deferred

		end

	unadvise_status_callback (p_ieiffel_html_documentation_events: IEIFFEL_HTML_DOCUMENTATION_EVENTS_INTERFACE) is
			-- Remove a callback interface.
			-- `p_ieiffel_html_documentation_events' [in].  
		require
			unadvise_status_callback_user_precondition: unadvise_status_callback_user_precondition (p_ieiffel_html_documentation_events)
		deferred

		end

end -- IEIFFEL_HTML_DOCUMENTATION_GENERATOR_INTERFACE

