indexing
	description: "Objects that can build a new GB_OBJECT based purely on an xml_element"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_XML_OBJECT_BUILDER
	
inherit
	
	GB_SHARED_OBJECT_HANDLER
		export
			{NONE} all
		end
	
	GB_SHARED_DEFERRED_BUILDER
		export
			{NONE} all
		end
	
	GB_CONSTANTS
		export
			{NONE} all
		end
	
	INTERNAL
		export
			{NONE} all
		end

feature -- Access
	new_object (element: XML_ELEMENT; is_component: BOOLEAN): GB_OBJECT is
			-- `Result' is an object generated from `xml_element'.
			-- This object has no parent, is not included in the
			-- objects list and has all representations built.
		require
			element_not_void: element /= Void
		local
			a_new_object: GB_OBJECT
			current_element: XML_ELEMENT
			current_name: STRING
			gb_ev_any: GB_EV_ANY
			display_object: GB_DISPLAY_OBJECT
			xml_element: XML_ELEMENT
		do
			xml_element ?= element.first	
			
			a_new_object := object_handler.build_object_from_string (xml_element.attribute_by_name (type_string).value.to_utf8)
			object_handler.build_object (a_new_object)
			from
				xml_element.start
			until
				xml_element.off
			loop
				current_element ?= xml_element.item_for_iteration
				if current_element /= Void then
					current_name := current_element.name.to_utf8
					if current_name.is_equal (Item_string) then
						-- Add the new objects as children.
						build_new_object (current_element, a_new_object, is_component)
						
					else
						if current_name.is_equal (Internal_properties_string) or
							current_name.is_equal (Events_string) then
							-- I do not think we have to do anything when we find the internal properties
							-- currently just a name, and as this is used for components, no name should be 
							-- applied.
							-- | FIXME, we do need to connect the events though.
						else	
							gb_ev_any ?= new_instance_of (dynamic_type_from_string ("GB_" + current_name))
						
							-- Call default_create on `gb_ev_any'
							gb_ev_any.default_create
						
							-- Ensure that the new class exists.
						check
							new_instance_exists: gb_ev_any /= Void
						end

						gb_ev_any.add_object (a_new_object.object)
						display_object ?= a_new_object.display_object
						if display_object = Void then
							gb_ev_any.add_object (a_new_object.display_object)
						else
							gb_ev_any.add_object (display_object.child)
						end
						
							-- Call `modify_from_xml' which should modify the objects.
						gb_ev_any.modify_from_xml (current_element)
						
						end
					end
				end
				xml_element.forth
			end
				-- If we were just building a component, then
				-- there should be no deferred building routines.
			if is_component then
				deferred_builder.clear_deferred
			end
			Result := a_new_object
		end
		

	build_new_object (element: XML_ELEMENT; object: GB_OBJECT; is_component: BOOLEAN) is
			-- Build a new object from information in `element'.
		require
			element_not_void: element /= Void
			element_type_is_item: element.name.to_utf8.is_equal (Item_string)
		local
			a_new_object: GB_OBJECT
			current_element: XML_ELEMENT
			gb_ev_any: GB_EV_ANY
			current_name: STRING
			display_object: GB_DISPLAY_OBJECT
		do
			a_new_object := object_handler.build_object_from_string (element.attribute_by_name (type_string).value.to_utf8)
			
			object_handler.add_object (object, a_new_object, object.layout_item.count + 1)
			from
				element.start
			until
				element.off
			loop
				current_element ?= element.item_for_iteration
				if current_element /= Void then
					current_name := current_element.name.to_utf8
					if current_name.is_equal (Item_string) then
						-- The element represents an item, so we must add new objects.
						build_new_object (current_element, a_new_object, is_component)
					else
						-- We must check for internal properties, else set the properties of the component
						if current_name.is_equal (Internal_properties_string) or current_name.is_equal (Events_string) then
							-- No internal properties are used. i.e. no name is assigned.
						else
						
							-- Create the class.
						gb_ev_any ?= new_instance_of (dynamic_type_from_string ("GB_" + current_name))
						
							-- Call default_create on `gb_ev_any'
						gb_ev_any.default_create
						
							-- Ensure that the new class exists.
						check
							new_instance_exists: gb_ev_any /= Void
						end

						gb_ev_any.add_object (a_new_object.object)			
						display_object ?= a_new_object.display_object
						if display_object = Void then
							gb_ev_any.add_object (a_new_object.display_object)
						else
							gb_ev_any.add_object (display_object.child)
						end

							-- Call `modify_from_xml' which should modify the objects.
						gb_ev_any.modify_from_xml (current_element)
						end
					end
				end
				element.forth
			end
		end
		

end -- class GB_XML_OBJECT_BUILDER
