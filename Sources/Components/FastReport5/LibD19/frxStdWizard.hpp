// CodeGear C++Builder
// Copyright (c) 1995, 2013 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'frxStdWizard.pas' rev: 26.00 (Windows)

#ifndef FrxstdwizardHPP
#define FrxstdwizardHPP

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
#include <Vcl.Buttons.hpp>	// Pascal unit
#include <Vcl.ComCtrls.hpp>	// Pascal unit
#include <Vcl.ExtCtrls.hpp>	// Pascal unit
#include <frxClass.hpp>	// Pascal unit
#include <frxDesgn.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Frxstdwizard
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TfrxStdWizard;
class PASCALIMPLEMENTATION TfrxStdWizard : public Frxclass::TfrxCustomWizard
{
	typedef Frxclass::TfrxCustomWizard inherited;
	
public:
	__classmethod virtual System::UnicodeString __fastcall GetDescription();
	virtual bool __fastcall Execute(void);
public:
	/* TfrxCustomWizard.Create */ inline __fastcall virtual TfrxStdWizard(System::Classes::TComponent* AOwner) : Frxclass::TfrxCustomWizard(AOwner) { }
	
public:
	/* TComponent.Destroy */ inline __fastcall virtual ~TfrxStdWizard(void) { }
	
};


class DELPHICLASS TfrxDotMatrixWizard;
class PASCALIMPLEMENTATION TfrxDotMatrixWizard : public Frxclass::TfrxCustomWizard
{
	typedef Frxclass::TfrxCustomWizard inherited;
	
public:
	__classmethod virtual System::UnicodeString __fastcall GetDescription();
	virtual bool __fastcall Execute(void);
public:
	/* TfrxCustomWizard.Create */ inline __fastcall virtual TfrxDotMatrixWizard(System::Classes::TComponent* AOwner) : Frxclass::TfrxCustomWizard(AOwner) { }
	
public:
	/* TComponent.Destroy */ inline __fastcall virtual ~TfrxDotMatrixWizard(void) { }
	
};


class DELPHICLASS TfrxStdEmptyWizard;
class PASCALIMPLEMENTATION TfrxStdEmptyWizard : public Frxclass::TfrxCustomWizard
{
	typedef Frxclass::TfrxCustomWizard inherited;
	
public:
	__classmethod virtual System::UnicodeString __fastcall GetDescription();
	virtual bool __fastcall Execute(void);
public:
	/* TfrxCustomWizard.Create */ inline __fastcall virtual TfrxStdEmptyWizard(System::Classes::TComponent* AOwner) : Frxclass::TfrxCustomWizard(AOwner) { }
	
public:
	/* TComponent.Destroy */ inline __fastcall virtual ~TfrxStdEmptyWizard(void) { }
	
};


class DELPHICLASS TfrxDMPEmptyWizard;
class PASCALIMPLEMENTATION TfrxDMPEmptyWizard : public Frxclass::TfrxCustomWizard
{
	typedef Frxclass::TfrxCustomWizard inherited;
	
public:
	__classmethod virtual System::UnicodeString __fastcall GetDescription();
	virtual bool __fastcall Execute(void);
public:
	/* TfrxCustomWizard.Create */ inline __fastcall virtual TfrxDMPEmptyWizard(System::Classes::TComponent* AOwner) : Frxclass::TfrxCustomWizard(AOwner) { }
	
public:
	/* TComponent.Destroy */ inline __fastcall virtual ~TfrxDMPEmptyWizard(void) { }
	
};


