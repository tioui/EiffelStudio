indexing
	description: "Control interfaces. Help file: "
	Note: "Automatically generated by the EiffelCOM Wizard."

deferred class
	IQUICK_ACTIVATE_INTERFACE

inherit
	ECOM_INTERFACE

feature -- Status Report

	quick_activate_user_precondition (p_qa_container: TAG_QACONTAINER_RECORD; p_qa_control: TAG_QACONTROL_RECORD): BOOLEAN is
			-- User-defined preconditions for `quick_activate'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	set_content_extent_user_precondition (psizel: TAG_SIZEL_RECORD): BOOLEAN is
			-- User-defined preconditions for `set_content_extent'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	get_content_extent_user_precondition (psizel: TAG_SIZEL_RECORD): BOOLEAN is
			-- User-defined preconditions for `get_content_extent'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

feature -- Basic Operations

	quick_activate (p_qa_container: TAG_QACONTAINER_RECORD; p_qa_control: TAG_QACONTROL_RECORD) is
			-- No description available.
			-- `p_qa_container' [in].  
			-- `p_qa_control' [out].  
		require
			non_void_p_qa_container: p_qa_container /= Void
			valid_p_qa_container: p_qa_container.item /= default_pointer
			non_void_p_qa_control: p_qa_control /= Void
			valid_p_qa_control: p_qa_control.item /= default_pointer
			quick_activate_user_precondition: quick_activate_user_precondition (p_qa_container, p_qa_control)
		deferred

		end

	set_content_extent (psizel: TAG_SIZEL_RECORD) is
			-- No description available.
			-- `psizel' [in].  
		require
			non_void_psizel: psizel /= Void
			valid_psizel: psizel.item /= default_pointer
			set_content_extent_user_precondition: set_content_extent_user_precondition (psizel)
		deferred

		end

	get_content_extent (psizel: TAG_SIZEL_RECORD) is
			-- No description available.
			-- `psizel' [out].  
		require
			non_void_psizel: psizel /= Void
			valid_psizel: psizel.item /= default_pointer
			get_content_extent_user_precondition: get_content_extent_user_precondition (psizel)
		deferred

		end

end -- IQUICK_ACTIVATE_INTERFACE

