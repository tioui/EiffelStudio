indexing
	description: "Wizard writer constants"
	status: "See notice at end of class";
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_WRITER_DICTIONARY

feature -- Special simbols -- 1

	Space: STRING is " "
	
	New_line: STRING is "%N"
	
	Tab: STRING is "%T"
	
	Tab_tab: STRING is "%T%T"

	Tab_tab_tab: STRING is "%T%T%T"
	
	New_line_tab: STRING is "%N%T"
	
	New_line_tab_tab: STRING is "%N%T%T"
	
	New_line_tab_tab_tab: STRING is "%N%T%T%T"
	
	Open_parenthesis: STRING is "("
	
	Close_parenthesis: STRING is ")"
	
	Open_bracket: STRING is "%("
	
	Close_bracket: STRING is "%)"
	
	Open_curly_brace: STRING is "%<"
	
	Close_curly_brace: STRING is "%>"
	
	Double_dash: STRING is "--"

	Dollar: STRING is "%D"
	
	Colon: STRING is ":"
	
	Comma: STRING is ","

	Semicolon: STRING is ";"

	Underscore: STRING is "_"

	Equal_sign: STRING is "="

	Assignment: STRING is ":="

	Eiffel_not_equal: STRING is "/="

	C_equal: STRING is " == "

	C_not_equal: STRING is "!="

	Ampersand: STRING is "&"

	Single_quote: STRING is "%'"

	Back_quote: STRING is "%Q"

	Double_quote: STRING is "%""

	Percent_double_quote: STRING is "%%%""

	Asterisk: STRING is "*"

	Space_asterisk_space: STRING is " * "

	Percent: STRING is "%%"

	Tilda: STRING is "~"

	Dot: STRING is "."

	Less: STRING is "<"

	More: STRING is ">"

	Plus: STRING is "+"

	Comma_space: STRING is ", "

	Space_open_parenthesis: STRING is " ("

	Space_equal_space: STRING is " = "

	Sharp: STRING is "%S"
			-- #

	At_sign: STRING is "@"

	C_or: STRING is "||"

	Registry_field_seperator: STRING is "\\"

feature -- Access -- 2

	Class_footer: STRING is ""

	Class_header: STRING is ""

	Description_keyword: STRING is "description"
	
	Note_keyword: STRING is "Note"

	None_keyword: STRING is "None"
		
	Wizard_note: STRING is "%"Automatically generated by the EiffelCOM Wizard.%""

	Initialization_title: STRING is "Initialization"

	Access_title: STRING is "Access"
	
	Measurement_title: STRING is "Measurement"
	
	Status_report_title: STRING is "Status Report"

	Element_change_title: STRING is "Element Change"

	Basic_operations_title: STRING is "Basic Operations"

	Implementation_title: STRING is "Implementation"
	
	External_title: STRING is "External"

	No_description_available: STRING is "No description available."
	
	Added:STRING is "Added"

	Dynamic_type_function_name: STRING is "dynamic_type"

	Processed: STRING is "Processed"

	Processing: STRING is "Processing"

	Record: STRING is "Record"

	Elements_string: STRING is "Elements"

	Inherit_from_string: STRING is   "inherit from"

	Dispinterface_string: STRING is "Dispinterface"

	Interface: STRING is "Interface"

	Coclass: STRING is "Coclass"

	Enumerator: STRING is "Enumerator"

	Functions_string: STRING is "Functions"

	Properties_string: STRING is "Properties"

	Precondition_function_comment: STRING is "User-defined preconditions for "

	Should_redefine: STRING is "Redefine in descendants if needed."

	Implemented_word: STRING is "implemented"

