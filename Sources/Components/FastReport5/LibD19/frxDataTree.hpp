// CodeGear C++Builder
// Copyright (c) 1995, 2013 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'frxDataTree.pas' rev: 26.00 (Windows)

#ifndef FrxdatatreeHPP
#define FrxdatatreeHPP

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
#include <fs_xml.hpp>	// Pascal unit
#include <Vcl.ComCtrls.hpp>	// Pascal unit
#include <Vcl.Tabs.hpp>	// Pascal unit
#include <System.Variants.hpp>	// Pascal unit
#include <System.UITypes.hpp>	// Pascal unit
#include <System.Types.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Frxdatatree
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TfrxDataTreeForm;
class PASCALIMPLEMENTATION TfrxDataTreeForm : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Extctrls::TPanel* DataPn;
	Vcl::Comctrls::TTreeView* DataTree;
	Vcl::Extctrls::TPanel* CBPanel;
	Vcl::Stdctrls::TCheckBox* InsFieldCB;
	Vcl::Stdctrls::TCheckBox* InsCaptionCB;
	Vcl::Extctrls::TPanel* VariablesPn;
	Vcl::Comctrls::TTreeView* VariablesTree;
	Vcl::Extctrls::TPanel* FunctionsPn;
	Vcl::Extctrls::TSplitter* Splitter1;
	Vcl::Forms::TScrollBox* HintPanel;
	Vcl::Stdctrls::TLabel* FunctionDescL;
	Vcl::Stdctrls::TLabel* FunctionNameL;
	Vcl::Comctrls::TTreeView* FunctionsTree;
	Vcl::Extctrls::TPanel* ClassesPn;
	Vcl::Comctrls::TTreeView* ClassesTree;
	Vcl::Forms::TScrollBox* NoDataPn;
	Vcl::Stdctrls::TLabel* NoDataL;
	Vcl::Stdctrls::TCheckBox* SortCB;
	void __fastcall FormResize(System::TObject* Sender);
	void __fastcall DataTreeCustomDrawItem(Vcl::Comctrls::TCustomTreeView* Sender, Vcl::Comctrls::TTreeNode* Node, Vcl::Comctrls::TCustomDrawState State, bool &DefaultDraw);
	void __fastcall FunctionsTreeChange(System::TObject* Sender, Vcl::Comctrls::TTreeNode* Node);
	void __fastcall DataTreeDblClick(System::TObject* Sender);
	void __fastcall ClassesTreeExpanding(System::TObject* Sender, Vcl::Comctrls::TTreeNode* Node, bool &AllowExpansion);
	void __fastcall ClassesTreeCustomDrawItem(Vcl::Comctrls::TCustomTreeView* Sender, Vcl::Comctrls::TTreeNode* Node, Vcl::Comctrls::TCustomDrawState State, bool &DefaultDraw);
	void __fastcall SortCBClick(System::TObject* Sender);
	
private:
	Fs_xml::TfsXMLDocument* FXML;
	Vcl::Controls::TImageList* FImages;
	Frxclass::TfrxReport* FReport;
	bool FUpdating;
	bool FFirstTime;
	bool FMultiSelectAllowed;
	Vcl::Tabs::TTabSet* FTabs;
	void __fastcall FillClassesTree(void);
	void __fastcall FillDataTree(void);
	void __fastcall FillFunctionsTree(void);
	void __fastcall FillVariablesTree(void);
	void __fastcall TabsChange(System::TObject* Sender);
	System::UnicodeString __fastcall GetCollapsedNodes(void);
	
public:
	__fastcall virtual TfrxDataTreeForm(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TfrxDataTreeForm(void);
	void __fastcall SetColor_(System::Uitypes::TColor AColor);
	void __fastcall SetControlsParent(Vcl::Controls::TWinControl* AParent);
	void __fastcall SetLastPosition(const System::Types::TPoint &p);
	void __fastcall ShowTab(int Index);
	void __fastcall UpdateItems(void);
	void __fastcall UpdateSelection(void);
	void __fastcall UpdateSize(void);
	void __fastcall CheclMultiSelection(void);
	int __fastcall GetActivePage(void);
	System::UnicodeString __fastcall GetFieldName(int SelectionIndex = 0xffffffff);
	Frxclass::TfrxDataSet* __fastcall GetDataSet(int SelectionIndex);
	System::UnicodeString __fastcall ActiveDS(void);
	System::Types::TPoint __fastcall GetLastPosition(void);
	bool __fastcall IsDataField(void);
	int __fastcall GetSelectionCount(void);
	__property Frxclass::TfrxReport* Report = {read=FReport, write=FReport};
	__property bool MultiSelectAllowed = {read=FMultiSelectAllowed, write=FMultiSelectAllowed, nodefault};
public:
	/* TCustomForm.CreateNew */ inline __fastcall virtual TfrxDataTreeForm(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TfrxDataTreeForm(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Frxdatatree */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FRXDATATREE)
using namespace Frxdatatree;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// FrxdatatreeHPP
