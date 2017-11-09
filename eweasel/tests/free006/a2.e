deferred class A

feature

	natural_constant: NATURAL_8 = 1
			-- A basic type constant.

	natural_external: NATURAL_16
			-- A basic type external function.
		note
			option: instance_free
		external "C inline"
			alias "[
				return (EIF_NATURAL_16) 2;
			]"
		end

	natural_function: NATURAL_32
			-- A basic type function.
		note
			option: instance_free
		do
			Result := 3
		end

	natural_once: NATURAL_64
			-- A basic type once function.
		note
			option: instance_free
		once
			Result := 4
		end

	string_constant: STRING_32 = "string_constant"
			-- A reference type constant.

	string_external (argument: STRING_32): STRING_32
			-- A reference type external function.
		note
			option: instance_free
		external "C inline"
			alias "[
				return eif_access ($argument);
			]"
		end

	string_function: STRING_32
			-- A reference type function.
		note
			option: instance_free
		do
			Result := {STRING_32} "string_function"
		end

	string_once: STRING_32
			-- A reference type once function.
		note
			option: instance_free
		once
			Result := {STRING_32} "string_once"
		end

end