// CodeGear C++Builder
// Copyright (c) 1995, 2013 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'frxBarcode2D.pas' rev: 26.00 (Windows)

#ifndef Frxbarcode2dHPP
#define Frxbarcode2dHPP

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
#include <System.Types.hpp>	// Pascal unit
#include <Vcl.Controls.hpp>	// Pascal unit
#include <Vcl.Forms.hpp>	// Pascal unit
#include <Vcl.Dialogs.hpp>	// Pascal unit
#include <Vcl.StdCtrls.hpp>	// Pascal unit
#include <Vcl.Menus.hpp>	// Pascal unit
#include <frxClass.hpp>	// Pascal unit
#include <Vcl.ExtCtrls.hpp>	// Pascal unit
#include <frxDesgn.hpp>	// Pascal unit
#include <frxBarcodePDF417.hpp>	// Pascal unit
#include <frxBarcodeDataMatrix.hpp>	// Pascal unit
#include <frxBarcodeQR.hpp>	// Pascal unit
#include <frxBarcode2DBase.hpp>	// Pascal unit
#include <frxBarcodeProperties.hpp>	// Pascal unit
#include <System.Variants.hpp>	// Pascal unit
#include <System.UITypes.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Frxbarcode2d
{
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TfrxBarcode2DType : unsigned char { bcCodePDF417, bcCodeDataMatrix, bcCodeQR };

class DELPHICLASS TfrxBarcode2DView;
class PASCALIMPLEMENTATION TfrxBarcode2DView : public Frxclass::TfrxView
{
	typedef Frxclass::TfrxView inherited;
	
private:
	Frxbarcode2dbase::TfrxBarcode2DBase* FBarCode;
	TfrxBarcode2DType FBarType;
	Frxclass::TfrxHAlign FHAlign;
	Frxbarcodeproperties::TfrxBarcode2DProperties* FProp;
	System::UnicodeString FExpression;
	void __fastcall SetZoom(System::Extended z);
	System::Extended __fastcall GetZoom(void);
	void __fastcall SetRotation(int v);
	int __fastcall GetRotation(void);
	void __fastcall SetShowText(bool v);
	bool __fastcall GetShowText(void);
	void __fastcall SetText(System::UnicodeString v);
	System::UnicodeString __fastcall GetText(void);
	void __fastcall SetFontScaled(bool v);
	bool __fastcall GetFontScaled(void);
	void __fastcall SetErrorText(System::UnicodeString v);
	System::UnicodeString __fastcall GetErrorText(void);
	void __fastcall SetQuietZone(int v);
	int __fastcall GetQuietZone(void);
	void __fastcall SetProp(Frxbarcodeproperties::TfrxBarcode2DProperties* v);
	void __fastcall SetBarType(TfrxBarcode2DType v);
	
public:
	__fastcall virtual TfrxBarcode2DView(System::Classes::TComponent* AOwner);
	__fastcall virtual TfrxBarcode2DView(System::Classes::TComponent* AOwner, System::Word Flags);
	__fastcall virtual ~TfrxBarcode2DView(void);
	virtual void __fastcall Draw(Vcl::Graphics::TCanvas* Canvas, System::Extended ScaleX, System::Extended ScaleY, System::Extended OffsetX, System::Extended OffsetY);
	__classmethod virtual System::UnicodeString __fastcall GetDescription();
	virtual void __fastcall GetData(void);
	virtual Frxclass::TfrxRect __fastcall GetRealBounds(void);
	
__published:
	__property System::UnicodeString Expression = {read=FExpression, write=FExpression};
	__property TfrxBarcode2DType BarType = {read=FBarType, write=SetBarType, nodefault};
	__property Frxbarcodeproperties::TfrxBarcode2DProperties* BarProperties = {read=FProp, write=SetProp};
	__property BrushStyle;
	__property Color;
	__property Cursor = {default=0};
	__property DataField = {default=0};
	__property DataSet;
	__property DataSetName = {default=0};
	__property Frame;
	__property Frxclass::TfrxHAlign HAlign = {read=FHAlign, write=FHAlign, default=0};
	__property int Rotation = {read=GetRotation, write=SetRotation, nodefault};
	__property bool ShowText = {read=GetShowText, write=SetShowText, nodefault};
	__property TagStr = {default=0};
	__property System::UnicodeString Text = {read=GetText, write=SetText};
	__property URL = {default=0};
	__property System::Extended Zoom = {read=GetZoom, write=SetZoom};
	__property Font;
	__property bool FontScaled = {read=GetFontScaled, write=SetFontScaled, nodefault};
	__property System::UnicodeString ErrorText = {read=GetErrorText, write=SetErrorText};
	__property int QuietZone = {read=GetQuietZone, write=SetQuietZone, nodefault};
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Frxbarcode2d */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FRXBARCODE2D)
using namespace Frxbarcode2d;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Frxbarcode2dHPP
