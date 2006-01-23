indexing
	description: "Control interfaces. Help file: "
	legal: "See notice at end of class."
	status: "See notice at end of class."
	Note: "Automatically generated by the EiffelCOM Wizard."

deferred class
	IOLE_UNDO_MANAGER_INTERFACE

inherit
	ECOM_INTERFACE

feature -- Status Report

	open_user_precondition (p_puu: IOLE_PARENT_UNDO_UNIT_INTERFACE): BOOLEAN is
			-- User-defined preconditions for `open'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	close_user_precondition (p_puu: IOLE_PARENT_UNDO_UNIT_INTERFACE; f_commit: INTEGER): BOOLEAN is
			-- User-defined preconditions for `close'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	add_user_precondition (p_uu: IOLE_UNDO_UNIT_INTERFACE): BOOLEAN is
			-- User-defined preconditions for `add'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	get_open_parent_state_user_precondition (pdw_state: INTEGER_REF): BOOLEAN is
			-- User-defined preconditions for `get_open_parent_state'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	discard_from_user_precondition (p_uu: IOLE_UNDO_UNIT_INTERFACE): BOOLEAN is
			-- User-defined preconditions for `discard_from'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	undo_to_user_precondition (p_uu: IOLE_UNDO_UNIT_INTERFACE): BOOLEAN is
			-- User-defined preconditions for `undo_to'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	redo_to_user_precondition (p_uu: IOLE_UNDO_UNIT_INTERFACE): BOOLEAN is
			-- User-defined preconditions for `redo_to'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	enum_undoable_user_precondition (ppenum: CELL [IENUM_OLE_UNDO_UNITS_INTERFACE]): BOOLEAN is
			-- User-defined preconditions for `enum_undoable'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	enum_redoable_user_precondition (ppenum: CELL [IENUM_OLE_UNDO_UNITS_INTERFACE]): BOOLEAN is
			-- User-defined preconditions for `enum_redoable'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	get_last_undo_description_user_precondition (p_bstr: CELL [STRING]): BOOLEAN is
			-- User-defined preconditions for `get_last_undo_description'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	get_last_redo_description_user_precondition (p_bstr: CELL [STRING]): BOOLEAN is
			-- User-defined preconditions for `get_last_redo_description'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	enable_user_precondition (f_enable: INTEGER): BOOLEAN is
			-- User-defined preconditions for `enable'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

feature -- Basic Operations

	open (p_puu: IOLE_PARENT_UNDO_UNIT_INTERFACE) is
			-- No description available.
			-- `p_puu' [in].  
		require
			open_user_precondition: open_user_precondition (p_puu)
		deferred

		end

	close (p_puu: IOLE_PARENT_UNDO_UNIT_INTERFACE; f_commit: INTEGER) is
			-- No description available.
			-- `p_puu' [in].  
			-- `f_commit' [in].  
		require
			close_user_precondition: close_user_precondition (p_puu, f_commit)
		deferred

		end

	add (p_uu: IOLE_UNDO_UNIT_INTERFACE) is
			-- No description available.
			-- `p_uu' [in].  
		require
			add_user_precondition: add_user_precondition (p_uu)
		deferred

		end

	get_open_parent_state (pdw_state: INTEGER_REF) is
			-- No description available.
			-- `pdw_state' [out].  
		require
			non_void_pdw_state: pdw_state /= Void
			get_open_parent_state_user_precondition: get_open_parent_state_user_precondition (pdw_state)
		deferred

		end

	discard_from (p_uu: IOLE_UNDO_UNIT_INTERFACE) is
			-- No description available.
			-- `p_uu' [in].  
		require
			discard_from_user_precondition: discard_from_user_precondition (p_uu)
		deferred

		end

	undo_to (p_uu: IOLE_UNDO_UNIT_INTERFACE) is
			-- No description available.
			-- `p_uu' [in].  
		require
			undo_to_user_precondition: undo_to_user_precondition (p_uu)
		deferred

		end

	redo_to (p_uu: IOLE_UNDO_UNIT_INTERFACE) is
			-- No description available.
			-- `p_uu' [in].  
		require
			redo_to_user_precondition: redo_to_user_precondition (p_uu)
		deferred

		end

	enum_undoable (ppenum: CELL [IENUM_OLE_UNDO_UNITS_INTERFACE]) is
			-- No description available.
			-- `ppenum' [out].  
		require
			non_void_ppenum: ppenum /= Void
			enum_undoable_user_precondition: enum_undoable_user_precondition (ppenum)
		deferred

		ensure
			valid_ppenum: ppenum.item /= Void
		end

	enum_redoable (ppenum: CELL [IENUM_OLE_UNDO_UNITS_INTERFACE]) is
			-- No description available.
			-- `ppenum' [out].  
		require
			non_void_ppenum: ppenum /= Void
			enum_redoable_user_precondition: enum_redoable_user_precondition (ppenum)
		deferred

		ensure
			valid_ppenum: ppenum.item /= Void
		end

	get_last_undo_description (p_bstr: CELL [STRING]) is
			-- No description available.
			-- `p_bstr' [out].  
		require
			non_void_p_bstr: p_bstr /= Void
			get_last_undo_description_user_precondition: get_last_undo_description_user_precondition (p_bstr)
		deferred

		ensure
			valid_p_bstr: p_bstr.item /= Void
		end

	get_last_redo_description (p_bstr: CELL [STRING]) is
			-- No description available.
			-- `p_bstr' [out].  
		require
			non_void_p_bstr: p_bstr /= Void
			get_last_redo_description_user_precondition: get_last_redo_description_user_precondition (p_bstr)
		deferred

		ensure
			valid_p_bstr: p_bstr.item /= Void
		end

	enable (f_enable: INTEGER) is
			-- No description available.
			-- `f_enable' [in].  
		require
			enable_user_precondition: enable_user_precondition (f_enable)
		deferred

		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- IOLE_UNDO_MANAGER_INTERFACE