feature -- C keywords -- 3

	C_open_comment_line: STRING is "/*-----------------------------------------------------------"

	C_close_comment_line: STRING is "-----------------------------------------------------------*/"

	Static_cast: STRING is "static_cast"

	Reinterpret_cast: STRING is "reinterpret_cast"

	Else_if: STRING is "else if"

	For: STRING is "for"

	Int: STRING is "int"

	New: STRING is "new"

	Const: STRING is "const"

	Hash_if_def: STRING is "#ifdef"

	Hash_else: STRING is "#else"

	Hash_end_if: STRING is "#endif"

	Hash_define: STRING is "#define"

	While: STRING is "while"

	Long_macro: STRING is "LONG"

	This: STRING is "this"

	Delete: STRING is "delete"

	Define: STRING is "define"

	Endif: STRING is "endif"

	Ifndef: STRING is "ifndef"

	Return: STRING is "return"

	Struct: STRING is "struct"

	Enum: STRING is "enum"

	Extern: STRING is "extern"

	Import: STRING is "%Simport"

	Include_clause: STRING is "%Sinclude"

	C_class_keyword: STRING is "class"

	Calloc: STRING is "calloc"

	Free: STRING is "free"

	Sizeof: STRING is "sizeof"

	C_void_pointer: STRING is "void *"

	Void_c_keyword: STRING is "void"

	C_binary_or: STRING is "|"

	Null: STRING is "NULL"

	Char: STRING is "char"

	Short: STRING is "short"

	Long: STRING is "long"

	Unsigned_char: STRING is "unsigned char"

	Unsigned_short: STRING is "unsigned short"

	Unsigned_long: STRING is "unsigned long"

	Float: STRING is "float"

	Double_c_keyword: STRING is "double"

	Unsigned_int: STRING is "unsigned int"

	Ptr: STRING is "Pointed Type"

	Carray: STRING is "CARRAY"

	Typedef: STRING is "typedef"

	Virtual: STRING is "virtual"

	Pure_virtual_sufix: STRING is " = 0"

	Ulong_type: STRING is "ULONG"

	Bool: STRING is "BOOL"

	C_true: STRING is "TRUE"

	Assert: STRING is "assert"

	Unicode_string_copy_function: STRING is "lstrcpy"

	Non_unicode_string_copy_function: STRING is "mbstowcs"

	Get_message: STRING is "GetMessage"

	Dispatch_message: STRING is "DispatchMessage"

	Malloc: STRING is "malloc"

	Memcpy: STRING is "memcpy"

feature -- IDL keywords -- 4

	In: STRING is "in"

	Out_keyword: STRING is "out"

	Inout: STRING is "in, out"

	Retval: STRING is "retval"

	
feature -- CECIL names -- 5

	Eif_integer: STRING is "EIF_INTEGER"

	Eif_character: STRING is "EIF_CHARACTER"

	Eif_boolean: STRING is "EIF_BOOLEAN"

	Eif_pointer: STRING is "EIF_POINTER"

	Eif_real: STRING is "EIF_REAL"

	Eif_double: STRING is "EIF_DOUBLE"

	Eif_reference: STRING is "EIF_REFERENCE"

	Eif_object: STRING is "EIF_OBJECT"

	Eif_procedure: STRING is "EIF_PROCEDURE"

	Eif_procedure_name: STRING is "eif_procedure"

	Eif_field: STRING is "eif_field"

	Eif_character_function: STRING is "EIF_CHARACTER_FUNCTION"

	Eif_character_function_name: STRING is "eif_character_function"

	Eif_reference_function: STRING is "EIF_REFERENCE_FUNCTION"

	Eif_reference_function_name: STRING is "eif_reference_function"

	Eif_pointer_function: STRING is "EIF_POINTER_FUNCTION"

	Eif_pointer_function_name: STRING is "eif_pointer_function"

	Eif_integer_function: STRING is "EIF_INTEGER_FUNCTION"

	Eif_integer_function_name: STRING is "eif_integer_function"

	Eif_real_function: STRING is "EIF_REAL_FUNCTION"

	Eif_real_function_name: STRING is "eif_real_function"

	Eif_double_function: STRING is "EIF_DOUBLE_FUNCTION"

	Eif_double_function_name: STRING is "eif_double_function"

	Eif_boolean_function: STRING is "EIF_BOOLEAN_FUNCTION"

	Eif_boolean_function_name: STRING is "eif_boolean_function"

	Eif_type_id: STRING is "EIF_TYPE_ID"

	Eif_type_id_function_name: STRING is "eif_type_id"

	Eif_create: STRING is "eif_create"

	Eif_protect: STRING is "eif_protect"

	Eif_access: STRING is "eif_access"

	Eif_wean: STRING is "eif_wean"

	Eif_make_from_c: STRING is "eif_make_from_c"

	C_keyword: STRING is "C"

	Macro: STRING is "macro"

