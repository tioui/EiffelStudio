indexing
	description: "Objects that ..."
	author: "Mark Howard, AxaRosenberg"
	date: "$Date$"
	revision: "$Revision$"

class
	FAST_COMPILE

creation
	make

feature 

	make (a_arguments: ARRAY[STRING]) is
		do
			if a_arguments.count > 2 then
				create top_directory.make(a_arguments.item(1), a_arguments.item (2), True)
				top_directory.convert
			else
				print_usage
			end
		end

	top_directory : EIFFEL_F_CODE_DIRECTORY

feature {NONE} -- Implementation

	print_usage is
			-- Print the usage of `quick_finalize'.
		do
			io.putstring ("Usage: quick_finalize path object_extension%N")
			io.putstring ("%Tpath: path to your F_code directory generated by EiffelStudio%N")
			io.putstring ("%Tobject_extension: either obj or o depending on the plaform%N")
		end

end
   
