-- The when..then construct.

class CASE_B 

inherit

	BYTE_NODE
		redefine
			analyze, generate, enlarge_tree, make_byte_code
		end;
	
feature 

	interval: BYTE_LIST [BYTE_NODE];
			-- Case interval {list of INTERVAL_B}: can be Void
			-- in situations such as 5..3

	compound: BYTE_LIST [BYTE_NODE];
			-- Associated compound {list of INSTR_B}: can be Void
	
	set_interval (i: like interval) is
			-- Assign `i' to `interval'.
		do
			interval := i;
		end;

	set_compound (c: like compound) is
			-- Assign `c' to `compound'.
		do
			compound := c;
		end;

	enlarge_tree is
			-- Enlarge the when construct
		do
			interval.enlarge_tree;
			if compound /= Void then
				compound.enlarge_tree;
			end;
		end;

	analyze is
			-- Builds a proper context (for C code).
		do
				-- Values are constants (need not be analyzed)
			if compound /= Void then
				compound.analyze;
			end;
		end;

	generate is
			-- Generate C code in `generated_file'.
		do
			interval.generate;
			if compound /= Void then
				generated_file.indent;
				compound.generate;
				generated_file.putstring ("break;");
				generated_file.new_line;
				generated_file.exdent;
			else
				generated_file.indent;
				generated_file.putstring ("break;");
				generated_file.new_line;
				generated_file.exdent;
			end;
		end;

feature -- Byte code generation

	make_range (ba: BYTE_ARRAY) is
			-- Generate range byte code
		local
			i, nb: INTEGER;
			inter: INTERVAL_B;
		do
			from
				i := interval.count;
			until
				i < 1
			loop
				inter ?= interval.i_th (i);
				inter.make_range (ba);
				ba.mark_forward2;
				i := i - 1;
			end;
		end;

	make_byte_code (ba: BYTE_ARRAY) is
			-- Generate compound byte code
		local
			i: INTEGER;
		do
			from
				i := interval.count;
			until
				i < 1
			loop
				ba.write_forward2;
				i := i - 1;
			end;
			if compound /= Void then
				compound.make_byte_code (ba);
			end;
				-- To end of inspect
			ba.append (Bc_jmp);
			ba.mark_forward;
		end;

end
