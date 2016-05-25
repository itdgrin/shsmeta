// CodeGear C++Builder
// Copyright (c) 1995, 2013 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'frxDCtrl.pas' rev: 26.00 (Windows)

#ifndef FrxdctrlHPP
#define FrxdctrlHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <Winapi.Windows.hpp>	// Pascal unit
#include <Winapi.Messages.hpp>	// Pascal unit
#include <Winapi.CommCtrl.hpp>	// Pascal unit
#include <System.SysUtils.hpp>	// Pascal unit
#include <System.Classes.hpp>	// Pascal unit
#include <Vcl.Graphics.hpp>	// Pascal unit
#include <Vcl.Controls.hpp>	// Pascal unit
#include <Vcl.StdCtrls.hpp>	// Pascal unit
#include <Vcl.ExtCtrls.hpp>	// Pascal unit
#include <Vcl.Forms.hpp>	// Pascal unit
#include <Vcl.Menus.hpp>	// Pascal unit
#include <Vcl.Dialogs.hpp>	// Pascal unit
#include <Vcl.ComCtrls.hpp>	// Pascal unit
#include <Vcl.Buttons.hpp>	// Pascal unit
#include <Vcl.Mask.hpp>	// Pascal unit
#include <Vcl.CheckLst.hpp>	// Pascal unit
#include <frxClass.hpp>	// Pascal unit
#include <System.Variants.hpp>	// Pascal unit
#include <System.UITypes.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Frxdctrl
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TfrxDialogControls;
class PASCALIMPLEMENTATION TfrxDialogControls : public System::Classes::TComponent
{
	typedef System::Classes::TComponent inherited;
	
public:
	/* TComponent.Create */ inline __fastcall virtual TfrxDialogControls(System::Classes::TComponent* AOwner) : System::Classes::TComponent(AOwner) { }
	/* TComponent.Destroy */ inline __fastcall virtual ~TfrxDialogControls(void) { }
	
};


class DELPHICLASS TfrxLabelControl;
class PASCALIMPLEMENTATION TfrxLabelControl : public Frxclass::TfrxDialogControl
{
	typedef Frxclass::TfrxDialogControl inherited;
	
private:
	Vcl::Stdctrls::TLabel* FLabel;
	System::Classes::TAlignment __fastcall GetAlignment(void);
	bool __fastcall GetAutoSize(void);
	bool __fastcall GetWordWrap(void);
	void __fastcall SetAlignment(const System::Classes::TAlignment Value);
	void __fastcall SetAutoSize(const bool Value);
	void __fastcall SetWordWrap(const bool Value);
	
public:
	__fastcall virtual TfrxLabelControl(System::Classes::TComponent* AOwner);
	__classmethod virtual System::UnicodeString __fastcall GetDescription();
	virtual void __fastcall BeforeStartReport(void);
	virtual void __fastcall Draw(Vcl::Graphics::TCanvas* Canvas, System::Extended ScaleX, System::Extended ScaleY, System::Extended OffsetX, System::Extended OffsetY);
	__property Vcl::Stdctrls::TLabel* LabelCtl = {read=FLabel};
	
__published:
	__property System::Classes::TAlignment Alignment = {read=GetAlignment, write=SetAlignment, default=0};
	__property bool AutoSize = {read=GetAutoSize, write=SetAutoSize, default=1};
	__property Caption = {default=0};
	__property Color;
	__property bool WordWrap = {read=GetWordWrap, write=SetWordWrap, default=0};
	__property OnClick = {default=0};
	__property OnDblClick = {default=0};
	__property OnMouseDown = {default=0};
	__property OnMouseMove = {default=0};
	__property OnMouseUp = {default=0};
public:
	/* TfrxDialogControl.Destroy */ inline __fastcall virtual ~TfrxLabelControl(void) { }
	
public:
	/* TfrxComponent.DesignCreate */ inline __fastcall virtual TfrxLabelControl(System::Classes::TComponent* AOwner, System::Word Flags) : Frxclass::TfrxDialogControl(AOwner, Flags) { }
	
};


class DELPHICLASS TfrxCustomEditControl;
class PASCALIMPLEMENTATION TfrxCustomEditControl : public Frxclass::TfrxDialogControl
{
	typedef Frxclass::TfrxDialogControl inherited;
	
private:
	Frxclass::TfrxNotifyEvent FOnChange;
	int __fastcall GetMaxLength(void);
	System::WideChar __fastcall GetPasswordChar(void);
	bool __fastcall GetReadOnly(void);
	System::UnicodeString __fastcall GetText(void);
	void __fastcall DoOnChange(System::TObject* Sender);
	void __fastcall SetMaxLength(const int Value);
	void __fastcall SetPasswordChar(const System::WideChar Value);
	void __fastcall SetReadOnly(const bool Value);
	void __fastcall SetText(const System::UnicodeString Value);
	
protected:
	Vcl::Stdctrls::TCustomEdit* FCustomEdit;
	
public:
	__fastcall virtual TfrxCustomEditControl(System::Classes::TComponent* AOwner);
	__property int MaxLength = {read=GetMaxLength, write=SetMaxLength, nodefault};
	__property System::WideChar PasswordChar = {read=GetPasswordChar, write=SetPasswordChar, nodefault};
	__property bool ReadOnly = {read=GetReadOnly, write=SetReadOnly, default=0};
	__property System::UnicodeString Text = {read=GetText, write=SetText};
	__property Frxclass::TfrxNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
public:
	/* TfrxDialogControl.Destroy */ inline __fastcall virtual ~TfrxCustomEditControl(void) { }
	
public:
	/* TfrxComponent.DesignCreate */ inline __fastcall virtual TfrxCustomEditControl(System::Classes::TComponent* AOwner, System::Word Flags) : Frxclass::TfrxDialogControl(AOwner, Flags) { }
	
};


