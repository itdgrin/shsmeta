// CodeGear C++Builder
// Copyright (c) 1995, 2013 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'frxChartEditor.pas' rev: 26.00 (Windows)

#ifndef FrxcharteditorHPP
#define FrxcharteditorHPP

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
#include <frxChart.hpp>	// Pascal unit
#include <frxCustomEditors.hpp>	// Pascal unit
#include <frxCtrls.hpp>	// Pascal unit
#include <frxInsp.hpp>	// Pascal unit
#include <frxDock.hpp>	// Pascal unit
#include <Vcl.ComCtrls.hpp>	// Pascal unit
#include <Vcl.ImgList.hpp>	// Pascal unit
#include <VCLTee.TeeProcs.hpp>	// Pascal unit
#include <VCLTee.TeEngine.hpp>	// Pascal unit
#include <VCLTee.Chart.hpp>	// Pascal unit
#include <VCLTee.Series.hpp>	// Pascal unit
#include <VCLTee.TeeGalleryAlternate.hpp>	// Pascal unit
#include <System.Variants.hpp>	// Pascal unit
#include <frxDsgnIntf.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Frxcharteditor
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TfrxChartEditor;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TfrxChartEditor : public Frxcustomeditors::TfrxViewEditor
{
	typedef Frxcustomeditors::TfrxViewEditor inherited;
	
public:
	virtual bool __fastcall Edit(void);
	virtual bool __fastcall HasEditor(void);
	virtual void __fastcall GetMenuItems(void);
	virtual bool __fastcall Execute(int Tag, bool Checked);
public:
	/* TfrxComponentEditor.Create */ inline __fastcall TfrxChartEditor(Frxclass::TfrxComponent* Component, Frxclass::TfrxCustomDesigner* Designer, Vcl::Menus::TMenu* Menu) : Frxcustomeditors::TfrxViewEditor(Component, Designer, Menu) { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TfrxChartEditor(void) { }
	
};

#pragma pack(pop)

class DELPHICLASS TfrxHackReport;
class PASCALIMPLEMENTATION TfrxHackReport : public Frxclass::TfrxReport
{
	typedef Frxclass::TfrxReport inherited;
	
public:
	/* TfrxReport.Create */ inline __fastcall virtual TfrxHackReport(System::Classes::TComponent* AOwner) : Frxclass::TfrxReport(AOwner) { }
	/* TfrxReport.Destroy */ inline __fastcall virtual ~TfrxHackReport(void) { }
	
public:
	/* TfrxComponent.DesignCreate */ inline __fastcall virtual TfrxHackReport(System::Classes::TComponent* AOwner, System::Word Flags) : Frxclass::TfrxReport(AOwner, Flags) { }
	
};


class DELPHICLASS TfrxChartEditorForm;
class PASCALIMPLEMENTATION TfrxChartEditorForm : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Stdctrls::TButton* OkB;
	Vcl::Extctrls::TPanel* Panel1;
	Vcl::Extctrls::TPanel* Panel2;
	Vcl::Controls::TImageList* ChartImages;
	Vcl::Stdctrls::TButton* CancelB;
	Vcl::Extctrls::TPanel* SourcePanel;
	Vcl::Stdctrls::TGroupBox* DataSourceGB;
	Vcl::Stdctrls::TRadioButton* DBSourceRB;
	Vcl::Stdctrls::TRadioButton* BandSourceRB;
	Vcl::Stdctrls::TRadioButton* FixedDataRB;
	Vcl::Stdctrls::TComboBox* DatasetsCB;
	Vcl::Stdctrls::TComboBox* DatabandsCB;
	Vcl::Stdctrls::TGroupBox* ValuesGB;
	Vcl::Stdctrls::TComboBox* Values1CB;
	Vcl::Stdctrls::TLabel* Values1L;
	Vcl::Stdctrls::TLabel* Values2L;
	Vcl::Stdctrls::TComboBox* Values2CB;
	Vcl::Stdctrls::TLabel* Values3L;
	Vcl::Stdctrls::TComboBox* Values3CB;
	Vcl::Stdctrls::TLabel* Values4L;
	Vcl::Stdctrls::TComboBox* Values4CB;
	Vcl::Stdctrls::TGroupBox* OptionsGB;
	Vcl::Stdctrls::TLabel* ShowTopLbl;
	Vcl::Stdctrls::TLabel* CaptionLbl;
	Vcl::Stdctrls::TLabel* SortLbl;
	Vcl::Stdctrls::TLabel* XLbl;
	Vcl::Stdctrls::TEdit* TopNE;
	Vcl::Stdctrls::TEdit* TopNCaptionE;
	Vcl::Stdctrls::TComboBox* SortCB;
	Vcl::Comctrls::TUpDown* UpDown1;
	Vcl::Stdctrls::TComboBox* XTypeCB;
	Vcl::Extctrls::TPanel* InspSite;
	Vcl::Stdctrls::TLabel* Values5L;
	Vcl::Stdctrls::TComboBox* Values5CB;
	Vcl::Stdctrls::TLabel* HintL;
	Vcl::Stdctrls::TLabel* Values6L;
	Vcl::Stdctrls::TComboBox* Values6CB;
	Vcl::Extctrls::TPanel* Panel3;
	Vcl::Comctrls::TTreeView* ChartTree;
	Vcl::Extctrls::TPanel* TreePanel;
	Vcl::Buttons::TSpeedButton* AddB;
	Vcl::Buttons::TSpeedButton* DeleteB;
	Vcl::Buttons::TSpeedButton* EditB;
	Vcl::Buttons::TSpeedButton* UPB;
	Vcl::Buttons::TSpeedButton* DownB;
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall ChartTreeClick(System::TObject* Sender);
	void __fastcall AddBClick(System::TObject* Sender);
	void __fastcall DeleteBClick(System::TObject* Sender);
	void __fastcall DoClick(System::TObject* Sender);
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall UpDown1Click(System::TObject* Sender, Vcl::Comctrls::TUDBtnType Button);
	void __fastcall FormKeyDown(System::TObject* Sender, System::Word &Key, System::Classes::TShiftState Shift);
	void __fastcall DatasetsCBClick(System::TObject* Sender);
	void __fastcall DatabandsCBClick(System::TObject* Sender);
	void __fastcall DBSourceRBClick(System::TObject* Sender);
	void __fastcall OkBClick(System::TObject* Sender);
	void __fastcall EditBClick(System::TObject* Sender);
	void __fastcall ChartTreeEdited(System::TObject* Sender, Vcl::Comctrls::TTreeNode* Node, System::UnicodeString &S);
	void __fastcall ChartTreeEditing(System::TObject* Sender, Vcl::Comctrls::TTreeNode* Node, bool &AllowEdit);
	void __fastcall UPBClick(System::TObject* Sender);
	void __fastcall DownBClick(System::TObject* Sender);
	void __fastcall ChartTreeChange(System::TObject* Sender, Vcl::Comctrls::TTreeNode* Node);
	
private:
	Frxchart::TfrxChartView* FChart;
	Frxchart::TfrxSeriesItem* FCurSeries;
	Frxinsp::TfrxObjectInspector* FInspector;
	bool FModified;
	Frxclass::TfrxReport* FReport;
	bool FUpdating;
	int FValuesGBHeight;
	Frxclass::TfrxCustomDesigner* FDesigner;
	void __fastcall FillDropDownLists(Frxclass::TfrxDataSet* ds);
	void __fastcall SetCurSeries(Frxchart::TfrxSeriesItem* const Value);
	void __fastcall SetModified(const bool Value);
	void __fastcall ShowSeriesData(void);
	void __fastcall UpdateSeriesData(void);
	__property bool Modified = {read=FModified, write=SetModified, nodefault};
	__property Frxchart::TfrxSeriesItem* CurSeries = {read=FCurSeries, write=SetCurSeries};
	
public:
	__fastcall virtual TfrxChartEditorForm(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TfrxChartEditorForm(void);
	__property Frxchart::TfrxChartView* Chart = {read=FChart, write=FChart};
public:
	/* TCustomForm.CreateNew */ inline __fastcall virtual TfrxChartEditorForm(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TfrxChartEditorForm(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Frxcharteditor */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FRXCHARTEDITOR)
using namespace Frxcharteditor;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// FrxcharteditorHPP
