indexing
	description: "Implemented `IEiffelException' Interface."
	Note: "Automatically generated by the EiffelCOM Wizard."

class
	IEIFFEL_EXCEPTION_IMPL_STUB

inherit
	IEIFFEL_EXCEPTION_INTERFACE

	ECOM_STUB

feature -- Access

	inner_exception: IEIFFEL_EXCEPTION_INTERFACE is
			-- Get inner exception
		do
			-- Put Implementation here.
		end

	message: STRING is
			-- Get exception message
		do
			-- Put Implementation here.
		end

	exception_code: INTEGER is
			-- Retrieve exception type
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

	ccom_create_item (eif_object: IEIFFEL_EXCEPTION_IMPL_STUB): POINTER is
			-- Initialize `item'
		external
			"C++ [new ecom_EiffelComCompiler::IEiffelException_impl_stub %"ecom_EiffelComCompiler_IEiffelException_impl_stub_s.h%"](EIF_OBJECT)"
		end

end -- IEIFFEL_EXCEPTION_IMPL_STUB

