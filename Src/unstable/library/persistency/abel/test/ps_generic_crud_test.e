note
	description: "Tests all CRUD operations on generic objects."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	PS_GENERIC_CRUD_TEST [G -> attached ANY]

inherit

	PS_TEST_PROVIDER

create
	make

feature {PS_CRUD_TESTS}

	test_insert (object: G)
			-- Tests an insert (and successive read) operation on `an_object'
		do
			test_insert_special_equality (object, agent standard_deep_equal)
		end

	test_insert_special_equality (object: G; equality_function: PREDICATE [ANY, TUPLE [G, G]])
			-- Tests an insert (and successive read) operation on `an_object'
			-- Use `equality_function' to test if `object' and the retrieved object from the database are equal.
		do
			executor.execute_insert (object)
			internal_check_equality (object, equality_function)
		end

	test_crud_operations (object: G; update_operation: PROCEDURE [ANY, TUPLE [G]])
			-- Tests all the CRUD operations on `object'
			-- An update on object is done with `update_operation'.
			-- In default reference graph depth settings, `update_operation' should only update `an_object' directly and not any referenced object.
		do
			test_crud_operations_special_equality (object, update_operation, agent standard_deep_equal)
		end

	test_crud_operations_special_equality (object: G; update_operation: PROCEDURE [ANY, TUPLE [G]]; equality_function: PREDICATE [ANY, TUPLE [G, G]])
			-- Tests all the CRUD operations on `object'
			-- An update on object is done with `update_operation'.
			-- In default reference graph depth settings, `update_operation' should only update `an_object' directly and not any referenced object.
			-- Use `equality_function' to test if `object' and the retrieved object from the database are equal.
		local
			first_count, second_count, third_count: INTEGER
		do
				-- Test successful insert
			executor.execute_insert (object)
			internal_check_equality (object, equality_function)
				-- Test successful update
			update_operation.call ([object])
			first_count := count_results
			executor.execute_update (object)
			second_count := count_results
			internal_check_equality (object, equality_function)
			assert ("Something has been deleted or inserted during an update", second_count = first_count)
				-- Test successful delete
			executor.execute_delete (object)
			third_count := count_results
				-- In a successful delete, all we can guarantee is that the third count is smaller than the second
			assert ("The object still exists in the database", second_count > third_count)
		end

	default_update_operation (an_object: G)
			-- A default operation that does nothing.
		do
		end

	count_results: INTEGER
			-- Count the number of results of objects of type G
		local
			query: PS_OBJECT_QUERY [G]
		do
			create query.make
			executor.execute_query (query)
			across
				query as q
			loop
				Result := Result + 1
			end
		end

feature {NONE}

	internal_check_equality (object: G; equality_test: PREDICATE [ANY, TUPLE [G, G]])
			-- See if any retrieved object from the database is equal to `object'
			-- Use `equality_test' to test on equality.
		local
			query: PS_OBJECT_QUERY [G]
			ref_list: LINKED_LIST [G]
			one_equal: BOOLEAN
		do
			create query.make
			executor.execute_query (query)
			assert ("The result is empty", not query.result_cursor.after)
				-- collect results - there may be many if an_object references other objects of type G
			create ref_list.make
			across
				query as cursor
			loop
				ref_list.extend (cursor.item)
			end
				-- See if one result is equal
			one_equal := across ref_list as cursor some equality_test.item ([cursor.item, object]) end
				--	across ref_list as cursor from print (object) loop print (cursor.item) end
			assert ("The results are not the same", one_equal)
		end

	standard_deep_equal (a, b: G): BOOLEAN
			-- The standard deep_equal feature from ANY
		do
			Result := deep_equal (a, b)
		end

end