feature -- COM constants -- 6

	Appid: STRING is "AppID"

	Prog_id: STRING is "ProgID"

	Current_version: STRING is "CurVer"

	Version_independent_prog_id: STRING is "VersionIndependentProgID"

	Unicode: STRING is "UNICODE"

	Inproc_server32: STRING is "InprocServer32"

	Local_server32: STRING is "LocalServer32"

	Hkey_class_root: STRING is "HKEY_CLASSES_ROOT"

	Class_factory: STRING is "IClassFactory"

	Inprocess_server: STRING is "CLSCTX_INPROC_SERVER"

	Remote_server: STRING is "CLSCTX_LOCAL_SERVER|CLSCTX_REMOTE_SERVER"

	Coserverinfo: STRING is "COSERVERINFO"

	E_no_interface: STRING is "E_NOINTERFACE"

	Class_e_noaggregation: STRING is "CLASS_E_NOAGGREGATION"

	S_ok: STRING is "S_OK"

	S_false: STRING is "S_FALSE"

	E_out_of_memory: STRING is "E_OUTOFMEMORY"

	Ulong_std_method_imp: STRING is "STDMETHODIMP_(ULONG)"

	Std_method_imp: STRING is "STDMETHODIMP"

	Type_lib_type: STRING is "ITypeLib *"

	Type_lib_variable_name: STRING is "pTypeLib"

	Olestr: STRING is "OLESTR"

	E_pointer: STRING is "E_POINTER"

	Tchar: STRING is "TCHAR *"

	Tchar_type: STRING is "TCHAR"

	Interlocked_increment: STRING is "InterlockedIncrement"

	Interlocked_decrement: STRING is "InterlockedDecrement"

	Automation_marshaler_guid: STRING is "{00020424-0000-0000-C000-000000000046}"

feature -- COM types -- 7

	Excepinfo: STRING is "EXCEPINFO"

	Lpwstr: STRING is "LPWSTR"

	Lpstr: STRING is "LPSTR"

	Iunknown_type: STRING is "IUnknown"

	Idispatch_type: STRING is "IDispatch"

	Variant_bool: STRING is "VARIANT_BOOL"

	Date_c_keyword: STRING is "DATE"

	Hresult: STRING is "HRESULT"

	Type_info: STRING is "ITypeInfo *"

	Variant_c_keyword: STRING is "VARIANT"

	Currency: STRING is "CURRENCY"

	Decimal: STRING is "DECIMAL"

	Idispatch: STRING is "IDispatch *"

	Iunknown: STRING is "IUnknown *"

	Bstr: STRING is "BSTR"

	Olechar: STRING is "OLECHAR"

	Large_integer: STRING is "LARGE_INTEGER"

	Ularge_integer: STRING is "ULARGE_INTEGER"

	Iunknown_pointer: STRING is "IUnknown *"

	Safearray: STRING is "SAFEARRAY"

	Variantarg: STRING is "VARIANTARG"

	Clsid_type: STRING is "CLSID"

	Libid_type: STRING is "LIBID"

	Iid_type: STRING is "IID"

	Dword: STRING is "DWORD"

	Class_e_class_not_available: STRING is "CLASS_E_CLASSNOTAVAILABLE"

	Register_server_option_a: STRING is "/REGSERVER"

	Register_server_option_b: STRING is "-REGSERVER"

	Unregister_server_option_a: STRING is "/UNREGSERVER"

	Unregister_server_option_b: STRING is "-UNREGSERVER"

	Embedding_option_a: STRING is "/EMBEDDING"

	Embedding_option_b: STRING is "-EMBEDDING"

	Std_api: STRING is "STDAPI"

	Clsctx_local_server: STRING is "CLSCTX_LOCAL_SERVER"

	Regcls_multiple_use: STRING is "REGCLS_MULTIPLEUSE"

	Regcls_single_use: STRING is "REGCLS_SINGLEUSE"

	Tchar_creation_function: STRING is "__TEXT"

