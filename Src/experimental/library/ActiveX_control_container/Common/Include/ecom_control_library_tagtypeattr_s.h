/*-----------------------------------------------------------
"Automatically generated by the EiffelCOM Wizard."Added Record tagTYPEATTR
	guid: typedef
			-- No description available.
	lcid: ULONG
			-- No description available.
	dwReserved: ULONG
			-- No description available.
	memidConstructor: LONG
			-- No description available.
	memidDestructor: LONG
			-- No description available.
	lpstrSchema: LPWSTR
			-- No description available.
	cbSizeInstance: ULONG
			-- No description available.
	typekind: typedef
			-- No description available.
	cFuncs: USHORT
			-- No description available.
	cVars: USHORT
			-- No description available.
	cImplTypes: USHORT
			-- No description available.
	cbSizeVft: USHORT
			-- No description available.
	cbAlignment: USHORT
			-- No description available.
	wTypeFlags: USHORT
			-- No description available.
	wMajorVerNum: USHORT
			-- No description available.
	wMinorVerNum: USHORT
			-- No description available.
	tdescAlias: typedef
			-- No description available.
	idldescType: typedef
			-- No description available.
	
-----------------------------------------------------------*/

#ifndef __ECOM_CONTROL_LIBRARY_TAGTYPEATTR_S_H__
#define __ECOM_CONTROL_LIBRARY_TAGTYPEATTR_S_H__
#ifdef __cplusplus
extern "C" {
#endif


namespace ecom_control_library
{
struct tagtagTYPEATTR;
typedef struct ecom_control_library::tagtagTYPEATTR tagTYPEATTR;
}

#ifdef __cplusplus
}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_control_library_tagTYPEDESC_s.h"

#include "ecom_control_library_tagIDLDESC_s.h"

#ifdef __cplusplus
extern "C" {
#endif



namespace ecom_control_library
{
struct tagtagTYPEATTR
{	GUID guid;
	ULONG lcid;
	ULONG dwReserved;
	LONG memidConstructor;
	LONG memidDestructor;
	LPWSTR lpstrSchema;
	ULONG cbSizeInstance;
	long typekind;
	USHORT cFuncs;
	USHORT cVars;
	USHORT cImplTypes;
	USHORT cbSizeVft;
	USHORT cbAlignment;
	USHORT wTypeFlags;
	USHORT wMajorVerNum;
	USHORT wMinorVerNum;
	ecom_control_library::tagTYPEDESC tdescAlias;
	ecom_control_library::tagIDLDESC idldescType;
};
}
#ifdef __cplusplus
}
#endif

#endif