indexing
	description: "Eiffel deferred function generator"
	status: "See notice at end of class";
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_EIFFEL_DEFERRED_FUNCTION_GENERATOR

inherit
	WIZARD_EIFFEL_FUNCTION_GENERATOR

	WIZARD_VARIABLE_NAME_MAPPER

	WIZARD_EIFFEL_DEFERRED_FEATURE_GENERATOR

feature -- Access

	precondition_feature_writer: WIZARD_WRITER_FEATURE

feature -- Basic operation

	generate (a_descriptor: WIZARD_FUNCTION_DESCRIPTOR) is
			-- Generate deferred function
		require
			non_void_descriptor: a_descriptor /= Void
		do
			func_desc := a_descriptor

			create feature_writer.make
			create precondition_feature_writer.make

			feature_writer.set_comment (func_desc.description)

			feature_writer.set_name (func_desc.interface_eiffel_name)

			-- Set arguments and precondition
			if func_desc.argument_count > 0 then
				set_feature_result_type_and_arguments
				set_feature_assertions
			end
			feature_writer.add_precondition (user_defined_precondition (func_desc.interface_eiffel_name))
			-- Set description, function body

			feature_writer.set_deferred
			set_precondition_feature_writer (precondition_feature_writer, func_desc.interface_eiffel_name)
			precondition_feature_writer.arguments.append (clone (feature_writer.arguments))
		end

end -- class WIZARD_EIFFEL_DEFERRED_FUNCTION_GENERATOR
--|----------------------------------------------------------------
--| EiffelCOM: library of reusable components for ISE Eiffel.
--| Copyright (C) 1988-1999 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support http://support.eiffel.com
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------
