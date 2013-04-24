/*-----------------------------------------------------------
Implemented `IPersistStream' Interface.
-----------------------------------------------------------*/

#ifndef __ECOM_CONTROL_LIBRARY_IPERSISTSTREAM_IMPL_PROXY_S_H__
#define __ECOM_CONTROL_LIBRARY_IPERSISTSTREAM_IMPL_PROXY_S_H__
#ifdef __cplusplus
extern "C" {


namespace ecom_control_library
{
class IPersistStream_impl_proxy;
}

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_control_library_IPersistStream_s.h"

#include "ecom_control_library__ULARGE_INTEGER_s.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
extern "C" {
namespace ecom_control_library
{
class IPersistStream_impl_proxy
{
public:
  IPersistStream_impl_proxy (IUnknown * a_pointer);
  virtual ~IPersistStream_impl_proxy ();

  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  void ccom_get_class_id(  /* [out] */ GUID * p_class_id );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  void ccom_is_dirty();


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  void ccom_load(  /* [in] */ ::IStream * pstm );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  void ccom_save(  /* [in] */ ::IStream * pstm,  /* [in] */ EIF_INTEGER f_clear_dirty );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  void ccom_get_size_max(  /* [out] */ ULARGE_INTEGER * pcb_size );


  /*-----------------------------------------------------------
  IUnknown interface
  -----------------------------------------------------------*/
  EIF_POINTER ccom_item();



protected:


private:
  /*-----------------------------------------------------------
  Interface pointer
  -----------------------------------------------------------*/
  ::IPersistStream * p_IPersistStream;


  /*-----------------------------------------------------------
  Default IUnknown interface pointer
  -----------------------------------------------------------*/
  IUnknown * p_unknown;




};
}
}
#endif

#ifdef __cplusplus
}
#endif
#include "ecom_grt_globals_control_interfaces2.h"


#endif
