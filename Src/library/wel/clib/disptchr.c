/*
 * DISPTCHR.C
 *
 * Dispatcher functions used by the class WEL_DISPATCHER.
 *
 */

/*
 * WEL has only 2 C-functions:
 * `cwel_window_procedure' receives messages from windows and
 * `cwel_dialog_procedure' receives messages from dialog boxes.
 * These 2 functions call the routines `window_procedure' and
 * `dialog_procedure' respectively from the Eiffel class WEL_DISPATCHER.
 * -- PK.
 */

#include "wel_globals.h"

/* Temporary external used to get around genericity problem in Vision2. */
EIF_REFERENCE generize (EIF_OBJECT g_item)
{
	return eif_access (g_item);
}

#ifndef EIF_THREADS
	EIF_WNDPROC wel_wndproc = NULL;
	/* Address of the Eiffel routine `window_procedure' (class WEL_DISPATCHER) */
	
	EIF_DLGPROC wel_dlgproc = NULL;
	/* Address of the Eiffel routine `dialog_procedure' (class WEL_DISPATCHER) */
	
	EIF_OBJ dispatcher = NULL;
	/* Address of the Eiffel object WEL_DISPATCHER created for each application */
#endif

LRESULT CALLBACK cwel_window_procedure (HWND hwnd, UINT msg, WPARAM wparam, LPARAM lparam)
{
	/*
	 * Receive window messages and call the Eiffel routine `window_procedure'
	 * of the `dispatcher' Eiffel object. Since `dispatcher' is an adopted
	 * object we need to call `eif_access' to use it.
	 */
	WGTCX

	if (dispatcher)
		return (LRESULT) ((wel_wndproc) (
			(EIF_OBJ) eif_access (dispatcher),
			(EIF_POINTER) hwnd,
			(EIF_INTEGER) msg,
			(EIF_INTEGER) wparam,
			(EIF_INTEGER) lparam));
	else
		return DefWindowProc (hwnd, msg, wparam, lparam);
}

BOOL CALLBACK cwel_dialog_procedure (HWND hwnd, UINT msg, WPARAM wparam, LPARAM lparam)
{
	/*
	 * Receive dialog messages and call the Eiffel routine `dialog_procedure'
	 * of the `dispatcher' Eiffel object. Since `dispatcher' is an adopted
	 * object we need to call `eif_access' to use it.
	 */

	WGTCX

	if (dispatcher) {
		LONG dialog_result;

		dialog_result = (LONG) ((wel_dlgproc) (
			(EIF_OBJ) eif_access (dispatcher),
			(EIF_POINTER) hwnd,
			(EIF_INTEGER) msg,
			(EIF_INTEGER) wparam,
			(EIF_INTEGER) lparam));

		switch (msg) {
			case WM_CTLCOLORBTN:
			case WM_CTLCOLORDLG:
			case WM_CTLCOLOREDIT:
			case WM_CTLCOLORLISTBOX:
			case WM_CTLCOLORMSGBOX:
			case WM_CTLCOLORSCROLLBAR:
			case WM_CTLCOLORSTATIC:
			case WM_COMPAREITEM:
			case WM_VKEYTOITEM:
			case WM_CHARTOITEM:
			case WM_QUERYDRAGICON:
					return (BOOL) dialog_result;
			default:
				if (dialog_result != 0) {
						/* Set the result given by WEL to the dialog */
					dialog_result = SetWindowLong (hwnd, DWL_MSGRESULT, dialog_result);
					return (dialog_result != 0);
				} else
					return FALSE;
		}
	} else
		return FALSE;
}

#ifdef EIF_THREADS
void wel_set_window_procedure_address( EIF_POINTER _addr_)
{
	WGTCX
	wel_wndproc = (EIF_WNDPROC) _addr_ 	;
}

void wel_set_dialog_procedure_address( EIF_POINTER _addr_)
{
	WGTCX
	wel_dlgproc = (EIF_DLGPROC) _addr_;
}

void wel_set_dispatcher_object(EIF_OBJ _addr_)
{
	WGTCX
	dispatcher = (EIF_OBJ) eif_adopt (_addr_);	
}

void wel_release_dispatcher_object()
{
	WGTCX
	eif_wean (dispatcher);
}

#endif

/*
--|-------------------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1995-1997, Interactive Software Engineering, Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Information e-mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|-------------------------------------------------------------------------
*/