feature -- Generator constants -- 8

	Register_dll_server_function_name: STRING is "register_dll_server"

	Unregister_dll_server_function_name: STRING is "unregister_dll_server"

	Can_unload_dll_now_function_name: STRING is "dll_can_unload_now"

	Get_class_object_function_name: STRING is "class_object"

	Ccom_get_class_object_function_name: STRING is "ccom_class_object"

	Ccom_register_dll_server_function_name: STRING is "ccom_register_dll_server"

	Ccom_unregister_dll_server_function_name: STRING is "ccom_unregister_dll_server"

	Ccom_can_unload_dll_now_function_name: STRING is "ccom_dll_can_unload_now"
	
	Excepinfo_access: STRING is "excepinfo->"

	Excepinfo_variable_name: STRING is "excepinfo"

	Wcode_field: STRING is "wCode"

	Default_iunknown_variable_comment: STRING is "Default IUnknown interface pointer"

	Excepinfo_variable_comment: STRING is "Exception information"

	Bstr_source_field: STRING is "bstrSource"

	Server_registration_header_file_name: STRING is "server_registration.h"

	Ccom_embedding_feature_name: STRING is "ccom_embedding"

	Ccom_regserver_feature_name: STRING is "ccom_register_server"

	Ccom_unregserver_feature_name: STRING is "ccom_unregister_server"

	Embedding_feature_name: STRING is "embedding"

	Regserver_feature_name: STRING is "regserver"

	Unregserver_feature_name: STRING is "unregserver"

	Bstr_description_field: STRING is "bstrDescription"

	Bstr_help_file_field: STRING is "bstrHelpFile"

	Class_object_registration_token: STRING is "dwRegister"

	Class_object_variable_name: STRING is "cls_object"

	Tmp_eif_object: STRING is "tmp_eif_object"

	Option_variable_name: STRING is "an_option"

	Locks_variable_name: STRING is "lock_count"

	Delete_on_unregister: STRING is "pDelOnUnregister"

	Key_name: STRING is "pKeyName"

	Struct_value: STRING is "pValue"

	Value_name: STRING is "pValueName"

	Reg_data: STRING is "REG_DATA"

	Registry_entries_variable_name: STRING is "reg_entries"

	Component_entries_count: STRING is "com_entries_count"

	Extern_lock_module: STRING is "extern void LockModule (void);"

	Extern_unlock_module: STRING is "extern void UnlockModule (void);"

	Eiffel_object: STRING is "eiffel_object"

	Set_type_id_function_name: STRING is "set_type_id"

	Ecatch: STRING is "%TECATCH;%N"

	Lock_module_function: STRING is "LockModule ();"

	Unlock_module_function: STRING is "UnlockModule ();"

	Riid: STRING is "riid"

	Factory: STRING is "factory"

	Tmp_object_pointer: STRING is "pUnknown"

	Star_ppv: STRING is "*ppv"

	Query_interface_signature: STRING is "REFIID riid, void ** ppv"

	Ref_count: STRING is "ref_count"

	Tmp_variable_name: STRING is "tmp_value"

	Eiffel_procedure_variable_name: STRING is "eiffel_procedure"

	Eiffel_function_variable_name: STRING is "eiffel_function"

	Argument_name: STRING is "a_value"

	Struct_selection_operator: STRING is "->"

	Ce_boolean: STRING is "ccom_ce_boolean"

	Index_of_word_option_function_name: STRING is "index_of_word_option"

	Interface_pointer_comment: STRING is "Interface pointer"

	Release_function: STRING is "->Release ();"

	Release: STRING is "Release"

	Load_type_lib: STRING is "LoadTypeLib"

	Return_s_ok: STRING is "return S_OK;"

	Get_type_info_of_guid: STRING is "GetTypeInfoOfGuid"

	Get_ids_of_names: STRING is "GetIDsOfNames"

	Get_type_info: STRING is "GetTypeInfo"

	Get_type_info_count: STRING is "GetTypeInfoCount"

	Add_reference: STRING is "AddRef"

	Add_reference_function: STRING is "->AddRef ();"

	Query_interface: STRING  is "QueryInterface"

	Co_uninitialize_function: STRING is "CoUninitialize ();"

	Interface_variable_prepend: STRING is "p_"

	Initialize_function_name: STRING is "initialize"

	Zero: STRING is "0"

	Type_info_variable_name: STRING is "pTypeInfo"

	Arguments_name: STRING is "arguments"

	One: STRING is "1"

	Multi_qi: STRING is "MULTI_QI"

	Ccom_item_function_name: STRING is "ccom_item"

	Current_object_variable_name: STRING is "current_object"

	Server_info_access: STRING is "server_info->"

	Server_info_variable: STRING is "server_info"

	Iunknown_variable_name: STRING is "p_unknown"

	Idispatch_variable_name: STRING is "p_dispatch"

	Invoke: STRING is "Invoke"

	Iunknown_clsid: STRING is "IID_IUnknown"

	Hresult_variable: STRING is "HRESULT hr;%N"
																		
	Routine_clause: STRING is "_routine"

	Append_tid_clause: STRING is "_tid"

	Feature_clause: STRING is "_feature"

	Set_item_procedure_name: STRING is "set_item"

	Put_procedure_name: STRING is "put"

	Module_file_name: STRING is "file_name"

	Wide_string_module_file_name: STRING is "ws_file_name"

	Max_path: STRING is "MAX_PATH"

	Arguments_variable_name: STRING is "arguments"

	Deferred_class_clause: STRING is "deferred class"

	Iunknown_interface: STRING is "ECOM_IUNKNOWN_INTERFACE"

	Empty_function_body: STRING is "%T%T%T-- DO NOT put implementation here as the wizard will override this class when you rerun wizard."

	Result_clause: STRING is "Result := "

	Item_parameter_clause: STRING is "(item)"

	To_c_function: STRING is "to_c"

	Item_clause: STRING is "item"

	Array_item: STRING is "array_item"

	Make_word: STRING is "make"

	Make_from_other: STRING is "make_from_other"

	Make_from_pointer: STRING is "make_from_pointer"

	An_item_variable: STRING is "an_item"

	Current_item_variable: STRING is "current_item: POINTER"

	Null_coclass_test: STRING is "if (eiffel_coclass == NULL)%<%N"

	Type_id_variable: STRING is "EIF_TYPE_ID tid;%N"

	Type_id_variable_name: STRING is "tid"

	Eif_procedure_variable: STRING is "EIF_PROCEDURE p_make;%N"

	Make_procedure: STRING is "p_make = eif_procedure (%"make_from_pointer%", tid)%N"

	Create_eiffel_object: STRING is "eiffel_object = eif_create (tid);%N"

	Tmp_clause: STRING is "tmp_"

	Get_clause: STRING is "get_"

	Register: STRING is "Register"

	Export_dll_class_name: STRING is "EXPORT_DLL_FEATURES"

	Unregister: STRING is "Unregister"

	Set_clause: STRING is "set_"

	Make_function: STRING is ".make "

	Ccom_clause: STRING is "ccom_"

	Item_function: STRING is ".item"

	Interface_function: STRING is ".interface"

	Ecom_date_type: STRING is "ECOM_DATE"
	
	Any_clause: STRING is "an_any: "

	Cpp_clause: STRING is "C++ %("

	Initializer_variable: STRING is "initializer"

	Pointer_variable: STRING is "a_pointer: POINTER"

	Default_pointer_argument: STRING is "cpp_obj: POINTER"

	Empty_dispparams: STRING is "DISPPARAMS args = %<NULL, NULL, 0, 0%>;"

	Return_variant_variable: STRING is "VARIANT pResult; %N%TVariantInit (&pResult);"

	Return_variant_variable_name: STRING is "pResult"

	Hresult_variable_name: STRING is "hr"

	Hresult_variable_name_2: STRING is "hr2"

	Type_id: STRING is "type_id"

	Eif_object_variable: STRING is "eif_object"

	A_pointer: STRING is "a_pointer"

	Eif_ref_variable: STRING is "eif_ref"

	Failed: STRING is "FAILED"

	Hresult_code: STRING is "HRESULT_CODE"

	Format_message: STRING is "c_format_message"

	Com_eraise: STRING is "com_eraise"

	Beginning_comment_paramflag: STRING is " /* %("

	End_comment_paramflag: STRING is "%) */ "

	C_result: STRING is "result"

	Message_variable_name: STRING is "msg"
	
	Eif_eiffel_h: STRING is "eif_eiffel.h"

	Eif_com_h: STRING is "eif_com.h"

	Windows_h: STRING is "windows.h"

	Objbase_h: STRING is "objbase.h"

	Ecom_server_rt_globals_h: STRING is "ecom_server_rt_globals.h"

	An_object: STRING is "an_object"

	Eif_array: STRING is "eif_array"

	An_array: STRING is "an_array"

	Array_word: STRING is "array"

	Count_word: STRING is "count"

	A_count_word: STRING is "a_count"

	An_element: STRING is "an_element"

	A_ref: STRING is "a_ref"

	Last_error_code: STRING is "last_error_code"

	Last_error_description: STRING is "last_error_description"

	Last_error_help_file: STRING is "last_error_help_file"

	Last_source_of_exception: STRING is "last_source_of_exception"

	Ccom_last_error_code: STRING is "ccom_last_error_code"

	Ccom_last_error_description: STRING is "ccom_last_error_description"

	Ccom_last_error_help_file: STRING is "ccom_last_error_help_file"

	Ccom_last_source_of_exception: STRING is "ccom_last_source_of_exception"