class DELPHICLASS TfrxEditControl;
class PASCALIMPLEMENTATION TfrxEditControl : public TfrxCustomEditControl
{
	typedef TfrxCustomEditControl inherited;
	
private:
	Vcl::Stdctrls::TEdit* FEdit;
	
public:
	__fastcall virtual TfrxEditControl(System::Classes::TComponent* AOwner);
	__classmethod virtual System::UnicodeString __fastcall GetDescription();
	__property Vcl::Stdctrls::TEdit* Edit = {read=FEdit};
	
__published:
	__property Color;
	__property MaxLength;
	__property PasswordChar;
	__property ReadOnly = {default=0};
	__property TabStop = {default=1};
	__property Text = {default=0};
	__property OnChange = {default=0};
	__property OnClick = {default=0};
	__property OnDblClick = {default=0};
	__property OnEnter = {default=0};
	__property OnExit = {default=0};
	__property OnKeyDown = {default=0};
	__property OnKeyPress = {default=0};
	__property OnKeyUp = {default=0};
	__property OnMouseDown = {default=0};
	__property OnMouseMove = {default=0};
	__property OnMouseUp = {default=0};
public:
	/* TfrxDialogControl.Destroy */ inline __fastcall virtual ~TfrxEditControl(void) { }
	
public:
	/* TfrxComponent.DesignCreate */ inline __fastcall virtual TfrxEditControl(System::Classes::TComponent* AOwner, System::Word Flags) : TfrxCustomEditControl(AOwner, Flags) { }
	
};


class DELPHICLASS TfrxMemoControl;
class PASCALIMPLEMENTATION TfrxMemoControl : public TfrxCustomEditControl
{
	typedef TfrxCustomEditControl inherited;
	
private:
	Vcl::Stdctrls::TMemo* FMemo;
	System::Classes::TStrings* __fastcall GetLines(void);
	void __fastcall SetLines(System::Classes::TStrings* const Value);
	System::Uitypes::TScrollStyle __fastcall GetScrollStyle(void);
	bool __fastcall GetWordWrap(void);
	void __fastcall SetScrollStyle(const System::Uitypes::TScrollStyle Value);
	void __fastcall SetWordWrap(const bool Value);
	
public:
	__fastcall virtual TfrxMemoControl(System::Classes::TComponent* AOwner);
	__classmethod virtual System::UnicodeString __fastcall GetDescription();
	__property Vcl::Stdctrls::TMemo* Memo = {read=FMemo};
	
__published:
	__property Color;
	__property System::Classes::TStrings* Lines = {read=GetLines, write=SetLines};
	__property MaxLength;
	__property ReadOnly = {default=0};
	__property System::Uitypes::TScrollStyle ScrollBars = {read=GetScrollStyle, write=SetScrollStyle, default=0};
	__property TabStop = {default=1};
	__property bool WordWrap = {read=GetWordWrap, write=SetWordWrap, default=1};
	__property OnChange = {default=0};
	__property OnClick = {default=0};
	__property OnDblClick = {default=0};
	__property OnEnter = {default=0};
	__property OnExit = {default=0};
	__property OnKeyDown = {default=0};
	__property OnKeyPress = {default=0};
	__property OnKeyUp = {default=0};
	__property OnMouseDown = {default=0};
	__property OnMouseMove = {default=0};
	__property OnMouseUp = {default=0};
public:
	/* TfrxDialogControl.Destroy */ inline __fastcall virtual ~TfrxMemoControl(void) { }
	
public:
	/* TfrxComponent.DesignCreate */ inline __fastcall virtual TfrxMemoControl(System::Classes::TComponent* AOwner, System::Word Flags) : TfrxCustomEditControl(AOwner, Flags) { }
	
};


