// CodeGear C++Builder
// Copyright (c) 1995, 2013 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'frxServerVariables.pas' rev: 26.00 (Windows)

#ifndef FrxservervariablesHPP
#define FrxservervariablesHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <Winapi.Windows.hpp>	// Pascal unit
#include <System.Classes.hpp>	// Pascal unit
#include <System.SysUtils.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Frxservervariables
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TfrxServerVariable;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TfrxServerVariable : public System::Classes::TCollectionItem
{
	typedef System::Classes::TCollectionItem inherited;
	
private:
	System::UnicodeString FName;
	System::AnsiString FValue;
	
__published:
	__property System::UnicodeString Name = {read=FName, write=FName};
	__property System::AnsiString Value = {read=FValue, write=FValue};
public:
	/* TCollectionItem.Create */ inline __fastcall virtual TfrxServerVariable(System::Classes::TCollection* Collection) : System::Classes::TCollectionItem(Collection) { }
	/* TCollectionItem.Destroy */ inline __fastcall virtual ~TfrxServerVariable(void) { }
	
};

#pragma pack(pop)

class DELPHICLASS TfrxServerVariables;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TfrxServerVariables : public System::Classes::TCollection
{
	typedef System::Classes::TCollection inherited;
	
public:
	__fastcall TfrxServerVariables(void);
	System::AnsiString __fastcall GetValue(const System::UnicodeString Name);
	void __fastcall AddVariable(const System::UnicodeString Name, const System::AnsiString Value)/* overload */;
	void __fastcall AddVariable(const System::UnicodeString Name, const System::UnicodeString Value)/* overload */;
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TfrxServerVariables(void) { }
	
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
}	/* namespace Frxservervariables */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FRXSERVERVARIABLES)
using namespace Frxservervariables;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// FrxservervariablesHPP
