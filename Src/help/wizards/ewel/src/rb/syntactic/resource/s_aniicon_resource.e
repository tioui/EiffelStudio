indexing
	description: "xxx"
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"

--  Aniicon_resource -> "ANIICON" Load_and_mem filename

class S_ANIICON_RESOURCE

inherit
	RB_AGGREGATE

feature 

	construct_name: STRING is
		once
			Result := "ANIICON_RESOURCE"
		end

	production: LINKED_LIST [CONSTRUCT] is
		local
			load_and_mem: LOAD_AND_MEM
			filename: IDENTIFIER
		once
			!! Result.make
			Result.forth

			keyword ("ANIICON")
			commit

			!! load_and_mem.make
			put (load_and_mem)

			!! filename.make
			put (filename)
		end

end -- class S_ANIICON_RESOURCE

--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------
