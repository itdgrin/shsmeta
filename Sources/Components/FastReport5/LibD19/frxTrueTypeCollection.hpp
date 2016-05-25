// CodeGear C++Builder
// Copyright (c) 1995, 2013 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'frxTrueTypeCollection.pas' rev: 26.00 (Windows)

#ifndef FrxtruetypecollectionHPP
#define FrxtruetypecollectionHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.Classes.hpp>	// Pascal unit
#include <System.SysUtils.hpp>	// Pascal unit
#include <Vcl.Graphics.hpp>	// Pascal unit
#include <Winapi.Windows.hpp>	// Pascal unit
#include <TTFHelpers.hpp>	// Pascal unit
#include <frxTrueTypeFont.hpp>	// Pascal unit
#include <frxFontHeaderClass.hpp>	// Pascal unit
#include <frxNameTableClass.hpp>	// Pascal unit
#include <System.UITypes.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Frxtruetypecollection
{
//-- type declarations -------------------------------------------------------
typedef System::Classes::TList TFontCollection;

#pragma pack(push,1)
struct DECLSPEC_DRECORD TTCollectionHeader
{
public:
	unsigned TTCTag;
	unsigned Version;
	unsigned numFonts;
};
#pragma pack(pop)


class DELPHICLASS TrueTypeCollection;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TrueTypeCollection : public Ttfhelpers::TTF_Helpers
{
	typedef Ttfhelpers::TTF_Helpers inherited;
	
private:
	System::Classes::TList* fonts_collection;
	System::Classes::TList* __fastcall get_FontCollection(void);
	Frxtruetypefont::TrueTypeFont* __fastcall get_Item(System::UnicodeString FamilyName);
	
public:
	__fastcall TrueTypeCollection(void);
	__fastcall virtual ~TrueTypeCollection(void);
	void __fastcall Initialize(char * FD, int FontDataSize);
	Frxtruetypefont::TByteArray __fastcall PackFont(Vcl::Graphics::TFont* font, System::Classes::TList* UsedAlphabet);
	__property System::Classes::TList* FontCollection = {read=get_FontCollection};
	__property Frxtruetypefont::TrueTypeFont* Item[System::UnicodeString FamilyName] = {read=get_Item};
};

#pragma pack(pop)

typedef System::StaticArray<System::AnsiString, 10> Frxtruetypecollection__2;

//-- var, const, procedure ---------------------------------------------------
static const System::Int8 Elements = System::Int8(0xa);
extern DELPHI_PACKAGE Frxtruetypecollection__2 Substitutes;
}	/* namespace Frxtruetypecollection */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FRXTRUETYPECOLLECTION)
using namespace Frxtruetypecollection;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// FrxtruetypecollectionHPP