class DELPHICLASS TfrxButtonControl;
class PASCALIMPLEMENTATION TfrxButtonControl : public Frxclass::TfrxDialogControl
{
	typedef Frxclass::TfrxDialogControl inherited;
	
private:
	Vcl::Stdctrls::TButton* FButton;
	bool __fastcall GetCancel(void);
	bool __fastcall GetDefault(void);
	System::Uitypes::TModalResult __fastcall GetModalResult(void);
	void __fastcall SetCancel(const bool Value);
	void __fastcall SetDefault(const bool Value);
	void __fastcall SetModalResult(const System::Uitypes::TModalResult Value);
	bool __fastcall GetWordWrap(void);
	void __fastcall SetWordWrap(const bool Value);
	
public:
	__fastcall virtual TfrxButtonControl(System::Classes::TComponent* AOwner);
	__classmethod virtual System::UnicodeString __fastcall GetDescription();
	__property Vcl::Stdctrls::TButton* Button = {read=FButton};
	
__published:
	__property bool Cancel = {read=GetCancel, write=SetCancel, default=0};
	__property Caption = {default=0};
	__property bool Default = {read=GetDefault, write=SetDefault, default=0};
	__property System::Uitypes::TModalResult ModalResult = {read=GetModalResult, write=SetModalResult, default=0};
	__property bool WordWrap = {read=GetWordWrap, write=SetWordWrap, default=0};
	__property TabStop = {default=1};
	__property OnClick = {default=0};
	__property OnEnter = {default=0};
	__property OnExit = {default=0};
	__property OnKeyDown = {default=0};
	__property OnKeyPress = {default=0};
	__property OnKeyUp = {default=0};
	__property OnMouseDown = {default=0};
	__property OnMouseMove = {default=0};
	__property OnMouseUp = {default=0};
public:
	/* TfrxDialogControl.Destroy */ inline __fastcall virtual ~TfrxButtonControl(void) { }
	
public:
	/* TfrxComponent.DesignCreate */ inline __fastcall virtual TfrxButtonControl(System::Classes::TComponent* AOwner, System::Word Flags) : Frxclass::TfrxDialogControl(AOwner, Flags) { }
	
};


class DELPHICLASS TfrxCheckBoxControl;
class PASCALIMPLEMENTATION TfrxCheckBoxControl : public Frxclass::TfrxDialogControl
{
	typedef Frxclass::TfrxDialogControl inherited;
	
private:
	Vcl::Stdctrls::TCheckBox* FCheckBox;
	System::Classes::TAlignment __fastcall GetAlignment(void);
	bool __fastcall GetAllowGrayed(void);
	bool __fastcall GetChecked(void);
	Vcl::Stdctrls::TCheckBoxState __fastcall GetState(void);
	void __fastcall SetAlignment(const System::Classes::TAlignment Value);
	void __fastcall SetAllowGrayed(const bool Value);
	void __fastcall SetChecked(const bool Value);
	void __fastcall SetState(const Vcl::Stdctrls::TCheckBoxState Value);
	bool __fastcall GetWordWrap(void);
	void __fastcall SetWordWrap(const bool Value);
	
public:
	__fastcall virtual TfrxCheckBoxControl(System::Classes::TComponent* AOwner);
	__classmethod virtual System::UnicodeString __fastcall GetDescription();
	__property Vcl::Stdctrls::TCheckBox* CheckBox = {read=FCheckBox};
	
__published:
	__property System::Classes::TAlignment Alignment = {read=GetAlignment, write=SetAlignment, default=1};
	__property Caption = {default=0};
	__property bool Checked = {read=GetChecked, write=SetChecked, default=0};
	__property bool AllowGrayed = {read=GetAllowGrayed, write=SetAllowGrayed, default=0};
	__property Vcl::Stdctrls::TCheckBoxState State = {read=GetState, write=SetState, default=0};
	__property TabStop = {default=1};
	__property bool WordWrap = {read=GetWordWrap, write=SetWordWrap, default=0};
	__property Color;
	__property OnClick = {default=0};
	__property OnEnter = {default=0};
	__property OnExit = {default=0};
	__property OnKeyDown = {default=0};
	__property OnKeyPress = {default=0};
	__property OnKeyUp = {default=0};
	__property OnMouseDown = {default=0};
	__property OnMouseMove = {default=0};
	__property OnMouseUp = {default=0};
public:
	/* TfrxDialogControl.Destroy */ inline __fastcall virtual ~TfrxCheckBoxControl(void) { }
	
public:
	/* TfrxComponent.DesignCreate */ inline __fastcall virtual TfrxCheckBoxControl(System::Classes::TComponent* AOwner, System::Word Flags) : Frxclass::TfrxDialogControl(AOwner, Flags) { }
	
};


class DELPHICLASS TfrxRadioButtonControl;
class PASCALIMPLEMENTATION TfrxRadioButtonControl : public Frxclass::TfrxDialogControl
{
	typedef Frxclass::TfrxDialogControl inherited;
	
private:
	Vcl::Stdctrls::TRadioButton* FRadioButton;
	System::Classes::TAlignment __fastcall GetAlignment(void);
	bool __fastcall GetChecked(void);
	void __fastcall SetAlignment(const System::Classes::TAlignment Value);
	void __fastcall SetChecked(const bool Value);
	bool __fastcall GetWordWrap(void);
	void __fastcall SetWordWrap(const bool Value);
	
public:
	__fastcall virtual TfrxRadioButtonControl(System::Classes::TComponent* AOwner);
	__classmethod virtual System::UnicodeString __fastcall GetDescription();
	__property Vcl::Stdctrls::TRadioButton* RadioButton = {read=FRadioButton};
	
__published:
	__property System::Classes::TAlignment Alignment = {read=GetAlignment, write=SetAlignment, default=1};
	__property Caption = {default=0};
	__property bool Checked = {read=GetChecked, write=SetChecked, default=0};
	__property TabStop = {default=1};
	__property bool WordWrap = {read=GetWordWrap, write=SetWordWrap, default=0};
	__property Color;
	__property OnClick = {default=0};
	__property OnDblClick = {default=0};
	__property OnEnter = {default=0};
	__property OnExit = {default=0};
	__property OnKeyDown = {default=0};
	__property OnKeyPress = {default=0};
	__property OnKeyUp = {default=0};
	__property OnMouseDown = {default=0};
	__property OnMouseMove = {default=0};
	__property OnMouseUp = {default=0};
public:
	/* TfrxDialogControl.Destroy */ inline __fastcall virtual ~TfrxRadioButtonControl(void) { }
	
public:
	/* TfrxComponent.DesignCreate */ inline __fastcall virtual TfrxRadioButtonControl(System::Classes::TComponent* AOwner, System::Word Flags) : Frxclass::TfrxDialogControl(AOwner, Flags) { }
	
};


