indexing
	description: "Control interfaces. Help file: "
	Note: "Automatically generated by the EiffelCOM Wizard."

deferred class
	IBIND_CTX_INTERFACE

inherit
	ECOM_INTERFACE

feature -- Status Report

	register_object_bound_user_precondition (punk: ECOM_INTERFACE): BOOLEAN is
			-- User-defined preconditions for `register_object_bound'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	revoke_object_bound_user_precondition (punk: ECOM_INTERFACE): BOOLEAN is
			-- User-defined preconditions for `revoke_object_bound'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	release_bound_objects_user_precondition: BOOLEAN is
			-- User-defined preconditions for `release_bound_objects'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	set_bind_options_user_precondition (pbindopts: TAG_BIND_OPTS2_RECORD): BOOLEAN is
			-- User-defined preconditions for `set_bind_options'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	get_bind_options_user_precondition (pbindopts: TAG_BIND_OPTS2_RECORD): BOOLEAN is
			-- User-defined preconditions for `get_bind_options'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	get_running_object_table_user_precondition (pprot: CELL [IRUNNING_OBJECT_TABLE_INTERFACE]): BOOLEAN is
			-- User-defined preconditions for `get_running_object_table'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	register_object_param_user_precondition (psz_key: STRING; punk: ECOM_INTERFACE): BOOLEAN is
			-- User-defined preconditions for `register_object_param'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	get_object_param_user_precondition (psz_key: STRING; ppunk: CELL [ECOM_INTERFACE]): BOOLEAN is
			-- User-defined preconditions for `get_object_param'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	enum_object_param_user_precondition (ppenum: CELL [IENUM_STRING_INTERFACE]): BOOLEAN is
			-- User-defined preconditions for `enum_object_param'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	revoke_object_param_user_precondition (psz_key: STRING): BOOLEAN is
			-- User-defined preconditions for `revoke_object_param'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

feature -- Basic Operations

	register_object_bound (punk: ECOM_INTERFACE) is
			-- No description available.
			-- `punk' [in].  
		require
			register_object_bound_user_precondition: register_object_bound_user_precondition (punk)
		deferred

		end

	revoke_object_bound (punk: ECOM_INTERFACE) is
			-- No description available.
			-- `punk' [in].  
		require
			revoke_object_bound_user_precondition: revoke_object_bound_user_precondition (punk)
		deferred

		end

	release_bound_objects is
			-- No description available.
		require
			release_bound_objects_user_precondition: release_bound_objects_user_precondition
		deferred

		end

	set_bind_options (pbindopts: TAG_BIND_OPTS2_RECORD) is
			-- No description available.
			-- `pbindopts' [in].  
		require
			non_void_pbindopts: pbindopts /= Void
			valid_pbindopts: pbindopts.item /= default_pointer
			set_bind_options_user_precondition: set_bind_options_user_precondition (pbindopts)
		deferred

		end

	get_bind_options (pbindopts: TAG_BIND_OPTS2_RECORD) is
			-- No description available.
			-- `pbindopts' [in, out].  
		require
			non_void_pbindopts: pbindopts /= Void
			valid_pbindopts: pbindopts.item /= default_pointer
			get_bind_options_user_precondition: get_bind_options_user_precondition (pbindopts)
		deferred

		end

	get_running_object_table (pprot: CELL [IRUNNING_OBJECT_TABLE_INTERFACE]) is
			-- No description available.
			-- `pprot' [out].  
		require
			non_void_pprot: pprot /= Void
			get_running_object_table_user_precondition: get_running_object_table_user_precondition (pprot)
		deferred

		ensure
			valid_pprot: pprot.item /= Void
		end

	register_object_param (psz_key: STRING; punk: ECOM_INTERFACE) is
			-- No description available.
			-- `psz_key' [in].  
			-- `punk' [in].  
		require
			register_object_param_user_precondition: register_object_param_user_precondition (psz_key, punk)
		deferred

		end

	get_object_param (psz_key: STRING; ppunk: CELL [ECOM_INTERFACE]) is
			-- No description available.
			-- `psz_key' [in].  
			-- `ppunk' [out].  
		require
			non_void_ppunk: ppunk /= Void
			get_object_param_user_precondition: get_object_param_user_precondition (psz_key, ppunk)
		deferred

		ensure
			valid_ppunk: ppunk.item /= Void
		end

	enum_object_param (ppenum: CELL [IENUM_STRING_INTERFACE]) is
			-- No description available.
			-- `ppenum' [out].  
		require
			non_void_ppenum: ppenum /= Void
			enum_object_param_user_precondition: enum_object_param_user_precondition (ppenum)
		deferred

		ensure
			valid_ppenum: ppenum.item /= Void
		end

	revoke_object_param (psz_key: STRING) is
			-- No description available.
			-- `psz_key' [in].  
		require
			revoke_object_param_user_precondition: revoke_object_param_user_precondition (psz_key)
		deferred

		end

end -- IBIND_CTX_INTERFACE

