-- This file has been generated by EWG. Do not edit. Changes will be lost!

class OPAQUE_MOUSE_TRACKING_REF_STRUCT

inherit

	EWG_STRUCT

	OPAQUE_MOUSE_TRACKING_REF_STRUCT_EXTERNAL
		export
			{NONE} all
		end

create

	make_new_unshared,
	make_new_shared,
	make_unshared,
	make_shared

feature {ANY} -- Access

	sizeof: INTEGER is
		do
			Result := sizeof_external
		end

feature {ANY} -- Member Access

end
