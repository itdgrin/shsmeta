// CodeGear C++Builder
// Copyright (c) 1995, 2013 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'frxGraphicUtils.pas' rev: 26.00 (Windows)

#ifndef FrxgraphicutilsHPP
#define FrxgraphicutilsHPP

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
#include <Vcl.Dialogs.hpp>	// Pascal unit
#include <frxClass.hpp>	// Pascal unit
#include <System.Variants.hpp>	// Pascal unit
#include <frxUnicodeUtils.hpp>	// Pascal unit
#include <System.WideStrings.hpp>	// Pascal unit
#include <System.UITypes.hpp>	// Pascal unit
#include <System.Types.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------
#undef NewLine

namespace Frxgraphicutils
{
//-- type declarations -------------------------------------------------------
typedef System::StaticArray<int, 536870911> TIntArray;

typedef TIntArray *PIntArray;

enum DECLSPEC_DENUM TSubStyle : unsigned char { ssNormal, ssSubscript, ssSuperscript };

class DELPHICLASS TfrxHTMLTag;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TfrxHTMLTag : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	int Position;
	int Size;
	int AddY;
	System::Uitypes::TFontStyles Style;
	int Color;
	bool Default;
	bool Small;
	bool DontWRAP;
	TSubStyle SubType;
	void __fastcall Assign(TfrxHTMLTag* Tag);
public:
	/* TObject.Create */ inline __fastcall TfrxHTMLTag(void) : System::TObject() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TfrxHTMLTag(void) { }
	
};

#pragma pack(pop)

class DELPHICLASS TfrxHTMLTags;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TfrxHTMLTags : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	TfrxHTMLTag* operator[](int Index) { return Items[Index]; }
	
private:
	System::Classes::TList* FItems;
	void __fastcall Add(TfrxHTMLTag* Tag);
	TfrxHTMLTag* __fastcall GetItems(int Index);
	
public:
	__fastcall TfrxHTMLTags(void);
	__fastcall virtual ~TfrxHTMLTags(void);
	void __fastcall Clear(void);
	int __fastcall Count(void);
	__property TfrxHTMLTag* Items[int Index] = {read=GetItems/*, default*/};
};

#pragma pack(pop)

class DELPHICLASS TfrxHTMLTagsList;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TfrxHTMLTagsList : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	TfrxHTMLTags* operator[](int Index) { return Items[Index]; }
	
private:
	bool FAllowTags;
	int FAddY;
	int FColor;
	int FDefColor;
	int FDefSize;
	System::Uitypes::TFontStyles FDefStyle;
	System::Classes::TList* FItems;
	int FPosition;
	int FSize;
	System::Uitypes::TFontStyles FStyle;
	bool FDontWRAP;
	TIntArray *FTempArray;
	TSubStyle FSubStyle;
	void __fastcall NewLine(void);
	void __fastcall Wrap(int TagsCount, bool AddBreak);
	TfrxHTMLTag* __fastcall Add(void);
	int __fastcall FillCharSpacingArray(PIntArray &ar, const System::WideString s, Vcl::Graphics::TCanvas* Canvas, int LineIndex, int Add, bool Convert, bool DefCharset);
	TfrxHTMLTags* __fastcall GetItems(int Index);
	TfrxHTMLTag* __fastcall GetPrevTag(void);
	
public:
	__fastcall TfrxHTMLTagsList(void);
	__fastcall virtual ~TfrxHTMLTagsList(void);
	void __fastcall Clear(void);
	void __fastcall SetDefaults(System::Uitypes::TColor DefColor, int DefSize, System::Uitypes::TFontStyles DefStyle);
	void __fastcall ExpandHTMLTags(System::WideString &s);
	int __fastcall Count(void);
	__property bool AllowTags = {read=FAllowTags, write=FAllowTags, nodefault};
	__property TfrxHTMLTags* Items[int Index] = {read=GetItems/*, default*/};
	__property int Position = {read=FPosition, write=FPosition, nodefault};
};

