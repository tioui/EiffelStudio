indexing
	description: "ICorElementTypes constants"
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	EIFNET_ICOR_ELEMENT_TYPES

inherit
	MD_SIGNATURE_CONSTANTS

feature -- Access

	cor_element_type_to_string (a_id: INTEGER): STRING is
		do
			inspect a_id
 				when Element_type_array then
					Result := "array"
 				when Element_type_boolean then
					Result := "boolean"
 				when Element_type_byref then
					Result := "byref"
 				when Element_type_char then
					Result := "char"
 				when Element_type_class then
					Result := "class"
 				when Element_type_cmod_opt then
					Result := "cmod_opt"
 				when Element_type_cmod_reqd then
					Result := "cmod_reqd"
 				when Element_type_end then
					Result := "end"
 				when Element_type_fnptr then
					Result := "fnptr"
 				when Element_type_i then
					Result := "i:"
 				when Element_type_i1 then
					Result := "i1"
 				when Element_type_i2 then
					Result := "i2"
 				when Element_type_i4 then
					Result := "i4"
 				when Element_type_i8 then
					Result := "i8"
 				when Element_type_internal then
					Result := "internal"
 				when Element_type_max then
					Result := "max"
 				when Element_type_modifier then
					Result := "modifier"
 				when Element_type_object then
					Result := "object"
 				when Element_type_ptr then
					Result := "ptr"
 				when Element_type_r4 then
					Result := "r4"
 				when Element_type_r8 then
					Result := "r8"
 				when Element_type_string then
					Result := "string"
 				when Element_type_szarray then
					Result := "szarray"
 				when Element_type_typedbyref then
					Result := "typedbyref"
 				when Element_type_u then
					Result := "u:"
 				when Element_type_u1 then
					Result := "u1|pinned"
 				when Element_type_u2 then
					Result := "u2"
 				when Element_type_u4 then
					Result := "u4"
 				when Element_type_u8 then
					Result := "u8"
 				when Element_type_valuetype then
					Result := "valuetype"
 				when Element_type_void then
					Result := "void|sentinel"
				else
					Result := "?"
			end
		end
		
feature
	
	cor_element_type_valid (a_id: INTEGER): BOOLEAN is
		do
			inspect a_id
 				when 
 					Element_type_array,
	 				Element_type_boolean,
	 				Element_type_byref,
	 				Element_type_char,
	 				Element_type_class,
	 				Element_type_cmod_opt,
	 				Element_type_cmod_reqd,
	 				Element_type_end,
	 				Element_type_fnptr,
	 				Element_type_i,
	 				Element_type_i1,
 					Element_type_i2,
 					Element_type_i4,
 					Element_type_i8,
 					Element_type_internal,
 					Element_type_max,
 					Element_type_modifier,
 					Element_type_object,
 					Element_type_ptr,
 					Element_type_r4,
 					Element_type_r8,
 					Element_type_string,
 					Element_type_szarray,
 					Element_type_typedbyref,
 					Element_type_u,
 					Element_type_u1,
 					Element_type_u2,
 					Element_type_u4,
 					Element_type_u8,
 					Element_type_valuetype,
 					Element_type_void
 				then
					Result := True
				else
					Result := False
			end
		end		



end -- class EIFNET_ICOR_ELEMENT_TYPES
