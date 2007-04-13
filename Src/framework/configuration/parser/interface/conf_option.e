indexing
	description: "Objects that specify configuration options."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CONF_OPTION

inherit
	CONF_VALIDITY

	CONF_ACCESS

feature -- Status

	is_profile_configured: BOOLEAN
			-- Is `is_profile' configured?

	is_trace_configured: BOOLEAN
			-- Is `is_trace' configured?

	is_optimize_configured: BOOLEAN
			-- Is `is_optimize' configured?

	is_debug_configured: BOOLEAN
			-- Is `is_debug' configured?

	is_warning_configured: BOOLEAN
			-- Is `is_warning' configured?

	is_msil_application_optimize_configured: BOOLEAN
			-- Is `is_msil_application_optimize' configured?

	is_full_class_checking_configured: BOOLEAN
			-- Is `is_full_class_checking' configued?

	is_cat_call_detection_configured: BOOLEAN
			-- Is `is_cat_call_detection' configured?

	is_empty: BOOLEAN is
			-- Is `Current' empty? No settings are set?
		do
			Result := not (is_profile_configured or is_trace_configured or is_optimize_configured or is_debug_configured or
				is_warning_configured or is_msil_application_optimize_configured or is_full_class_checking_configured or
				is_cat_call_detection_configured or assertions /= Void or local_namespace /= Void or warnings /= Void or
				debugs /= Void)
		end

feature -- Status update

	unset_profile is
			-- Unset profile.
		do
			is_profile_configured := False
			is_profile := False
		end

	unset_trace is
			-- Unset trace.
		do
			is_trace_configured := False
			is_trace := False
		end

	unset_optimize is
			-- Unset optimize.
		do
			is_optimize_configured := False
			is_optimize := False
		end

	unset_debug is
			-- Unset debug.
		do
			is_debug_configured := False
			is_debug := False
		end

	unset_warning is
			-- Unset warning.
		do
			is_warning_configured := False
			is_warning := False
		end

	unset_msil_application_optimize is
			-- Unset .NET application optimizations
		do
			is_msil_application_optimize_configured := False
			is_msil_application_optimize := False
		end

	unset_full_class_checking is
			-- Unset full class checking.
		do
			is_full_class_checking_configured := False
			is_full_class_checking := False
		end

	unset_cat_call_detection is
			-- Unset cat call detection.
		do
			is_cat_call_detection_configured := False
			is_cat_call_detection := False
		end

feature -- Access, stored in configuration file

	assertions: CONF_ASSERTIONS
			-- The assertion settings.

	namespace: STRING
			-- .NET namespace that is computed on demand.

	local_namespace: STRING
			-- .NET namespace set in configuration file

	is_profile: BOOLEAN
			-- Do profile?

	is_trace: BOOLEAN
			-- Do trace?

	is_optimize: BOOLEAN
			-- Do optimize?

	is_debug: BOOLEAN
			-- Do debug?

	is_warning: BOOLEAN
			-- Show warnings?

	is_msil_application_optimize: BOOLEAN
			-- Do .NET specific application optimizations?

	is_full_class_checking: BOOLEAN
			-- Do we perform a full class checking?

	is_cat_call_detection: BOOLEAN
			-- Do we perform cat-call detection on all feature calls?

	description: STRING
			-- A description about the options.

feature -- Access, stored in configuration file.

	debugs: EQUALITY_HASH_TABLE [BOOLEAN, STRING]
			-- Debug settings.

	warnings: EQUALITY_HASH_TABLE [BOOLEAN, STRING]
			-- Warning settings.

feature -- Access queries

	is_debug_enabled (a_debug: STRING): BOOLEAN is
			-- Is `a_debug' enabled?
		do
			Result := is_debug and then debugs /= Void and then debugs.item (a_debug)
		end

	is_warning_enabled (a_warning: STRING): BOOLEAN is
			-- Is `a_warning' enabled?
		require
			a_warning_valid: valid_warning (a_warning)
		do
			Result := is_warning and then (warnings = Void or else (not warnings.has_key (a_warning) or else warnings.found_item))
		end

feature {CONF_ACCESS} -- Update, stored in configuration file.

	set_assertions (an_assertions: like assertions) is
			-- Set `assertions' to `an_assertions'.
		do
			assertions := an_assertions
		ensure
			assertions_set: assertions = an_assertions
		end

	add_debug (a_name: STRING; an_enabled: BOOLEAN) is
			-- Add a debug.
		require
			a_name_ok: a_name /= Void and then not a_name.is_empty
			a_name_lower: a_name.is_equal (a_name.as_lower)
		do
			if debugs = Void then
				create debugs.make (1)
			end
			debugs.force (an_enabled, a_name)
		ensure
			added: debugs.has (a_name) and then debugs.item (a_name) = an_enabled
		end

	add_warning (a_name: STRING; an_enabled: BOOLEAN) is
			-- Add a warning.
		require
			a_name_ok: a_name /= Void and then not a_name.is_empty
			a_name_lower: a_name.is_equal (a_name.as_lower)
			valid_warning: valid_warning (a_name)
		do
			if warnings = Void then
				create warnings.make (1)
			end
			warnings.force (an_enabled, a_name)
		ensure
			added: warnings.has (a_name) and then warnings.item (a_name) = an_enabled
		end

	set_local_namespace (a_namespace: like local_namespace) is
			-- Set `local_namespace' from `a_namepace' and reset `namespace'.
		do
			if a_namespace /= Void and then a_namespace.is_empty then
				local_namespace := Void
			else
				local_namespace := a_namespace
			end
			namespace := Void
		ensure
			local_namespace_set:
				a_namespace = Void or else not a_namespace.is_empty implies local_namespace = a_namespace
			local_namespace_reset:
				a_namespace /= Void and then a_namespace.is_empty implies local_namespace = Void
			namespace_reset: namespace = Void
		end

	set_profile (a_enabled: BOOLEAN) is
			-- Set `is_profile' to `a_enabled'.
		do
			is_profile_configured := True
			is_profile := a_enabled
		ensure
			is_profile_set: is_profile = a_enabled
			is_profile_configured: is_profile_configured
		end

	set_trace (a_enabled: BOOLEAN) is
			-- Set `is_trace' to `a_enabled'.
		do
			is_trace_configured := True
			is_trace := a_enabled
		ensure
			is_trace_set: is_trace = a_enabled
			is_trace_configured: is_trace_configured
		end

	set_optimize (a_enabled: BOOLEAN) is
			-- Set `is_optimize' to `a_enabled'.
		do
			is_optimize_configured := True
			is_optimize := a_enabled
		ensure
			is_optimize_set: is_optimize = a_enabled
			is_optimize_configured: is_optimize_configured
		end

	set_debug (a_enabled: BOOLEAN) is
			-- Set `is_debug' to `a_enabled'.
			-- Enables/disables debug clauses in general.
		do
			is_debug_configured := True
			is_debug := a_enabled
		ensure
			is_debug_set: is_debug = a_enabled
			is_debug_configured: is_debug_configured
		end

	set_warning (a_enabled: BOOLEAN) is
			-- Set `is_warning' to `a_enabled'.
			-- Enables/disables warning clauses in general.
		do
			is_warning_configured := True
			is_warning := a_enabled
		ensure
			is_warning_set: is_warning = a_enabled
			is_warning_configured: is_warning_configured
		end

	set_msil_application_optimize (a_enabled: BOOLEAN) is
			-- Set `is_msil_application_optimize' to `a_enable'.
			-- Enabled/disables .NET application optimizations in general.
		do
			is_msil_application_optimize_configured := True
			is_msil_application_optimize := a_enabled
		ensure
			is_msil_application_optimize_set: is_msil_application_optimize = a_enabled
			is_msil_application_optimize_configured: is_msil_application_optimize_configured
		end

	set_full_class_checking (a_enabled: BOOLEAN) is
			-- Set `is_full_class_checking' to `a_enabled'.
		do
			is_full_class_checking_configured := True
			is_full_class_checking := a_enabled
		ensure
			is_full_class_checking_set: is_full_class_checking = a_enabled
			is_full_class_checking_configured: is_full_class_checking_configured
		end

	set_cat_call_detection (a_enabled: BOOLEAN) is
			-- Set `is_cat_call_detection' to `a_enabled'.
		do
			is_cat_call_detection_configured := True
			is_cat_call_detection := a_enabled
		ensure
			is_cat_call_detection_set: is_cat_call_detection = a_enabled
			is_cat_call_detection_configured: is_cat_call_detection_configured
		end

	set_description (a_description: like description) is
			-- Set `description' to `a_description'.
		do
			description := a_description
		ensure
			description_set: description = a_description
		end

