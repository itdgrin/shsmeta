// CodeGear C++Builder
// Copyright (c) 1995, 2013 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'frxChBox.pas' rev: 26.00 (Windows)

#ifndef FrxchboxHPP
#define FrxchboxHPP

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
#include <Vcl.Menus.hpp>	// Pascal unit
#include <frxClass.hpp>	// Pascal unit
#include <System.Variants.hpp>	// Pascal unit
#include <Vcl.Controls.hpp>	// Pascal unit
#include <System.UITypes.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Frxchbox
{
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TfrxCheckStyle : unsigned char { csCross, csCheck, csLineCross, csPlus };

enum DECLSPEC_DENUM TfrxUncheckStyle : unsigned char { usEmpty, usCross, usLineCross, usMinus };

class DELPHICLASS TfrxCheckBoxObject;
class PASCALIMPLEMENTATION TfrxCheckBoxObject : public System::Classes::TComponent
{
	typedef System::Classes::TComponent inherited;
	
public:
	/* TComponent.Create */ inline __fastcall virtual TfrxCheckBoxObject(System::Classes::TComponent* AOwner) : System::Classes::TComponent(AOwner) { }
	/* TComponent.Destroy */ inline __fastcall virtual ~TfrxCheckBoxObject(void) { }
	
};


class DELPHICLASS TfrxCheckBoxView;
class PASCALIMPLEMENTATION TfrxCheckBoxView : public Frxclass::TfrxView
{
	typedef Frxclass::TfrxView inherited;
	
private:
	System::Uitypes::TColor FCheckColor;
	bool FChecked;
	TfrxCheckStyle FCheckStyle;
	TfrxUncheckStyle FUncheckStyle;
	System::UnicodeString FExpression;
	void __fastcall DrawCheck(const System::Types::TRect &ARect);
	
public:
	__fastcall virtual TfrxCheckBoxView(System::Classes::TComponent* AOwner);
	virtual void __fastcall Draw(Vcl::Graphics::TCanvas* Canvas, System::Extended ScaleX, System::Extended ScaleY, System::Extended OffsetX, System::Extended OffsetY);
	virtual void __fastcall GetData(void);
	__classmethod virtual System::UnicodeString __fastcall GetDescription();
	
__published:
	__property BrushStyle;
	__property System::Uitypes::TColor CheckColor = {read=FCheckColor, write=FCheckColor, nodefault};
	__property bool Checked = {read=FChecked, write=FChecked, default=1};
	__property TfrxCheckStyle CheckStyle = {read=FCheckStyle, write=FCheckStyle, nodefault};
	__property Color;
	__property Cursor = {default=0};
	__property DataField = {default=0};
	__property DataSet;
	__property DataSetName = {default=0};
	__property System::UnicodeString Expression = {read=FExpression, write=FExpression};
	__property Frame;
	__property TagStr = {default=0};
	__property TfrxUncheckStyle UncheckStyle = {read=FUncheckStyle, write=FUncheckStyle, default=0};
	__property URL = {default=0};
public:
	/* TfrxView.Destroy */ inline __fastcall virtual ~TfrxCheckBoxView(void) { }
	
public:
	/* TfrxComponent.DesignCreate */ inline __fastcall virtual TfrxCheckBoxView(System::Classes::TComponent* AOwner, System::Word Flags) : Frxclass::TfrxView(AOwner, Flags) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Frxchbox */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FRXCHBOX)
using namespace Frxchbox;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// FrxchboxHPP