class DELPHICLASS TfrxListBoxControl;
class PASCALIMPLEMENTATION TfrxListBoxControl : public Frxclass::TfrxDialogControl
{
	typedef Frxclass::TfrxDialogControl inherited;
	
private:
	Vcl::Stdctrls::TListBox* FListBox;
	System::Classes::TStrings* __fastcall GetItems(void);
	void __fastcall SetItems(System::Classes::TStrings* const Value);
	int __fastcall GetItemIndex(void);
	void __fastcall SetItemIndex(const int Value);
	
public:
	__fastcall virtual TfrxListBoxControl(System::Classes::TComponent* AOwner);
	__classmethod virtual System::UnicodeString __fastcall GetDescription();
	__property Vcl::Stdctrls::TListBox* ListBox = {read=FListBox};
	__property int ItemIndex = {read=GetItemIndex, write=SetItemIndex, nodefault};
	
__published:
	__property Color;
	__property System::Classes::TStrings* Items = {read=GetItems, write=SetItems};
	__property TabStop = {default=1};
	__property OnClick = {default=0};
	__property OnDblClick = {default=0};
	__property OnEnter = {default=0};
	__property OnExit = {default=0};
	__property OnKeyDown = {default=0};
	__property OnKeyPress = {default=0};
	__property OnKeyUp = {default=0};
	__property OnMouseDown = {default=0};
	__property OnMouseMove = {default=0};
	__property OnMouseUp = {default=0};
public:
	/* TfrxDialogControl.Destroy */ inline __fastcall virtual ~TfrxListBoxControl(void) { }
	
public:
	/* TfrxComponent.DesignCreate */ inline __fastcall virtual TfrxListBoxControl(System::Classes::TComponent* AOwner, System::Word Flags) : Frxclass::TfrxDialogControl(AOwner, Flags) { }
	
};


class DELPHICLASS TfrxComboBoxControl;
class PASCALIMPLEMENTATION TfrxComboBoxControl : public Frxclass::TfrxDialogControl
{
	typedef Frxclass::TfrxDialogControl inherited;
	
private:
	Vcl::Stdctrls::TComboBox* FComboBox;
	Frxclass::TfrxNotifyEvent FOnChange;
	int __fastcall GetItemIndex(void);
	System::Classes::TStrings* __fastcall GetItems(void);
	Vcl::Stdctrls::TComboBoxStyle __fastcall GetStyle(void);
	System::UnicodeString __fastcall GetText(void);
	void __fastcall DoOnChange(System::TObject* Sender);
	void __fastcall SetItemIndex(const int Value);
	void __fastcall SetItems(System::Classes::TStrings* const Value);
	void __fastcall SetStyle(const Vcl::Stdctrls::TComboBoxStyle Value);
	void __fastcall SetText(const System::UnicodeString Value);
	
public:
	__fastcall virtual TfrxComboBoxControl(System::Classes::TComponent* AOwner);
	__classmethod virtual System::UnicodeString __fastcall GetDescription();
	__property Vcl::Stdctrls::TComboBox* ComboBox = {read=FComboBox};
	
__published:
	__property Color;
	__property System::Classes::TStrings* Items = {read=GetItems, write=SetItems};
	__property Vcl::Stdctrls::TComboBoxStyle Style = {read=GetStyle, write=SetStyle, default=0};
	__property TabStop = {default=1};
	__property System::UnicodeString Text = {read=GetText, write=SetText};
	__property int ItemIndex = {read=GetItemIndex, write=SetItemIndex, nodefault};
	__property Frxclass::TfrxNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
	__property OnClick = {default=0};
	__property OnDblClick = {default=0};
	__property OnEnter = {default=0};
	__property OnExit = {default=0};
	__property OnKeyDown = {default=0};
	__property OnKeyPress = {default=0};
	__property OnKeyUp = {default=0};
public:
	/* TfrxDialogControl.Destroy */ inline __fastcall virtual ~TfrxComboBoxControl(void) { }
	
public:
	/* TfrxComponent.DesignCreate */ inline __fastcall virtual TfrxComboBoxControl(System::Classes::TComponent* AOwner, System::Word Flags) : Frxclass::TfrxDialogControl(AOwner, Flags) { }
	
};


