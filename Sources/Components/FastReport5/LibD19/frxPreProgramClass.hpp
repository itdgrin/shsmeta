// CodeGear C++Builder
// Copyright (c) 1995, 2013 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'frxPreProgramClass.pas' rev: 26.00 (Windows)

#ifndef FrxpreprogramclassHPP
#define FrxpreprogramclassHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <TTFHelpers.hpp>	// Pascal unit
#include <frxTrueTypeTable.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Frxpreprogramclass
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS PreProgramClass;
#pragma pack(push,4)
class PASCALIMPLEMENTATION PreProgramClass : public Frxtruetypetable::TrueTypeTable
{
	typedef Frxtruetypetable::TrueTypeTable inherited;
	
private:
	typedef System::DynamicArray<System::Byte> _PreProgramClass__1;
	
	
private:
	_PreProgramClass__1 pre_program;
	
public:
	__fastcall PreProgramClass(Frxtruetypetable::TrueTypeTable* src);
	virtual void __fastcall Load(void * font);
	virtual unsigned __fastcall Save(void * font, unsigned offset);
public:
	/* TObject.Destroy */ inline __fastcall virtual ~PreProgramClass(void) { }
	
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
}	/* namespace Frxpreprogramclass */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FRXPREPROGRAMCLASS)
using namespace Frxpreprogramclass;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// FrxpreprogramclassHPP