feature -- Eiffel types -- 9

	Arguments_type: STRING is "ARGUMENTS"

	User_precondition: STRING is "user_precondition"

	Integer_type: STRING is "INTEGER"

	Internal_type: STRING is "INTERNAL"

	Void_type: STRING is "Void"

	Character_type: STRING is "CHARACTER"

	Real_type: STRING is "REAL"

	Double_type: STRING is "DOUBLE"

	Boolean_type: STRING is "BOOLEAN"

	Date_time: STRING is "DATE_TIME"

	Ecom_hresult: STRING is "ECOM_HRESULT"

	Ecom_variant: STRING is "ECOM_VARIANT"

	Ecom_currency: STRING is "ECOM_CURRENCY"

	Ecom_decimal: STRING is "ECOM_DECIMAL"

	Ecom_unknown_interface: STRING  is "ECOM_UNKNOWN_INTERFACE"

	Ecom_automation_interface: STRING is "ECOM_AUTOMATION_INTERFACE"

	String_type: STRING is "STRING"

	Ecom_large_integer: STRING is "ECOM_LARGE_INTEGER"

	Ecom_ularge_integer: STRING is "ECOM_ULARGE_INTEGER"

	Any_type: STRING is "ANY"

	Pointer_type: STRING is "POINTER"

	Exceptions_type: STRING is "EXCEPTIONS"

	Wrapper_type: STRING is "ECOM_WRAPPER"

	Queriable_type: STRING is "ECOM_QUERIABLE"

	Wel_string_type: STRING is "WEL_STRING"

	Ecom_wide_string_type: STRING is "ECOM_WIDE_STRING"

	Error_handler_type: STRING is "ECOM_ERROR_HANDLER"

	ecom_excep_info_type: STRING is "ECOM_EXCEP_INFO"

	Character_ref_type: STRING is "CHARACTER_REF"

	Integer_ref_type: STRING is "INTEGER_REF"

	Real_ref_type: STRING is "REAL_REF"

	Double_ref_type: STRING is "DOUBLE_REF"

	Boolean_ref_type: STRING is "BOOLEAN_REF"

	Array_type: STRING is "ARRAY"

	Ecom_array_type: STRING is "ECOM_ARRAY"

	Cell_type: STRING is "CELL"

	Alias_type: STRING is "ALIAS"

	Ecom_structure: STRING is "ECOM_STRUCTURE"

	Cell_pointer: STRING is "CELL [POINTER]"