class DELPHICLASS TfrxStdWizardForm;
class PASCALIMPLEMENTATION TfrxStdWizardForm : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Comctrls::TPageControl* Pages;
	Vcl::Comctrls::TTabSheet* FieldsTab;
	Vcl::Comctrls::TTabSheet* GroupsTab;
	Vcl::Comctrls::TTabSheet* LayoutTab;
	Vcl::Stdctrls::TListBox* FieldsLB;
	Vcl::Buttons::TSpeedButton* AddFieldB;
	Vcl::Buttons::TSpeedButton* AddAllFieldsB;
	Vcl::Buttons::TSpeedButton* RemoveFieldB;
	Vcl::Buttons::TSpeedButton* RemoveAllFieldsB;
	Vcl::Stdctrls::TListBox* SelectedFieldsLB;
	Vcl::Stdctrls::TLabel* SelectedFieldsL;
	Vcl::Buttons::TSpeedButton* FieldUpB;
	Vcl::Buttons::TSpeedButton* FieldDownB;
	Vcl::Stdctrls::TListBox* AvailableFieldsLB;
	Vcl::Buttons::TSpeedButton* AddGroupB;
	Vcl::Buttons::TSpeedButton* RemoveGroupB;
	Vcl::Stdctrls::TListBox* GroupsLB;
	Vcl::Stdctrls::TLabel* GroupsL;
	Vcl::Buttons::TSpeedButton* GroupUpB;
	Vcl::Buttons::TSpeedButton* GroupDownB;
	Vcl::Stdctrls::TLabel* AvailableFieldsL;
	Vcl::Stdctrls::TButton* BackB;
	Vcl::Stdctrls::TButton* NextB;
	Vcl::Stdctrls::TButton* FinishB;
	Vcl::Stdctrls::TCheckBox* FitWidthCB;
	Vcl::Stdctrls::TLabel* Step2L;
	Vcl::Stdctrls::TLabel* Step3L;
	Vcl::Stdctrls::TLabel* Step4L;
	Vcl::Comctrls::TTabSheet* StyleTab;
	Vcl::Stdctrls::TLabel* Step5L;
	Vcl::Forms::TScrollBox* ScrollBox1;
	Vcl::Extctrls::TPaintBox* StylePB;
	Vcl::Stdctrls::TListBox* StyleLB;
	Vcl::Stdctrls::TGroupBox* OrientationL;
	Vcl::Stdctrls::TGroupBox* LayoutL;
	Vcl::Extctrls::TImage* PortraitImg;
	Vcl::Extctrls::TImage* LandscapeImg;
	Vcl::Stdctrls::TRadioButton* PortraitRB;
	Vcl::Stdctrls::TRadioButton* LandscapeRB;
	Vcl::Stdctrls::TRadioButton* TabularRB;
	Vcl::Stdctrls::TRadioButton* ColumnarRB;
	Vcl::Comctrls::TTabSheet* DataTab;
	Vcl::Stdctrls::TComboBox* DatasetsCB;
	Vcl::Stdctrls::TLabel* Step1L;
	Vcl::Stdctrls::TButton* NewTableB;
	Vcl::Stdctrls::TButton* NewQueryB;
	Vcl::Forms::TScrollBox* ScrollBox2;
	Vcl::Extctrls::TPaintBox* LayoutPB;
	Vcl::Stdctrls::TLabel* AvailableFieldsL1;
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall DatasetsCBClick(System::TObject* Sender);
	void __fastcall AddFieldBClick(System::TObject* Sender);
	void __fastcall AddAllFieldsBClick(System::TObject* Sender);
	void __fastcall RemoveFieldBClick(System::TObject* Sender);
	void __fastcall RemoveAllFieldsBClick(System::TObject* Sender);
	void __fastcall AddGroupBClick(System::TObject* Sender);
	void __fastcall RemoveGroupBClick(System::TObject* Sender);
	void __fastcall FieldUpBClick(System::TObject* Sender);
	void __fastcall FieldDownBClick(System::TObject* Sender);
	void __fastcall GroupUpBClick(System::TObject* Sender);
	void __fastcall GroupDownBClick(System::TObject* Sender);
	void __fastcall NextBClick(System::TObject* Sender);
	void __fastcall BackBClick(System::TObject* Sender);
	void __fastcall GroupsTabShow(System::TObject* Sender);
	void __fastcall StylePBPaint(System::TObject* Sender);
	void __fastcall PortraitRBClick(System::TObject* Sender);
	void __fastcall PagesChange(System::TObject* Sender);
	void __fastcall StyleLBClick(System::TObject* Sender);
	void __fastcall FinishBClick(System::TObject* Sender);
	void __fastcall NewTableBClick(System::TObject* Sender);
	void __fastcall NewQueryBClick(System::TObject* Sender);
	void __fastcall FormKeyDown(System::TObject* Sender, System::Word &Key, System::Classes::TShiftState Shift);
	void __fastcall LayoutPBPaint(System::TObject* Sender);
	void __fastcall TabularRBClick(System::TObject* Sender);
	
private:
	Frxdesgn::TfrxDesignerForm* FDesigner;
	bool FDotMatrix;
	Frxclass::TfrxReport* FLayoutReport;
	Frxclass::TfrxReport* FReport;
	Frxclass::TfrxReport* FStyleReport;
	Frxclass::TfrxStyleSheet* FStyleSheet;
	void __fastcall DrawSample(Vcl::Extctrls::TPaintBox* PaintBox, Frxclass::TfrxReport* Report);
	void __fastcall FillDatasets(void);
	void __fastcall FillFields(void);
	void __fastcall NewDBItem(const System::UnicodeString wizName);
	void __fastcall UpdateAvailableFields(void);
	
public:
	__fastcall virtual TfrxStdWizardForm(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TfrxStdWizardForm(void);
public:
	/* TCustomForm.CreateNew */ inline __fastcall virtual TfrxStdWizardForm(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TfrxStdWizardForm(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Frxstdwizard */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FRXSTDWIZARD)
using namespace Frxstdwizard;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// FrxstdwizardHPP
