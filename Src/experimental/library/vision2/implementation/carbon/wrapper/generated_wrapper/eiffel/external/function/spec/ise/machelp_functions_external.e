-- This file has been generated by EWG. Do not edit. Changes will be lost!
-- functions wrapper
class MACHELP_FUNCTIONS_EXTERNAL

feature
	frozen new_hmcontrol_content_upp_external (userroutine: POINTER): POINTER is
		external
			"C [macro <ewg_carbon_function_c_glue_code.h>] (HMControlContentProcPtr):HMControlContentUPP"
		alias
			"ewg_function_macro_NewHMControlContentUPP"
		end

	frozen new_hmcontrol_content_upp_address_external: POINTER is
			-- Address of C function `NewHMControlContentUPP'
		external
			"C [macro <Carbon/Carbon.h>]: void*"
		alias
			"(void*) NewHMControlContentUPP"
		end

	frozen new_hmwindow_content_upp_external (userroutine: POINTER): POINTER is
		external
			"C [macro <ewg_carbon_function_c_glue_code.h>] (HMWindowContentProcPtr):HMWindowContentUPP"
		alias
			"ewg_function_macro_NewHMWindowContentUPP"
		end

	frozen new_hmwindow_content_upp_address_external: POINTER is
			-- Address of C function `NewHMWindowContentUPP'
		external
			"C [macro <Carbon/Carbon.h>]: void*"
		alias
			"(void*) NewHMWindowContentUPP"
		end

	frozen new_hmmenu_title_content_upp_external (userroutine: POINTER): POINTER is
		external
			"C [macro <ewg_carbon_function_c_glue_code.h>] (HMMenuTitleContentProcPtr):HMMenuTitleContentUPP"
		alias
			"ewg_function_macro_NewHMMenuTitleContentUPP"
		end

	frozen new_hmmenu_title_content_upp_address_external: POINTER is
			-- Address of C function `NewHMMenuTitleContentUPP'
		external
			"C [macro <Carbon/Carbon.h>]: void*"
		alias
			"(void*) NewHMMenuTitleContentUPP"
		end

	frozen new_hmmenu_item_content_upp_external (userroutine: POINTER): POINTER is
		external
			"C [macro <ewg_carbon_function_c_glue_code.h>] (HMMenuItemContentProcPtr):HMMenuItemContentUPP"
		alias
			"ewg_function_macro_NewHMMenuItemContentUPP"
		end

	frozen new_hmmenu_item_content_upp_address_external: POINTER is
			-- Address of C function `NewHMMenuItemContentUPP'
		external
			"C [macro <Carbon/Carbon.h>]: void*"
		alias
			"(void*) NewHMMenuItemContentUPP"
		end

	frozen dispose_hmcontrol_content_upp_external (userupp: POINTER) is
		external
			"C [macro <ewg_carbon_function_c_glue_code.h>] (HMControlContentUPP)"
		alias
			"ewg_function_macro_DisposeHMControlContentUPP"
		end

	frozen dispose_hmcontrol_content_upp_address_external: POINTER is
			-- Address of C function `DisposeHMControlContentUPP'
		external
			"C [macro <Carbon/Carbon.h>]: void*"
		alias
			"(void*) DisposeHMControlContentUPP"
		end

	frozen dispose_hmwindow_content_upp_external (userupp: POINTER) is
		external
			"C [macro <ewg_carbon_function_c_glue_code.h>] (HMWindowContentUPP)"
		alias
			"ewg_function_macro_DisposeHMWindowContentUPP"
		end

	frozen dispose_hmwindow_content_upp_address_external: POINTER is
			-- Address of C function `DisposeHMWindowContentUPP'
		external
			"C [macro <Carbon/Carbon.h>]: void*"
		alias
			"(void*) DisposeHMWindowContentUPP"
		end

	frozen dispose_hmmenu_title_content_upp_external (userupp: POINTER) is
		external
			"C [macro <ewg_carbon_function_c_glue_code.h>] (HMMenuTitleContentUPP)"
		alias
			"ewg_function_macro_DisposeHMMenuTitleContentUPP"
		end

	frozen dispose_hmmenu_title_content_upp_address_external: POINTER is
			-- Address of C function `DisposeHMMenuTitleContentUPP'
		external
			"C [macro <Carbon/Carbon.h>]: void*"
		alias
			"(void*) DisposeHMMenuTitleContentUPP"
		end

	frozen dispose_hmmenu_item_content_upp_external (userupp: POINTER) is
		external
			"C [macro <ewg_carbon_function_c_glue_code.h>] (HMMenuItemContentUPP)"
		alias
			"ewg_function_macro_DisposeHMMenuItemContentUPP"
		end

	frozen dispose_hmmenu_item_content_upp_address_external: POINTER is
			-- Address of C function `DisposeHMMenuItemContentUPP'
		external
			"C [macro <Carbon/Carbon.h>]: void*"
		alias
			"(void*) DisposeHMMenuItemContentUPP"
		end

	frozen invoke_hmcontrol_content_upp_external (incontrol: POINTER; inglobalmouse: POINTER; inrequest: INTEGER; outcontentprovided: POINTER; iohelpcontent: POINTER; userupp: POINTER): INTEGER is
		external
			"C [macro <ewg_carbon_function_c_glue_code.h>] (ControlRef, Point*, HMContentRequest, HMContentProvidedType*, HMHelpContentPtr, HMControlContentUPP):OSStatus"
		alias
			"ewg_function_macro_InvokeHMControlContentUPP"
		end

	frozen invoke_hmcontrol_content_upp_address_external: POINTER is
			-- Address of C function `InvokeHMControlContentUPP'
		external
			"C [macro <Carbon/Carbon.h>]: void*"
		alias
			"(void*) InvokeHMControlContentUPP"
		end

	frozen invoke_hmwindow_content_upp_external (inwindow: POINTER; inglobalmouse: POINTER; inrequest: INTEGER; outcontentprovided: POINTER; iohelpcontent: POINTER; userupp: POINTER): INTEGER is
		external
			"C [macro <ewg_carbon_function_c_glue_code.h>] (WindowRef, Point*, HMContentRequest, HMContentProvidedType*, HMHelpContentPtr, HMWindowContentUPP):OSStatus"
		alias
			"ewg_function_macro_InvokeHMWindowContentUPP"
		end

	frozen invoke_hmwindow_content_upp_address_external: POINTER is
			-- Address of C function `InvokeHMWindowContentUPP'
		external
			"C [macro <Carbon/Carbon.h>]: void*"
		alias
			"(void*) InvokeHMWindowContentUPP"
		end

	frozen invoke_hmmenu_title_content_upp_external (inmenu: POINTER; inrequest: INTEGER; outcontentprovided: POINTER; iohelpcontent: POINTER; userupp: POINTER): INTEGER is
		external
			"C [macro <ewg_carbon_function_c_glue_code.h>] (MenuRef, HMContentRequest, HMContentProvidedType*, HMHelpContentPtr, HMMenuTitleContentUPP):OSStatus"
		alias
			"ewg_function_macro_InvokeHMMenuTitleContentUPP"
		end

	frozen invoke_hmmenu_title_content_upp_address_external: POINTER is
			-- Address of C function `InvokeHMMenuTitleContentUPP'
		external
			"C [macro <Carbon/Carbon.h>]: void*"
		alias
			"(void*) InvokeHMMenuTitleContentUPP"
		end

	frozen invoke_hmmenu_item_content_upp_external (intrackingdata: POINTER; inrequest: INTEGER; outcontentprovided: POINTER; iohelpcontent: POINTER; userupp: POINTER): INTEGER is
		external
			"C [macro <ewg_carbon_function_c_glue_code.h>] (MenuTrackingData const*, HMContentRequest, HMContentProvidedType*, HMHelpContentPtr, HMMenuItemContentUPP):OSStatus"
		alias
			"ewg_function_macro_InvokeHMMenuItemContentUPP"
		end

	frozen invoke_hmmenu_item_content_upp_address_external: POINTER is
			-- Address of C function `InvokeHMMenuItemContentUPP'
		external
			"C [macro <Carbon/Carbon.h>]: void*"
		alias
			"(void*) InvokeHMMenuItemContentUPP"
		end

	frozen hmget_help_menu_external (outhelpmenu: POINTER; outfirstcustomitemindex: POINTER): INTEGER is
		external
			"C [macro <ewg_carbon_function_c_glue_code.h>] (MenuRef*, MenuItemIndex*):OSStatus"
		alias
			"ewg_function_macro_HMGetHelpMenu"
		end

	frozen hmget_help_menu_address_external: POINTER is
			-- Address of C function `HMGetHelpMenu'
		external
			"C [macro <Carbon/Carbon.h>]: void*"
		alias
			"(void*) HMGetHelpMenu"
		end

	frozen hmset_control_help_content_external (incontrol: POINTER; incontent: POINTER): INTEGER is
		external
			"C [macro <ewg_carbon_function_c_glue_code.h>] (ControlRef, HMHelpContentRec const*):OSStatus"
		alias
			"ewg_function_macro_HMSetControlHelpContent"
		end

	frozen hmset_control_help_content_address_external: POINTER is
			-- Address of C function `HMSetControlHelpContent'
		external
			"C [macro <Carbon/Carbon.h>]: void*"
		alias
			"(void*) HMSetControlHelpContent"
		end

	frozen hmget_control_help_content_external (incontrol: POINTER; outcontent: POINTER): INTEGER is
		external
			"C [macro <ewg_carbon_function_c_glue_code.h>] (ControlRef, HMHelpContentRec*):OSStatus"
		alias
			"ewg_function_macro_HMGetControlHelpContent"
		end

	frozen hmget_control_help_content_address_external: POINTER is
			-- Address of C function `HMGetControlHelpContent'
		external
			"C [macro <Carbon/Carbon.h>]: void*"
		alias
			"(void*) HMGetControlHelpContent"
		end

	frozen hmset_window_help_content_external (inwindow: POINTER; incontent: POINTER): INTEGER is
		external
			"C [macro <ewg_carbon_function_c_glue_code.h>] (WindowRef, HMHelpContentRec const*):OSStatus"
		alias
			"ewg_function_macro_HMSetWindowHelpContent"
		end

	frozen hmset_window_help_content_address_external: POINTER is
			-- Address of C function `HMSetWindowHelpContent'
		external
			"C [macro <Carbon/Carbon.h>]: void*"
		alias
			"(void*) HMSetWindowHelpContent"
		end

	frozen hmget_window_help_content_external (inwindow: POINTER; outcontent: POINTER): INTEGER is
		external
			"C [macro <ewg_carbon_function_c_glue_code.h>] (WindowRef, HMHelpContentRec*):OSStatus"
		alias
			"ewg_function_macro_HMGetWindowHelpContent"
		end

	frozen hmget_window_help_content_address_external: POINTER is
			-- Address of C function `HMGetWindowHelpContent'
		external
			"C [macro <Carbon/Carbon.h>]: void*"
		alias
			"(void*) HMGetWindowHelpContent"
		end

	frozen hmset_menu_item_help_content_external (inmenu: POINTER; initem: INTEGER; incontent: POINTER): INTEGER is
		external
			"C [macro <ewg_carbon_function_c_glue_code.h>] (MenuRef, MenuItemIndex, HMHelpContentRec const*):OSStatus"
		alias
			"ewg_function_macro_HMSetMenuItemHelpContent"
		end

	frozen hmset_menu_item_help_content_address_external: POINTER is
			-- Address of C function `HMSetMenuItemHelpContent'
		external
			"C [macro <Carbon/Carbon.h>]: void*"
		alias
			"(void*) HMSetMenuItemHelpContent"
		end

	frozen hmget_menu_item_help_content_external (inmenu: POINTER; initem: INTEGER; outcontent: POINTER): INTEGER is
		external
			"C [macro <ewg_carbon_function_c_glue_code.h>] (MenuRef, MenuItemIndex, HMHelpContentRec*):OSStatus"
		alias
			"ewg_function_macro_HMGetMenuItemHelpContent"
		end

	frozen hmget_menu_item_help_content_address_external: POINTER is
			-- Address of C function `HMGetMenuItemHelpContent'
		external
			"C [macro <Carbon/Carbon.h>]: void*"
		alias
			"(void*) HMGetMenuItemHelpContent"
		end

	frozen hminstall_control_content_callback_external (incontrol: POINTER; incontentupp: POINTER): INTEGER is
		external
			"C [macro <ewg_carbon_function_c_glue_code.h>] (ControlRef, HMControlContentUPP):OSStatus"
		alias
			"ewg_function_macro_HMInstallControlContentCallback"
		end

	frozen hminstall_control_content_callback_address_external: POINTER is
			-- Address of C function `HMInstallControlContentCallback'
		external
			"C [macro <Carbon/Carbon.h>]: void*"
		alias
			"(void*) HMInstallControlContentCallback"
		end

	frozen hminstall_window_content_callback_external (inwindow: POINTER; incontentupp: POINTER): INTEGER is
		external
			"C [macro <ewg_carbon_function_c_glue_code.h>] (WindowRef, HMWindowContentUPP):OSStatus"
		alias
			"ewg_function_macro_HMInstallWindowContentCallback"
		end

	frozen hminstall_window_content_callback_address_external: POINTER is
			-- Address of C function `HMInstallWindowContentCallback'
		external
			"C [macro <Carbon/Carbon.h>]: void*"
		alias
			"(void*) HMInstallWindowContentCallback"
		end

	frozen hminstall_menu_title_content_callback_external (inmenu: POINTER; incontentupp: POINTER): INTEGER is
		external
			"C [macro <ewg_carbon_function_c_glue_code.h>] (MenuRef, HMMenuTitleContentUPP):OSStatus"
		alias
			"ewg_function_macro_HMInstallMenuTitleContentCallback"
		end

	frozen hminstall_menu_title_content_callback_address_external: POINTER is
			-- Address of C function `HMInstallMenuTitleContentCallback'
		external
			"C [macro <Carbon/Carbon.h>]: void*"
		alias
			"(void*) HMInstallMenuTitleContentCallback"
		end

	frozen hminstall_menu_item_content_callback_external (inmenu: POINTER; incontentupp: POINTER): INTEGER is
		external
			"C [macro <ewg_carbon_function_c_glue_code.h>] (MenuRef, HMMenuItemContentUPP):OSStatus"
		alias
			"ewg_function_macro_HMInstallMenuItemContentCallback"
		end

	frozen hminstall_menu_item_content_callback_address_external: POINTER is
			-- Address of C function `HMInstallMenuItemContentCallback'
		external
			"C [macro <Carbon/Carbon.h>]: void*"
		alias
			"(void*) HMInstallMenuItemContentCallback"
		end

	frozen hmget_control_content_callback_external (incontrol: POINTER; outcontentupp: POINTER): INTEGER is
		external
			"C [macro <ewg_carbon_function_c_glue_code.h>] (ControlRef, HMControlContentUPP*):OSStatus"
		alias
			"ewg_function_macro_HMGetControlContentCallback"
		end

	frozen hmget_control_content_callback_address_external: POINTER is
			-- Address of C function `HMGetControlContentCallback'
		external
			"C [macro <Carbon/Carbon.h>]: void*"
		alias
			"(void*) HMGetControlContentCallback"
		end

	frozen hmget_window_content_callback_external (inwindow: POINTER; outcontentupp: POINTER): INTEGER is
		external
			"C [macro <ewg_carbon_function_c_glue_code.h>] (WindowRef, HMWindowContentUPP*):OSStatus"
		alias
			"ewg_function_macro_HMGetWindowContentCallback"
		end

	frozen hmget_window_content_callback_address_external: POINTER is
			-- Address of C function `HMGetWindowContentCallback'
		external
			"C [macro <Carbon/Carbon.h>]: void*"
		alias
			"(void*) HMGetWindowContentCallback"
		end

	frozen hmget_menu_title_content_callback_external (inmenu: POINTER; outcontentupp: POINTER): INTEGER is
		external
			"C [macro <ewg_carbon_function_c_glue_code.h>] (MenuRef, HMMenuTitleContentUPP*):OSStatus"
		alias
			"ewg_function_macro_HMGetMenuTitleContentCallback"
		end

	frozen hmget_menu_title_content_callback_address_external: POINTER is
			-- Address of C function `HMGetMenuTitleContentCallback'
		external
			"C [macro <Carbon/Carbon.h>]: void*"
		alias
			"(void*) HMGetMenuTitleContentCallback"
		end

	frozen hmget_menu_item_content_callback_external (inmenu: POINTER; outcontentupp: POINTER): INTEGER is
		external
			"C [macro <ewg_carbon_function_c_glue_code.h>] (MenuRef, HMMenuItemContentUPP*):OSStatus"
		alias
			"ewg_function_macro_HMGetMenuItemContentCallback"
		end

	frozen hmget_menu_item_content_callback_address_external: POINTER is
			-- Address of C function `HMGetMenuItemContentCallback'
		external
			"C [macro <Carbon/Carbon.h>]: void*"
		alias
			"(void*) HMGetMenuItemContentCallback"
		end

	frozen hmare_help_tags_displayed_external: INTEGER is
		external
			"C [macro <ewg_carbon_function_c_glue_code.h>] :Boolean"
		alias
			"ewg_function_macro_HMAreHelpTagsDisplayed"
		end

	frozen hmare_help_tags_displayed_address_external: POINTER is
			-- Address of C function `HMAreHelpTagsDisplayed'
		external
			"C [macro <Carbon/Carbon.h>]: void*"
		alias
			"(void*) HMAreHelpTagsDisplayed"
		end

	frozen hmset_help_tags_displayed_external (indisplaytags: INTEGER): INTEGER is
		external
			"C [macro <ewg_carbon_function_c_glue_code.h>] (Boolean):OSStatus"
		alias
			"ewg_function_macro_HMSetHelpTagsDisplayed"
		end

	frozen hmset_help_tags_displayed_address_external: POINTER is
			-- Address of C function `HMSetHelpTagsDisplayed'
		external
			"C [macro <Carbon/Carbon.h>]: void*"
		alias
			"(void*) HMSetHelpTagsDisplayed"
		end

	frozen hmset_tag_delay_external (indelay: INTEGER): INTEGER is
		external
			"C [macro <ewg_carbon_function_c_glue_code.h>] (Duration):OSStatus"
		alias
			"ewg_function_macro_HMSetTagDelay"
		end

	frozen hmset_tag_delay_address_external: POINTER is
			-- Address of C function `HMSetTagDelay'
		external
			"C [macro <Carbon/Carbon.h>]: void*"
		alias
			"(void*) HMSetTagDelay"
		end

	frozen hmget_tag_delay_external (outdelay: POINTER): INTEGER is
		external
			"C [macro <ewg_carbon_function_c_glue_code.h>] (Duration*):OSStatus"
		alias
			"ewg_function_macro_HMGetTagDelay"
		end

	frozen hmget_tag_delay_address_external: POINTER is
			-- Address of C function `HMGetTagDelay'
		external
			"C [macro <Carbon/Carbon.h>]: void*"
		alias
			"(void*) HMGetTagDelay"
		end

	frozen hmset_menu_help_from_balloon_rsrc_external (inmenu: POINTER; inhmnursrcid: INTEGER): INTEGER is
		external
			"C [macro <ewg_carbon_function_c_glue_code.h>] (MenuRef, SInt16):OSStatus"
		alias
			"ewg_function_macro_HMSetMenuHelpFromBalloonRsrc"
		end

	frozen hmset_menu_help_from_balloon_rsrc_address_external: POINTER is
			-- Address of C function `HMSetMenuHelpFromBalloonRsrc'
		external
			"C [macro <Carbon/Carbon.h>]: void*"
		alias
			"(void*) HMSetMenuHelpFromBalloonRsrc"
		end

	frozen hmset_dialog_help_from_balloon_rsrc_external (indialog: POINTER; inhdlgrsrcid: INTEGER; initemstart: INTEGER): INTEGER is
		external
			"C [macro <ewg_carbon_function_c_glue_code.h>] (DialogRef, SInt16, SInt16):OSStatus"
		alias
			"ewg_function_macro_HMSetDialogHelpFromBalloonRsrc"
		end

	frozen hmset_dialog_help_from_balloon_rsrc_address_external: POINTER is
			-- Address of C function `HMSetDialogHelpFromBalloonRsrc'
		external
			"C [macro <Carbon/Carbon.h>]: void*"
		alias
			"(void*) HMSetDialogHelpFromBalloonRsrc"
		end

	frozen hmdisplay_tag_external (incontent: POINTER): INTEGER is
		external
			"C [macro <ewg_carbon_function_c_glue_code.h>] (HMHelpContentRec const*):OSStatus"
		alias
			"ewg_function_macro_HMDisplayTag"
		end

	frozen hmdisplay_tag_address_external: POINTER is
			-- Address of C function `HMDisplayTag'
		external
			"C [macro <Carbon/Carbon.h>]: void*"
		alias
			"(void*) HMDisplayTag"
		end

	frozen hmhide_tag_external: INTEGER is
		external
			"C [macro <ewg_carbon_function_c_glue_code.h>] :OSStatus"
		alias
			"ewg_function_macro_HMHideTag"
		end

	frozen hmhide_tag_address_external: POINTER is
			-- Address of C function `HMHideTag'
		external
			"C [macro <Carbon/Carbon.h>]: void*"
		alias
			"(void*) HMHideTag"
		end

	frozen hmhide_tag_with_options_external (inoptions: INTEGER): INTEGER is
		external
			"C [macro <ewg_carbon_function_c_glue_code.h>] (OptionBits):OSStatus"
		alias
			"ewg_function_macro_HMHideTagWithOptions"
		end

	frozen hmhide_tag_with_options_address_external: POINTER is
			-- Address of C function `HMHideTagWithOptions'
		external
			"C [macro <Carbon/Carbon.h>]: void*"
		alias
			"(void*) HMHideTagWithOptions"
		end

end