class DELPHICLASS TfrxPanelControl;
class PASCALIMPLEMENTATION TfrxPanelControl : public Frxclass::TfrxDialogControl
{
	typedef Frxclass::TfrxDialogControl inherited;
	
private:
	Vcl::Extctrls::TPanel* FPanel;
	System::Classes::TAlignment __fastcall GetAlignment(void);
	Vcl::Controls::TBevelCut __fastcall GetBevelInner(void);
	Vcl::Controls::TBevelCut __fastcall GetBevelOuter(void);
	int __fastcall GetBevelWidth(void);
	void __fastcall SetAlignment(const System::Classes::TAlignment Value);
	void __fastcall SetBevelInner(const Vcl::Controls::TBevelCut Value);
	void __fastcall SetBevelOuter(const Vcl::Controls::TBevelCut Value);
	void __fastcall SetBevelWidth(const int Value);
	
public:
	__fastcall virtual TfrxPanelControl(System::Classes::TComponent* AOwner);
	__classmethod virtual System::UnicodeString __fastcall GetDescription();
	__property Vcl::Extctrls::TPanel* Panel = {read=FPanel};
	
__published:
	__property System::Classes::TAlignment Alignment = {read=GetAlignment, write=SetAlignment, default=2};
	__property Vcl::Controls::TBevelCut BevelInner = {read=GetBevelInner, write=SetBevelInner, default=0};
	__property Vcl::Controls::TBevelCut BevelOuter = {read=GetBevelOuter, write=SetBevelOuter, default=2};
	__property int BevelWidth = {read=GetBevelWidth, write=SetBevelWidth, default=1};
	__property Caption = {default=0};
	__property Color;
	__property OnClick = {default=0};
	__property OnDblClick = {default=0};
	__property OnEnter = {default=0};
	__property OnExit = {default=0};
	__property OnMouseDown = {default=0};
	__property OnMouseMove = {default=0};
	__property OnMouseUp = {default=0};
public:
	/* TfrxDialogControl.Destroy */ inline __fastcall virtual ~TfrxPanelControl(void) { }
	
public:
	/* TfrxComponent.DesignCreate */ inline __fastcall virtual TfrxPanelControl(System::Classes::TComponent* AOwner, System::Word Flags) : Frxclass::TfrxDialogControl(AOwner, Flags) { }
	
};


class DELPHICLASS TfrxGroupBoxControl;
class PASCALIMPLEMENTATION TfrxGroupBoxControl : public Frxclass::TfrxDialogControl
{
	typedef Frxclass::TfrxDialogControl inherited;
	
private:
	Vcl::Stdctrls::TGroupBox* FGroupBox;
	
public:
	__fastcall virtual TfrxGroupBoxControl(System::Classes::TComponent* AOwner);
	__classmethod virtual System::UnicodeString __fastcall GetDescription();
	__property Vcl::Stdctrls::TGroupBox* GroupBox = {read=FGroupBox};
	
__published:
	__property Caption = {default=0};
	__property Color;
	__property OnClick = {default=0};
	__property OnDblClick = {default=0};
	__property OnEnter = {default=0};
	__property OnExit = {default=0};
	__property OnMouseDown = {default=0};
	__property OnMouseMove = {default=0};
	__property OnMouseUp = {default=0};
public:
	/* TfrxDialogControl.Destroy */ inline __fastcall virtual ~TfrxGroupBoxControl(void) { }
	
public:
	/* TfrxComponent.DesignCreate */ inline __fastcall virtual TfrxGroupBoxControl(System::Classes::TComponent* AOwner, System::Word Flags) : Frxclass::TfrxDialogControl(AOwner, Flags) { }
	
};


class DELPHICLASS TfrxDateEditControl;
class PASCALIMPLEMENTATION TfrxDateEditControl : public Frxclass::TfrxDialogControl
{
	typedef Frxclass::TfrxDialogControl inherited;
	
private:
	Vcl::Comctrls::TDateTimePicker* FDateEdit;
	Frxclass::TfrxNotifyEvent FOnChange;
	bool FWeekNumbers;
	System::TDate __fastcall GetDate(void);
	System::TTime __fastcall GetTime(void);
	Vcl::Comctrls::TDTDateFormat __fastcall GetDateFormat(void);
	Vcl::Comctrls::TDateTimeKind __fastcall GetKind(void);
	void __fastcall DoOnChange(System::TObject* Sender);
	void __fastcall SetDate(const System::TDate Value);
	void __fastcall SetTime(const System::TTime Value);
	void __fastcall SetDateFormat(const Vcl::Comctrls::TDTDateFormat Value);
	void __fastcall SetKind(const Vcl::Comctrls::TDateTimeKind Value);
	void __fastcall DropDown(System::TObject* Sender);
	
public:
	__fastcall virtual TfrxDateEditControl(System::Classes::TComponent* AOwner);
	__classmethod virtual System::UnicodeString __fastcall GetDescription();
	__property Vcl::Comctrls::TDateTimePicker* DateEdit = {read=FDateEdit};
	
__published:
	__property Color;
	__property System::TDate Date = {read=GetDate, write=SetDate};
	__property Vcl::Comctrls::TDTDateFormat DateFormat = {read=GetDateFormat, write=SetDateFormat, default=0};
	__property Vcl::Comctrls::TDateTimeKind Kind = {read=GetKind, write=SetKind, default=0};
	__property TabStop = {default=1};
	__property System::TTime Time = {read=GetTime, write=SetTime};
	__property bool WeekNumbers = {read=FWeekNumbers, write=FWeekNumbers, nodefault};
	__property Frxclass::TfrxNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
	__property OnClick = {default=0};
	__property OnDblClick = {default=0};
	__property OnEnter = {default=0};
	__property OnExit = {default=0};
	__property OnKeyDown = {default=0};
	__property OnKeyPress = {default=0};
	__property OnKeyUp = {default=0};
public:
	/* TfrxDialogControl.Destroy */ inline __fastcall virtual ~TfrxDateEditControl(void) { }
	
public:
	/* TfrxComponent.DesignCreate */ inline __fastcall virtual TfrxDateEditControl(System::Classes::TComponent* AOwner, System::Word Flags) : Frxclass::TfrxDialogControl(AOwner, Flags) { }
	
};


