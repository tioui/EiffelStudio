-- Instance of an Eiffel feature: for every inherited feature there is
-- an instance of FEATURE_I with its final name, the class name where it
-- is written, the body id of its content and the routine table ids to
-- which the feature is attached.
-- Attribute `type' is the real type of the feature in the class where it
-- is inherited (or written), that means there is no more anchored type.

deferred class FEATURE_I 

inherit

	SHARED_WORKBENCH;
	SHARED_SERVER;
	SHARED_INSTANTIATOR;
	BASIC_ROUTINES;
	SHARED_ERROR_HANDLER;
	SHARED_TYPES;
	SHARED_CONSTRAINT_ERROR;
	SHARED_EVALUATOR;
	SHARED_ARG_TYPES;
	SHARED_TABLE;
	SHARED_AST_CONTEXT;
	SHARED_BYTE_CONTEXT
		rename
			context as byte_context
		end;
	SHARED_ENCODER;
	SHARED_CODE_FILES;
	SHARED_PATTERN_TABLE;
	SHARED_USED_TABLE;
	SHARED_INST_CONTEXT;
	SHARED_ID_TABLES;
	SHARED_ARRAY_BYTE;
	SHARED_EXEC_TABLE;
	HASHABLE;
	
feature 

	feature_name: STRING;
			-- Final name of the feature

	feature_id: INTEGER;
			-- Feature id: first key in the feature call hash table
			-- of a class: tow features of different names have two
			-- different feature ids.

	written_in: INTEGER;
			-- Class id where the feature is written

	body_index: INTEGER;
			-- Index of body id

	pattern_id: INTEGER;
			-- Id of the feature pattern

	rout_id_set: ROUT_ID_SET;
			-- Routine table to which the feature belongs to.

	export_status: EXPORT_I;
			-- Export status of the feature

	is_origin: BOOLEAN;
			-- Is the feature an origin ?

	is_frozen: BOOLEAN;
			-- Is the feature frozen ?

	is_selected: BOOLEAN;
			-- Is the feature selected ?

	is_infix: BOOLEAN;
			-- Is the feature an infixed one ?

	is_prefix: BOOLEAN;
			-- Is the feature a prefixed one ?

	hash_code: INTEGER is
			-- Hash code
		do
			check
				feature_name_exists: feature_name /= Void
			end;
			Result := feature_name.hash_code
		end;

	set_feature_id (i: INTEGER) is
			-- Assign `i' to `feature_id'
		do
			feature_id := i;
		end;

	set_body_index (i: INTEGER) is
			-- Assign `i' to `body_index'.
		do
			body_index := i;
		end;

	set_pattern_id (i: INTEGER) is
			-- Assign `i' to `pattern_id'.
		do
			pattern_id := i;
		end;

	set_feature_name (s: STRING) is
			-- Assign `s' to `feature_name'.
		do
			feature_name := s;
		end;

	set_written_in (s: INTEGER) is
			-- Assign `s' to `written_in'.
		do
			written_in := s;
		end;

	set_is_origin (b: BOOLEAN) is
			-- Assign `b' to `is_origin'.
		do
			is_origin := b;
		end;

	set_export_status (e: EXPORT_I) is
			-- Assign `e' to `export_status'.
		do
			export_status := e;
		end;

	set_is_frozen (b: BOOLEAN) is
			-- Assign `b' to `is_frozen'.
		do
			is_frozen := b;
		end;

	set_is_infix (b: BOOLEAN) is
			-- Assign `b' to `is_infix'. 
		do
			is_infix := b;
		end;

	set_is_prefix (b: BOOLEAN) is
			-- Assign `b' to `is_prefix'.
		do
			is_prefix := b;
		end;

	set_is_selected (b: BOOLEAN) is
			-- Assign `b' to `is_selected'.
		do
			is_selected := b;
		end;

	set_rout_id_set (set: like rout_id_set) is
			-- Assign `set' to `rout_id_set'.
		do
			rout_id_set := set;
		end;

	to_generate_in (a_class: CLASS_C): BOOLEAN is
			-- Has the current feature to be generate in class `a_class' ?
		require
			good_argument: a_class /= Void
		do
			Result := a_class.id = written_in
		end;

	generation_class_id: INTEGER is
			-- Id of the class where the feature has to be generated in
		do
			Result := written_in
		end;

	body_id: INTEGER is
			-- Body id of the current version of the feature
		require
			consistency: Body_index_table.has (body_index);
		do
			Result := Body_index_table.item (body_index);
		end;

	original_body_id: INTEGER is
			-- Body id of the feature before before the beginning of
			-- a recompilation
		require
			consistency: Original_body_index_table.has (body_index);
		do
			Result := Original_body_index_table.item (body_index);
		end;

	duplicate: like Current is
			-- Clone
		do
			Result := twin
		end;

feature -- Incrementality

	equiv (other: FEATURE_I): BOOLEAN is
			-- Incrementality test on instance fo FEATURE_I during
			-- second pass.
		require
			good_argument: other /= Void
		do
			Result :=	written_in = other.written_in
						and then
						is_selected = other.is_selected
						and then	
						rout_id_set.same_as (other.rout_id_set)
						and then
						is_origin = other.is_origin
						and then
						is_frozen = other.is_frozen
						and then
						export_status.same_as (other.export_status)
						and then
						same_signature (other);
		end;

	same_interface (other: FEATURE_I): BOOLEAN is
			-- Has `other' the same interface than Current ?
			-- [Semnatic for second pass is `old_feat.same_interface (new)']
		require
			good_argument: other /= Void;
			same_names: other.feature_name.is_equal (feature_name);
			export_statuses_exist: not ( 	export_status = Void
											or else
											other.export_status = Void);
		do
			Result := 	type.same_as (other.type)
						and then
						export_status.equiv (other.export_status);
			if Result then
				if argument_count = 0 then
					Result := other.argument_count = 0;
				else
					Result := 	argument_count = other.argument_count
								and then
								arguments.same_interface (other.arguments)
				end;
			end;
			Result := 	Result
						and then
						is_attribute = other.is_attribute;
		end;

feature -- Type id

	written_type_id (class_type: CL_TYPE_I): INTEGER is
			-- Written type id of the feature in the context of the
			-- type `class_type'.
		do
			Result := written_type (class_type).type_id;
		end;

	written_type (class_type: CL_TYPE_I): CL_TYPE_I is
			-- Written type of the feature in the context of the
			-- type `class_type'.
		require
			good_argument: class_type /= Void;
			conformance: class_type.base_class.conform_to (written_class);
		do
			Result := written_class.meta_type (class_type);
		end;

feature -- Conveniences

	is_obsolete: BOOLEAN is
			-- Is Current feature obsolete?
		do
			Result := obsolete_message /= Void
		end;

	obsolete_message: STRING is
			-- Obsolete message
			-- (Void if Current is not obsolete)
		do
			-- Do nothing
		end;

	has_arguments: BOOLEAN is
			-- Has the current feature some formal arguments ?
		do
			Result := arguments /= Void
		end;

	is_procedure: BOOLEAN is
			-- Is the current feature a procedure ?
		do
			-- Do nothing
		end;

	is_function: BOOLEAN is
			-- Is the cuurent feature a function ?
		do
			-- Do nothing
		end;

	is_attribute: BOOLEAN is
			-- Is the current feature an attribute ?
		do
			-- Do nothing
		end;

	is_constant: BOOLEAN is
			-- Is the current feature a constant ?
		do
			-- Do nothing
		end;

	is_once: BOOLEAN is
			-- Is the current feature a once one ?
		do
			-- Do nothing
		end;

	is_do: BOOLEAN is
			-- Is the current feature a do one ?
		do
			-- Do nothing
		end;

	is_deferred: BOOLEAN is
			-- Is the current feature a deferred one ?
		do
			-- Do nothing
		end;

	is_unique: BOOLEAN is
			-- Is the current feature a unique constant ?
		do
			-- Do nothing
		end;

	is_external: BOOLEAN is
			-- Is the current feature an external one ?
		do
			-- Do nothing
		end;

	is_require_else: BOOLEAN is
			-- Is the precondition block of the feature a redefined one ?
		do
			Result := True;
		end;

	has_precondition: BOOLEAN is
			-- Is the feature declaring some preconditions ?
		do
			-- Do nothing
		end;

	has_postcondition: BOOLEAN is
			-- Is the feature declaring some postconditions ?
		do
			-- Do nothing
		end;

	has_assertion: BOOLEAN is
			-- Is the feature declaring some pre or post conditions ?
		do
			Result := has_postcondition or else has_precondition
		end;

	is_ensure_then: BOOLEAN is
			-- Is the postcondition block of the feature a redefined one ?
		do
			Result := True;
		end;

	redefinable: BOOLEAN is
			-- Is the feature redefinable ?
		do
			Result := not is_frozen;
		end;

	undefinable: BOOLEAN is
			-- Is the feature undefinable ?
		do
			Result := redefinable
		end;

	is_none_attribute: BOOLEAN is
			-- is the feature an attribute of type NONE ?
		do
			-- Do nothing
		end;

	type: TYPE is
			-- Type of the feature
		do
			Result := Void_type
		end;

	set_type (t: TYPE) is
			-- Assign `t' to `type'.
		do
			-- Do nothing
		end;

	arguments: FEAT_ARG is
			-- Argument types
		do
			-- No arguments
		end;

	argument_names: EIFFEL_LIST [ID_AS] is
			-- Argument names
		do
			-- No argument names
		end;

	argument_count: INTEGER is
			-- Number of arguments of the feature
		do
			if arguments /= Void then
				Result := arguments.count;
			end;
		end;

	written_class: CLASS_C is
			-- Class where the feature is written in
		require
			good_written_in: written_in > 0;
		do
			Result := System.class_of_id (written_in);
		end;

feature -- Export checking

	is_exported_for (client: CLASS_C): BOOLEAN is
			-- Is the current feature exported to class `client' ?
		require
			good_argument: client /= Void;
			has_export_status: export_status /= Void;
		do
			Result := export_status.valid_for (client);
		end;

feature -- Check

	type_check is
			-- Third pass on current feature
		require
			in_pass3
		local
			type_a: TYPE_A;
			a_class: CLASS_C;
			body: FEATURE_AS;
				-- Body of the feature
		do
				-- Take the body in the body server
			body := Body_server.item (body_id);
				-- make the type check
			body.type_check;
			type_a ?= type;
			if type_a /= Void then
				a_class := type_a.associated_class;
				if a_class /= Void then
					context.supplier_ids.add_supplier (a_class.id);
				end;
			end;
			if has_arguments then
				from
					arguments.start
				until
					arguments.offright
				loop
					type_a ?= arguments.item;
					a_class := type_a.associated_class;
					if a_class /= Void then
						context.supplier_ids.add_supplier (a_class.id);
					end;
					arguments.forth;
				end;
			end;
		end;

	in_pass3: BOOLEAN is
			-- Does the current feature support the type check ?
		do
			Result := True;
		end;

feature -- Byte code computation

	compute_byte_code is
			-- Compute byte code for melted feature
		require
			in_pass3
		local
			body: FEATURE_AS;
				-- Body of the feature
			byte_code: BYTE_CODE;
			i: INTEGER;
		do
			i := body_id;
				-- Take the body in the body server
			body := Body_server.item (i);
				-- Process byte code
			byte_code := body.byte_node;
			byte_code.set_byte_id (i);
				-- Put it in the temporary byte code server
			byte_code.set_old_expressions (byte_context.old_expressions);
			byte_context.clear_old_expressions;
			Tmp_byte_server.put (byte_code);
		end;

	melt (dispatch: DISPATCH_UNIT; exec: EXECUTION_UNIT) is
			-- Generate byte code for the current feature
			-- [To be redefined in CONSTANT_I, ATTRIBUTE_I and in EXTERNAL_I].
		require
			good_argument: dispatch /= Void;
		local
			byte_code: BYTE_CODE;
			melted_feature: MELT_FEATURE;
		do
			byte_code := Byte_server.item (body_id);

			byte_context.set_byte_code (byte_code);

			Byte_array.clear;
			byte_code.make_byte_code (Byte_array);
			byte_context.clear_all;

			melted_feature := Byte_array.melted_feature;
			melted_feature.set_body_id (dispatch.real_body_id);
			M_feature_server.put (melted_feature);

			Dispatch_table.mark_melted (dispatch);
			Execution_table.mark_melted (exec);
		end;

	melted: BOOLEAN is
			-- Is the feature melted ?
		do
			Result := body_id > System.frozen_level;
		end;

	execution_unit (cl_type: CLASS_TYPE): EXECUTION_UNIT is
			-- Execution unit
		do
			!!Result.make (cl_type, Current);
		end;

	change_body_id is
			-- Change the body id of the current feature
			--| In case of automatic melting of the Current feature (see
			--| `pass3' in CLASS_C, the body id of the feature must be
			--| cnaged even if not syntactically changed.
		local
			new_body_id, old_body_id: INTEGER;
		do
			old_body_id := body_id;
			new_body_id := System.body_id_counter.next;
				-- Update the server using `old_body_id'
			Body_server.change_key (new_body_id, old_body_id);
			Tmp_body_server.change_key (new_body_id, old_body_id);
			Byte_server.change_key (new_body_id, old_body_id);
			Tmp_byte_server.change_key (new_body_id, old_body_id);
				-- Update the body index table
			Body_index_table.force (new_body_id, body_index);
			Original_body_index_table.force (new_body_id, body_index);
		end;
	
feature -- Polymorphism

 	has_poly_unit: BOOLEAN is
 			-- Has the feature an associated polymorphic unit ?
 		do
 			Result := True
 		end;
 
 	new_poly_unit (rout_id: INTEGER): POLY_UNIT is
 			-- New polymorhphic unit
 		require
 			positive_rout_id: rout_id > 0
 		do
 			if (not is_attribute) or else rout_id_set.has (rout_id) then
 				Result := new_rout_unit
 			else
 				Result := new_attr_unit
 			end;
 		end;
 
 	new_rout_unit: ROUT_UNIT is
 			-- New routine unit
 		require
 			not_deferred: not is_deferred;
 		do
 			!!Result;
 			Result.set_body_index (body_index);
 			Result.set_type (type.actual_type);
 			Result.set_written_in (written_in);
 			Result.set_pattern_id (pattern_id);
 		end;
 
 	new_attr_unit: ATTR_UNIT is
 			-- New attribute unit
 		require
 			is_attribute: is_attribute;
 		do
 			!!Result;
 			Result.set_type (type.actual_type);
 			Result.set_feature_id (feature_id);
 		end;
 
 	poly_equiv (other: FEATURE_I): BOOLEAN is
 			-- Is `other' equivalent to Current from the polymorhic table 
			-- implementation point of view ?
 		require
 			good_argument: other /= Void;
 		local
 			is_attr: BOOLEAN;
 		do
 			is_attr := is_attribute;
 			Result := 	other.is_attribute = is_attr
 						and then
 						type.actual_type.same_as (other.type.actual_type);
 			if Result then
 				if is_attr then
 					Result := 	feature_id = other.feature_id
				else
	 				Result :=	written_in = other.written_in
 								and then
 								body_index = other.body_index
 								and then
 								pattern_id = other.pattern_id
 				end;
 			end;
 		end;

feature -- Signature instantiation

	instantiate (parent_type: CL_TYPE_A) is
			-- Instantiated the signature in the context of `parent_type'.
		require
			good_argument: parent_type /= Void;
			is_solved: type.is_solved;
		local
			i, nb: INTEGER;
			old_type: TYPE_A;
		do
				-- Instantiation of the type
			old_type ?= type;
			set_type (old_type.instantiated_in (parent_type));
				-- Instantiation of the arguments
			from
				i := 1;
				nb := argument_count;
			until
				i > nb
			loop
				old_type ?= arguments.i_th (i);
				arguments.put_i_th (old_type.instantiated_in (parent_type), i);
				i := i + 1;
			end;
		end;

feature -- Signature checking
	
	check_argument_names (feat_table: FEATURE_TABLE) is
			-- Check the argument names
		require
			argument_names_exists: argument_names /= Void;
			written_in_class: written_in = feat_table.feat_tbl_id;
				-- The feature must be written in the associated class
				-- of `feat_table'.
		local
			arg_names: like argument_names;
			arg_id: ID_AS;
			vreg: VREG;
			vrfa: VRFA;
		do
			from
				arg_names := argument_names;
				arg_names.start;
			until
				arg_names.offright
			loop
				arg_id := arg_names.item;
				if arg_names.index_of (arg_id, 2) /= 0 then
						-- Two arguments with the same name
					!!vreg;
					vreg.set_class_id (written_in);
					vreg.set_body_id (body_id);
					vreg.set_argument_name (arg_id);
					Error_handler.insert_error (vreg);
				end;
				if feat_table.has (arg_id) then
						-- An argument name is a feature name of the feature
						-- table.
					!!vrfa;
					vrfa.set_class_id (written_in);
					vrfa.set_body_id (body_id);
					vrfa.set_argument_name (arg_id);
					Error_handler.insert_warning (vrfa);
				end;
				arg_names.forth
			end;
		end;

	check_types (feat_table: FEATURE_TABLE) is
			-- Check the type and the arguments types. The objective is
			-- to deal with anchored types and genericity. All the anchored
			-- types are interpreted here and the generic parameter
			-- instantiated if possible.
		require
			type /= Void;
		local
			solved_type: TYPE_A;
			vffd5: VFFD5;
			vffd6: VFFD6;
			vffd7: VFFD7;
			vffd8: VFFD8;
			vtug1: VTUG1;
			vtec1: VTEC1;
			vtec2: VTEC2;
			vtgg1: VTGG1;
		do
			if type.has_like and then is_once then
					-- We have an anchored type.
					-- Check if the feature is not a once feature
				!!vffd8;
				vffd8.set_class_id (written_in);
				vffd8.set_body_id (body_id);
				Error_handler.insert_error (vffd8);
			end;
				-- Process an actual type for the feature; interpret
				-- anchored types.
			solved_type := Result_evaluator.evaluated_type
												(type, feat_table, Current);
			check
					-- If an anchored cannot be valuated then an
					-- exection is triggered by the type evaluator.
				solved_type /= Void;
			end;
			if feat_table.associated_class = written_class then
					-- Check validity of an expanded result type
				if	solved_type.has_expanded then
					if 	solved_type.expanded_deferred then
						!!vtec1;
						vtec1.set_class_id (written_in);	
						vtec1.set_body_id (body_id);
						vtec1.set_type (solved_type);
						Error_handler.insert_error (vtec1);
					elseif not solved_type.valid_expanded_creation then
						!!vtec2;
						vtec2.set_class_id (written_in);	
						vtec2.set_body_id (body_id);
						vtec2.set_type (solved_type);
						Error_handler.insert_error (vtec2);
					end
				end;
					-- Check valididty of a generic class type
				if not solved_type.good_generics then
					!!vtug1;
					vtug1.set_class_id (written_in);
					vtug1.set_body_id (body_id);
					vtug1.set_type (solved_type);
					Error_handler.insert_error (vtug1);
						-- Cannot go on here ..
					Error_handler.raise_error;
				end;
					-- Check constrained genericity validity rule
				solved_type.check_constraints (written_class);
				if not Constraint_error_list.empty then
					!!vtgg1;
					vtgg1.set_class_id (written_in);
					vtgg1.set_body_id (body_id);
					vtgg1.set_error_list
										(deep_clone (Constraint_error_list));
					Error_handler.insert_error (vtgg1);
				end;
			end;

			set_type (solved_type);
				-- Instantitate the feature type in the context of the
				-- actual type of the class associated to `feat_table'.

			if is_once and then solved_type.has_formal_generic then
					-- A once funtion cannot have a type with formal generics
				!!vffd7;
				vffd7.set_class_id (written_in);
				vffd7.set_body_id (body_id);
				Error_handler.insert_error (vffd7);
			end;
			if solved_type /= Void then
				solved_type.check_for_obsolete_class
			end;
			if arguments /= Void then
				if is_infix and then argument_count /= 1 then
						-- Infixed features should have only one argument
					!!vffd6;
					vffd6.set_class_id (written_in);
					vffd6.set_body_id (body_id);
					Error_handler.insert_error (vffd6);
				end;
				if is_prefix and then argument_count /= 0 then
						-- Prefixed features shouldn't have any argument
					!!vffd5;
					vffd5.set_class_id (written_in);
					vffd5.set_body_id (body_id);
					Error_handler.insert_error (vffd5);
				end;
					-- Check types of arguments
				arguments.check_types (feat_table, Current);
			end;
		end;

	check_signature (old_feature: FEATURE_I) is
			-- Check the signature conformance beetween Current
			-- and inherited feature in `inherit_info' from which Current
			-- is a redefinition.
		require
			good_argument: old_feature /= Void;
		local
			old_type, new_type: TYPE_A;
			i, arg_count: INTEGER;
			new_ext, old_ext: EXTERNAL_I;
			old_arguments: like arguments;
			current_class: CLASS_C;
			vdrd51: VDRD51;
			vdrd52: VDRD52;
			vdrd53: VDRD53;
			vdrd6: VDRD6;
			vdrd7: VDRD7;
			ve01: VE01;
			ve02: VE02;
			ve02a: VE02A;
		do
			current_class := System.current_class;

				-- Check if an attribute is redefined in an attribute
			if old_feature.is_attribute and then not is_attribute then
				!!vdrd6;
				vdrd6.init (old_feature, Current);
				Error_handler.insert_error (vdrd6);
			end;

				-- Check if an external (resp. non-external) feature is not
				-- redefined into a non external (resp. external) one
			if 	(old_feature.is_external and then not is_external)
				or else
				(not old_feature.is_external and then is_external)
			then
				!!ve01;
				ve01.set_class_id (current_class.id);
				ve01.set_feature1 (Current);
				ve01.set_feature2 (old_feature);
				Error_handler.insert_error (ve01);
			elseif is_external then
				old_ext ?= old_feature;
				new_ext ?= Current;
				new_ext.set_encapsulated
						(new_ext.encapsulated or else old_ext.encapsulated);
			end;

				-- Check if an effective feature is not redefined in a
				-- non-effective feature
			if (not old_feature.is_deferred) and then is_deferred then
				!!vdrd7;
				vdrd7.init (old_feature, Current);
				Error_handler.insert_error (vdrd7);
			end;
	
				-- Initialization for like-argument types
			Argument_types.init1 (Current);
		
			old_type ?= old_feature.type;	
			old_type := old_type.conformance_type.actual_type;
				-- `new_type' is the actual type of the redefinition already
				-- instantiated
			new_type := type.actual_type;
			if not current_class.valid_redeclaration (old_type, new_type) then
				!!vdrd51;
				vdrd51.init (old_feature, Current);
				vdrd51.set_type (new_type);
				vdrd51.set_precursor_type (old_type);
				Error_handler.insert_error (vdrd51);
			elseif
				new_type.is_expanded /= old_type.is_expanded
			then
				!!ve02;
				ve02.init (old_feature, Current);
				ve02.set_type (new_type);
				ve02.set_precursor_type (old_type);
				Error_handler.insert_error (ve02);
			end;

				-- Check the argument count
			if argument_count /= old_feature.argument_count then
				!!vdrd52;
				vdrd52.init (old_feature, Current);
				Error_handler.insert_error (vdrd52);
			else
					-- Check the argument conformance
				from
					i := 1;
					arg_count := argument_count;
					old_arguments := old_feature.arguments;
				until
					i > arg_count
				loop
					old_type ?= old_arguments.i_th (i);
					old_type := old_type.conformance_type.actual_type;
					new_type := arguments.i_th (i).actual_type;
					if not
						current_class.valid_redeclaration (old_type, new_type)
					then
						!!vdrd53;
						vdrd53.init (old_feature, Current);
						vdrd53.set_type (new_type);
						vdrd53.set_precursor_type (old_type);
						vdrd53.set_argument_number (i);
						Error_handler.insert_error (vdrd53);
					elseif
						new_type.is_expanded /= old_type.is_expanded
					then
						!!ve02a;
						ve02a.init (old_feature, Current);
						ve02a.set_type (new_type);
						ve02a.set_precursor_type (old_type);
						ve02a.set_argument_number (i);
						Error_handler.insert_error (ve02a);
					end;
	
					i := i + 1;
				end;
			end;
		end;

	check_same_signature (old_feature: FEATURE_I) is
			-- Check the signature equality beetween Current
			-- and inherited feature in `inherit_info' from which Current
			-- is a join.
		require
			good_argument: old_feature /= Void;
			is_deferred;
			old_feature.is_deferred;
			old_feature_is_solved: old_feature.type.is_solved;
		local
			old_type, new_type: TYPE_A;
			i, arg_count: INTEGER;
			old_arguments: like arguments;
			vdjr: VDJR;
			vdjr1: VDJR1;
			vdjr2: VDJR2;
		do
				-- Check the result type conformance
				-- `old_type' is the instantiated inherited type in the
				-- context of the class where the join takes place:
				-- i.e the class relative to `written_in'.
			old_type ?= old_feature.type;
				-- `new_type' is the actual type of the join already
				-- instantiated
			new_type ?= type;
			if not deep_equal (new_type, old_type) then
				!!vdjr1;
				vdjr1.init (old_feature, Current);
				vdjr1.set_type (new_type);
				vdjr1.set_old_type (old_type);
				Error_handler.insert_error (vdjr1);
			end;

				-- Check the argument count
			if argument_count /= old_feature.argument_count then
				!!vdjr;
				vdjr.init (old_feature, Current);
				Error_handler.insert_error (vdjr);
			else
	
					-- Check the argument equality
				from
					i := 1;
					arg_count := argument_count;
					old_arguments := old_feature.arguments;
				until
					i > arg_count
				loop
					old_type ?= old_arguments.i_th (i);
					new_type ?= arguments.i_th (i);
					if not deep_equal (new_type, old_type) then
						!!vdjr2;
						vdjr2.init (old_feature, Current);
						vdjr2.set_type (new_type);
						vdjr2.set_old_type (old_type);
						vdjr2.set_argument_number (i);
						Error_handler.insert_error (vdjr2);
					end;
					i := i + 1;
				end;
			end;
		end;

	solve_types (feat_tbl: FEATURE_TABLE) is
			-- Evaluates signature types in the context of `feat_tbl'.
			-- | Take care of possible anchored types
		do
			set_type
				(Result_evaluator.evaluated_type (type, feat_tbl, Current));
			if arguments /= Void then
				arguments.solve_types (feat_tbl, Current);
			end;
		end;

	same_signature (other: FEATURE_I): BOOLEAN is
			-- Has `other' the same signature than Current ?
		require
			good_argument: other /= Void;
			same_feature_names: feature_name.is_equal (other.feature_name);
		local
			i, nb: INTEGER;
		do
			Result := deep_equal (type, other.type);
			from
				nb := argument_count;
				Result := Result and then nb = other.argument_count;
				nb := argument_count;
				i := 1;
			until
				i > nb or else not Result
			loop
				Result := deep_equal (arguments.i_th (i),
											other.arguments.i_th (i));
				i := i + 1;
			end;
		end;

	argument_position (arg_id: ID_AS): INTEGER is
			-- Position of argument `arg_id' in the list of arguments
			-- of the current feature. 0 if none or not found.
		require
			arg_id /= Void;
		do
			if arguments /= Void then
				Result := argument_names.index_of (arg_id, 1);
			end;
		end;

	has_argument_name (arg_id: ID_AS): BOOLEAN is
			-- Has the current feature an argument named `arg_id" ?
		do
			if arguments /= Void then
				Result := argument_names.has (arg_id);
			end;
		end;

feature -- Undefinition

	new_deferred: DEF_PROC_I is
			-- New deferred feature for undefinition
		require
			not is_deferred;
			redefinable;
		do
			if type /= Void then
				!DEF_FUNC_I!Result;
			else
				!!Result;
			end;
			Result.set_type (type);
			Result.set_arguments (arguments);
			Result.set_written_in (written_in);
			Result.set_rout_id_set (rout_id_set);
			Result.set_is_selected (is_selected);
			Result.set_is_infix (is_infix);
			Result.set_is_prefix (is_prefix);
			Result.set_is_frozen (is_frozen);
			Result.set_feature_name (feature_name);
			Result.set_feature_id (feature_id);
			Result.set_pattern_id (pattern_id);
			Result.set_is_require_else (is_require_else);
			Result.set_is_ensure_then (is_ensure_then);
			Result.set_export_status (export_status);
			Result.set_body_index (body_index);
		ensure
			Result_exists: Result /= Void;
			Result_is_deferred: Result.is_deferred;
		end;

	new_rout_id: INTEGER is
			-- New routine id
		do
			Result := Routine_id_counter.next;
		end;

	Routine_id_counter: COUNTER is
			-- Routine id counter
		once
			Result := System.routine_id_counter;
		end;

feature -- Replication

	code_id: INTEGER is
			-- Code id for inheritance analysis
		do
			Result := body_id;
		end;

	access_in: INTEGER is
			-- Id of the class where the current feature can be accessed
			-- through its routine id
			-- Useful for replication
		do
			Result := written_in;
		end;

	access_class: CLASS_C is
			-- Access class
		do
			Result := System.class_of_id (access_in);
		end;

	replicated: FEATURE_I is
			-- Replicated feature
		deferred
		ensure
			Result /= Void
		end;

	new_code_id: INTEGER is
			-- New code id
		do
			Result := System.body_id_counter.next
		end;

	unselected (in: INTEGER): FEATURE_I is
			-- Unselected feature
		deferred
		ensure
			Result_exists: Result /= Void;
		end;

	is_unselected: BOOLEAN is
			-- Is the current feature an unselected one ?
		do
			-- Do nothing
		end;

	transfer_to (other: FEATURE_I) is
			-- Transfer of datas from Current into `other'.
		require
			other_exists: other /= Void
		do
			other.set_body_index (body_index);
			other.set_export_status (export_status);
			other.set_feature_id (feature_id);
			other.set_feature_name (feature_name);
			other.set_is_frozen (is_frozen);
			other.set_is_infix (is_infix);
			other.set_is_prefix (is_prefix);
			other.set_is_selected (is_selected);
			other.set_pattern_id (pattern_id);
			other.set_rout_id_set (rout_id_set);
			other.set_written_in (written_in);
			other.set_is_origin (is_origin);
		end;

feature -- Genericity

	update_instantiator2 (a_class: CLASS_C) is
			-- Look for generic types in the result and arguments in order
			-- to update the instantiator.
		require
			good_argument: a_class /= Void;
			good_context: a_class.changed;
		local
			gen_type: GEN_TYPE_A;
			i, arg_count: INTEGER;
		do
			gen_type ?= type.actual_type;
			if gen_type /= Void then
					-- Found generic result type
				Instantiator.dispatch (gen_type, a_class);
			end;
			from
				i := 1;
				arg_count := argument_count;
			until
				i > arg_count
			loop	
				gen_type ?= arguments.i_th (i).actual_type;
				if gen_type /= Void then
						-- Found generic argument type
					Instantiator.dispatch (gen_type, a_class);
				end;
				i := i + 1;
			end;
		end;

feature -- Pattern

	pattern: PATTERN is
			-- Feature pattern
		do
			!!Result.make (type.actual_type.meta_type);
			if argument_count > 0 then
				Result.set_argument_types (arguments.pattern_types);
			end;
		end;

	process_pattern is
			-- Process pattern of Current feature
		do
			Pattern_table.insert (generation_class_id, pattern);
			pattern_id := Pattern_table.last_pattern_id;
		end;
			
feature -- Dead code removal

	used: BOOLEAN is
			-- Is the feature used ?
		do
					-- In final mode dead code removal process is on.
					-- In workbench mode all the features are considered
					-- used.
--			Result := 	byte_context.workbench_mode 
--						or else
--						System.is_used (Current)
			Result := True
		end;

feature -- Byte code access

	access (access_type: TYPE_I): ACCESS_B is
			-- Byte code access for current feature
		local
			feature_b: FEATURE_B;
		do
			!!feature_b;
			feature_b.init (Current);
			feature_b.set_type (access_type);
			Result := feature_b;
		ensure
			Result_exists: Result /= Void
		end;

feature -- C code generation

	generate (class_type: CLASS_TYPE; file: INDENT_FILE) is
			-- Generate feature written in `class_type' in `file'.
		require
			valid_file: file /= Void;
			file_open_for_writing: file.is_open_write or file.is_open_append;
			written_in_type: class_type.associated_class = written_class;
			not_deferred: not is_deferred;
		local
			byte_code: BYTE_CODE;
			result_type: TYPE_I;
			gen_type: GEN_TYPE_I;
		do
			if used then
				byte_code := Byte_server.disk_item (body_id);

				if byte_context.final_mode then
					if in_pass3 then
							-- Not a constant
						result_type := byte_code.result_type;
					else
							-- Constant: result type cannot be generic
						result_type := type.actual_type.type_i;
					end;
	
					if 	(result_type /= Void)
						and then
						result_type.has_formal
					then
						gen_type ?= class_type.type;
						result_type := result_type.instantiation_in (gen_type);
					end;
	
				end;

					-- Generation of C code for an Eiffel feature written in
					-- the associated class of the current type.
				byte_context.set_byte_code (byte_code);

					-- Generation of the C routine
				byte_code.analyze;
				byte_code.generate;
				byte_context.clear_all;

			end;
		end;

feature -- Debug purpose

	trace is
			-- Debug purpose
		local
			i: INTEGER
		do
			io.error.putstring ("feature name: ");
			io.error.putstring (feature_name);
			io.error.putchar (' ');
			rout_id_set.trace;
			io.error.putstring (" {");
			io.error.putstring ("body_id = ");
			io.error.putint (body_id);
			io.error.putstring ("}%N");;
		end;

	trace_signature is
			-- Trace signature of current feature
		local
			i, nb: INTEGER;
		do
			io.error.putstring (feature_name);
			from
				i := 1;
				nb := argument_count;
				io.error.putstring (" [");
			until
				i > nb
			loop
				arguments.i_th (i).trace;
				if i < nb then
					io.error.putstring (", ");
				end;
				i := i + 1;
			end;
			io.error.putstring ("]: ");
			type.trace;
		end; -- trace_signature

feature -- PS

	flat_names (target: CLASS_C; desc: FEATURE_AS): LINKED_LIST [STRING] is
			-- Flat name list of access id's found in
			-- abstract syntax description `desc' in the context of
			-- the target class `target'.
		require
			good_arguments: not (target = Void or desc = Void);
			good_target: target.conform_to (written_class);
		local
			rout_id: INTEGER;
			source: CLASS_C;
			flat_feature: FEATURE_I;
		do
				-- Initialization of the context
			source := written_class;
			Inst_context.set_cluster (source.cluster);
			rout_id := rout_id_set.first;
			if rout_id < 0 then
				rout_id := - rout_id;
			end;
			flat_feature := target.feature_table.origin_table.item (rout_id);
 
-- FIXME: add feature init_flat, clear3  in context and make_flat in FEATURE_AS
--			context.init_flat (source, target, Current, flat_feature);
--			desc.make_flat;
--			Result := context.flat_name_list;
				-- Clean context
--			context.clear3
		ensure
			Result_exists: Result /= Void
		end;

	signature: STRING is
			-- Signature of Current feature
		do
			!!Result.make (50);
			Result.append (feature_name);
			if arguments /= Void then
				Result.append (" (");
				from
					arguments.start
				until
					arguments.offright
				loop
					Result.append (arguments.argument_names.i_th (arguments.position));
					Result.append (": ");
					Result.append (arguments.item.actual_type.dump);
					arguments.forth;
					if not arguments.offright then
						Result.append (", ")
					end
				end;
				Result.append (")")
			end;
			if not type.is_void then
				Result.append (": ");
				Result.append (type.dump)
			end
		end;

feature -- Debugging

	debuggables: LINKED_LIST [DEBUGGABLE] is
			-- List of byte code arrays and associated
			-- information corresponding to Current
			-- FEATURE_I.
			--| The class in which the feature is
			--| written might be generic, debugable 
			--| information must thus be generated 
			--| for each possible instantiation.
		local
			type_list: LINKED_LIST [CLASS_TYPE]
		do
			!!Result.make;
			from
				type_list := written_class.types;
				type_list.start
			until
				type_list.after
			loop
				Result.add (debuggable (type_list.item));
				type_list.forth
			end
		end;

	debuggable (class_type: CLASS_TYPE): DEBUGGABLE is
			-- Debuggable byte code, real_body_index and
			-- real_body_id of version of current feature
			-- in `class_type'
		require
			class_type /= Void;
			--class_type.associated_class = written_class
		local
			du: DISPATCH_UNIT;
			eu: EXECUTION_UNIT;
			new_body_id: INTEGER;
			bc: BYTE_CODE;
			fa: FEATURE_AS
		do
			!!Result;

			-- Compute the real body index.
			!!du.make (class_type, Current);
			Dispatch_table.put (du);
				-- `put' has a side effect which
				-- `positions' last_unit; `du' 
				-- should aready be present in
				-- `Dispatch_table'.
			du := Dispatch_table.last_unit;
			Result.set_real_body_index (du.real_body_index);

			-- Compute the real body id.
			eu :=  du.execution_unit;
			if System.frozen_level < eu.real_body_id then
					-- The feature is already melted, the entry
					-- in the run time melted table can be reused.
				Result.set_real_body_id (eu.real_body_id)
			else
					-- The feature is frozen. Ask the execution
					-- table to generate a new body id.	
				new_body_id := Execution_table.debuggable_body_id;
				Result.set_real_body_id (new_body_id);
				Result.set_was_frozen
			end;

			-- Compute the list of breakable AST nodes
			-- (will be used when generating the byte
			-- code array). Specific to debug mode.
			fa := Body_server.item (body_id);
			Context.start_lines; -- Ast_context
			fa.find_breakable;

			-- Compute the debuggable byte code.
			Byte_context.init (class_type.type);
			Byte_context.set_class_type (class_type);

			-- Pass the instruction line generated in
			-- trhe AST context to the Byte_context.
			-- Specific to debug mode.
			Byte_context.set_instruction_line (context.instruction_line);

			bc := Byte_server.item (body_id);

			Byte_context.set_debug_mode (True);

			Byte_context.set_byte_code (bc);
			Byte_array.clear;
			bc.make_byte_code (Byte_array);
			Result.set_byte_code (Byte_array.character_array);
			Result.set_breakable_points (Byte_context.breakable_points);
			Byte_context.clear_all;
			Context.clear2
		end;

end
