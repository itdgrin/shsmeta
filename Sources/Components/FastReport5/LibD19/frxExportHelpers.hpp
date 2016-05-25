// CodeGear C++Builder
// Copyright (c) 1995, 2013 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'frxExportHelpers.pas' rev: 26.00 (Windows)

#ifndef FrxexporthelpersHPP
#define FrxexporthelpersHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <Winapi.Windows.hpp>	// Pascal unit
#include <Winapi.Messages.hpp>	// Pascal unit
#include <System.SysUtils.hpp>	// Pascal unit
#include <System.Classes.hpp>	// Pascal unit
#include <Vcl.Controls.hpp>	// Pascal unit
#include <Vcl.Forms.hpp>	// Pascal unit
#include <Vcl.Dialogs.hpp>	// Pascal unit
#include <Vcl.StdCtrls.hpp>	// Pascal unit
#include <Winapi.ShellAPI.hpp>	// Pascal unit
#include <Vcl.Graphics.hpp>	// Pascal unit
#include <Vcl.ComCtrls.hpp>	// Pascal unit
#include <frxClass.hpp>	// Pascal unit
#include <frxCrypto.hpp>	// Pascal unit
#include <frxStorage.hpp>	// Pascal unit
#include <frxGradient.hpp>	// Pascal unit
#include <System.UITypes.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Frxexporthelpers
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TfrxCSSStyle;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TfrxCSSStyle : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	System::UnicodeString operator[](System::UnicodeString Index) { return Style[Index]; }
	
private:
	System::Classes::TStrings* FKeys;
	System::Classes::TStrings* FValues;
	System::UnicodeString FName;
	void __fastcall SetStyle(System::UnicodeString Index, const System::UnicodeString Value);
	
public:
	__fastcall TfrxCSSStyle(void);
	__fastcall virtual ~TfrxCSSStyle(void);
	TfrxCSSStyle* __fastcall This(void);
	int __fastcall Count(void);
	System::UnicodeString __fastcall Text(bool Formatted = false);
	void __fastcall AssignTo(TfrxCSSStyle* Dest);
	__property System::UnicodeString Style[System::UnicodeString Index] = {write=SetStyle/*, default*/};
	__property System::UnicodeString Name = {read=FName, write=FName};
};

#pragma pack(pop)

class DELPHICLASS TfrxCSS;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TfrxCSS : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	Frxstorage::TObjList* FStyles;
	System::Classes::TList* FStyleHashes;
	
protected:
	TfrxCSSStyle* __fastcall GetStyle(int i);
	int __fastcall GetHash(const System::UnicodeString s);
	System::UnicodeString __fastcall GetStyleName(int i);
	int __fastcall GetStylesCount(void);
	
public:
	__fastcall TfrxCSS(void);
	__fastcall virtual ~TfrxCSS(void);
	System::UnicodeString __fastcall Add(TfrxCSSStyle* Style)/* overload */;
	TfrxCSSStyle* __fastcall Add(const System::UnicodeString StyleName)/* overload */;
	void __fastcall Save(System::Classes::TStream* Stream, bool Formatted);
};

#pragma pack(pop)

struct DECLSPEC_DRECORD TfrxPictureInfo
{
public:
	System::UnicodeString Extension;
	System::UnicodeString Mimetype;
};


class DELPHICLASS TfrxPictureStorage;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TfrxPictureStorage : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	System::UnicodeString FWorkDir;
	System::Classes::TList* FHashes;
	
protected:
	int __fastcall GetHash(System::Classes::TMemoryStream* Stream);
	
public:
	__fastcall TfrxPictureStorage(const System::UnicodeString WorkDir);
	__fastcall virtual ~TfrxPictureStorage(void);
	System::UnicodeString __fastcall Save(Vcl::Graphics::TGraphic* Pic);
	__classmethod TfrxPictureInfo __fastcall GetInfo(Vcl::Graphics::TGraphic* Pic);
};

#pragma pack(pop)

enum DECLSPEC_DENUM TfrxPictureFormat : unsigned char { pfPNG, pfEMF, pfBMP, pfJPG };

class DELPHICLASS TfrxPicture;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TfrxPicture : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	TfrxPictureFormat FFormat;
	Vcl::Graphics::TGraphic* FGraphic;
	Vcl::Graphics::TCanvas* FCanvas;
	Vcl::Graphics::TBitmap* FBitmap;
	
public:
	__fastcall TfrxPicture(TfrxPictureFormat Format, int Width, int Height);
	__fastcall virtual ~TfrxPicture(void);
	Vcl::Graphics::TGraphic* __fastcall Release(void);
	__property Vcl::Graphics::TCanvas* Canvas = {read=FCanvas};
};

#pragma pack(pop)

typedef bool __fastcall (__closure *TfrxExportHandler)(Frxclass::TfrxView* Obj);

//-- var, const, procedure ---------------------------------------------------
}	/* namespace Frxexporthelpers */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FRXEXPORTHELPERS)
using namespace Frxexporthelpers;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// FrxexporthelpersHPP
