// CodeGear C++Builder
// Copyright (c) 1995, 2013 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'frxOLE.pas' rev: 26.00 (Windows)

#ifndef FrxoleHPP
#define FrxoleHPP

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
#include <Vcl.OleCtnrs.hpp>	// Pascal unit
#include <Vcl.StdCtrls.hpp>	// Pascal unit
#include <Vcl.ExtCtrls.hpp>	// Pascal unit
#include <frxClass.hpp>	// Pascal unit
#include <Winapi.ActiveX.hpp>	// Pascal unit
#include <System.Variants.hpp>	// Pascal unit
#include <System.UITypes.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Frxole
{
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TfrxSizeMode : unsigned char { fsmClip, fsmScale };

class DELPHICLASS TfrxOLEObject;
class PASCALIMPLEMENTATION TfrxOLEObject : public System::Classes::TComponent
{
	typedef System::Classes::TComponent inherited;
	
public:
	/* TComponent.Create */ inline __fastcall virtual TfrxOLEObject(System::Classes::TComponent* AOwner) : System::Classes::TComponent(AOwner) { }
	/* TComponent.Destroy */ inline __fastcall virtual ~TfrxOLEObject(void) { }
	
};


class DELPHICLASS TfrxOLEView;
class PASCALIMPLEMENTATION TfrxOLEView : public Frxclass::TfrxView
{
	typedef Frxclass::TfrxView inherited;
	
private:
	Vcl::Olectnrs::TOleContainer* FOleContainer;
	TfrxSizeMode FSizeMode;
	bool FStretched;
	void __fastcall ReadData(System::Classes::TStream* Stream);
	void __fastcall SetStretched(const bool Value);
	void __fastcall WriteData(System::Classes::TStream* Stream);
	
protected:
	virtual void __fastcall DefineProperties(System::Classes::TFiler* Filer);
	
public:
	__fastcall virtual TfrxOLEView(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TfrxOLEView(void);
	virtual void __fastcall Draw(Vcl::Graphics::TCanvas* Canvas, System::Extended ScaleX, System::Extended ScaleY, System::Extended OffsetX, System::Extended OffsetY);
	virtual void __fastcall GetData(void);
	__classmethod virtual System::UnicodeString __fastcall GetDescription();
	__property Vcl::Olectnrs::TOleContainer* OleContainer = {read=FOleContainer};
	
__published:
	__property BrushStyle;
	__property Color;
	__property Cursor = {default=0};
	__property DataField = {default=0};
	__property DataSet;
	__property DataSetName = {default=0};
	__property FillType = {default=0};
	__property Fill;
	__property Frame;
	__property TfrxSizeMode SizeMode = {read=FSizeMode, write=FSizeMode, default=0};
	__property bool Stretched = {read=FStretched, write=SetStretched, default=0};
	__property TagStr = {default=0};
	__property URL = {default=0};
public:
	/* TfrxComponent.DesignCreate */ inline __fastcall virtual TfrxOLEView(System::Classes::TComponent* AOwner, System::Word Flags) : Frxclass::TfrxView(AOwner, Flags) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE void __fastcall frxAssignOle(Vcl::Olectnrs::TOleContainer* ContFrom, Vcl::Olectnrs::TOleContainer* ContTo);
}	/* namespace Frxole */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FRXOLE)
using namespace Frxole;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// FrxoleHPP
