// CodeGear C++Builder
// Copyright (c) 1995, 2013 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'frxEditHyperlink.pas' rev: 26.00 (Windows)

#ifndef FrxedithyperlinkHPP
#define FrxedithyperlinkHPP

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
#include <System.Variants.hpp>	// Pascal unit
#include <System.Classes.hpp>	// Pascal unit
#include <Vcl.Graphics.hpp>	// Pascal unit
#include <Vcl.Controls.hpp>	// Pascal unit
#include <Vcl.Forms.hpp>	// Pascal unit
#include <Vcl.Dialogs.hpp>	// Pascal unit
#include <Vcl.StdCtrls.hpp>	// Pascal unit
#include <Vcl.ExtCtrls.hpp>	// Pascal unit
#include <frxClass.hpp>	// Pascal unit
#include <frxCtrls.hpp>	// Pascal unit
#include <System.UITypes.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Frxedithyperlink
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TfrxHyperlinkEditorForm;
class PASCALIMPLEMENTATION TfrxHyperlinkEditorForm : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Stdctrls::TButton* OKB;
	Vcl::Stdctrls::TButton* CancelB;
	Vcl::Stdctrls::TGroupBox* KindGB;
	Vcl::Stdctrls::TRadioButton* UrlRB;
	Vcl::Stdctrls::TRadioButton* PageNumberRB;
	Vcl::Stdctrls::TRadioButton* AnchorRB;
	Vcl::Stdctrls::TRadioButton* ReportRB;
	Vcl::Stdctrls::TRadioButton* ReportPageRB;
	Vcl::Stdctrls::TRadioButton* CustomRB;
	Vcl::Stdctrls::TGroupBox* PropertiesGB;
	Vcl::Extctrls::TPanel* UrlP;
	Vcl::Stdctrls::TLabel* UrlL;
	Vcl::Stdctrls::TEdit* UrlE;
	Vcl::Stdctrls::TLabel* UrlExprL;
	Frxctrls::TfrxComboEdit* UrlExprE;
	Vcl::Stdctrls::TLabel* Hint1L;
	Vcl::Stdctrls::TLabel* Hint2L;
	Vcl::Extctrls::TPanel* PageNumberP;
	Vcl::Stdctrls::TLabel* PageNumberL;
	Vcl::Stdctrls::TLabel* PageNumberExprL;
	Vcl::Stdctrls::TEdit* PageNumberE;
	Frxctrls::TfrxComboEdit* PageNumberExprE;
	Vcl::Extctrls::TPanel* AnchorP;
	Vcl::Stdctrls::TLabel* AnchorL;
	Vcl::Stdctrls::TLabel* AnchorExprL;
	Vcl::Stdctrls::TEdit* AnchorE;
	Frxctrls::TfrxComboEdit* AnchorExprE;
	Vcl::Extctrls::TPanel* CustomP;
	Vcl::Stdctrls::TLabel* CustomL;
	Vcl::Stdctrls::TLabel* CustomExprL;
	Vcl::Stdctrls::TEdit* CustomE;
	Frxctrls::TfrxComboEdit* CustomExprE;
	Vcl::Extctrls::TPanel* ReportP;
	Vcl::Stdctrls::TLabel* ReportValueL;
	Vcl::Stdctrls::TLabel* ReportExprL;
	Vcl::Stdctrls::TEdit* ReportValueE;
	Frxctrls::TfrxComboEdit* ReportExprE;
	Vcl::Stdctrls::TLabel* ReportNameL;
	Frxctrls::TfrxComboEdit* ReportNameE;
	Vcl::Stdctrls::TLabel* ReportParamL;
	Vcl::Stdctrls::TComboBox* ReportParamCB;
	Vcl::Extctrls::TPanel* ReportPageP;
	Vcl::Stdctrls::TLabel* ReportPageValueL;
	Vcl::Stdctrls::TLabel* ReportPageExprL;
	Vcl::Stdctrls::TLabel* ReportPageL;
	Vcl::Stdctrls::TLabel* ReportPageParamL;
	Vcl::Stdctrls::TEdit* ReportPageValueE;
	Frxctrls::TfrxComboEdit* ReportPageExprE;
	Vcl::Stdctrls::TComboBox* ReportPageParamCB;
	Vcl::Stdctrls::TComboBox* ReportPageCB;
	Vcl::Dialogs::TOpenDialog* OpenDialog;
	Vcl::Stdctrls::TCheckBox* ModifyAppearanceCB;
	void __fastcall UrlRBClick(System::TObject* Sender);
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall ExprClick(System::TObject* Sender);
	void __fastcall FormHide(System::TObject* Sender);
	void __fastcall ReportNameEButtonClick(System::TObject* Sender);
	void __fastcall FormCreate(System::TObject* Sender);
	
private:
	void __fastcall FillVariablesList(Frxclass::TfrxReport* Report, System::Classes::TStrings* List)/* overload */;
	void __fastcall FillVariablesList(const System::UnicodeString FileName, System::Classes::TStrings* List)/* overload */;
	void __fastcall FillPagesList(void);
	
public:
	Frxclass::TfrxView* View;
public:
	/* TCustomForm.Create */ inline __fastcall virtual TfrxHyperlinkEditorForm(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TfrxHyperlinkEditorForm(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TfrxHyperlinkEditorForm(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TfrxHyperlinkEditorForm(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Frxedithyperlink */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FRXEDITHYPERLINK)
using namespace Frxedithyperlink;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// FrxedithyperlinkHPP
