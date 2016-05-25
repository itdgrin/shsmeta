// CodeGear C++Builder
// Copyright (c) 1995, 2013 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'frxEditStyle.pas' rev: 26.00 (Windows)

#ifndef FrxeditstyleHPP
#define FrxeditstyleHPP

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
#include <Vcl.ComCtrls.hpp>	// Pascal unit
#include <Vcl.ExtCtrls.hpp>	// Pascal unit
#include <Vcl.StdCtrls.hpp>	// Pascal unit
#include <Vcl.ToolWin.hpp>	// Pascal unit
#include <Vcl.ImgList.hpp>	// Pascal unit
#include <frxClass.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Frxeditstyle
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TfrxStyleEditorForm;
class PASCALIMPLEMENTATION TfrxStyleEditorForm : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Comctrls::TToolBar* ToolBar;
	Vcl::Comctrls::TToolButton* AddB;
	Vcl::Comctrls::TToolButton* DeleteB;
	Vcl::Comctrls::TToolButton* Sep1;
	Vcl::Comctrls::TToolButton* LoadB;
	Vcl::Comctrls::TToolButton* SaveB;
	Vcl::Comctrls::TToolButton* Sep2;
	Vcl::Comctrls::TToolButton* CancelB;
	Vcl::Comctrls::TToolButton* OkB;
	Vcl::Dialogs::TOpenDialog* OpenDialog;
	Vcl::Dialogs::TSaveDialog* SaveDialog;
	Vcl::Comctrls::TTreeView* StylesTV;
	Vcl::Comctrls::TToolButton* EditB;
	Vcl::Extctrls::TPaintBox* PaintBox;
	Vcl::Stdctrls::TButton* ColorB;
	Vcl::Stdctrls::TButton* FontB;
	Vcl::Stdctrls::TButton* FrameB;
	Vcl::Stdctrls::TCheckBox* DefCB;
	Vcl::Stdctrls::TCheckBox* ApplyFillCB;
	Vcl::Stdctrls::TCheckBox* ApplyFontCB;
	Vcl::Stdctrls::TCheckBox* ApplyFrameCB;
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall CancelBClick(System::TObject* Sender);
	void __fastcall OkBClick(System::TObject* Sender);
	void __fastcall PaintBoxPaint(System::TObject* Sender);
	void __fastcall FormHide(System::TObject* Sender);
	void __fastcall AddBClick(System::TObject* Sender);
	void __fastcall DeleteBClick(System::TObject* Sender);
	void __fastcall LoadBClick(System::TObject* Sender);
	void __fastcall SaveBClick(System::TObject* Sender);
	void __fastcall BClick(System::TObject* Sender);
	void __fastcall StylesTVClick(System::TObject* Sender);
	void __fastcall StylesTVEdited(System::TObject* Sender, Vcl::Comctrls::TTreeNode* Node, System::UnicodeString &S);
	void __fastcall EditBClick(System::TObject* Sender);
	void __fastcall FormKeyDown(System::TObject* Sender, System::Word &Key, System::Classes::TShiftState Shift);
	void __fastcall DefCBClick(System::TObject* Sender);
	void __fastcall ApplyFillCBClick(System::TObject* Sender);
	
private:
	Vcl::Controls::TImageList* FImageList;
	Frxclass::TfrxReport* FReport;
	Frxclass::TfrxStyles* FStyles;
	bool FIsLocked;
	void __fastcall UpdateStyles(int Focus = 0x0);
	void __fastcall UpdateControls(void);
	
public:
	__fastcall virtual TfrxStyleEditorForm(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TfrxStyleEditorForm(void);
public:
	/* TCustomForm.CreateNew */ inline __fastcall virtual TfrxStyleEditorForm(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TfrxStyleEditorForm(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Frxeditstyle */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FRXEDITSTYLE)
using namespace Frxeditstyle;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// FrxeditstyleHPP
