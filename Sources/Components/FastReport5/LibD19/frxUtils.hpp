// CodeGear C++Builder
// Copyright (c) 1995, 2013 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'frxUtils.pas' rev: 26.00 (Windows)

#ifndef FrxutilsHPP
#define FrxutilsHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.SysUtils.hpp>	// Pascal unit
#include <Winapi.Windows.hpp>	// Pascal unit
#include <Winapi.Messages.hpp>	// Pascal unit
#include <System.Classes.hpp>	// Pascal unit
#include <Vcl.Graphics.hpp>	// Pascal unit
#include <Vcl.Controls.hpp>	// Pascal unit
#include <Vcl.Forms.hpp>	// Pascal unit
#include <Vcl.StdCtrls.hpp>	// Pascal unit
#include <Vcl.Menus.hpp>	// Pascal unit
#include <Vcl.ImgList.hpp>	// Pascal unit
#include <Vcl.ActnList.hpp>	// Pascal unit
#include <Vcl.ComCtrls.hpp>	// Pascal unit
#include <frxClass.hpp>	// Pascal unit
#include <frxXML.hpp>	// Pascal unit
#include <frxCollections.hpp>	// Pascal unit
#include <System.UITypes.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Frxutils
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TfrxRectArea;
class PASCALIMPLEMENTATION TfrxRectArea : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	System::Extended X;
	System::Extended Y;
	System::Extended X1;
	System::Extended Y1;
	__fastcall TfrxRectArea(Frxclass::TfrxComponent* c)/* overload */;
	__fastcall TfrxRectArea(System::Extended Left, System::Extended Top, System::Extended Right, System::Extended Bottom)/* overload */;
	bool __fastcall InterceptsX(TfrxRectArea* a);
	bool __fastcall InterceptsY(TfrxRectArea* a);
	TfrxRectArea* __fastcall InterceptX(TfrxRectArea* a);
	TfrxRectArea* __fastcall InterceptY(TfrxRectArea* a);
	System::Extended __fastcall Max(System::Extended x1, System::Extended x2);
	System::Extended __fastcall Min(System::Extended x1, System::Extended x2);
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TfrxRectArea(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE unsigned __fastcall frxStreamCRC32(System::Classes::TStream* Stream);
extern DELPHI_PACKAGE System::Classes::TComponent* __fastcall frxFindComponent(System::Classes::TComponent* Owner, const System::UnicodeString Name);
extern DELPHI_PACKAGE void __fastcall frxGetComponents(System::Classes::TComponent* Owner, System::TClass ClassRef, System::Classes::TStrings* List, System::Classes::TComponent* Skip);
extern DELPHI_PACKAGE System::UnicodeString __fastcall frxGetFullName(System::Classes::TComponent* Owner, System::Classes::TComponent* c);
extern DELPHI_PACKAGE void __fastcall frxSetCommaText(const System::UnicodeString Text, System::Classes::TStrings* sl, System::WideChar Comma = (System::WideChar)(0x3b));
extern DELPHI_PACKAGE System::UnicodeString __fastcall frxRemoveQuotes(const System::UnicodeString s);
extern DELPHI_PACKAGE System::UnicodeString __fastcall frxStreamToString(System::Classes::TStream* Stream);
extern DELPHI_PACKAGE void __fastcall frxStringToStream(const System::UnicodeString s, System::Classes::TStream* Stream);
extern DELPHI_PACKAGE System::Extended __fastcall frxStrToFloat(System::UnicodeString s);
extern DELPHI_PACKAGE System::UnicodeString __fastcall frxFloatToStr(System::Extended d);
extern DELPHI_PACKAGE Frxclass::TfrxRect __fastcall frxRect(System::Extended ALeft, System::Extended ATop, System::Extended ARight, System::Extended ABottom);
extern DELPHI_PACKAGE Frxclass::TfrxPoint __fastcall frxPoint(System::Extended X, System::Extended Y);
extern DELPHI_PACKAGE System::AnsiString __fastcall frxGetBrackedVariable(const System::AnsiString Str, const System::AnsiString OpenBracket, const System::AnsiString CloseBracket, int &i, int &j);
extern DELPHI_PACKAGE System::WideString __fastcall frxGetBrackedVariableW(const System::WideString Str, const System::WideString OpenBracket, const System::WideString CloseBracket, int &i, int &j);
extern DELPHI_PACKAGE void __fastcall frxCommonErrorHandler(Frxclass::TfrxReport* Report, const System::UnicodeString Text);
extern DELPHI_PACKAGE void __fastcall frxErrorMsg(const System::UnicodeString Text);
extern DELPHI_PACKAGE int __fastcall frxConfirmMsg(const System::UnicodeString Text, int Buttons);
extern DELPHI_PACKAGE void __fastcall frxInfoMsg(const System::UnicodeString Text);
extern DELPHI_PACKAGE bool __fastcall frxIsValidFloat(const System::UnicodeString Value);
extern DELPHI_PACKAGE void __fastcall frxAssignImages(Vcl::Graphics::TBitmap* Bitmap, int dx, int dy, Vcl::Controls::TImageList* ImgList1, Vcl::Controls::TImageList* ImgList2 = (Vcl::Controls::TImageList*)(0x0));
extern DELPHI_PACKAGE void __fastcall frxDrawTransparent(Vcl::Graphics::TCanvas* Canvas, int x, int y, Vcl::Graphics::TBitmap* bmp);
extern DELPHI_PACKAGE void __fastcall frxDrawGraphic(Vcl::Graphics::TCanvas* Canvas, const System::Types::TRect &DestRect, Vcl::Graphics::TGraphic* aGraph, bool IsPrinting, bool Smooth, bool Transparent, System::Uitypes::TColor TransparentColor);
extern DELPHI_PACKAGE void __fastcall frxParsePageNumbers(const System::UnicodeString PageNumbers, System::Classes::TStrings* List, int Total);
extern DELPHI_PACKAGE System::UnicodeString __fastcall HTMLRGBColor(System::Uitypes::TColor Color);
extern DELPHI_PACKAGE void __fastcall frxWriteCollection(System::Classes::TCollection* Collection, System::Classes::TWriter* Writer, Frxclass::TfrxComponent* Owner)/* overload */;
extern DELPHI_PACKAGE void __fastcall frxWriteCollection(System::Classes::TCollection* Collection, const System::UnicodeString Name, Frxxml::TfrxXMLItem* Item, Frxclass::TfrxComponent* Owner, Frxcollections::TfrxCollection* aAncestor)/* overload */;
extern DELPHI_PACKAGE void __fastcall frxReadCollection(System::Classes::TCollection* Collection, System::Classes::TReader* Reader, Frxclass::TfrxComponent* Owner)/* overload */;
extern DELPHI_PACKAGE void __fastcall frxReadCollection(System::Classes::TCollection* Collection, Frxxml::TfrxXMLItem* Item, Frxclass::TfrxComponent* Owner, Frxcollections::TfrxCollection* aAncestor)/* overload */;
extern DELPHI_PACKAGE System::UnicodeString __fastcall GetTemporaryFolder(void);
extern DELPHI_PACKAGE System::UnicodeString __fastcall GetTempFile(void);
extern DELPHI_PACKAGE System::UnicodeString __fastcall frxCreateTempFile(const System::UnicodeString TempDir);
extern DELPHI_PACKAGE System::UnicodeString __fastcall GetAppFileName(void);
extern DELPHI_PACKAGE System::UnicodeString __fastcall GetAppPath(void);
extern DELPHI_PACKAGE System::UnicodeString __fastcall frFloat2Str(const System::Extended Value, const int Prec = 0x2, const System::WideChar Sep = (System::WideChar)(0x2e));
extern DELPHI_PACKAGE System::UnicodeString __fastcall frxReverseString(const System::UnicodeString AText);
extern DELPHI_PACKAGE System::UnicodeString __fastcall frxUnixPath2WinPath(const System::UnicodeString Path);
extern DELPHI_PACKAGE void __fastcall frxUpdateControl(Vcl::Controls::TWinControl* AControl, const bool ARepaint = true);
}	/* namespace Frxutils */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FRXUTILS)
using namespace Frxutils;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// FrxutilsHPP
