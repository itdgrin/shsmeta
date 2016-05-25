// CodeGear C++Builder
// Copyright (c) 1995, 2013 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'frxDMPClass.pas' rev: 26.00 (Windows)

#ifndef FrxdmpclassHPP
#define FrxdmpclassHPP

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
#include <System.UITypes.hpp>	// Pascal unit
#include <System.WideStrings.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Frxdmpclass
{
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TfrxDMPFontStyle : unsigned char { fsxBold, fsxItalic, fsxUnderline, fsxSuperScript, fsxSubScript, fsxCondensed, fsxWide, fsx12cpi, fsx15cpi };

typedef System::Set<TfrxDMPFontStyle, TfrxDMPFontStyle::fsxBold, TfrxDMPFontStyle::fsx15cpi> TfrxDMPFontStyles;

class DELPHICLASS TfrxDMPMemoView;
class PASCALIMPLEMENTATION TfrxDMPMemoView : public Frxclass::TfrxCustomMemoView
{
	typedef Frxclass::TfrxCustomMemoView inherited;
	
private:
	TfrxDMPFontStyles FFontStyle;
	bool FTruncOutboundText;
	void __fastcall SetFontStyle(const TfrxDMPFontStyles Value);
	bool __fastcall IsFontStyleStored(void);
	
protected:
	virtual void __fastcall DrawFrame(void);
	virtual void __fastcall SetLeft(System::Extended Value);
	virtual void __fastcall SetTop(System::Extended Value);
	virtual void __fastcall SetWidth(System::Extended Value);
	virtual void __fastcall SetHeight(System::Extended Value);
	virtual void __fastcall SetParentFont(const bool Value);
	
public:
	__fastcall virtual TfrxDMPMemoView(System::Classes::TComponent* AOwner);
	__classmethod virtual System::UnicodeString __fastcall GetDescription();
	void __fastcall ResetFontOptions(void);
	void __fastcall SetBoundsDirect(System::Extended ALeft, System::Extended ATop, System::Extended AWidth, System::Extended AHeight);
	virtual System::Extended __fastcall CalcHeight(void);
	virtual System::Extended __fastcall CalcWidth(void);
	System::UnicodeString __fastcall GetoutBoundText(void);
	
__published:
	__property AutoWidth = {default=0};
	__property AllowExpressions = {default=1};
	__property DataField = {default=0};
	__property DataSet;
	__property DataSetName = {default=0};
	__property DisplayFormat;
	__property ExpressionDelimiters = {default=0};
	__property FlowTo;
	__property TfrxDMPFontStyles FontStyle = {read=FFontStyle, write=SetFontStyle, stored=IsFontStyleStored, nodefault};
	__property Frame;
	__property HAlign = {default=0};
	__property HideZeros = {default=0};
	__property Memo;
	__property ParentFont = {default=1};
	__property RTLReading = {default=0};
	__property SuppressRepeated = {default=0};
	__property WordWrap = {default=1};
	__property bool TruncOutboundText = {read=FTruncOutboundText, write=FTruncOutboundText, nodefault};
	__property VAlign = {default=0};
public:
	/* TfrxCustomMemoView.Destroy */ inline __fastcall virtual ~TfrxDMPMemoView(void) { }
	
public:
	/* TfrxComponent.DesignCreate */ inline __fastcall virtual TfrxDMPMemoView(System::Classes::TComponent* AOwner, System::Word Flags) : Frxclass::TfrxCustomMemoView(AOwner, Flags) { }
	
};


class DELPHICLASS TfrxDMPLineView;
class PASCALIMPLEMENTATION TfrxDMPLineView : public Frxclass::TfrxCustomLineView
{
	typedef Frxclass::TfrxCustomLineView inherited;
	
private:
	TfrxDMPFontStyles FFontStyle;
	void __fastcall SetFontStyle(const TfrxDMPFontStyles Value);
	bool __fastcall IsFontStyleStored(void);
	
protected:
	virtual void __fastcall SetLeft(System::Extended Value);
	virtual void __fastcall SetTop(System::Extended Value);
	virtual void __fastcall SetWidth(System::Extended Value);
	virtual void __fastcall SetParentFont(const bool Value);
	
public:
	__classmethod virtual System::UnicodeString __fastcall GetDescription();
	
__published:
	__property TfrxDMPFontStyles FontStyle = {read=FFontStyle, write=SetFontStyle, stored=IsFontStyleStored, nodefault};
	__property ParentFont = {default=1};
public:
	/* TfrxCustomLineView.Create */ inline __fastcall virtual TfrxDMPLineView(System::Classes::TComponent* AOwner) : Frxclass::TfrxCustomLineView(AOwner) { }
	/* TfrxCustomLineView.DesignCreate */ inline __fastcall virtual TfrxDMPLineView(System::Classes::TComponent* AOwner, System::Word Flags) : Frxclass::TfrxCustomLineView(AOwner, Flags) { }
	
public:
	/* TfrxView.Destroy */ inline __fastcall virtual ~TfrxDMPLineView(void) { }
	
};


class DELPHICLASS TfrxDMPCommand;
class PASCALIMPLEMENTATION TfrxDMPCommand : public Frxclass::TfrxView
{
	typedef Frxclass::TfrxView inherited;
	
private:
	System::UnicodeString FCommand;
	
protected:
	virtual void __fastcall SetLeft(System::Extended Value);
	virtual void __fastcall SetTop(System::Extended Value);
	
public:
	__classmethod virtual System::UnicodeString __fastcall GetDescription();
	System::UnicodeString __fastcall ToChr(void);
	
__published:
	__property System::UnicodeString Command = {read=FCommand, write=FCommand};
public:
	/* TfrxView.Create */ inline __fastcall virtual TfrxDMPCommand(System::Classes::TComponent* AOwner) : Frxclass::TfrxView(AOwner) { }
	/* TfrxView.Destroy */ inline __fastcall virtual ~TfrxDMPCommand(void) { }
	
public:
	/* TfrxComponent.DesignCreate */ inline __fastcall virtual TfrxDMPCommand(System::Classes::TComponent* AOwner, System::Word Flags) : Frxclass::TfrxView(AOwner, Flags) { }
	
};


class DELPHICLASS TfrxDMPPage;
class PASCALIMPLEMENTATION TfrxDMPPage : public Frxclass::TfrxReportPage
{
	typedef Frxclass::TfrxReportPage inherited;
	
private:
	TfrxDMPFontStyles FFontStyle;
	void __fastcall SetFontStyle(const TfrxDMPFontStyles Value);
	
protected:
	virtual void __fastcall SetPaperHeight(const System::Extended Value);
	virtual void __fastcall SetPaperWidth(const System::Extended Value);
	virtual void __fastcall SetPaperSize(const int Value);
	
public:
	__fastcall virtual TfrxDMPPage(System::Classes::TComponent* AOwner);
	virtual void __fastcall SetDefaults(void);
	void __fastcall ResetFontOptions(void);
	
__published:
	__property TfrxDMPFontStyles FontStyle = {read=FFontStyle, write=SetFontStyle, nodefault};
public:
	/* TfrxReportPage.Destroy */ inline __fastcall virtual ~TfrxDMPPage(void) { }
	
public:
	/* TfrxComponent.DesignCreate */ inline __fastcall virtual TfrxDMPPage(System::Classes::TComponent* AOwner, System::Word Flags) : Frxclass::TfrxReportPage(AOwner, Flags) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Frxdmpclass */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FRXDMPCLASS)
using namespace Frxdmpclass;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// FrxdmpclassHPP
