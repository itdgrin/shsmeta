// CodeGear C++Builder
// Copyright (c) 1995, 2013 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'frxDesgnCtrls.pas' rev: 26.00 (Windows)

#ifndef FrxdesgnctrlsHPP
#define FrxdesgnctrlsHPP

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
#include <System.Types.hpp>	// Pascal unit
#include <System.Classes.hpp>	// Pascal unit
#include <Vcl.Graphics.hpp>	// Pascal unit
#include <Vcl.Controls.hpp>	// Pascal unit
#include <Vcl.Forms.hpp>	// Pascal unit
#include <Vcl.Dialogs.hpp>	// Pascal unit
#include <Vcl.StdCtrls.hpp>	// Pascal unit
#include <Vcl.Buttons.hpp>	// Pascal unit
#include <Vcl.ExtCtrls.hpp>	// Pascal unit
#include <Vcl.ComCtrls.hpp>	// Pascal unit
#include <Vcl.ToolWin.hpp>	// Pascal unit
#include <Vcl.ImgList.hpp>	// Pascal unit
#include <frxClass.hpp>	// Pascal unit
#include <frxPictureCache.hpp>	// Pascal unit
#include <System.Variants.hpp>	// Pascal unit
#include <System.UITypes.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Frxdesgnctrls
{
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TfrxRulerUnits : unsigned char { ruCM, ruInches, ruPixels, ruChars };

class DELPHICLASS TfrxRuler;
class PASCALIMPLEMENTATION TfrxRuler : public Vcl::Extctrls::TPanel
{
	typedef Vcl::Extctrls::TPanel inherited;
	
private:
	int FOffset;
	System::Extended FScale;
	int FStart;
	TfrxRulerUnits FUnits;
	System::Extended FPosition;
	int FSize;
	void __fastcall SetOffset(const int Value);
	void __fastcall SetScale(const System::Extended Value);
	void __fastcall SetStart(const int Value);
	void __fastcall SetUnits(const TfrxRulerUnits Value);
	void __fastcall SetPosition(const System::Extended Value);
	MESSAGE void __fastcall WMEraseBackground(Winapi::Messages::TMessage &Message);
	void __fastcall SetSize(const int Value);
	
public:
	__fastcall virtual TfrxRuler(System::Classes::TComponent* AOwner);
	virtual void __fastcall Paint(void);
	
__published:
	__property int Offset = {read=FOffset, write=SetOffset, nodefault};
	__property System::Extended Scale = {read=FScale, write=SetScale};
	__property int Start = {read=FStart, write=SetStart, nodefault};
	__property TfrxRulerUnits Units = {read=FUnits, write=SetUnits, default=2};
	__property System::Extended Position = {read=FPosition, write=SetPosition};
	__property int Size = {read=FSize, write=SetSize, nodefault};
public:
	/* TCustomControl.Destroy */ inline __fastcall virtual ~TfrxRuler(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TfrxRuler(HWND ParentWindow) : Vcl::Extctrls::TPanel(ParentWindow) { }
	
};


class DELPHICLASS TfrxScrollBox;
class PASCALIMPLEMENTATION TfrxScrollBox : public Vcl::Forms::TScrollBox
{
	typedef Vcl::Forms::TScrollBox inherited;
	
protected:
	MESSAGE void __fastcall WMGetDlgCode(Winapi::Messages::TWMNoParams &Message);
	DYNAMIC void __fastcall KeyDown(System::Word &Key, System::Classes::TShiftState Shift);
	DYNAMIC void __fastcall KeyUp(System::Word &Key, System::Classes::TShiftState Shift);
	DYNAMIC void __fastcall KeyPress(System::WideChar &Key);
public:
	/* TScrollBox.Create */ inline __fastcall virtual TfrxScrollBox(System::Classes::TComponent* AOwner) : Vcl::Forms::TScrollBox(AOwner) { }
	
public:
	/* TScrollingWinControl.Destroy */ inline __fastcall virtual ~TfrxScrollBox(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TfrxScrollBox(HWND ParentWindow) : Vcl::Forms::TScrollBox(ParentWindow) { }
	
};


class DELPHICLASS TfrxCustomSelector;
class PASCALIMPLEMENTATION TfrxCustomSelector : public Vcl::Extctrls::TPanel
{
	typedef Vcl::Extctrls::TPanel inherited;
	
private:
	int FclWidth;
	int FclHeight;
	MESSAGE void __fastcall WMEraseBackground(Winapi::Messages::TMessage &Message);
	
protected:
	virtual void __fastcall DrawEdge(int X, int Y, bool IsDown) = 0 ;
	DYNAMIC void __fastcall MouseDown(System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseMove(System::Classes::TShiftState Shift, int X, int Y);
	
public:
	virtual void __fastcall Paint(void);
	__fastcall virtual TfrxCustomSelector(System::Classes::TComponent* AOwner);
public:
	/* TCustomControl.Destroy */ inline __fastcall virtual ~TfrxCustomSelector(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TfrxCustomSelector(HWND ParentWindow) : Vcl::Extctrls::TPanel(ParentWindow) { }
	
};


class DELPHICLASS TfrxColorSelector;
class PASCALIMPLEMENTATION TfrxColorSelector : public TfrxCustomSelector
{
	typedef TfrxCustomSelector inherited;
	
private:
	System::Uitypes::TColor FColor;
	System::Classes::TNotifyEvent FOnColorChanged;
	System::UnicodeString FBtnCaption;
	
protected:
	virtual void __fastcall DrawEdge(int X, int Y, bool IsDown);
	DYNAMIC void __fastcall MouseUp(System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	
public:
	__fastcall virtual TfrxColorSelector(System::Classes::TComponent* AOwner);
	virtual void __fastcall Paint(void);
	__property System::Uitypes::TColor Color = {read=FColor, write=FColor, nodefault};
	__property System::Classes::TNotifyEvent OnColorChanged = {read=FOnColorChanged, write=FOnColorChanged};
	__property System::UnicodeString BtnCaption = {read=FBtnCaption, write=FBtnCaption};
public:
	/* TCustomControl.Destroy */ inline __fastcall virtual ~TfrxColorSelector(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TfrxColorSelector(HWND ParentWindow) : TfrxCustomSelector(ParentWindow) { }
	
};


class DELPHICLASS TfrxLineSelector;
class PASCALIMPLEMENTATION TfrxLineSelector : public TfrxCustomSelector
{
	typedef TfrxCustomSelector inherited;
	
private:
	System::Byte FStyle;
	System::Classes::TNotifyEvent FOnStyleChanged;
	
protected:
	virtual void __fastcall DrawEdge(int X, int Y, bool IsDown);
	DYNAMIC void __fastcall MouseUp(System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	
public:
	__fastcall virtual TfrxLineSelector(System::Classes::TComponent* AOwner);
	virtual void __fastcall Paint(void);
	__property System::Byte Style = {read=FStyle, nodefault};
	__property System::Classes::TNotifyEvent OnStyleChanged = {read=FOnStyleChanged, write=FOnStyleChanged};
public:
	/* TCustomControl.Destroy */ inline __fastcall virtual ~TfrxLineSelector(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TfrxLineSelector(HWND ParentWindow) : TfrxCustomSelector(ParentWindow) { }
	
};


class DELPHICLASS TfrxUndoBuffer;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TfrxUndoBuffer : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	Frxpicturecache::TfrxPictureCache* FPictureCache;
	System::Classes::TList* FRedo;
	System::Classes::TList* FUndo;
	int __fastcall GetRedoCount(void);
	int __fastcall GetUndoCount(void);
	void __fastcall SetPictureFlag(Frxclass::TfrxComponent* ReportComponent, bool Flag);
	void __fastcall SetPictures(Frxclass::TfrxComponent* ReportComponent);
	
public:
	__fastcall TfrxUndoBuffer(void);
	__fastcall virtual ~TfrxUndoBuffer(void);
	void __fastcall AddUndo(Frxclass::TfrxComponent* ReportComponent);
	void __fastcall AddRedo(Frxclass::TfrxComponent* ReportComponent);
	void __fastcall GetUndo(Frxclass::TfrxComponent* ReportComponent);
	void __fastcall GetRedo(Frxclass::TfrxComponent* ReportComponent);
	void __fastcall ClearUndo(void);
	void __fastcall ClearRedo(void);
	__property int UndoCount = {read=GetUndoCount, nodefault};
	__property int RedoCount = {read=GetRedoCount, nodefault};
	__property Frxpicturecache::TfrxPictureCache* PictureCache = {read=FPictureCache, write=FPictureCache};
};

#pragma pack(pop)

class DELPHICLASS TfrxClipboard;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TfrxClipboard : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	Frxclass::TfrxCustomDesigner* FDesigner;
	Frxpicturecache::TfrxPictureCache* FPictureCache;
	bool __fastcall GetPasteAvailable(void);
	
public:
	__fastcall TfrxClipboard(Frxclass::TfrxCustomDesigner* ADesigner);
	void __fastcall Copy(void);
	void __fastcall Paste(void);
	__property bool PasteAvailable = {read=GetPasteAvailable, nodefault};
	__property Frxpicturecache::TfrxPictureCache* PictureCache = {read=FPictureCache, write=FPictureCache};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TfrxClipboard(void) { }
	
};

#pragma pack(pop)

typedef void __fastcall (__closure *TfrxFrameLineClickedEvent)(Frxclass::TfrxFrameType Line, bool state);

class DELPHICLASS TfrxFrameSampleControl;
class PASCALIMPLEMENTATION TfrxFrameSampleControl : public Vcl::Controls::TCustomControl
{
	typedef Vcl::Controls::TCustomControl inherited;
	
private:
	Frxclass::TfrxFrame* FFrame;
	TfrxFrameLineClickedEvent FOnFrameLineClicked;
	
protected:
	DYNAMIC void __fastcall MouseDown(System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	
public:
	virtual void __fastcall Paint(void);
	__property Frxclass::TfrxFrame* Frame = {read=FFrame, write=FFrame};
	__property TfrxFrameLineClickedEvent OnFrameLineClicked = {read=FOnFrameLineClicked, write=FOnFrameLineClicked};
public:
	/* TCustomControl.Create */ inline __fastcall virtual TfrxFrameSampleControl(System::Classes::TComponent* AOwner) : Vcl::Controls::TCustomControl(AOwner) { }
	/* TCustomControl.Destroy */ inline __fastcall virtual ~TfrxFrameSampleControl(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TfrxFrameSampleControl(HWND ParentWindow) : Vcl::Controls::TCustomControl(ParentWindow) { }
	
};


class DELPHICLASS TfrxLineStyleControl;
class PASCALIMPLEMENTATION TfrxLineStyleControl : public Vcl::Controls::TCustomControl
{
	typedef Vcl::Controls::TCustomControl inherited;
	
private:
	Frxclass::TfrxFrameStyle FStyle;
	System::Classes::TNotifyEvent FOnStyleChanged;
	MESSAGE void __fastcall WMEraseBackground(Winapi::Messages::TMessage &Message);
	void __fastcall SetStyle(const Frxclass::TfrxFrameStyle Value);
	
protected:
	DYNAMIC void __fastcall MouseUp(System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	
public:
	__fastcall virtual TfrxLineStyleControl(System::Classes::TComponent* AOwner);
	virtual void __fastcall Paint(void);
	__property Frxclass::TfrxFrameStyle Style = {read=FStyle, write=SetStyle, nodefault};
	__property System::Classes::TNotifyEvent OnStyleChanged = {read=FOnStyleChanged, write=FOnStyleChanged};
public:
	/* TCustomControl.Destroy */ inline __fastcall virtual ~TfrxLineStyleControl(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TfrxLineStyleControl(HWND ParentWindow) : Vcl::Controls::TCustomControl(ParentWindow) { }
	
};


class DELPHICLASS TfrxColorComboBox;
class PASCALIMPLEMENTATION TfrxColorComboBox : public Vcl::Controls::TCustomControl
{
	typedef Vcl::Controls::TCustomControl inherited;
	
private:
	Vcl::Stdctrls::TComboBox* FCombo;
	System::Uitypes::TColor FColor;
	bool FShowColorName;
	System::Classes::TNotifyEvent FOnColorChanged;
	bool FBlockPopup;
	HIDESBASE void __fastcall SetColor(const System::Uitypes::TColor Value);
	void __fastcall SetShowColorName(const bool Value);
	void __fastcall ColorChanged(System::TObject* Sender);
	
protected:
	virtual void __fastcall SetEnabled(bool Value);
	DYNAMIC void __fastcall MouseDown(System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseUp(System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	
public:
	__fastcall virtual TfrxColorComboBox(System::Classes::TComponent* AOwner);
	virtual void __fastcall Paint(void);
	virtual void __fastcall SetBounds(int ALeft, int ATop, int AWidth, int AHeight);
	__property System::Uitypes::TColor Color = {read=FColor, write=SetColor, nodefault};
	__property bool ShowColorName = {read=FShowColorName, write=SetShowColorName, nodefault};
	__property System::Classes::TNotifyEvent OnColorChanged = {read=FOnColorChanged, write=FOnColorChanged};
public:
	/* TCustomControl.Destroy */ inline __fastcall virtual ~TfrxColorComboBox(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TfrxColorComboBox(HWND ParentWindow) : Vcl::Controls::TCustomControl(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Frxdesgnctrls */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FRXDESGNCTRLS)
using namespace Frxdesgnctrls;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// FrxdesgnctrlsHPP
