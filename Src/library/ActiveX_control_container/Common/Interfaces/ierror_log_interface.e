note
	description: "Control interfaces. Help file: "
	legal: "See notice at end of class."
	status: "See notice at end of class."
	Note: "Automatically generated by the EiffelCOM Wizard."

deferred class
	IERROR_LOG_INTERFACE

inherit
	ECOM_INTERFACE

feature -- Status Report

	add_error_user_precondition (psz_prop_name: STRING; p_excep_info: ECOM_EXCEP_INFO): BOOLEAN
			-- User-defined preconditions for `add_error'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

feature -- Basic Operations

	add_error (psz_prop_name: STRING; p_excep_info: ECOM_EXCEP_INFO)
			-- No description available.
			-- `psz_prop_name' [in].  
			-- `p_excep_info' [in].  
		require
			non_void_p_excep_info: p_excep_info /= Void
			valid_p_excep_info: p_excep_info.item /= default_pointer
			add_error_user_precondition: add_error_user_precondition (psz_prop_name, p_excep_info)
		deferred

		end

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- IERROR_LOG_INTERFACE

