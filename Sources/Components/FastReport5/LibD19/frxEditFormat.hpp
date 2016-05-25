// CodeGear C++Builder
// Copyright (c) 1995, 2013 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'frxEditFormat.pas' rev: 26.00 (Windows)

#ifndef FrxeditformatHPP
#define FrxeditformatHPP

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
#include <Vcl.ExtCtrls.hpp>	// Pascal unit
#include <frxClass.hpp>	// Pascal unit
#include <System.Variants.hpp>	// Pascal unit
#include <System.Types.hpp>	// Pascal unit
#include <System.UITypes.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Frxeditformat
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TfrxFormatEditorForm;
class PASCALIMPLEMENTATION TfrxFormatEditorForm : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Stdctrls::TButton* OkB;
	Vcl::Stdctrls::TButton* CancelB;
	Vcl::Stdctrls::TListBox* CategoryLB;
	Vcl::Stdctrls::TListBox* FormatLB;
	Vcl::Stdctrls::TGroupBox* GroupBox1;
	Vcl::Stdctrls::TLabel* FormatStrL;
	Vcl::Stdctrls::TLabel* SeparatorL;
	Vcl::Stdctrls::TEdit* FormatE;
	Vcl::Stdctrls::TEdit* SeparatorE;
	Vcl::Stdctrls::TComboBox* ComboBox1;
	Vcl::Stdctrls::TLabel* ExpressionL;
	Vcl::Stdctrls::TLabel* CategoryL;
	Vcl::Stdctrls::TLabel* FormatL;
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall CategoryLBClick(System::TObject* Sender);
	void __fastcall FormatLBDrawItem(Vcl::Controls::TWinControl* Control, int Index, const System::Types::TRect &ARect, Winapi::Windows::TOwnerDrawState State);
	void __fastcall FormatLBClick(System::TObject* Sender);
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall FormHide(System::TObject* Sender);
	void __fastcall FormKeyDown(System::TObject* Sender, System::Word &Key, System::Classes::TShiftState Shift);
	void __fastcall ComboBox1Change(System::TObject* Sender);
	
private:
	Frxclass::TfrxCustomMemoView* FMemo;
	System::WideString FMemoText;
	Frxclass::TfrxFormatCollection* FFormats;
	Frxclass::TfrxFormat* FCurFormat;
	void __fastcall FillFormats(void);
	void __fastcall SetMemo(Frxclass::TfrxCustomMemoView* Value);
	void __fastcall UpdateCurFormat(void);
	void __fastcall UpdateControls(void);
	
public:
	__fastcall virtual TfrxFormatEditorForm(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TfrxFormatEditorForm(void);
	void __fastcall HostControls(Vcl::Controls::TWinControl* Host);
	void __fastcall UnhostControls(System::Uitypes::TModalResult AModalResult);
	__property Frxclass::TfrxCustomMemoView* Memo = {read=FMemo, write=SetMemo};
	__property System::WideString MemoText = {read=FMemoText, write=FMemoText};
public:
	/* TCustomForm.CreateNew */ inline __fastcall virtual TfrxFormatEditorForm(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TfrxFormatEditorForm(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Frxeditformat */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FRXEDITFORMAT)
using namespace Frxeditformat;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// FrxeditformatHPP
