// CodeGear C++Builder
// Copyright (c) 1995, 2013 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'frxBarcode.pas' rev: 26.00 (Windows)

#ifndef FrxbarcodeHPP
#define FrxbarcodeHPP

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
#include <Vcl.Graphics.hpp>	// Pascal unit
#include <Vcl.Controls.hpp>	// Pascal unit
#include <Vcl.Forms.hpp>	// Pascal unit
#include <Vcl.Dialogs.hpp>	// Pascal unit
#include <Vcl.StdCtrls.hpp>	// Pascal unit
#include <Vcl.Menus.hpp>	// Pascal unit
#include <frxBarcod.hpp>	// Pascal unit
#include <frxClass.hpp>	// Pascal unit
#include <Vcl.ExtCtrls.hpp>	// Pascal unit
#include <System.Variants.hpp>	// Pascal unit
#include <System.UITypes.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Frxbarcode
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TfrxBarCodeObject;
class PASCALIMPLEMENTATION TfrxBarCodeObject : public System::Classes::TComponent
{
	typedef System::Classes::TComponent inherited;
	
public:
	/* TComponent.Create */ inline __fastcall virtual TfrxBarCodeObject(System::Classes::TComponent* AOwner) : System::Classes::TComponent(AOwner) { }
	/* TComponent.Destroy */ inline __fastcall virtual ~TfrxBarCodeObject(void) { }
	
};


class DELPHICLASS TfrxBarCodeView;
class PASCALIMPLEMENTATION TfrxBarCodeView : public Frxclass::TfrxView
{
	typedef Frxclass::TfrxView inherited;
	
private:
	Frxbarcod::TfrxBarcode* FBarCode;
	Frxbarcod::TfrxBarcodeType FBarType;
	bool FCalcCheckSum;
	System::UnicodeString FExpression;
	Frxclass::TfrxHAlign FHAlign;
	int FRotation;
	bool FShowText;
	System::UnicodeString FText;
	System::Extended FWideBarRatio;
	System::Extended FZoom;
	void __fastcall BcFontChanged(System::TObject* Sender);
	
public:
	__fastcall virtual TfrxBarCodeView(System::Classes::TComponent* AOwner);
	__fastcall virtual TfrxBarCodeView(System::Classes::TComponent* AOwner, System::Word Flags);
	__fastcall virtual ~TfrxBarCodeView(void);
	virtual void __fastcall Draw(Vcl::Graphics::TCanvas* Canvas, System::Extended ScaleX, System::Extended ScaleY, System::Extended OffsetX, System::Extended OffsetY);
	virtual void __fastcall GetData(void);
	__classmethod virtual System::UnicodeString __fastcall GetDescription();
	virtual Frxclass::TfrxRect __fastcall GetRealBounds(void);
	__property Frxbarcod::TfrxBarcode* BarCode = {read=FBarCode};
	
__published:
	__property Frxbarcod::TfrxBarcodeType BarType = {read=FBarType, write=FBarType, nodefault};
	__property BrushStyle;
	__property bool CalcCheckSum = {read=FCalcCheckSum, write=FCalcCheckSum, default=0};
	__property FillType = {default=0};
	__property Fill;
	__property Cursor = {default=0};
	__property DataField = {default=0};
	__property DataSet;
	__property DataSetName = {default=0};
	__property System::UnicodeString Expression = {read=FExpression, write=FExpression};
	__property Frame;
	__property Frxclass::TfrxHAlign HAlign = {read=FHAlign, write=FHAlign, default=0};
	__property int Rotation = {read=FRotation, write=FRotation, nodefault};
	__property bool ShowText = {read=FShowText, write=FShowText, default=1};
	__property TagStr = {default=0};
	__property System::UnicodeString Text = {read=FText, write=FText};
	__property URL = {default=0};
	__property System::Extended WideBarRatio = {read=FWideBarRatio, write=FWideBarRatio};
	__property System::Extended Zoom = {read=FZoom, write=FZoom};
	__property Font;
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Frxbarcode */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FRXBARCODE)
using namespace Frxbarcode;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// FrxbarcodeHPP