class DELPHICLASS TfrxImageControl;
class PASCALIMPLEMENTATION TfrxImageControl : public Frxclass::TfrxDialogControl
{
	typedef Frxclass::TfrxDialogControl inherited;
	
private:
	Vcl::Extctrls::TImage* FImage;
	bool __fastcall GetAutoSize(void);
	bool __fastcall GetCenter(void);
	Vcl::Graphics::TPicture* __fastcall GetPicture(void);
	bool __fastcall GetStretch(void);
	void __fastcall SetAutoSize(const bool Value);
	void __fastcall SetCenter(const bool Value);
	void __fastcall SetPicture(Vcl::Graphics::TPicture* const Value);
	void __fastcall SetStretch(const bool Value);
	
public:
	__fastcall virtual TfrxImageControl(System::Classes::TComponent* AOwner);
	__classmethod virtual System::UnicodeString __fastcall GetDescription();
	__property Vcl::Extctrls::TImage* Image = {read=FImage};
	
__published:
	__property bool AutoSize = {read=GetAutoSize, write=SetAutoSize, default=0};
	__property bool Center = {read=GetCenter, write=SetCenter, default=0};
	__property Vcl::Graphics::TPicture* Picture = {read=GetPicture, write=SetPicture};
	__property bool Stretch = {read=GetStretch, write=SetStretch, default=0};
	__property OnClick = {default=0};
	__property OnDblClick = {default=0};
	__property OnMouseDown = {default=0};
	__property OnMouseMove = {default=0};
	__property OnMouseUp = {default=0};
public:
	/* TfrxDialogControl.Destroy */ inline __fastcall virtual ~TfrxImageControl(void) { }
	
public:
	/* TfrxComponent.DesignCreate */ inline __fastcall virtual TfrxImageControl(System::Classes::TComponent* AOwner, System::Word Flags) : Frxclass::TfrxDialogControl(AOwner, Flags) { }
	
};


class DELPHICLASS TfrxBevelControl;
class PASCALIMPLEMENTATION TfrxBevelControl : public Frxclass::TfrxDialogControl
{
	typedef Frxclass::TfrxDialogControl inherited;
	
private:
	Vcl::Extctrls::TBevel* FBevel;
	Vcl::Extctrls::TBevelShape __fastcall GetBevelShape(void);
	Vcl::Extctrls::TBevelStyle __fastcall GetBevelStyle(void);
	void __fastcall SetBevelShape(const Vcl::Extctrls::TBevelShape Value);
	void __fastcall SetBevelStyle(const Vcl::Extctrls::TBevelStyle Value);
	
public:
	__fastcall virtual TfrxBevelControl(System::Classes::TComponent* AOwner);
	__classmethod virtual System::UnicodeString __fastcall GetDescription();
	__property Vcl::Extctrls::TBevel* Bevel = {read=FBevel};
	
__published:
	__property Vcl::Extctrls::TBevelShape Shape = {read=GetBevelShape, write=SetBevelShape, default=0};
	__property Vcl::Extctrls::TBevelStyle Style = {read=GetBevelStyle, write=SetBevelStyle, default=0};
public:
	/* TfrxDialogControl.Destroy */ inline __fastcall virtual ~TfrxBevelControl(void) { }
	
public:
	/* TfrxComponent.DesignCreate */ inline __fastcall virtual TfrxBevelControl(System::Classes::TComponent* AOwner, System::Word Flags) : Frxclass::TfrxDialogControl(AOwner, Flags) { }
	
};


