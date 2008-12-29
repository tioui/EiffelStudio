note
	description: "Control interfaces. Help file: "
	legal: "See notice at end of class."
	status: "See notice at end of class."
	Note: "Automatically generated by the EiffelCOM Wizard."

deferred class
	IPROPERTY_BAG_INTERFACE

inherit
	ECOM_INTERFACE

feature -- Status Report

	read_user_precondition (psz_prop_name: STRING; p_var: ECOM_VARIANT; p_error_log: IERROR_LOG_INTERFACE): BOOLEAN
			-- User-defined preconditions for `read'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	write_user_precondition (psz_prop_name: STRING; p_var: ECOM_VARIANT): BOOLEAN
			-- User-defined preconditions for `write'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

feature -- Basic Operations

	read (psz_prop_name: STRING; p_var: ECOM_VARIANT; p_error_log: IERROR_LOG_INTERFACE)
			-- No description available.
			-- `psz_prop_name' [in].  
			-- `p_var' [out].  
			-- `p_error_log' [in].  
		require
			non_void_p_var: p_var /= Void
			valid_p_var: p_var.item /= default_pointer
			read_user_precondition: read_user_precondition (psz_prop_name, p_var, p_error_log)
		deferred

		end

	write (psz_prop_name: STRING; p_var: ECOM_VARIANT)
			-- No description available.
			-- `psz_prop_name' [in].  
			-- `p_var' [in].  
		require
			non_void_p_var: p_var /= Void
			valid_p_var: p_var.item /= default_pointer
			write_user_precondition: write_user_precondition (psz_prop_name, p_var)
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




end -- IPROPERTY_BAG_INTERFACE

