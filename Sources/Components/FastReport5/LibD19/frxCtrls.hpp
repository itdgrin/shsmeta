// CodeGear C++Builder
// Copyright (c) 1995, 2013 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'frxCtrls.pas' rev: 26.00 (Windows)

#ifndef FrxctrlsHPP
#define FrxctrlsHPP

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
#include <Vcl.StdCtrls.hpp>	// Pascal unit
#include <Vcl.ExtCtrls.hpp>	// Pascal unit
#include <Vcl.Buttons.hpp>	// Pascal unit
#include <System.IniFiles.hpp>	// Pascal unit
#include <Winapi.CommCtrl.hpp>	// Pascal unit
#include <System.Win.Registry.hpp>	// Pascal unit
#include <Winapi.ActiveX.hpp>	// Pascal unit
#include <System.Variants.hpp>	// Pascal unit
#include <System.UITypes.hpp>	// Pascal unit
#include <Vcl.Menus.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Frxctrls
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TfrxCustomComboBox;
class PASCALIMPLEMENTATION TfrxCustomComboBox : public Vcl::Stdctrls::TCustomComboBox
{
	typedef Vcl::Stdctrls::TCustomComboBox inherited;
	
private:
	bool FUpDropdown;
	int FButtonWidth;
	bool msMouseInControl;
	HWND FListHandle;
	void *FListInstance;
	void *FDefListProc;
	HWND FChildHandle;
	bool FSolidBorder;
	bool FReadOnly;
	int FEditOffset;
	int FListWidth;
	HIDESBASE void __fastcall ListWndProc(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMPaint(Winapi::Messages::TWMPaint &Message);
	HIDESBASE MESSAGE void __fastcall CNCommand(Winapi::Messages::TWMCommand &Message);
	HIDESBASE MESSAGE void __fastcall CMEnabledChanged(Winapi::Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CMMouseEnter(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMFontChanged(Winapi::Messages::TMessage &Message);
	void __fastcall PaintButtonGlyph(HDC DC, int X, int Y, System::Uitypes::TColor Color);
	void __fastcall PaintButton(int ButtonStyle);
	void __fastcall PaintBorder(HDC DC, const bool SolidBorder);
	void __fastcall PaintDisabled(void);
	bool __fastcall GetSolidBorder(void);
	int __fastcall GetListHeight(void);
	void __fastcall SetReadOnly(bool Value);
	
protected:
	virtual void __fastcall CreateParams(Vcl::Controls::TCreateParams &Params);
	virtual void __fastcall ComboWndProc(Winapi::Messages::TMessage &Message, HWND ComboWnd, void * ComboProc);
	virtual void __fastcall WndProc(Winapi::Messages::TMessage &Message);
	virtual void __fastcall CreateWnd(void);
	DYNAMIC void __fastcall DrawImage(HDC DC, int Index, const System::Types::TRect &R);
	DYNAMIC void __fastcall KeyPress(System::WideChar &Key);
	__property int ListWidth = {read=FListWidth, write=FListWidth, nodefault};
	__property bool ReadOnly = {read=FReadOnly, write=SetReadOnly, default=0};
	__property bool SolidBorder = {read=FSolidBorder, nodefault};
	
public:
	__fastcall virtual TfrxCustomComboBox(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TfrxCustomComboBox(void);
public:
	/* TWinControl.CreateParented */ inline __fastcall TfrxCustomComboBox(HWND ParentWindow) : Vcl::Stdctrls::TCustomComboBox(ParentWindow) { }
	
};


class DELPHICLASS TfrxComboBox;
class PASCALIMPLEMENTATION TfrxComboBox : public TfrxCustomComboBox
{
	typedef TfrxCustomComboBox inherited;
	
__published:
	__property Color = {default=-16777211};
	__property DragMode = {default=0};
	__property DragCursor = {default=-12};
	__property DropDownCount = {default=8};
	__property Enabled = {default=1};
	__property Font;
	__property ItemHeight;
	__property Items;
	__property ListWidth;
	__property MaxLength = {default=0};
	__property ParentColor = {default=0};
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property PopupMenu;
	__property ShowHint;
	__property Sorted = {default=0};
	__property TabOrder = {default=-1};
	__property TabStop = {default=1};
	__property Text = {default=0};
	__property ReadOnly = {default=0};
	__property Visible = {default=1};
	__property ItemIndex;
	__property OnChange;
	__property OnClick;
	__property OnDblClick;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnDrawItem;
	__property OnDropDown;
	__property OnEndDrag;
	__property OnEnter;
	__property OnExit;
	__property OnKeyDown;
	__property OnKeyPress;
	__property OnKeyUp;
	__property OnStartDrag;
	__property Anchors = {default=3};
	__property BiDiMode;
	__property Constraints;
	__property DragKind = {default=0};
	__property ParentBiDiMode = {default=1};
	__property OnEndDock;
	__property OnStartDock;
public:
	/* TfrxCustomComboBox.Create */ inline __fastcall virtual TfrxComboBox(System::Classes::TComponent* AOwner) : TfrxCustomComboBox(AOwner) { }
	/* TfrxCustomComboBox.Destroy */ inline __fastcall virtual ~TfrxComboBox(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TfrxComboBox(HWND ParentWindow) : TfrxCustomComboBox(ParentWindow) { }
	
};


class DELPHICLASS TfrxFontPreview;
class PASCALIMPLEMENTATION TfrxFontPreview : public Vcl::Controls::TWinControl
{
	typedef Vcl::Controls::TWinControl inherited;
	
private:
	Vcl::Extctrls::TPanel* FPanel;
	
protected:
	virtual void __fastcall CreateParams(Vcl::Controls::TCreateParams &Params);
	
public:
	__fastcall virtual TfrxFontPreview(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TfrxFontPreview(void);
public:
	/* TWinControl.CreateParented */ inline __fastcall TfrxFontPreview(HWND ParentWindow) : Vcl::Controls::TWinControl(ParentWindow) { }
	
};


class DELPHICLASS TfrxFontComboBox;
class PASCALIMPLEMENTATION TfrxFontComboBox : public TfrxCustomComboBox
{
	typedef TfrxCustomComboBox inherited;
	
private:
	TfrxFontPreview* frFontViewForm;
	System::UnicodeString FRegKey;
	Vcl::Graphics::TBitmap* FTrueTypeBMP;
	Vcl::Graphics::TBitmap* FDeviceBMP;
	System::Classes::TNotifyEvent FOnClick;
	bool FUpdate;
	bool FShowMRU;
	int Numused;
	System::Inifiles::TCustomIniFile* FIni;
	HIDESBASE MESSAGE void __fastcall CNCommand(Winapi::Messages::TWMCommand &Message);
	HIDESBASE MESSAGE void __fastcall CMFontChanged(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMFontChange(Winapi::Messages::TMessage &Message);
	void __fastcall SetRegKey(System::UnicodeString Value);
	
protected:
	virtual void __fastcall Loaded(void);
	void __fastcall Init(void);
	void __fastcall Reset(void);
	DYNAMIC void __fastcall Click(void);
	virtual void __fastcall DrawItem(int Index, const System::Types::TRect &Rect, Winapi::Windows::TOwnerDrawState State);
	DYNAMIC void __fastcall DrawImage(HDC DC, int Index, const System::Types::TRect &R);
	
public:
	__fastcall virtual TfrxFontComboBox(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TfrxFontComboBox(void);
	virtual void __fastcall PopulateList(void);
	__property System::Inifiles::TCustomIniFile* IniFile = {read=FIni, write=FIni};
	
__published:
	__property bool ShowMRU = {read=FShowMRU, write=FShowMRU, default=1};
	__property System::UnicodeString MRURegKey = {read=FRegKey, write=SetRegKey};
	__property Text = {default=0};
	__property Color = {default=-16777211};
	__property DragMode = {default=0};
	__property DragCursor = {default=-12};
	__property DropDownCount = {default=8};
	__property Enabled = {default=1};
	__property Font;
	__property Anchors = {default=3};
	__property BiDiMode;
	__property Constraints;
	__property DragKind = {default=0};
	__property ParentBiDiMode = {default=1};
	__property ItemHeight;
	__property ParentColor = {default=0};
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property PopupMenu;
	__property ShowHint;
	__property TabOrder = {default=-1};
	__property TabStop = {default=1};
	__property Visible = {default=1};
	__property OnChange;
	__property System::Classes::TNotifyEvent OnClick = {read=FOnClick, write=FOnClick};
	__property OnDblClick;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnDropDown;
	__property OnEndDrag;
	__property OnEnter;
	__property OnExit;
	__property OnKeyDown;
	__property OnKeyPress;
	__property OnKeyUp;
	__property OnStartDrag;
	__property OnEndDock;
	__property OnStartDock;
public:
	/* TWinControl.CreateParented */ inline __fastcall TfrxFontComboBox(HWND ParentWindow) : TfrxCustomComboBox(ParentWindow) { }
	
};


class DELPHICLASS TfrxComboEdit;
class PASCALIMPLEMENTATION TfrxComboEdit : public Vcl::Stdctrls::TComboBox
{
	typedef Vcl::Stdctrls::TComboBox inherited;
	
private:
	Vcl::Controls::TWinControl* FPanel;
	Vcl::Buttons::TSpeedButton* FButton;
	bool FButtonEnabled;
	System::Classes::TNotifyEvent FOnButtonClick;
	Vcl::Graphics::TBitmap* __fastcall GetGlyph(void);
	void __fastcall SetGlyph(Vcl::Graphics::TBitmap* Value);
	System::UnicodeString __fastcall GetButtonHint(void);
	void __fastcall SetButtonHint(System::UnicodeString Value);
	void __fastcall SetButtonEnabled(bool Value);
	void __fastcall ButtonClick(System::TObject* Sender);
	HIDESBASE MESSAGE void __fastcall WMSize(Winapi::Messages::TWMSize &Message);
	HIDESBASE MESSAGE void __fastcall CMEnabledChanged(Winapi::Messages::TMessage &Message);
	void __fastcall SetPos(void);
	
public:
	__fastcall virtual TfrxComboEdit(System::Classes::TComponent* AOwner);
	virtual void __fastcall CreateWnd(void);
	DYNAMIC void __fastcall KeyPress(System::WideChar &Key);
	
__published:
	__property Vcl::Graphics::TBitmap* Glyph = {read=GetGlyph, write=SetGlyph};
	__property bool ButtonEnabled = {read=FButtonEnabled, write=SetButtonEnabled, default=1};
	__property System::UnicodeString ButtonHint = {read=GetButtonHint, write=SetButtonHint};
	__property System::Classes::TNotifyEvent OnButtonClick = {read=FOnButtonClick, write=FOnButtonClick};
public:
	/* TCustomComboBox.Destroy */ inline __fastcall virtual ~TfrxComboEdit(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TfrxComboEdit(HWND ParentWindow) : Vcl::Stdctrls::TComboBox(ParentWindow) { }
	
};


class DELPHICLASS TfrxScrollWin;
class PASCALIMPLEMENTATION TfrxScrollWin : public Vcl::Controls::TCustomControl
{
	typedef Vcl::Controls::TCustomControl inherited;
	
private:
	Vcl::Forms::TFormBorderStyle FBorderStyle;
	int FHorzPage;
	int FHorzPosition;
	int FHorzRange;
	int FLargeChange;
	int FSmallChange;
	int FVertPage;
	int FVertPosition;
	int FVertRange;
	int __fastcall GetLongPosition(int DefValue, System::Word Code);
	void __fastcall SetHorzPosition(int Value);
	void __fastcall SetHorzRange(int Value);
	void __fastcall SetPosition(int Value, System::Word Code);
	void __fastcall SetVertPosition(int Value);
	void __fastcall SetVertRange(int Value);
	void __fastcall UpdateScrollBar(int Max, int Page, int Pos, System::Word Code);
	MESSAGE void __fastcall WMEraseBackground(Winapi::Messages::TMessage &Message);
	MESSAGE void __fastcall WMGetDlgCode(Winapi::Messages::TWMNoParams &Message);
	HIDESBASE MESSAGE void __fastcall WMHScroll(Winapi::Messages::TWMScroll &Message);
	HIDESBASE MESSAGE void __fastcall WMVScroll(Winapi::Messages::TWMScroll &Message);
	void __fastcall SetHorzPage(const int Value);
	void __fastcall SetVertPage(const int Value);
	void __fastcall SetBorderStyle(const Vcl::Forms::TBorderStyle Value);
	
protected:
	virtual void __fastcall CreateParams(Vcl::Controls::TCreateParams &Params);
	virtual void __fastcall OnHScrollChange(System::TObject* Sender);
	virtual void __fastcall OnVScrollChange(System::TObject* Sender);
	
public:
	__fastcall virtual TfrxScrollWin(System::Classes::TComponent* AOwner);
	virtual void __fastcall Paint(void);
	__property BevelKind = {default=0};
	__property Vcl::Forms::TBorderStyle BorderStyle = {read=FBorderStyle, write=SetBorderStyle, nodefault};
	__property int HorzPage = {read=FHorzPage, write=SetHorzPage, nodefault};
	__property int HorzPosition = {read=FHorzPosition, write=SetHorzPosition, nodefault};
	__property int HorzRange = {read=FHorzRange, write=SetHorzRange, nodefault};
	__property int LargeChange = {read=FLargeChange, write=FLargeChange, nodefault};
	__property int SmallChange = {read=FSmallChange, write=FSmallChange, nodefault};
	__property int VertPage = {read=FVertPage, write=SetVertPage, nodefault};
	__property int VertPosition = {read=FVertPosition, write=SetVertPosition, nodefault};
	__property int VertRange = {read=FVertRange, write=SetVertRange, nodefault};
public:
	/* TCustomControl.Destroy */ inline __fastcall virtual ~TfrxScrollWin(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TfrxScrollWin(HWND ParentWindow) : Vcl::Controls::TCustomControl(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Frxctrls */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FRXCTRLS)
using namespace Frxctrls;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// FrxctrlsHPP