class DELPHICLASS TfrxBitBtnControl;
class PASCALIMPLEMENTATION TfrxBitBtnControl : public Frxclass::TfrxDialogControl
{
	typedef Frxclass::TfrxDialogControl inherited;
	
private:
	Vcl::Buttons::TBitBtn* FBitBtn;
	Vcl::Graphics::TBitmap* __fastcall GetGlyph(void);
	Vcl::Buttons::TBitBtnKind __fastcall GetKind(void);
	Vcl::Buttons::TButtonLayout __fastcall GetLayout(void);
	int __fastcall GetMargin(void);
	System::Uitypes::TModalResult __fastcall GetModalResult(void);
	int __fastcall GetSpacing(void);
	void __fastcall SetGlyph(Vcl::Graphics::TBitmap* const Value);
	void __fastcall SetKind(const Vcl::Buttons::TBitBtnKind Value);
	void __fastcall SetLayout(const Vcl::Buttons::TButtonLayout Value);
	void __fastcall SetMargin(const int Value);
	void __fastcall SetModalResult(const System::Uitypes::TModalResult Value);
	void __fastcall SetSpacing(const int Value);
	int __fastcall GetNumGlyphs(void);
	void __fastcall SetNumGlyphs(const int Value);
	bool __fastcall GetWordWrap(void);
	void __fastcall SetWordWrap(const bool Value);
	
public:
	__fastcall virtual TfrxBitBtnControl(System::Classes::TComponent* AOwner);
	__classmethod virtual System::UnicodeString __fastcall GetDescription();
	__property Vcl::Buttons::TBitBtn* BitBtn = {read=FBitBtn};
	
__published:
	__property Vcl::Graphics::TBitmap* Glyph = {read=GetGlyph, write=SetGlyph};
	__property Vcl::Buttons::TBitBtnKind Kind = {read=GetKind, write=SetKind, default=0};
	__property Caption = {default=0};
	__property Vcl::Buttons::TButtonLayout Layout = {read=GetLayout, write=SetLayout, default=0};
	__property int Margin = {read=GetMargin, write=SetMargin, default=-1};
	__property System::Uitypes::TModalResult ModalResult = {read=GetModalResult, write=SetModalResult, default=0};
	__property int NumGlyphs = {read=GetNumGlyphs, write=SetNumGlyphs, default=1};
	__property int Spacing = {read=GetSpacing, write=SetSpacing, default=4};
	__property bool WordWrap = {read=GetWordWrap, write=SetWordWrap, default=0};
	__property TabStop = {default=1};
	__property OnClick = {default=0};
	__property OnEnter = {default=0};
	__property OnExit = {default=0};
	__property OnKeyDown = {default=0};
	__property OnKeyPress = {default=0};
	__property OnKeyUp = {default=0};
	__property OnMouseDown = {default=0};
	__property OnMouseMove = {default=0};
	__property OnMouseUp = {default=0};
public:
	/* TfrxDialogControl.Destroy */ inline __fastcall virtual ~TfrxBitBtnControl(void) { }
	
public:
	/* TfrxComponent.DesignCreate */ inline __fastcall virtual TfrxBitBtnControl(System::Classes::TComponent* AOwner, System::Word Flags) : Frxclass::TfrxDialogControl(AOwner, Flags) { }
	
};


class DELPHICLASS TfrxSpeedButtonControl;
class PASCALIMPLEMENTATION TfrxSpeedButtonControl : public Frxclass::TfrxDialogControl
{
	typedef Frxclass::TfrxDialogControl inherited;
	
private:
	Vcl::Buttons::TSpeedButton* FSpeedButton;
	bool __fastcall GetAllowAllUp(void);
	bool __fastcall GetDown(void);
	bool __fastcall GetFlat(void);
	Vcl::Graphics::TBitmap* __fastcall GetGlyph(void);
	int __fastcall GetGroupIndex(void);
	Vcl::Buttons::TButtonLayout __fastcall GetLayout(void);
	int __fastcall GetMargin(void);
	int __fastcall GetSpacing(void);
	void __fastcall SetAllowAllUp(const bool Value);
	void __fastcall SetDown(const bool Value);
	void __fastcall SetFlat(const bool Value);
	void __fastcall SetGlyph(Vcl::Graphics::TBitmap* const Value);
	void __fastcall SetGroupIndex(const int Value);
	void __fastcall SetLayout(const Vcl::Buttons::TButtonLayout Value);
	void __fastcall SetMargin(const int Value);
	void __fastcall SetSpacing(const int Value);
	
public:
	__fastcall virtual TfrxSpeedButtonControl(System::Classes::TComponent* AOwner);
	__classmethod virtual System::UnicodeString __fastcall GetDescription();
	__property Vcl::Buttons::TSpeedButton* SpeedButton = {read=FSpeedButton};
	
__published:
	__property bool AllowAllUp = {read=GetAllowAllUp, write=SetAllowAllUp, default=0};
	__property Caption = {default=0};
	__property bool Down = {read=GetDown, write=SetDown, default=0};
	__property bool Flat = {read=GetFlat, write=SetFlat, default=0};
	__property Vcl::Graphics::TBitmap* Glyph = {read=GetGlyph, write=SetGlyph};
	__property int GroupIndex = {read=GetGroupIndex, write=SetGroupIndex, nodefault};
	__property Vcl::Buttons::TButtonLayout Layout = {read=GetLayout, write=SetLayout, default=0};
	__property int Margin = {read=GetMargin, write=SetMargin, default=-1};
	__property int Spacing = {read=GetSpacing, write=SetSpacing, default=4};
	__property OnClick = {default=0};
	__property OnDblClick = {default=0};
	__property OnMouseDown = {default=0};
	__property OnMouseMove = {default=0};
	__property OnMouseUp = {default=0};
public:
	/* TfrxDialogControl.Destroy */ inline __fastcall virtual ~TfrxSpeedButtonControl(void) { }
	
public:
	/* TfrxComponent.DesignCreate */ inline __fastcall virtual TfrxSpeedButtonControl(System::Classes::TComponent* AOwner, System::Word Flags) : Frxclass::TfrxDialogControl(AOwner, Flags) { }
	
};


