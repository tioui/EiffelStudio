indexing
	description: "Implemented `IEiffelParameterDescriptor' Interface."
	Note: "Automatically generated by the EiffelCOM Wizard."

class
	IEIFFEL_PARAMETER_DESCRIPTOR_IMPL_STUB

inherit
	IEIFFEL_PARAMETER_DESCRIPTOR_INTERFACE

	ECOM_STUB

feature -- Access

	name: STRING is
			-- Parameter name
		do
			-- Put Implementation here.
		end

	display: STRING is
			-- Parameter display
		do
			-- Put Implementation here.
		end

feature -- Basic Operations

	create_item is
			-- Initialize `item'
		do
			item := ccom_create_item (Current)
		end

feature {NONE}  -- Externals

	ccom_create_item (eif_object: IEIFFEL_PARAMETER_DESCRIPTOR_IMPL_STUB): POINTER is
			-- Initialize `item'
		external
			"C++ [new ecom_EiffelComCompiler::IEiffelParameterDescriptor_impl_stub %"ecom_EiffelComCompiler_IEiffelParameterDescriptor_impl_stub_s.h%"](EIF_OBJECT)"
		end

end -- IEIFFEL_PARAMETER_DESCRIPTOR_IMPL_STUB

