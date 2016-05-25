// CodeGear C++Builder
// Copyright (c) 1995, 2013 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'frxIndexToLocationClass.pas' rev: 26.00 (Windows)

#ifndef FrxindextolocationclassHPP
#define FrxindextolocationclassHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.SysUtils.hpp>	// Pascal unit
#include <TTFHelpers.hpp>	// Pascal unit
#include <frxFontHeaderClass.hpp>	// Pascal unit
#include <frxTrueTypeTable.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Frxindextolocationclass
{
//-- type declarations -------------------------------------------------------
typedef System::DynamicArray<unsigned> TCardinalArray;

typedef System::DynamicArray<System::Word> TWordArray;

class DELPHICLASS IndexToLocationClass;
#pragma pack(push,4)
class PASCALIMPLEMENTATION IndexToLocationClass : public Frxtruetypetable::TrueTypeTable
{
	typedef Frxtruetypetable::TrueTypeTable inherited;
	
private:
	TCardinalArray LongIndexToLocation;
	TWordArray ShortIndexToLocation;
	
public:
	__fastcall IndexToLocationClass(Frxtruetypetable::TrueTypeTable* src);
	System::Word __fastcall GetGlyph(System::Word i2l_idx, Frxfontheaderclass::FontHeaderClass* font_header, unsigned &location);
	void __fastcall LoadIndexToLocation(void * font, Frxfontheaderclass::FontHeaderClass* font_header);
	__property TCardinalArray Long = {read=LongIndexToLocation};
	__property TWordArray Short = {read=ShortIndexToLocation};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~IndexToLocationClass(void) { }
	
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
}	/* namespace Frxindextolocationclass */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FRXINDEXTOLOCATIONCLASS)
using namespace Frxindextolocationclass;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// FrxindextolocationclassHPP