feature -- COM function names -- 10

	Co_task_mem_free: STRING is "CoTaskMemFree"

	Co_task_mem_alloc: STRING is "CoTaskMemAlloc"

	Get_module_file_name: STRING is "GetModuleFileName"

	Dll_register_server: STRING is "DllRegisterServer"

	Dll_unregister_server: STRING is "DllUnregisterServer"

	Dll_get_class_object: STRING is "DllGetClassObject"

	Dll_can_unload_now: STRING is "DllCanUnloadNow"

	Co_initialize: STRING is "CoInitialize (0)"

	Succeeded: STRING is "SUCCEEDED"

	Co_register_class_object: STRING is "CoRegisterClassObject"

	Co_revoke_class_object: STRING is "CoRevokeClassObject"

	Proxy_stub_clsid_32: STRING is "ProxyStubClsid32"

	Type_library: STRING is "TypeLib"

	Num_methods: STRING is "NumMethods"

feature -- Paths -- 11

	Interfaces: STRING is "Interfaces"

	Common: STRING is "Common"

	Server: STRING is "Server"

	Client: STRING is "Client"

	Component: STRING is "Component"

	Clib: STRING is "Clib"

	Include: STRING is "Include"

	Structures: STRING is "Structures"

	Eiffel_file_extension: STRING is ".e"

	Header_file_extension: STRING is ".h"

	C_file_extension: STRING is ".c"

	Cpp_file_extension: STRING is ".cpp"

	Backup_file_extension: STRING is ".bac"

	Dll_file_extension: STRING is ".dll"

	Lib_file_extension: STRING is ".lib"

	Object_file_extension: STRING is ".obj"

	Definition_file_extension: STRING is ".def"

