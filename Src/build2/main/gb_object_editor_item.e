indexing
	description: "Objects that allow modification of attributes. For%
		% insertion into a GB_OBJECT_EDITOR."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_OBJECT_EDITOR_ITEM

inherit
	EV_VERTICAL_BOX

create
	make_with_components

feature {NONE} -- Initialization

	components: GB_INTERNAL_COMPONENTS
		-- Access to a set of internal components for an EiffelBuild instance.

	make_with_components (a_components: GB_INTERNAL_COMPONENTS) is
			-- Create `Current' and assign `a_components' to `components'.
		require
			a_components_not_void: a_components /= Void
		do
			components := a_components
			default_create
		ensure
			components_set: components = a_components
		end

feature -- Access

	update_for_child_addition: BOOLEAN
		-- must `Current be updated when a child
		-- has been added?

	type_represented: STRING
		-- Type of object represented and
		-- modifyable by `Current'.
		-- i.e. EV_SENSITIVE, EV_BUTTON etc.

	creating_class: GB_EV_ANY
		-- `Result' is class that created `Current'.

feature -- Status Setting

	enable_update_for_child_addition is
			-- Assign `True' to `update_for_child_addition'.
		do
			update_for_child_addition := True
		end

	set_type_represented (a_type: STRING) is
			-- Assign `a_type' to `type'.
		require
			type_not_void: a_type /= Void
		do
			type_represented := a_type
		ensure
			type_represented.is_equal (a_type)
		end

	set_creating_class (a_class: GB_EV_ANY) is
			-- Assign `a_class' to `creating_class'.
		do
			creating_class := a_class
		end


end -- class GB_OBJECT_EDITOR_ITEM
