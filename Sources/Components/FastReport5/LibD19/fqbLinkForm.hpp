// CodeGear C++Builder
// Copyright (c) 1995, 2013 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'fqbLinkForm.pas' rev: 26.00 (Windows)

#ifndef FqblinkformHPP
#define FqblinkformHPP

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
#include <Vcl.Buttons.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Fqblinkform
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TfqbLinkForm;
class PASCALIMPLEMENTATION TfqbLinkForm : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Extctrls::TRadioGroup* RadioOpt;
	Vcl::Extctrls::TRadioGroup* RadioType;
	Vcl::Stdctrls::TStaticText* txtTable1;
	Vcl::Stdctrls::TStaticText* txtTable2;
	Vcl::Stdctrls::TLabel* Label1;
	Vcl::Stdctrls::TLabel* Label2;
	Vcl::Stdctrls::TLabel* Label3;
	Vcl::Stdctrls::TStaticText* txtCol1;
	Vcl::Stdctrls::TLabel* Label4;
	Vcl::Stdctrls::TStaticText* txtCol2;
	Vcl::Buttons::TBitBtn* BitBtn1;
	Vcl::Buttons::TBitBtn* BitBtn2;
public:
	/* TCustomForm.Create */ inline __fastcall virtual TfqbLinkForm(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TfqbLinkForm(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TfqbLinkForm(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TfqbLinkForm(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Fqblinkform */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FQBLINKFORM)
using namespace Fqblinkform;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// FqblinkformHPP
