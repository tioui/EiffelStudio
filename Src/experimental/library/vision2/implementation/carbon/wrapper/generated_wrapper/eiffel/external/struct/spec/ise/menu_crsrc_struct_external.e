-- This file has been generated by EWG. Do not edit. Changes will be lost!
-- wrapper for struct: struct MenuCRsrc

class MENU_CRSRC_STRUCT_EXTERNAL

feature {NONE} -- Implementation

	sizeof_external: INTEGER is
		external
			"C [macro <Carbon/Carbon.h>]: EIF_INTEGER"
		alias
			"sizeof(struct MenuCRsrc)"
		end

	get_numentries_external (an_item: POINTER): INTEGER is
		require
			an_item_not_null: an_item /= default_pointer
		external
			"C [macro <ewg_carbon_struct_c_glue_code.h>]"
		alias
			"ewg_struct_macro_struct_MenuCRsrc_member_get_numEntries"
		end

	set_numentries_external (an_item: POINTER; a_value: INTEGER) is
		require
			an_item_not_null: an_item /= default_pointer
		external
			"C [macro <ewg_carbon_struct_c_glue_code.h>]"
		alias
			"ewg_struct_macro_struct_MenuCRsrc_member_set_numEntries"
		ensure
			a_value_set: a_value = get_numentries_external (an_item)
		end

	get_mcentryrecs_external (an_item: POINTER): POINTER is
		require
			an_item_not_null: an_item /= default_pointer
		external
			"C [macro <ewg_carbon_struct_c_glue_code.h>]"
		alias
			"ewg_struct_macro_struct_MenuCRsrc_member_get_mcEntryRecs"
		end

end

