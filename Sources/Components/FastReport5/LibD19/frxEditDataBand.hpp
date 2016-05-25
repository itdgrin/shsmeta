// CodeGear C++Builder
// Copyright (c) 1995, 2013 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'frxEditDataBand.pas' rev: 26.00 (Windows)

#ifndef FrxeditdatabandHPP
#define FrxeditdatabandHPP

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
#include <Vcl.ExtCtrls.hpp>	// Pascal unit
#include <Vcl.StdCtrls.hpp>	// Pascal unit
#include <frxClass.hpp>	// Pascal unit
#include <Vcl.ComCtrls.hpp>	// Pascal unit
#include <System.Variants.hpp>	// Pascal unit
#include <frxCtrls.hpp>	// Pascal unit
#include <System.Types.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Frxeditdataband
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TfrxDataBandEditorForm;
class PASCALIMPLEMENTATION TfrxDataBandEditorForm : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Stdctrls::TButton* OkB;
	Vcl::Stdctrls::TButton* CancelB;
	Vcl::Stdctrls::TGroupBox* DatasetGB;
	Vcl::Stdctrls::TListBox* DatasetsLB;
	Vcl::Stdctrls::TLabel* RecordsL;
	Vcl::Stdctrls::TEdit* RecordsE;
	Vcl::Comctrls::TUpDown* RecordsUD;
	Vcl::Stdctrls::TGroupBox* FilterGB;
	Frxctrls::TfrxComboEdit* FilterE;
	void __fastcall DatasetsLBDrawItem(Vcl::Controls::TWinControl* Control, int Index, const System::Types::TRect &ARect, Winapi::Windows::TOwnerDrawState State);
	void __fastcall DatasetsLBDblClick(System::TObject* Sender);
	void __fastcall FormHide(System::TObject* Sender);
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall FormKeyDown(System::TObject* Sender, System::Word &Key, System::Classes::TShiftState Shift);
	void __fastcall DatasetsLBClick(System::TObject* Sender);
	void __fastcall FilterEButtonClick(System::TObject* Sender);
	
private:
	Frxclass::TfrxDataBand* FDataBand;
	Frxclass::TfrxCustomDesigner* FDesigner;
	
public:
	__property Frxclass::TfrxDataBand* DataBand = {read=FDataBand, write=FDataBand};
public:
	/* TCustomForm.Create */ inline __fastcall virtual TfrxDataBandEditorForm(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TfrxDataBandEditorForm(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TfrxDataBandEditorForm(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TfrxDataBandEditorForm(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Frxeditdataband */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FRXEDITDATABAND)
using namespace Frxeditdataband;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// FrxeditdatabandHPP
