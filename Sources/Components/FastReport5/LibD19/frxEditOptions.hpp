// CodeGear C++Builder
// Copyright (c) 1995, 2013 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'frxEditOptions.pas' rev: 26.00 (Windows)

#ifndef FrxeditoptionsHPP
#define FrxeditoptionsHPP

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
#include <frxCtrls.hpp>	// Pascal unit
#include <System.Variants.hpp>	// Pascal unit
#include <System.UITypes.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Frxeditoptions
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TfrxOptionsEditor;
class PASCALIMPLEMENTATION TfrxOptionsEditor : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Stdctrls::TButton* OkB;
	Vcl::Stdctrls::TButton* CancelB;
	Vcl::Dialogs::TColorDialog* ColorDialog;
	Vcl::Stdctrls::TButton* RestoreDefaultsB;
	Vcl::Stdctrls::TGroupBox* Label1;
	Vcl::Stdctrls::TLabel* Label2;
	Vcl::Stdctrls::TLabel* Label3;
	Vcl::Stdctrls::TLabel* Label4;
	Vcl::Stdctrls::TLabel* Label13;
	Vcl::Stdctrls::TLabel* Label14;
	Vcl::Stdctrls::TLabel* Label15;
	Vcl::Stdctrls::TLabel* Label16;
	Vcl::Stdctrls::TRadioButton* CMRB;
	Vcl::Stdctrls::TRadioButton* InchesRB;
	Vcl::Stdctrls::TRadioButton* PixelsRB;
	Vcl::Stdctrls::TEdit* CME;
	Vcl::Stdctrls::TEdit* InchesE;
	Vcl::Stdctrls::TEdit* PixelsE;
	Vcl::Stdctrls::TEdit* DialogFormE;
	Vcl::Stdctrls::TCheckBox* ShowGridCB;
	Vcl::Stdctrls::TCheckBox* AlignGridCB;
	Vcl::Stdctrls::TGroupBox* Label6;
	Vcl::Stdctrls::TLabel* Label7;
	Vcl::Stdctrls::TLabel* Label8;
	Vcl::Stdctrls::TLabel* Label9;
	Vcl::Stdctrls::TLabel* Label10;
	Vcl::Stdctrls::TComboBox* CodeWindowFontCB;
	Vcl::Stdctrls::TComboBox* CodeWindowSizeCB;
	Vcl::Stdctrls::TComboBox* MemoEditorFontCB;
	Vcl::Stdctrls::TComboBox* MemoEditorSizeCB;
	Vcl::Stdctrls::TCheckBox* ObjectFontCB;
	Vcl::Stdctrls::TGroupBox* Label11;
	Vcl::Extctrls::TPaintBox* WorkspacePB;
	Vcl::Extctrls::TPaintBox* ToolPB;
	Vcl::Stdctrls::TButton* WorkspaceB;
	Vcl::Stdctrls::TButton* ToolB;
	Vcl::Stdctrls::TCheckBox* LCDCB;
	Vcl::Stdctrls::TGroupBox* Label5;
	Vcl::Stdctrls::TLabel* Label12;
	Vcl::Stdctrls::TLabel* Label17;
	Vcl::Stdctrls::TCheckBox* EditAfterInsCB;
	Vcl::Stdctrls::TCheckBox* FreeBandsCB;
	Vcl::Stdctrls::TEdit* GapE;
	Vcl::Stdctrls::TCheckBox* BandsCaptionsCB;
	Vcl::Stdctrls::TCheckBox* DropFieldsCB;
	Vcl::Stdctrls::TCheckBox* StartupCB;
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall WorkspacePBPaint(System::TObject* Sender);
	void __fastcall ToolPBPaint(System::TObject* Sender);
	void __fastcall WorkspaceBClick(System::TObject* Sender);
	void __fastcall ToolBClick(System::TObject* Sender);
	void __fastcall RestoreDefaultsBClick(System::TObject* Sender);
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall FormHide(System::TObject* Sender);
	void __fastcall FormKeyDown(System::TObject* Sender, System::Word &Key, System::Classes::TShiftState Shift);
	
private:
	System::Uitypes::TColor FWColor;
	System::Uitypes::TColor FTColor;
public:
	/* TCustomForm.Create */ inline __fastcall virtual TfrxOptionsEditor(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TfrxOptionsEditor(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TfrxOptionsEditor(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TfrxOptionsEditor(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Frxeditoptions */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FRXEDITOPTIONS)
using namespace Frxeditoptions;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// FrxeditoptionsHPP
