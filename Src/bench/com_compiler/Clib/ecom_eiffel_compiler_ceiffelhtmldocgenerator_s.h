/*-----------------------------------------------------------
 Help file: 
-----------------------------------------------------------*/

#ifndef __ECOM_EIFFEL_COMPILER_CEIFFELHTMLDOCGENERATOR_S_H__
#define __ECOM_EIFFEL_COMPILER_CEIFFELHTMLDOCGENERATOR_S_H__
#ifdef __cplusplus
extern "C" {


namespace ecom_eiffel_compiler
{
class CEiffelHTMLDocGenerator;
}

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_server_rt_globals.h"

#include "server_registration.h"

#include "CEiffelHTMLDocGenerator_factory.h"

#include "ecom_eiffel_compiler_IEiffelHTMLDocGenerator_s.h"

#ifdef __cplusplus
extern "C" {
#endif

extern "C" const CLSID CLSID_CEiffelHTMLDocGenerator_;

#ifdef __cplusplus
extern "C" {
namespace ecom_eiffel_compiler
{
class CEiffelHTMLDocGenerator : public ecom_eiffel_compiler::IEiffelHTMLDocGenerator, public IProvideClassInfo2
{
public:
	CEiffelHTMLDocGenerator (EIF_TYPE_ID tid);
	CEiffelHTMLDocGenerator (EIF_OBJECT eif_obj);
	virtual ~CEiffelHTMLDocGenerator ();

	/*-----------------------------------------------------------
	Add excluded cluster
	-----------------------------------------------------------*/
	STDMETHODIMP add_excluded_cluster(  /* [in] */ BSTR cluster_to_exclude );


	/*-----------------------------------------------------------
	Remove excluded cluster
	-----------------------------------------------------------*/
	STDMETHODIMP remove_excluded_cluster(  /* [in] */ BSTR excluded_cluster );


	/*-----------------------------------------------------------
	is the project incompatible?
	-----------------------------------------------------------*/
	STDMETHODIMP is_incompatible(  /* [out, retval] */ VARIANT_BOOL * return_value );


	/*-----------------------------------------------------------
	is the project corrupted?
	-----------------------------------------------------------*/
	STDMETHODIMP is_corrupted(  /* [out, retval] */ VARIANT_BOOL * return_value );


	/*-----------------------------------------------------------
	the last error
	-----------------------------------------------------------*/
	STDMETHODIMP last_error(  /* [out, retval] */ BSTR * return_value );


	/*-----------------------------------------------------------
	Load a compiled project
	-----------------------------------------------------------*/
	STDMETHODIMP load_project(  /* [in] */ BSTR project_dir, /* [out, retval] */ VARIANT_BOOL * return_value );


	/*-----------------------------------------------------------
	Generate the documentation.
	-----------------------------------------------------------*/
	STDMETHODIMP generate(  /* [in] */ BSTR generation_dir );


	/*-----------------------------------------------------------
	Get type info
	-----------------------------------------------------------*/
	STDMETHODIMP GetTypeInfo( unsigned int itinfo, LCID lcid, ITypeInfo **pptinfo );


	/*-----------------------------------------------------------
	Get type info count
	-----------------------------------------------------------*/
	STDMETHODIMP GetTypeInfoCount( unsigned int * pctinfo );


	/*-----------------------------------------------------------
	IDs of function names 'rgszNames'
	-----------------------------------------------------------*/
	STDMETHODIMP GetIDsOfNames( REFIID riid, OLECHAR ** rgszNames, unsigned int cNames, LCID lcid, DISPID *rgdispid );


	/*-----------------------------------------------------------
	Invoke function.
	-----------------------------------------------------------*/
	STDMETHODIMP Invoke( DISPID dispID, REFIID riid, LCID lcid, unsigned short wFlags, DISPPARAMS *pDispParams, VARIANT *pVarResult, EXCEPINFO *pExcepInfo, unsigned int *puArgErr );


	/*-----------------------------------------------------------
	Decrement reference count
	-----------------------------------------------------------*/
	STDMETHODIMP_(ULONG) Release();


	/*-----------------------------------------------------------
	Increment reference count
	-----------------------------------------------------------*/
	STDMETHODIMP_(ULONG) AddRef();


	/*-----------------------------------------------------------
	Query Interface.
	-----------------------------------------------------------*/
	STDMETHODIMP QueryInterface( REFIID riid, void ** ppv );


	/*-----------------------------------------------------------
	GetClassInfo
	-----------------------------------------------------------*/
	STDMETHODIMP GetClassInfo( ITypeInfo ** ppti );


	/*-----------------------------------------------------------
	GetGUID
	-----------------------------------------------------------*/
	STDMETHODIMP GetGUID( DWORD dwKind, GUID * pguid );



protected:


private:
	/*-----------------------------------------------------------
	Reference counter
	-----------------------------------------------------------*/
	LONG ref_count;


	/*-----------------------------------------------------------
	Corresponding Eiffel object
	-----------------------------------------------------------*/
	EIF_OBJECT eiffel_object;


	/*-----------------------------------------------------------
	Eiffel type id
	-----------------------------------------------------------*/
	EIF_TYPE_ID type_id;


	/*-----------------------------------------------------------
	Type information
	-----------------------------------------------------------*/
	ITypeInfo * pTypeInfo;




};
}
}
#endif

#ifdef __cplusplus
}
#endif
#include "ecom_grt_globals_ISE.h"


#endif