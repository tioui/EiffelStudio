-- Access to Result

class RESULT_B 

inherit

	ACCESS_B
		redefine
			enlarged, read_only, is_result, is_creatable,
			register_name,
			make_byte_code, creation_access,
			assign_code, expanded_assign_code, reverse_code,
			assigns_to
		end

feature 

	read_only: BOOLEAN is False;
			-- Is Result a read-only entity ?

	type: TYPE_I is
			-- Result type
		do
			Result := context.byte_code.result_type;
		end;

	is_result: BOOLEAN is true;
			-- Access is result

	is_creatable: BOOLEAN is true;
			-- Can an access to Result be a target for a creation ?

	same (other: ACCESS_B): BOOLEAN is
			-- Is `other' the same access as Current ?
		local
			result_b: RESULT_B;
		do
			result_b ?= other;
			Result := result_b /= Void
		end;

	creation_access (t: TYPE_I): RESULT_CR_B is
			-- Creation access
		do
			!!Result.make (t);
		end;

	enlarged: RESULT_BL is
			-- Enlarges the result node
		do
			!!Result.make (type);
		end;

	register_name: STRING is
			-- The "Result" string
		do
			Result := Buffer;
			Result.wipe_out;
			Result.append ("Result");
		end;

feature -- Byte code generation

	make_byte_code (ba: BYTE_ARRAY) is
			-- Generate byte code for an access to Result.
		do
			ba.append (Bc_result);
		end;

	assign_code: CHARACTER is
			-- Assignment code
		once
			Result := Bc_rassign;
		end;

	expanded_assign_code: CHARACTER is
			-- Expanded assignment code
		once
			Result := Bc_rexp_assign;
		end;

	reverse_code: CHARACTER is
			-- Reverse assignment code
		once
			Result := Bc_rreverse;
		end; -- reverse_code

feature -- Array optimization

	assigns_to (i: INTEGER): BOOLEAN is
		do
			Result := i = 0
		end;

end
