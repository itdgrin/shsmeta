// CodeGear C++Builder
// Copyright (c) 1995, 2013 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'frxCrossEditor.pas' rev: 26.00 (Windows)

#ifndef FrxcrosseditorHPP
#define FrxcrosseditorHPP

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
#include <Vcl.ImgList.hpp>	// Pascal unit
#include <Vcl.Menus.hpp>	// Pascal unit
#include <Vcl.ComCtrls.hpp>	// Pascal unit
#include <Vcl.Buttons.hpp>	// Pascal unit
#include <Vcl.ToolWin.hpp>	// Pascal unit
#include <Vcl.ExtCtrls.hpp>	// Pascal unit
#include <frxDock.hpp>	// Pascal unit
#include <frxCross.hpp>	// Pascal unit
#include <frxClass.hpp>	// Pascal unit
#include <frxCtrls.hpp>	// Pascal unit
#include <frxCustomEditors.hpp>	// Pascal unit
#include <System.Variants.hpp>	// Pascal unit
#include <System.UITypes.hpp>	// Pascal unit
#include <frxDsgnIntf.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Frxcrosseditor
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TfrxCrossEditor;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TfrxCrossEditor : public Frxcustomeditors::TfrxViewEditor
{
	typedef Frxcustomeditors::TfrxViewEditor inherited;
	
public:
	virtual bool __fastcall Edit(void);
	virtual bool __fastcall HasEditor(void);
public:
	/* TfrxComponentEditor.Create */ inline __fastcall TfrxCrossEditor(Frxclass::TfrxComponent* Component, Frxclass::TfrxCustomDesigner* Designer, Vcl::Menus::TMenu* Menu) : Frxcustomeditors::TfrxViewEditor(Component, Designer, Menu) { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TfrxCrossEditor(void) { }
	
};

#pragma pack(pop)

class DELPHICLASS TfrxCrossEditorForm;
class PASCALIMPLEMENTATION TfrxCrossEditorForm : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
private:
	typedef System::StaticArray<System::UnicodeString, 6> _TfrxCrossEditorForm__1;
	
	typedef System::StaticArray<System::UnicodeString, 4> _TfrxCrossEditorForm__2;
	
	
__published:
	Vcl::Menus::TPopupMenu* FuncPopup;
	Vcl::Menus::TMenuItem* Func1MI;
	Vcl::Menus::TMenuItem* Func2MI;
	Vcl::Menus::TMenuItem* Func3MI;
	Vcl::Menus::TMenuItem* Func4MI;
	Vcl::Menus::TMenuItem* Func5MI;
	Vcl::Menus::TMenuItem* Func6MI;
	Vcl::Menus::TPopupMenu* SortPopup;
	Vcl::Menus::TMenuItem* Sort1MI;
	Vcl::Menus::TMenuItem* Sort2MI;
	Vcl::Menus::TMenuItem* Sort3MI;
	Vcl::Stdctrls::TGroupBox* DatasetL;
	Vcl::Stdctrls::TComboBox* DatasetCB;
	Vcl::Stdctrls::TListBox* FieldsLB;
	Vcl::Stdctrls::TGroupBox* DimensionsL;
	Vcl::Stdctrls::TLabel* RowsL;
	Vcl::Stdctrls::TEdit* RowsE;
	Vcl::Stdctrls::TLabel* ColumnsL;
	Vcl::Stdctrls::TEdit* ColumnsE;
	Vcl::Stdctrls::TLabel* CellsL;
	Vcl::Stdctrls::TEdit* CellsE;
	Vcl::Comctrls::TUpDown* UpDown1;
	Vcl::Comctrls::TUpDown* UpDown2;
	Vcl::Comctrls::TUpDown* UpDown3;
	Vcl::Stdctrls::TGroupBox* StructureL;
	Vcl::Extctrls::TShape* Shape1;
	Vcl::Extctrls::TShape* Shape2;
	Vcl::Buttons::TSpeedButton* SwapB;
	Vcl::Stdctrls::TListBox* RowsLB;
	Vcl::Stdctrls::TListBox* ColumnsLB;
	Vcl::Stdctrls::TListBox* CellsLB;
	Vcl::Stdctrls::TGroupBox* OptionsL;
	Vcl::Stdctrls::TCheckBox* RowHeaderCB;
	Vcl::Stdctrls::TCheckBox* ColumnHeaderCB;
	Vcl::Stdctrls::TCheckBox* RowTotalCB;
	Vcl::Stdctrls::TCheckBox* ColumnTotalCB;
	Vcl::Stdctrls::TCheckBox* TitleCB;
	Vcl::Stdctrls::TCheckBox* CornerCB;
	Vcl::Stdctrls::TCheckBox* AutoSizeCB;
	Vcl::Stdctrls::TCheckBox* BorderCB;
	Vcl::Stdctrls::TCheckBox* DownAcrossCB;
	Vcl::Stdctrls::TCheckBox* PlainCB;
	Vcl::Stdctrls::TCheckBox* JoinCB;
	Vcl::Forms::TScrollBox* Box;
	Vcl::Extctrls::TPaintBox* PaintBox;
	Vcl::Stdctrls::TButton* OkB;
	Vcl::Stdctrls::TButton* CancelB;
	Vcl::Stdctrls::TCheckBox* RepeatCB;
	Vcl::Menus::TPopupMenu* StylePopup;
	Vcl::Menus::TMenuItem* Sep1;
	Vcl::Menus::TMenuItem* SaveStyleMI;
	Vcl::Comctrls::TToolBar* ToolBar;
	Vcl::Comctrls::TToolButton* StyleB;
	Vcl::Menus::TMenuItem* Sort4MI;
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall CancelBClick(System::TObject* Sender);
	void __fastcall OkBClick(System::TObject* Sender);
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall FormHide(System::TObject* Sender);
	void __fastcall DatasetCBClick(System::TObject* Sender);
	void __fastcall DatasetCBDrawItem(Vcl::Controls::TWinControl* Control, int Index, const System::Types::TRect &ARect, Winapi::Windows::TOwnerDrawState State);
	void __fastcall FieldsLBDrawItem(Vcl::Controls::TWinControl* Control, int Index, const System::Types::TRect &ARect, Winapi::Windows::TOwnerDrawState State);
	void __fastcall LBDrawItem(Vcl::Controls::TWinControl* Control, int Index, const System::Types::TRect &ARect, Winapi::Windows::TOwnerDrawState State);
	void __fastcall CellsLBDrawItem(Vcl::Controls::TWinControl* Control, int Index, const System::Types::TRect &ARect, Winapi::Windows::TOwnerDrawState State);
	void __fastcall LBDragOver(System::TObject* Sender, System::TObject* Source, int X, int Y, System::Uitypes::TDragState State, bool &Accept);
	void __fastcall LBDragDrop(System::TObject* Sender, System::TObject* Source, int X, int Y);
	void __fastcall LBMouseDown(System::TObject* Sender, System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	void __fastcall LBClick(System::TObject* Sender);
	void __fastcall CBClick(System::TObject* Sender);
	void __fastcall FuncMIClick(System::TObject* Sender);
	void __fastcall CellsLBMouseUp(System::TObject* Sender, System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	void __fastcall SortMIClick(System::TObject* Sender);
	void __fastcall SwapBClick(System::TObject* Sender);
	void __fastcall DimensionsChange(System::TObject* Sender);
	void __fastcall LBDblClick(System::TObject* Sender);
	void __fastcall FormKeyDown(System::TObject* Sender, System::Word &Key, System::Classes::TShiftState Shift);
	void __fastcall PaintBoxPaint(System::TObject* Sender);
	void __fastcall SaveStyleMIClick(System::TObject* Sender);
	
private:
	Frxcross::TfrxCustomCrossView* FCross;
	Vcl::Stdctrls::TListBox* FCurList;
	_TfrxCrossEditorForm__1 FFuncNames;
	Vcl::Controls::TImageList* FImages;
	_TfrxCrossEditorForm__2 FSortNames;
	Frxclass::TfrxStyleSheet* FStyleSheet;
	Frxcross::TfrxDBCrossView* FTempCross;
	bool FUpdating;
	void __fastcall ReflectChanges(System::TObject* ChangesFrom, bool UpdateText = true);
	void __fastcall CreateStyleMenu(void);
	void __fastcall StyleClick(System::TObject* Sender);
	
public:
	__fastcall virtual TfrxCrossEditorForm(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TfrxCrossEditorForm(void);
	__property Frxcross::TfrxCustomCrossView* Cross = {read=FCross, write=FCross};
public:
	/* TCustomForm.CreateNew */ inline __fastcall virtual TfrxCrossEditorForm(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TfrxCrossEditorForm(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Frxcrosseditor */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FRXCROSSEDITOR)
using namespace Frxcrosseditor;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// FrxcrosseditorHPP