class DELPHICLASS TfrxMaskEditControl;
class PASCALIMPLEMENTATION TfrxMaskEditControl : public TfrxCustomEditControl
{
	typedef TfrxCustomEditControl inherited;
	
private:
	Vcl::Mask::TMaskEdit* FMaskEdit;
	System::UnicodeString __fastcall GetEditMask(void);
	void __fastcall SetEditMask(const System::UnicodeString Value);
	
public:
	__fastcall virtual TfrxMaskEditControl(System::Classes::TComponent* AOwner);
	__classmethod virtual System::UnicodeString __fastcall GetDescription();
	__property Vcl::Mask::TMaskEdit* MaskEdit = {read=FMaskEdit};
	
__published:
	__property Color;
	__property System::UnicodeString EditMask = {read=GetEditMask, write=SetEditMask};
	__property MaxLength;
	__property ReadOnly = {default=0};
	__property TabStop = {default=1};
	__property Text = {default=0};
	__property OnChange = {default=0};
	__property OnClick = {default=0};
	__property OnDblClick = {default=0};
	__property OnEnter = {default=0};
	__property OnExit = {default=0};
	__property OnKeyDown = {default=0};
	__property OnKeyPress = {default=0};
	__property OnKeyUp = {default=0};
	__property OnMouseDown = {default=0};
	__property OnMouseMove = {default=0};
	__property OnMouseUp = {default=0};
public:
	/* TfrxDialogControl.Destroy */ inline __fastcall virtual ~TfrxMaskEditControl(void) { }
	
public:
	/* TfrxComponent.DesignCreate */ inline __fastcall virtual TfrxMaskEditControl(System::Classes::TComponent* AOwner, System::Word Flags) : TfrxCustomEditControl(AOwner, Flags) { }
	
};


class DELPHICLASS TfrxCheckListBoxControl;
class PASCALIMPLEMENTATION TfrxCheckListBoxControl : public Frxclass::TfrxDialogControl
{
	typedef Frxclass::TfrxDialogControl inherited;
	
private:
	Vcl::Checklst::TCheckListBox* FCheckListBox;
	bool __fastcall GetAllowGrayed(void);
	System::Classes::TStrings* __fastcall GetItems(void);
	bool __fastcall GetSorted(void);
	bool __fastcall GetChecked(int Index);
	Vcl::Stdctrls::TCheckBoxState __fastcall GetState(int Index);
	void __fastcall SetAllowGrayed(const bool Value);
	void __fastcall SetItems(System::Classes::TStrings* const Value);
	void __fastcall SetSorted(const bool Value);
	void __fastcall SetChecked(int Index, const bool Value);
	void __fastcall SetState(int Index, const Vcl::Stdctrls::TCheckBoxState Value);
	int __fastcall GetItemIndex(void);
	void __fastcall SetItemIndex(const int Value);
	
public:
	__fastcall virtual TfrxCheckListBoxControl(System::Classes::TComponent* AOwner);
	__classmethod virtual System::UnicodeString __fastcall GetDescription();
	__property Vcl::Checklst::TCheckListBox* CheckListBox = {read=FCheckListBox};
	__property bool Checked[int Index] = {read=GetChecked, write=SetChecked};
	__property int ItemIndex = {read=GetItemIndex, write=SetItemIndex, nodefault};
	__property Vcl::Stdctrls::TCheckBoxState State[int Index] = {read=GetState, write=SetState};
	
__published:
	__property bool AllowGrayed = {read=GetAllowGrayed, write=SetAllowGrayed, default=0};
	__property Color;
	__property System::Classes::TStrings* Items = {read=GetItems, write=SetItems};
	__property bool Sorted = {read=GetSorted, write=SetSorted, default=0};
	__property TabStop = {default=1};
	__property OnClick = {default=0};
	__property OnDblClick = {default=0};
	__property OnEnter = {default=0};
	__property OnExit = {default=0};
	__property OnKeyDown = {default=0};
	__property OnKeyPress = {default=0};
	__property OnKeyUp = {default=0};
	__property OnMouseDown = {default=0};
	__property OnMouseMove = {default=0};
	__property OnMouseUp = {default=0};
public:
	/* TfrxDialogControl.Destroy */ inline __fastcall virtual ~TfrxCheckListBoxControl(void) { }
	
public:
	/* TfrxComponent.DesignCreate */ inline __fastcall virtual TfrxCheckListBoxControl(System::Classes::TComponent* AOwner, System::Word Flags) : Frxclass::TfrxDialogControl(AOwner, Flags) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Frxdctrl */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FRXDCTRL)
using namespace Frxdctrl;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// FrxdctrlHPP
