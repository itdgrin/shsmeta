// CodeGear C++Builder
// Copyright (c) 1995, 2013 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'frxRichEditor.pas' rev: 26.00 (Windows)

#ifndef FrxricheditorHPP
#define FrxricheditorHPP

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
#include <frxRich.hpp>	// Pascal unit
#include <frxCustomEditors.hpp>	// Pascal unit
#include <frxCtrls.hpp>	// Pascal unit
#include <frxRichEdit.hpp>	// Pascal unit
#include <Vcl.ImgList.hpp>	// Pascal unit
#include <frxDock.hpp>	// Pascal unit
#include <Vcl.ToolWin.hpp>	// Pascal unit
#include <Vcl.ComCtrls.hpp>	// Pascal unit
#include <frxUnicodeCtrls.hpp>	// Pascal unit
#include <System.Variants.hpp>	// Pascal unit
#include <frxDsgnIntf.hpp>	// Pascal unit
#include <System.UITypes.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Frxricheditor
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TfrxRichEditor;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TfrxRichEditor : public Frxcustomeditors::TfrxViewEditor
{
	typedef Frxcustomeditors::TfrxViewEditor inherited;
	
public:
	virtual bool __fastcall Edit(void);
	virtual bool __fastcall HasEditor(void);
	virtual void __fastcall GetMenuItems(void);
	virtual bool __fastcall Execute(int Tag, bool Checked);
public:
	/* TfrxComponentEditor.Create */ inline __fastcall TfrxRichEditor(Frxclass::TfrxComponent* Component, Frxclass::TfrxCustomDesigner* Designer, Vcl::Menus::TMenu* Menu) : Frxcustomeditors::TfrxViewEditor(Component, Designer, Menu) { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TfrxRichEditor(void) { }
	
};

#pragma pack(pop)

class DELPHICLASS TfrxRichEditorForm;
class PASCALIMPLEMENTATION TfrxRichEditorForm : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Dialogs::TOpenDialog* OpenDialog;
	Vcl::Dialogs::TSaveDialog* SaveDialog;
	Vcl::Comctrls::TToolBar* SpeedBar;
	Vcl::Extctrls::TPanel* Ruler;
	Vcl::Dialogs::TFontDialog* FontDialog1;
	Vcl::Stdctrls::TLabel* FirstInd;
	Vcl::Stdctrls::TLabel* LeftInd;
	Vcl::Extctrls::TBevel* RulerLine;
	Vcl::Stdctrls::TLabel* RightInd;
	Vcl::Comctrls::TToolButton* BoldB;
	Vcl::Comctrls::TToolButton* ItalicB;
	Vcl::Comctrls::TToolButton* LeftAlignB;
	Vcl::Comctrls::TToolButton* CenterAlignB;
	Vcl::Comctrls::TToolButton* RightAlignB;
	Vcl::Comctrls::TToolButton* UnderlineB;
	Vcl::Comctrls::TToolButton* BulletsB;
	Vcl::Comctrls::TToolButton* TTB;
	Vcl::Comctrls::TToolButton* CancelB;
	Vcl::Comctrls::TToolButton* OkB;
	Vcl::Comctrls::TToolButton* ExprB;
	Frxctrls::TfrxFontComboBox* FontNameCB;
	Frxctrls::TfrxComboBox* FontSizeCB;
	Vcl::Comctrls::TToolButton* OpenB;
	Vcl::Comctrls::TToolButton* SaveB;
	Vcl::Comctrls::TToolButton* UndoB;
	Vcl::Comctrls::TToolButton* Sep1;
	Vcl::Comctrls::TToolButton* Sep2;
	Frxdock::TfrxTBPanel* Sep3;
	Vcl::Comctrls::TToolButton* Sep4;
	Vcl::Comctrls::TToolButton* Sep5;
	Vcl::Comctrls::TToolButton* BlockAlignB;
	void __fastcall SelectionChange(System::TObject* Sender);
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall FileOpen(System::TObject* Sender);
	void __fastcall FileSaveAs(System::TObject* Sender);
	void __fastcall EditUndo(System::TObject* Sender);
	void __fastcall SelectFont(System::TObject* Sender);
	void __fastcall RulerResize(System::TObject* Sender);
	void __fastcall FormResize(System::TObject* Sender);
	void __fastcall FormPaint(System::TObject* Sender);
	void __fastcall BoldBClick(System::TObject* Sender);
	void __fastcall AlignButtonClick(System::TObject* Sender);
	void __fastcall FontNameCBChange(System::TObject* Sender);
	void __fastcall BulletsBClick(System::TObject* Sender);
	void __fastcall RulerItemMouseDown(System::TObject* Sender, System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	void __fastcall RulerItemMouseMove(System::TObject* Sender, System::Classes::TShiftState Shift, int X, int Y);
	void __fastcall FirstIndMouseUp(System::TObject* Sender, System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	void __fastcall LeftIndMouseUp(System::TObject* Sender, System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	void __fastcall RightIndMouseUp(System::TObject* Sender, System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	void __fastcall CancelBClick(System::TObject* Sender);
	void __fastcall OkBClick(System::TObject* Sender);
	void __fastcall ExprBClick(System::TObject* Sender);
	void __fastcall FontSizeCBChange(System::TObject* Sender);
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall FormHide(System::TObject* Sender);
	void __fastcall FormKeyDown(System::TObject* Sender, System::Word &Key, System::Classes::TShiftState Shift);
	
private:
	bool FDragging;
	int FDragOfs;
	Frxrich::TfrxRichView* FRichView;
	bool FUpdating;
	Frxunicodectrls::TRxUnicodeRichEdit* RichEdit1;
	Frxrichedit::TRxTextAttributes* __fastcall CurrText(void);
	void __fastcall SetupRuler(void);
	void __fastcall SetEditRect(void);
	
public:
	__property Frxrich::TfrxRichView* RichView = {read=FRichView, write=FRichView};
public:
	/* TCustomForm.Create */ inline __fastcall virtual TfrxRichEditorForm(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TfrxRichEditorForm(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TfrxRichEditorForm(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TfrxRichEditorForm(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Frxricheditor */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FRXRICHEDITOR)
using namespace Frxricheditor;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// FrxricheditorHPP
