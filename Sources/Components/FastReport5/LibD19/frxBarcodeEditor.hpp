// CodeGear C++Builder
// Copyright (c) 1995, 2013 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'frxBarcodeEditor.pas' rev: 26.00 (Windows)

#ifndef FrxbarcodeeditorHPP
#define FrxbarcodeeditorHPP

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
#include <Vcl.Menus.hpp>	// Pascal unit
#include <Vcl.ExtCtrls.hpp>	// Pascal unit
#include <Vcl.Buttons.hpp>	// Pascal unit
#include <frxClass.hpp>	// Pascal unit
#include <frxBarcode.hpp>	// Pascal unit
#include <frxCustomEditors.hpp>	// Pascal unit
#include <frxBarcod.hpp>	// Pascal unit
#include <frxCtrls.hpp>	// Pascal unit
#include <Vcl.ComCtrls.hpp>	// Pascal unit
#include <System.Variants.hpp>	// Pascal unit
#include <frxDsgnIntf.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Frxbarcodeeditor
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TfrxBarcodeEditor;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TfrxBarcodeEditor : public Frxcustomeditors::TfrxViewEditor
{
	typedef Frxcustomeditors::TfrxViewEditor inherited;
	
public:
	virtual bool __fastcall Edit(void);
	virtual bool __fastcall HasEditor(void);
	virtual void __fastcall GetMenuItems(void);
	virtual bool __fastcall Execute(int Tag, bool Checked);
public:
	/* TfrxComponentEditor.Create */ inline __fastcall TfrxBarcodeEditor(Frxclass::TfrxComponent* Component, Frxclass::TfrxCustomDesigner* Designer, Vcl::Menus::TMenu* Menu) : Frxcustomeditors::TfrxViewEditor(Component, Designer, Menu) { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TfrxBarcodeEditor(void) { }
	
};

#pragma pack(pop)

class DELPHICLASS TfrxBarcodeEditorForm;
class PASCALIMPLEMENTATION TfrxBarcodeEditorForm : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Stdctrls::TButton* CancelB;
	Vcl::Stdctrls::TButton* OkB;
	Frxctrls::TfrxComboEdit* CodeE;
	Vcl::Stdctrls::TLabel* CodeLbl;
	Vcl::Stdctrls::TComboBox* TypeCB;
	Vcl::Stdctrls::TLabel* TypeLbl;
	Vcl::Extctrls::TBevel* ExampleBvl;
	Vcl::Extctrls::TPaintBox* ExamplePB;
	Vcl::Stdctrls::TGroupBox* OptionsLbl;
	Vcl::Stdctrls::TLabel* ZoomLbl;
	Vcl::Stdctrls::TCheckBox* CalcCheckSumCB;
	Vcl::Stdctrls::TCheckBox* ViewTextCB;
	Vcl::Stdctrls::TEdit* ZoomE;
	Vcl::Comctrls::TUpDown* UpDown1;
	Vcl::Stdctrls::TGroupBox* RotationLbl;
	Vcl::Stdctrls::TRadioButton* Rotation0RB;
	Vcl::Stdctrls::TRadioButton* Rotation90RB;
	Vcl::Stdctrls::TRadioButton* Rotation180RB;
	Vcl::Stdctrls::TRadioButton* Rotation270RB;
	void __fastcall ExprBtnClick(System::TObject* Sender);
	void __fastcall UpBClick(System::TObject* Sender);
	void __fastcall DownBClick(System::TObject* Sender);
	void __fastcall ExamplePBPaint(System::TObject* Sender);
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall FormHide(System::TObject* Sender);
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall FormKeyDown(System::TObject* Sender, System::Word &Key, System::Classes::TShiftState Shift);
	
private:
	Frxbarcode::TfrxBarCodeView* FBarcode;
	
public:
	__property Frxbarcode::TfrxBarCodeView* Barcode = {read=FBarcode, write=FBarcode};
public:
	/* TCustomForm.Create */ inline __fastcall virtual TfrxBarcodeEditorForm(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TfrxBarcodeEditorForm(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TfrxBarcodeEditorForm(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TfrxBarcodeEditorForm(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Frxbarcodeeditor */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FRXBARCODEEDITOR)
using namespace Frxbarcodeeditor;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// FrxbarcodeeditorHPP