feature -- Commands -- 12
	
	Copy_command: STRING is "xcopy /C"

	Delete_command: STRING is "del"

feature -- languages --13

	C: STRING is "C"

	Eiffel: STRING is "Eiffel"

feature -- Eiffel keywords -- 14

	Is_keyword: STRING is "is"

	If_keyword: STRING is "if"
	
	Do_keyword: STRING is "do"
	
	Alias_keyword: STRING is "alias"

	Deferred_keyword: STRING is "deferred"

	Require_keyword: STRING is "require"

	Create_keyword: STRING is "create"

	Once_keyword: STRING is "once"
	
	End_keyword: STRING is "end"
	
	Class_keyword: STRING is "class"
	
	Inherit_keyword: STRING is "inherit"

	Rename_keyword: STRING is "rename"

	Redefine_keyword: STRING is "redefine"

	Undefine_keyword: STRING is "undefine"

	Export_keyword: STRING is "export"

	Select_keyword: STRING is "select"

	Like_keyword: STRING is "like "

	Ensure_keyword: STRING is "ensure"

	Local_keyword: STRING is "local"

	Result_keyword: STRING is "Result"

	Current_keyword: STRING is "Current"

	As_keyword: STRING is "as"

	Or_keyword: STRING is "or"

	Then_keyword: STRING is "then"

	Feature_keyword: STRING is "feature"

	Indexing_keyword: STRING is "indexing"
	
	Creation_keyword: STRING is "creation"

	External_keyword: STRING is "external"

	Else_keyword: STRING is "else"

	All_keyword: STRING is "all"

	And_keyword: STRING is "and"

	Check_keyword: STRING is "check"

	Debug_keyword: STRING is "debug"

	Elseif_keyword: STRING is "elseif"

	Expanded_keyword: STRING is "expanded"

	From_keyword: STRING is "from"

	Frozen_keyword: STRING is "frozen"

	Implies_keyword: STRING is "implies"

	Infix_keyword: STRING is "infix"

	Inspect_keyword: STRING is "inspect"

	Invariant_keyword: STRING is "invariant"

	Loop_keyword: STRING is "loop"

	Not_keyword: STRING is "not"

	Obsolete_keyword: STRING is "obsolete"

	Old_keyword: STRING is "old"

	Prefix_keyword: STRING is "prefix"

	Rescue_keyword: STRING is "rescue"

	Retry_keyword: STRING is "retry"

	Separate_keyword: STRING is "separate"

	Until_keyword: STRING is "until"

	Variant_keyword: STRING is "variant"

	When_keyword: STRING is "when"

	Xor_keyword: STRING is "xor"

	Bit_keyword: STRING is "BIT"

	True_keyword: STRING is "True"

	False_keyword: STRING is "False"

	Precursor_keyword: STRING is "Precursor"

	Strip_keyword: STRING is "Strip"

	Unique_keyword: STRING is "Unique"

feature -- Lace keywords 15

	System_keyword: STRING is "system"

end -- class WIZARD_WRITER_DICTIONARY

--|----------------------------------------------------------------
--| EiffelCOM: library of reusable components for ISE Eiffel.
--| Copyright (C) 1988-1999 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support http://support.eiffel.com
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------