#pragma pack(pop)

class DELPHICLASS TfrxDrawText;
class PASCALIMPLEMENTATION TfrxDrawText : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	Vcl::Graphics::TBitmap* FBMP;
	Vcl::Graphics::TCanvas* FCanvas;
	int FDefPPI;
	int FScrPPI;
	TIntArray *FTempArray;
	int FFontSize;
	TfrxHTMLTagsList* FHTMLTags;
	System::Extended FCharSpacing;
	System::Extended FLineSpacing;
	int FOptions;
	System::Types::TRect FOriginalRect;
	System::Extended FParagraphGap;
	System::WideString FPlainText;
	System::Extended FPrintScale;
	int FRotation;
	bool FRTLReading;
	System::Types::TRect FScaledRect;
	System::Extended FScaleX;
	System::Extended FScaleY;
	System::Widestrings::TWideStrings* FText;
	bool FWordBreak;
	bool FWordWrap;
	bool FWysiwyg;
	bool FMonoFont;
	bool FUseDefaultCharset;
	System::WideString __fastcall GetWrappedText(void);
	bool __fastcall IsPrinter(Vcl::Graphics::TCanvas* C);
	void __fastcall DrawTextLine(Vcl::Graphics::TCanvas* C, const System::WideString s, int X, int Y, int DX, int LineIndex, Frxclass::TfrxHAlign Align, HFONT &fh, HFONT &oldfh);
	void __fastcall WrapTextLine(System::WideString s, int Width, int FirstLineWidth, int CharSpacing);
	
public:
	__fastcall TfrxDrawText(void);
	__fastcall virtual ~TfrxDrawText(void);
	void __fastcall SetFont(Vcl::Graphics::TFont* Font);
	void __fastcall SetOptions(bool WordWrap, bool HTMLTags, bool RTLReading, bool WordBreak, bool Clipped, bool Wysiwyg, int Rotation);
	void __fastcall SetGaps(System::Extended ParagraphGap, System::Extended CharSpacing, System::Extended LineSpacing);
	void __fastcall SetDimensions(System::Extended ScaleX, System::Extended ScaleY, System::Extended PrintScale, const System::Types::TRect &OriginalRect, const System::Types::TRect &ScaledRect);
	void __fastcall SetText(System::Widestrings::TWideStrings* Text, bool FirstParaBreak = false);
	void __fastcall SetParaBreaks(bool FirstParaBreak, bool LastParaBreak);
	System::WideString __fastcall DeleteTags(const System::WideString Txt);
	void __fastcall DrawText(Vcl::Graphics::TCanvas* C, Frxclass::TfrxHAlign HAlign, Frxclass::TfrxVAlign VAlign);
	System::Extended __fastcall CalcHeight(void);
	System::Extended __fastcall CalcWidth(void);
	System::Extended __fastcall LineHeight(void);
	System::Extended __fastcall TextHeight(void);
	System::WideString __fastcall GetInBoundsText(void);
	System::WideString __fastcall GetOutBoundsText(bool &ParaBreak);
	System::Extended __fastcall UnusedSpace(void);
	void __fastcall Lock(void);
	void __fastcall Unlock(void);
	__property Vcl::Graphics::TCanvas* Canvas = {read=FCanvas};
	__property int DefPPI = {read=FDefPPI, nodefault};
	__property int ScrPPI = {read=FScrPPI, nodefault};
	__property System::WideString WrappedText = {read=GetWrappedText};
	__property bool UseDefaultCharset = {read=FUseDefaultCharset, write=FUseDefaultCharset, nodefault};
	__property bool UseMonoFont = {read=FMonoFont, write=FMonoFont, nodefault};
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE TfrxDrawText* frxDrawText;
}	/* namespace Frxgraphicutils */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FRXGRAPHICUTILS)
using namespace Frxgraphicutils;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// FrxgraphicutilsHPP
