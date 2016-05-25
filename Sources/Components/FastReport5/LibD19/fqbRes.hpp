// CodeGear C++Builder
// Copyright (c) 1995, 2013 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'fqbRes.pas' rev: 26.00 (Windows)

#ifndef FqbresHPP
#define FqbresHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <Winapi.Windows.hpp>	// Pascal unit
#include <System.SysUtils.hpp>	// Pascal unit
#include <System.Classes.hpp>	// Pascal unit
#include <Vcl.Controls.hpp>	// Pascal unit
#include <Vcl.Graphics.hpp>	// Pascal unit
#include <Vcl.Forms.hpp>	// Pascal unit
#include <Vcl.ImgList.hpp>	// Pascal unit
#include <System.TypInfo.hpp>	// Pascal unit
#include <System.Variants.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Fqbres
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TfqbResources;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TfqbResources : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	System::Classes::TStringList* FNames;
	System::Classes::TStringList* FValues;
	
public:
	__fastcall TfqbResources(void);
	__fastcall virtual ~TfqbResources(void);
	System::UnicodeString __fastcall Get(const System::UnicodeString StrName);
	void __fastcall Add(const System::UnicodeString Ref, const System::UnicodeString Str);
	void __fastcall AddStrings(const System::UnicodeString Str);
	void __fastcall Clear(void);
	void __fastcall LoadFromFile(const System::UnicodeString FileName);
	void __fastcall LoadFromStream(System::Classes::TStream* Stream);
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE TfqbResources* __fastcall fqbResources(void);
extern DELPHI_PACKAGE System::UnicodeString __fastcall fqbGet(int ID);
}	/* namespace Fqbres */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FQBRES)
using namespace Fqbres;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// FqbresHPP
