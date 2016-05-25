// CodeGear C++Builder
// Copyright (c) 1995, 2013 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'frxUnicodeCtrls.pas' rev: 26.00 (Windows)

#ifndef FrxunicodectrlsHPP
#define FrxunicodectrlsHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <Winapi.Windows.hpp>	// Pascal unit
#include <Winapi.Messages.hpp>	// Pascal unit
#include <System.Classes.hpp>	// Pascal unit
#include <Vcl.Controls.hpp>	// Pascal unit
#include <Vcl.Forms.hpp>	// Pascal unit
#include <Vcl.StdCtrls.hpp>	// Pascal unit
#include <frxRichEdit.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Frxunicodectrls
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TUnicodeEdit;
class PASCALIMPLEMENTATION TUnicodeEdit : public Vcl::Stdctrls::TEdit
{
	typedef Vcl::Stdctrls::TEdit inherited;
	
private:
	HIDESBASE void __fastcall SetSelText(const System::WideString Value);
	HIDESBASE System::WideString __fastcall GetText(void);
	HIDESBASE void __fastcall SetText(const System::WideString Value);
	
protected:
	virtual void __fastcall CreateWindowHandle(const Vcl::Controls::TCreateParams &Params);
	HIDESBASE System::WideString __fastcall GetSelText(void);
	
public:
	__property System::WideString SelText = {read=GetSelText, write=SetSelText};
	__property System::WideString Text = {read=GetText, write=SetText};
public:
	/* TCustomEdit.Create */ inline __fastcall virtual TUnicodeEdit(System::Classes::TComponent* AOwner) : Vcl::Stdctrls::TEdit(AOwner) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TUnicodeEdit(HWND ParentWindow) : Vcl::Stdctrls::TEdit(ParentWindow) { }
	/* TWinControl.Destroy */ inline __fastcall virtual ~TUnicodeEdit(void) { }
	
};


class DELPHICLASS TUnicodeMemo;
class PASCALIMPLEMENTATION TUnicodeMemo : public Vcl::Stdctrls::TMemo
{
	typedef Vcl::Stdctrls::TMemo inherited;
	
public:
	/* TCustomMemo.Create */ inline __fastcall virtual TUnicodeMemo(System::Classes::TComponent* AOwner) : Vcl::Stdctrls::TMemo(AOwner) { }
	/* TCustomMemo.Destroy */ inline __fastcall virtual ~TUnicodeMemo(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TUnicodeMemo(HWND ParentWindow) : Vcl::Stdctrls::TMemo(ParentWindow) { }
	
};


class DELPHICLASS TRxUnicodeRichEdit;
class PASCALIMPLEMENTATION TRxUnicodeRichEdit : public Frxrichedit::TRxRichEdit
{
	typedef Frxrichedit::TRxRichEdit inherited;
	
public:
	/* TRxCustomRichEdit.Create */ inline __fastcall virtual TRxUnicodeRichEdit(System::Classes::TComponent* AOwner) : Frxrichedit::TRxRichEdit(AOwner) { }
	/* TRxCustomRichEdit.Destroy */ inline __fastcall virtual ~TRxUnicodeRichEdit(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TRxUnicodeRichEdit(HWND ParentWindow) : Frxrichedit::TRxRichEdit(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Frxunicodectrls */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FRXUNICODECTRLS)
using namespace Frxunicodectrls;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// FrxunicodectrlsHPP
