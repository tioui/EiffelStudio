indexing
	description: "System's root class";
	note: "Initial version automatically generated"

class
	ROOT_CLASS

inherit

	SHARED_JNI_ENVIRONMENT

creation
	make

feature -- Creation

	make is
		local
			class_test: JAVA_CLASS
			instance_of_class_test: JAVA_OBJECT
			fid: POINTER
			value: INTEGER
			j_args: JAVA_ARGS
		do
				--| Creation of the Java object
			class_test := jni.find_class ("test")
			create instance_of_class_test.create_instance (class_test, "()V", Void)
				
				--| Access to a public attribute
				-- 'fid' contains the id of the field 'my_integer'
			fid := instance_of_class_test.field_id ("my_integer", "I")
				-- 'value' contains the value of the field referenced by 'fid'
			value := instance_of_class_test.integer_attribute (fid)

				--| Access to a static attribute using directly the JAVA_CLASS
			fid := class_test.field_id ("my_static_integer", "I")
			value := class_test.integer_attribute (fid)

				--| Access to a static attribute using the attribute 'jclass'
			value := instance_of_class_test.integer_attribute (fid)

				--| Access to the method 'my_method'
				-- Get the id of 'my_method'
			fid := instance_of_class_test.method_id ("my_method", "(ILjava/lang/String;)V")

				-- Create the set of arguments for 'my_method'
			create j_args.make(2)
			j_args.push_int (2)
			j_args.push_string("String test")

				-- Call to the void method referenced by 'fid'
			instance_of_class_test.void_method (fid, j_args)

			fid := instance_of_class_test.field_id ("my_integer", "I")
				-- 'value' contains the value of the field referenced by 'fid'
			value := instance_of_class_test.integer_attribute (fid)
		end -- make

end -- class ROOT_CLASS
