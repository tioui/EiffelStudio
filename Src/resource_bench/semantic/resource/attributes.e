indexing
	description: "xxx"
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"
-- Attributes

class
	ATTRIBUTES

inherit
	S_ATTRIBUTES
		redefine
			action
		end

	TABLE_OF_SYMBOLS
		undefine
			is_equal, copy
		end

creation
	make

feature

	action is
		do
			tds.current_resource.load_and_mem_attributes.extend (token.string_value.twin)
		end

end -- class ATTRIBUTES

--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------
