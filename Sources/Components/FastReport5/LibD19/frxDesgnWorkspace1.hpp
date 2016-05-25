// CodeGear C++Builder
// Copyright (c) 1995, 2013 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'frxDesgnWorkspace1.pas' rev: 26.00 (Windows)

#ifndef Frxdesgnworkspace1HPP
#define Frxdesgnworkspace1HPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <Winapi.Windows.hpp>	// Pascal unit
#include <Winapi.Messages.hpp>	// Pascal unit
#include <System.Types.hpp>	// Pascal unit
#include <System.SysUtils.hpp>	// Pascal unit
#include <System.Classes.hpp>	// Pascal unit
#include <Vcl.Graphics.hpp>	// Pascal unit
#include <Vcl.Controls.hpp>	// Pascal unit
#include <Vcl.Forms.hpp>	// Pascal unit
#include <Vcl.Dialogs.hpp>	// Pascal unit
#include <Vcl.ExtCtrls.hpp>	// Pascal unit
#include <Vcl.StdCtrls.hpp>	// Pascal unit
#include <Vcl.Buttons.hpp>	// Pascal unit
#include <frxClass.hpp>	// Pascal unit
#include <frxDesgn.hpp>	// Pascal unit
#include <frxDesgnWorkspace.hpp>	// Pascal unit
#include <frxPopupForm.hpp>	// Pascal unit
#include <System.Variants.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Frxdesgnworkspace1
{
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TfrxDesignTool : unsigned char { dtSelect, dtHand, dtZoom, dtText, dtFormat };

class DELPHICLASS TfrxGuideItem;
class PASCALIMPLEMENTATION TfrxGuideItem : public System::Classes::TCollectionItem
{
	typedef System::Classes::TCollectionItem inherited;
	
public:
	System::Extended Left;
	System::Extended Top;
	System::Extended Right;
	System::Extended Bottom;
public:
	/* TCollectionItem.Create */ inline __fastcall virtual TfrxGuideItem(System::Classes::TCollection* Collection) : System::Classes::TCollectionItem(Collection) { }
	/* TCollectionItem.Destroy */ inline __fastcall virtual ~TfrxGuideItem(void) { }
	
};


class DELPHICLASS TfrxVirtualGuides;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TfrxVirtualGuides : public System::Classes::TCollection
{
	typedef System::Classes::TCollection inherited;
	
public:
	TfrxGuideItem* operator[](int Index) { return Items[Index]; }
	
private:
	TfrxGuideItem* __fastcall GetGuides(int Index);
	
public:
	__fastcall TfrxVirtualGuides(void);
	HIDESBASE void __fastcall Add(System::Extended Left, System::Extended Top, System::Extended Right, System::Extended Bottom);
	__property TfrxGuideItem* Items[int Index] = {read=GetGuides/*, default*/};
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TfrxVirtualGuides(void) { }
	
};

#pragma pack(pop)

class DELPHICLASS TDesignerWorkspace;
class PASCALIMPLEMENTATION TDesignerWorkspace : public Frxdesgnworkspace::TfrxDesignerWorkspace
{
	typedef Frxdesgnworkspace::TfrxDesignerWorkspace inherited;
	
private:
	Frxdesgn::TfrxDesignerForm* FDesigner;
	int FGuide;
	Vcl::Stdctrls::TListBox* FListBox;
	Frxclass::TfrxMemoView* FMemo;
	Frxpopupform::TfrxPopupForm* FPopupForm;
	bool FPopupFormVisible;
	bool FShowGuides;
	bool FSimulateMove;
	TfrxDesignTool FTool;
	TfrxVirtualGuides* FVirtualGuides;
	System::Classes::TList* FVirtualGuideObjects;
	void __fastcall DoLBClick(System::TObject* Sender);
	void __fastcall DoPopupHide(System::TObject* Sender);
	void __fastcall CreateVirtualGuides(void);
	void __fastcall LBDrawItem(Vcl::Controls::TWinControl* Control, int Index, const System::Types::TRect &ARect, Winapi::Windows::TOwnerDrawState State);
	void __fastcall SetShowGuides(const bool Value);
	void __fastcall SetHGuides(System::Classes::TStrings* const Value);
	void __fastcall SetVGuides(System::Classes::TStrings* const Value);
	System::Classes::TStrings* __fastcall GetHGuides(void);
	System::Classes::TStrings* __fastcall GetVGuides(void);
	__property System::Classes::TStrings* HGuides = {read=GetHGuides, write=SetHGuides};
	__property System::Classes::TStrings* VGuides = {read=GetVGuides, write=SetVGuides};
	void __fastcall SetTool(const TfrxDesignTool Value);
	
protected:
	virtual void __fastcall CheckGuides(System::Extended &kx, System::Extended &ky, bool &Result);
	DYNAMIC void __fastcall DragOver(System::TObject* Source, int X, int Y, System::Uitypes::TDragState State, bool &Accept);
	virtual void __fastcall DrawObjects(void);
	DYNAMIC void __fastcall KeyDown(System::Word &Key, System::Classes::TShiftState Shift);
	DYNAMIC void __fastcall MouseDown(System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseMove(System::Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseUp(System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall DblClick(void);
	
public:
	__fastcall virtual TDesignerWorkspace(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TDesignerWorkspace(void);
	virtual void __fastcall DeleteObjects(void);
	DYNAMIC void __fastcall DragDrop(System::TObject* Source, int X, int Y);
	void __fastcall SimulateMove(void);
	virtual void __fastcall SetInsertion(Frxclass::TfrxComponentClass AClass, System::Extended AWidth, System::Extended AHeight, System::Word AFlag);
	__property bool ShowGuides = {read=FShowGuides, write=SetShowGuides, nodefault};
	__property TfrxDesignTool Tool = {read=FTool, write=SetTool, nodefault};
public:
	/* TWinControl.CreateParented */ inline __fastcall TDesignerWorkspace(HWND ParentWindow) : Frxdesgnworkspace::TfrxDesignerWorkspace(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Frxdesgnworkspace1 */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FRXDESGNWORKSPACE1)
using namespace Frxdesgnworkspace1;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Frxdesgnworkspace1HPP
