class ASSERT_LIST_AS

inherit

	AST_EIFFEL

feature -- Attributes

	assertions: EIFFEL_LIST [TAGGED_AS];
			-- Assertion list

feature -- Initialization

	set is
			-- Yacc initialization
		do
			assertions ?= yacc_arg (0);
		end

feature -- Incrementality

	reset is
		do
			if assertions /= Void then
				assertions.start
			end;
		end;

feature -- Status report

	has_assertion (a: TAGGED_AS): BOOLEAN is
			-- Does current list have assertion `a'?
		local
			cur: CURSOR
		do
			cur := assertions.cursor
	
			from 
				assertions.start
			until
				assertions.after or else Result
			loop
				Result := assertions.item.is_equiv (a)
				assertions.forth
			end

			assertions.go_to (cur)
		end;

feature -- Simple formatting

	simple_format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text
		do
			if assertions /= void then
				simple_put_clause_keywords (ctxt);
				ctxt.new_line;
				ctxt.set_separator (ti_Semi_colon);
				ctxt.set_new_line_between_tokens;
				ctxt.indent;
				simple_format_assertions (ctxt);
				ctxt.exdent;
			end
		end;

	simple_format_assertions (ctxt: FORMAT_CONTEXT) is
			-- Format assertions.
		local
			i, l_count: INTEGER;
			not_first: BOOLEAN
		do
			ctxt.begin;
			from
				i := 1;
				l_count := assertions.count;
			until
				i > l_count
			loop
				if not_first then
					ctxt.put_separator;
				end;
				ctxt.new_expression;
				ctxt.begin;
				assertions.i_th (i).simple_format(ctxt);
				ctxt.commit;
				not_first := True
				i := i + 1
			end;
			if l_count > 0 then
				ctxt.new_line
			end;
			ctxt.commit;
		end;

feature {ASSERT_LIST_AS, REQUIRE_MERGER, ENSURE_MERGER} -- Replication

	set_assertions (l: like assertions) is
		do
			assertions := l
		end;
	
feature {NONE}
	
	simple_put_clause_keywords (ctxt: FORMAT_CONTEXT) is
			-- Append the assertion keywords ("require", "require else",
			-- "ensure", "ensure then" or "invariant").
		do
		end;

end -- class ASSERT_LIST_AS
