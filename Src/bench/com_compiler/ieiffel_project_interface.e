indexing
	description: "Eiffel Project.  Help file: "
	Note: "Automatically generated by the EiffelCOM Wizard."

deferred class
	IEIFFEL_PROJECT_INTERFACE

inherit
	ECOM_INTERFACE

feature -- Status Report

	retrieve_eiffel_project_user_precondition (a_project_file_name: STRING): BOOLEAN is
			-- User-defined preconditions for `retrieve_eiffel_project'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	create_eiffel_project_user_precondition (a_ace_file_name: STRING; a_project_directory_path: STRING): BOOLEAN is
			-- User-defined preconditions for `create_eiffel_project'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	retrieve_project_user_precondition (a_project_file_name: STRING): BOOLEAN is
			-- User-defined preconditions for `retrieve_project'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	create_project_user_precondition (an_ace_file_name: STRING; project_directory_path: STRING): BOOLEAN is
			-- User-defined preconditions for `create_project'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	project_file_name_user_precondition: BOOLEAN is
			-- User-defined preconditions for `project_file_name'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	ace_file_name_user_precondition: BOOLEAN is
			-- User-defined preconditions for `ace_file_name'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	project_directory_user_precondition: BOOLEAN is
			-- User-defined preconditions for `project_directory'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	valid_project_user_precondition: BOOLEAN is
			-- User-defined preconditions for `valid_project'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	last_error_message_user_precondition: BOOLEAN is
			-- User-defined preconditions for `last_error_message'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	last_exception_user_precondition: BOOLEAN is
			-- User-defined preconditions for `last_exception'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	compiler_user_precondition: BOOLEAN is
			-- User-defined preconditions for `compiler'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	is_compiled_user_precondition: BOOLEAN is
			-- User-defined preconditions for `is_compiled'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	project_has_updated_user_precondition: BOOLEAN is
			-- User-defined preconditions for `project_has_updated'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	system_browser_user_precondition: BOOLEAN is
			-- User-defined preconditions for `system_browser'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	project_properties_user_precondition: BOOLEAN is
			-- User-defined preconditions for `project_properties'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	completion_information_user_precondition: BOOLEAN is
			-- User-defined preconditions for `completion_information'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	html_doc_generator_user_precondition: BOOLEAN is
			-- User-defined preconditions for `html_doc_generator'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

feature -- Basic Operations

	retrieve_eiffel_project (a_project_file_name: STRING) is
			-- Retrieve Eiffel Project
			-- `a_project_file_name' [in].  
		require
			retrieve_eiffel_project_user_precondition: retrieve_eiffel_project_user_precondition (a_project_file_name)
		deferred

		end

	create_eiffel_project (a_ace_file_name: STRING; a_project_directory_path: STRING) is
			-- Create new Eiffel project.
			-- `a_ace_file_name' [in].  
			-- `a_project_directory_path' [in].  
		require
			create_eiffel_project_user_precondition: create_eiffel_project_user_precondition (a_ace_file_name, a_project_directory_path)
		deferred

		end

	retrieve_project (a_project_file_name: STRING) is
			-- Retrieve project. Obsolete
			-- `a_project_file_name' [in].  
		require
			retrieve_project_user_precondition: retrieve_project_user_precondition (a_project_file_name)
		deferred

		end

	create_project (an_ace_file_name: STRING; project_directory_path: STRING) is
			-- Create new project.
			-- `an_ace_file_name' [in].  
			-- `project_directory_path' [in].  
		require
			create_project_user_precondition: create_project_user_precondition (an_ace_file_name, project_directory_path)
		deferred

		end

	project_file_name: STRING is
			-- Full path to .epr file.
		require
			project_file_name_user_precondition: project_file_name_user_precondition
		deferred

		end

	ace_file_name: STRING is
			-- Full path to Ace file.
		require
			ace_file_name_user_precondition: ace_file_name_user_precondition
		deferred

		end

	project_directory: STRING is
			-- Project directory.
		require
			project_directory_user_precondition: project_directory_user_precondition
		deferred

		end

	valid_project: BOOLEAN is
			-- Is project valid?
		require
			valid_project_user_precondition: valid_project_user_precondition
		deferred

		end

	last_error_message: STRING is
			-- Last error message
		require
			last_error_message_user_precondition: last_error_message_user_precondition
		deferred

		end

	last_exception: IEIFFEL_EXCEPTION_INTERFACE is
			-- Last exception raised
		require
			last_exception_user_precondition: last_exception_user_precondition
		deferred

		end

	compiler: IEIFFEL_COMPILER_INTERFACE is
			-- Compiler.
		require
			compiler_user_precondition: compiler_user_precondition
		deferred

		end

	is_compiled: BOOLEAN is
			-- Has system been compiled?
		require
			is_compiled_user_precondition: is_compiled_user_precondition
		deferred

		end

	project_has_updated: BOOLEAN is
			-- Has the project updated since last compilation?
		require
			project_has_updated_user_precondition: project_has_updated_user_precondition
		deferred

		end

	system_browser: IEIFFEL_SYSTEM_BROWSER_INTERFACE is
			-- System Browser.
		require
			system_browser_user_precondition: system_browser_user_precondition
		deferred

		end

	project_properties: IEIFFEL_PROJECT_PROPERTIES_INTERFACE is
			-- Project Properties.
		require
			project_properties_user_precondition: project_properties_user_precondition
		deferred

		end

	completion_information: IEIFFEL_COMPLETION_INFO_INTERFACE is
			-- Completion information
		require
			completion_information_user_precondition: completion_information_user_precondition
		deferred

		end

	html_doc_generator: IEIFFEL_HTMLDOC_GENERATOR_INTERFACE is
			-- Help documentation generator
		require
			html_doc_generator_user_precondition: html_doc_generator_user_precondition
		deferred

		end

end -- IEIFFEL_PROJECT_INTERFACE

