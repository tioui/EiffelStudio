-- Abstract description of an Eiffel class

class CLASS_AS

inherit

	AST_EIFFEL
		redefine
			format
		end;
	IDABLE;
	SHARED_INST_CONTEXT;
	STONABLE;
	CLICKER;

feature -- Attributes

	id: INTEGER;
			-- Class id

	class_name: ID_AS;
			-- Class name

	obsolete_message: STRING_AS;
			-- Obsolete message clause 
			-- (Void if was not present)

	is_deferred: BOOLEAN;
			-- Is the class deferred ?

	is_expanded: BOOLEAN;
			-- Is the class expanded ?

	indexes: EIFFEL_LIST [INDEX_AS];
			-- Index clause

	generics: EIFFEL_LIST [FORMAL_DEC_AS];
			-- Formal generic parameter list

	parents: EIFFEL_LIST [PARENT_AS];
			-- Inheritance clause

	creators: EIFFEL_LIST [CREATE_AS];
			-- Creators

	features: EIFFEL_LIST [FEATURE_CLAUSE_AS];
			-- Feature list

	invariant_part: INVARIANT_AS;
			-- Class invariant

	suppliers: SUPPLIERS_AS;
			-- Supplier types

feature -- Initialization

	set is
			-- Initialization routine
		local
			click_class_name: CLICK_AST
		do
			class_name ?= yacc_arg (0);
			is_deferred := yacc_bool_arg (0);
			is_expanded := yacc_bool_arg (1);
			indexes ?= yacc_arg (1);
			generics ?= yacc_arg (2);
			parents ?= yacc_arg (3);
			creators ?= yacc_arg (4);
			features ?= yacc_arg (5);
			invariant_part ?= yacc_arg (6);
			if (invariant_part /= Void)
				and then
				invariant_part.assertion_list = Void
			then
					-- The keyword `invariant' followed by no assertion
					-- at all is not significant.
				invariant_part := Void;
			end;
			suppliers ?= yacc_arg (7);
			click_list ?= yacc_arg (8);
			obsolete_message ?= yacc_arg (9);	
			click_class_name ?= click_list.first;
			click_class_name.set_node (Current);
		ensure then
			class_name_exists: class_name /= Void;
			suppliers_exists: suppliers /= Void;
		end;

feature -- Conveniences

	set_id (i: INTEGER) is
			-- Assign `i' to `id'.
		do
			id := i;
		end;

feature {CLASS_C} -- Class information

	info: CLASS_INFO is
			-- Compiled information about the class produced after
			-- parsing (useful for second pass).
		local
			parent_list: PARENT_LIST;
		do
			!!Result;
			if parents /= Void then
				!!parent_list.make (parents.count);
			elseif not ("general").is_equal (class_name) then
				!!parent_list.make (1);
			else
				!!parent_list.make (0);
			end;
			Result.set_parents (parent_list);
				-- List `parent_list' will be filled by feature `init'
				-- of CLASS_C
			Result.set_creators (creators);
		end;

feature -- stoning
 
	stone (reference_class: CLASS_C): CLASSC_STONE is
		local
			aclass: CLASS_C;
		do
			aclass := Universe.class_named (class_name, reference_class.cluster).compiled_class;
			!!Result.make (aclass)
		end;

	click_list: CLICK_LIST;
 
feature -- formatting

	format (ctxt: FORMAT_CONTEXT) is
		local
			flat: FLAT_AST;
			s: STRING;
		do
			ctxt.begin;
			ctxt.flat_struct.format_comments (ctxt);			
			if indexes /= void and not indexes.empty then
				ctxt.put_keyword ("indexing");
				ctxt.indent_one_more;
				ctxt.next_line;
				ctxt.set_separator (void);
				ctxt.new_line_between_tokens;
				indexes.format (ctxt);
				ctxt.indent_one_less;
				ctxt.next_line;
				ctxt.next_line;
			end;

			if is_expanded then
				ctxt.put_keyword ("expanded");
				ctxt.put_string (" ");
			elseif is_deferred then
				ctxt.put_keyword ("deferred");
				ctxt.put_string (" ");
			end;
			ctxt.put_keyword ("class");
			ctxt.put_string (" ");
			if ctxt.is_short then
				ctxt.put_keyword ("interface");
				ctxt.put_string (" ");
			end;
			ctxt.put_name_of_class;	

			if generics /= void then
				ctxt.put_string (" ");
				ctxt.put_special ("[");
				ctxt.no_new_line_between_tokens;
				ctxt.set_separator (", ");
				generics.format (ctxt);
				ctxt.put_special ("]");
			end;
			ctxt.next_line;
			ctxt.next_line;
			if creators /= void then
				ctxt.continue_on_failure;
				ctxt.new_line_between_tokens;
				ctxt.set_separator (void);
				creators.format (ctxt);
				if not ctxt.last_was_printed then
					ctxt.put_keyword ("creation");
					ctxt.next_line;
				end;
				ctxt.next_line;
			end;		
			ctxt.begin;
			ctxt.flat_struct.format (ctxt);	
			ctxt.commit;	
			ctxt.put_keyword ("end");
			ctxt.end_class_text;
			ctxt.next_line;
			ctxt.commit;
		end;

feature {CASE_CLUSTER_INFO} -- Case storage 

	header_storage_info: S_CLASS_DATA is
			-- Header storage information for Current
			-- (such as index and class name)
		local
			g_l: FIXED_LIST [S_GENERIC_DATA];
			i_l: FIXED_LIST [S_TEXT_DATA];
			s_chart: S_CLASS_CHART;
			gen: FORMAL_DEC_AS;
			gen_name: STRING;
			gen_data: S_GENERIC_DATA;
			key: S_CLASS_KEY;
			type_info: S_TYPE_INFO;
			name: STRING
		do
			name := class_name.string_value;
			name.to_upper;
			!! Result.make (name);
			if indexes /= Void then
				!! s_chart;
				from
					!! i_l.make (indexes.count);
					i_l.start;
					indexes.start
				until
					indexes.after
				loop
					i_l.replace (indexes.item.storage_info);
					i_l.forth;
					indexes.forth
				end
				s_chart.set_indexes (i_l);
				Result.set_chart (s_chart);
			end;
			if generics /= Void then
				!! g_l.make (generics.count);
				from
					generics.start;
					g_l.start
				until
					generics.after
				loop
					gen := generics.item;
					!! gen_name.make (0);
					gen_name.append (gen.formal_name);
					if gen.constraint = Void then
						!! gen_data.make (gen_name, Void)
					else
						key := gen.constraint_type.associated_class.case_class_key;
						!! type_info.make (Void, key);
						!! gen_data.make (gen_name, type_info)
					end;
					g_l.replace (gen_data);
					g_l.forth;
					generics.forth
				end;
				Result.set_generics (g_l);
			end;
		end;

end
