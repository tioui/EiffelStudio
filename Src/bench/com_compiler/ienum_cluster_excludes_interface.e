indexing
	description: "Eiffel Cluster Exluded Directories Enumeration. Eiffel language compiler library. Help file: "
	Note: "Automatically generated by the EiffelCOM Wizard."

deferred class
	IENUM_CLUSTER_EXCLUDES_INTERFACE

inherit
	ECOM_INTERFACE

feature -- Status Report

	next_user_precondition (pbstr_exclude: CELL [STRING]; pul_fetched: INTEGER_REF): BOOLEAN is
			-- User-defined preconditions for `next'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	skip_user_precondition (ul_count: INTEGER): BOOLEAN is
			-- User-defined preconditions for `skip'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	reset_user_precondition: BOOLEAN is
			-- User-defined preconditions for `reset'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	clone1_user_precondition (pp_ienum_cluster_excludes: CELL [IENUM_CLUSTER_EXCLUDES_INTERFACE]): BOOLEAN is
			-- User-defined preconditions for `clone1'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	ith_item_user_precondition (ul_index: INTEGER; pbstr_exclude: CELL [STRING]): BOOLEAN is
			-- User-defined preconditions for `ith_item'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	count_user_precondition: BOOLEAN is
			-- User-defined preconditions for `count'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

feature -- Basic Operations

	next (pbstr_exclude: CELL [STRING]; pul_fetched: INTEGER_REF) is
			-- Go to next item in enumerator
			-- `pbstr_exclude' [out].  
			-- `pul_fetched' [out].  
		require
			non_void_pbstr_exclude: pbstr_exclude /= Void
			non_void_pul_fetched: pul_fetched /= Void
			next_user_precondition: next_user_precondition (pbstr_exclude, pul_fetched)
		deferred

		ensure
			valid_pbstr_exclude: pbstr_exclude.item /= Void
		end

	skip (ul_count: INTEGER) is
			-- Skip `ulCount' items.
			-- `ul_count' [in].  
		require
			skip_user_precondition: skip_user_precondition (ul_count)
		deferred

		end

	reset is
			-- Reset enumerator.
		require
			reset_user_precondition: reset_user_precondition
		deferred

		end

	clone1 (pp_ienum_cluster_excludes: CELL [IENUM_CLUSTER_EXCLUDES_INTERFACE]) is
			-- Clone enumerator.
			-- `pp_ienum_cluster_excludes' [out].  
		require
			non_void_pp_ienum_cluster_excludes: pp_ienum_cluster_excludes /= Void
			clone1_user_precondition: clone1_user_precondition (pp_ienum_cluster_excludes)
		deferred

		ensure
			valid_pp_ienum_cluster_excludes: pp_ienum_cluster_excludes.item /= Void
		end

	ith_item (ul_index: INTEGER; pbstr_exclude: CELL [STRING]) is
			-- Retrieve enumerators ith item at `ulIndex'.
			-- `ul_index' [in].  
			-- `pbstr_exclude' [out].  
		require
			non_void_pbstr_exclude: pbstr_exclude /= Void
			ith_item_user_precondition: ith_item_user_precondition (ul_index, pbstr_exclude)
		deferred

		ensure
			valid_pbstr_exclude: pbstr_exclude.item /= Void
		end

	count: INTEGER is
			-- Retrieve enumerator item count.
		require
			count_user_precondition: count_user_precondition
		deferred

		end

end -- IENUM_CLUSTER_EXCLUDES_INTERFACE

