indexing

	description: 
		"AST representation of a elsif clause of a condition instruction";
	date: "$Date$";
	revision: "$Revision$"

class ELSIF_AS

inherit

	AST_EIFFEL
		redefine
			number_of_stop_points
		end

feature {NONE} -- Initialization

	set is
			-- Yacc initialization
		do
			expr ?= yacc_arg (0);
			compound ?= yacc_arg (1);
		ensure then
			expr_exists: expr /= Void
		end;

feature -- Properties

	expr: EXPR_AS;
			-- Conditional expression

	compound: EIFFEL_LIST [INSTRUCTION_AS];
			-- Compound

feature -- Access

	number_of_stop_points: INTEGER is
			-- Number of stop points for AST
		do
            if compound /= Void then
                Result := compound.number_of_stop_points
            end;
            Result := Result + 1
		end

feature {AST_EIFFEL} -- Output

	simple_format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		do
			ctxt.put_text_item (ti_Elseif_keyword);
			ctxt.put_space;
			ctxt.new_expression;
			ctxt.format_ast (expr);
			ctxt.put_space;
			ctxt.put_text_item_without_tabs (ti_Then_keyword);
			ctxt.indent;
			ctxt.set_separator (ti_Semi_colon);
			ctxt.set_new_line_between_tokens;
			ctxt.new_line;
			if compound /= Void then
				ctxt.format_ast (compound);
			end;
			ctxt.new_line;
			ctxt.put_breakable;
		end;

feature {ELSIF_AS} -- Replication

	set_expr (e: like expr) is
		require
			valid_arg: e /= Void
		do
			expr := e
		end;

	set_compound (c: like compound) is
		do
			compound := c
		end;

end -- class ELSIF_AS
