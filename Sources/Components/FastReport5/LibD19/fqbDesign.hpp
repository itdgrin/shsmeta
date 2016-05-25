// CodeGear C++Builder
// Copyright (c) 1995, 2013 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'fqbDesign.pas' rev: 26.00 (Windows)

#ifndef FqbdesignHPP
#define FqbdesignHPP

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
#include <Vcl.ToolWin.hpp>	// Pascal unit
#include <Vcl.ComCtrls.hpp>	// Pascal unit
#include <Vcl.StdCtrls.hpp>	// Pascal unit
#include <Vcl.ExtCtrls.hpp>	// Pascal unit
#include <Vcl.Grids.hpp>	// Pascal unit
#include <Vcl.DBGrids.hpp>	// Pascal unit
#include <Vcl.ImgList.hpp>	// Pascal unit
#include <Vcl.Buttons.hpp>	// Pascal unit
#include <Vcl.Menus.hpp>	// Pascal unit
#include <Data.DB.hpp>	// Pascal unit
#include <System.Variants.hpp>	// Pascal unit
#include <fqbSynmemo.hpp>	// Pascal unit
#include <fqbClass.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Fqbdesign
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TfqbDesigner;
class PASCALIMPLEMENTATION TfqbDesigner : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Data::Db::TDataSource* DataSource1;
	Vcl::Dbgrids::TDBGrid* DBGrid1;
	Fqbclass::TfqbGrid* fqbGrid1;
	Fqbsynmemo::TfqbSyntaxMemo* fqbSyntaxMemo1;
	Fqbclass::TfqbTableArea* fqbTableArea1;
	Fqbclass::TfqbTableListBox* fqbTableListBox1;
	Vcl::Controls::TImageList* ImageList2;
	Vcl::Dialogs::TOpenDialog* OpenDialog1;
	Vcl::Comctrls::TPageControl* PageControl1;
	Vcl::Extctrls::TPanel* Panel1;
	Vcl::Dialogs::TSaveDialog* SaveDialog1;
	Vcl::Extctrls::TSplitter* Splitter1;
	Vcl::Extctrls::TSplitter* Splitter2;
	Vcl::Comctrls::TTabSheet* TabSheet1;
	Vcl::Comctrls::TTabSheet* TabSheet2;
	Vcl::Comctrls::TTabSheet* TabSheet3;
	Vcl::Comctrls::TToolBar* ToolBar1;
	Vcl::Comctrls::TToolButton* ToolButton10;
	Vcl::Comctrls::TToolButton* ToolButton3;
	Vcl::Comctrls::TToolButton* ToolButton4;
	Vcl::Comctrls::TToolButton* ToolButton5;
	Vcl::Comctrls::TToolButton* ToolButton6;
	Vcl::Comctrls::TToolButton* ToolButton7;
	Vcl::Comctrls::TToolButton* ToolButton8;
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall TabSheet2Show(System::TObject* Sender);
	void __fastcall TabSheet3Hide(System::TObject* Sender);
	void __fastcall TabSheet3Show(System::TObject* Sender);
	void __fastcall ToolButton10Click(System::TObject* Sender);
	void __fastcall ToolButton3Click(System::TObject* Sender);
	void __fastcall ToolButton4Click(System::TObject* Sender);
	void __fastcall ToolButton6Click(System::TObject* Sender);
	void __fastcall ToolButton7Click(System::TObject* Sender);
	void __fastcall FormDestroy(System::TObject* Sender);
	
protected:
	void __fastcall LoadPos(void);
	void __fastcall SavePos(void);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TfqbDesigner(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TfqbDesigner(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TfqbDesigner(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TfqbDesigner(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE TfqbDesigner* fqbDesigner;
}	/* namespace Fqbdesign */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FQBDESIGN)
using namespace Fqbdesign;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// FqbdesignHPP
