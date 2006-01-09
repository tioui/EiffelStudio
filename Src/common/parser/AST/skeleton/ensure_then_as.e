indexing
	description: "AST representation of a `ensure then' structure."
	date: "$Date$"
	revision: "$Revision$"

class ENSURE_THEN_AS

inherit
	ENSURE_AS
		rename
			make as ensure_make
		redefine
			process,
			is_then, complete_end_location
		end

create
	make

feature -- Initialization

	make (a: like assertions; k_as, l_as: KEYWORD_AS) is
			-- Create new REQUIRE AST node.
		do
			ensure_make (a, k_as)
			then_keyword := l_as
		ensure
			then_keyword_set: then_keyword = l_as
		end

feature -- Roundtrip

	then_keyword: KEYWORD_AS
			-- Keyword "then" associated with this structure

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_ensure_then_as (Current)
		end

feature -- Properties

	is_then: BOOLEAN is True
			-- Is the assertion list an "ensure then" part ?

feature -- Roundtrip/Location		
	complete_end_location (a_list: LEAF_AS_LIST): LOCATION_AS is
		do
			if a_list = Void then
				if assertions /= Void then
					Result := assertions.complete_end_location (a_list)
				else
					Result := null_location
				end
			else
				if full_assertion_list /= Void then
					Result := full_assertion_list.complete_end_location (a_list)
				else
					Result := then_keyword.complete_end_location (a_list)
				end
			end
		end

end -- class ENSURE_THEN_AS