feature -- Comparison

	is_equal_options (other: like Current): BOOLEAN is
			-- Are `current' and `other' equal considering the options that are in the compiled result?
		do
			Result := equal (assertions, other.assertions) and is_debug = other.is_debug and
				is_optimize = other.is_optimize and is_profile = other.is_profile and
				is_full_class_checking = other.is_full_class_checking and
				is_cat_call_detection = other.is_cat_call_detection and
				is_trace = other.is_trace and equal(local_namespace, other.local_namespace) and
				equal (debugs, other.debugs)
		end

feature -- Merging

	merge (other: like Current) is
			-- Merge with other, if the values aren't defined in `Current' take the values of `other'.
		local
			l_tmp: like debugs
			l_namespace: like local_namespace
		do
			if other /= Void then
				if assertions = Void then
					assertions := other.assertions
				end
				if debugs = Void then
					debugs := other.debugs
				elseif other.debugs /= Void then
					l_tmp := other.debugs.twin
					l_tmp.merge (debugs)
					debugs := l_tmp
				end
				if warnings = Void then
					warnings := other.warnings
				elseif other.warnings /= Void then
					l_tmp := other.warnings.twin
					l_tmp.merge (warnings)
					warnings := l_tmp
				end
					-- Computation of `namespace' by using values in `other'.
				if other.namespace /= Void then
					l_namespace := other.namespace
				else
					l_namespace := other.local_namespace
				end
				if l_namespace /= Void then
					if local_namespace /= Void then
						namespace := l_namespace + "." + local_namespace
					else
						namespace := l_namespace.twin
					end
				elseif local_namespace /= Void then
					namespace := local_namespace.twin
				else
					namespace := Void
				end
					-- Update `local_namespace' to use `other' in case it is not set.
				if local_namespace = Void then
					local_namespace := other.local_namespace
				end
				if not is_profile_configured then
					is_profile_configured := other.is_profile_configured
					is_profile := other.is_profile
				end
				if not is_trace_configured then
					is_trace_configured := other.is_trace_configured
					is_trace := other.is_trace
				end
				if not is_optimize_configured then
					is_optimize_configured := other.is_optimize_configured
					is_optimize := other.is_optimize
				end
				if not is_debug_configured then
					is_debug_configured := other.is_debug_configured
					is_debug := other.is_debug
				end
				if not is_warning_configured then
					is_warning_configured := other.is_warning_configured
					is_warning := other.is_warning
				end
				if not is_msil_application_optimize_configured then
					is_msil_application_optimize_configured := other.is_msil_application_optimize_configured
					is_msil_application_optimize := other.is_msil_application_optimize
				end
				if not is_full_class_checking_configured then
					is_full_class_checking_configured := other.is_full_class_checking_configured
					is_full_class_checking := other.is_full_class_checking
				end
				if not is_cat_call_detection_configured then
					is_cat_call_detection_configured := other.is_cat_call_detection_configured
					is_cat_call_detection := other.is_cat_call_detection
				end
			end
		end

invariant
	local_namespace_not_empty: local_namespace = Void or else not local_namespace.is_empty

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"
end
