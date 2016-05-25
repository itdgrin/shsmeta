// CodeGear C++Builder
// Copyright (c) 1995, 2013 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'frxDialogForm.pas' rev: 26.00 (Windows)

#ifndef FrxdialogformHPP
#define FrxdialogformHPP

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
#include <System.Variants.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Frxdialogform
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TfrxDialogForm;
class PASCALIMPLEMENTATION TfrxDialogForm : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	void __fastcall FormCloseQuery(System::TObject* Sender, bool &CanClose);
	
protected:
	virtual void __fastcall ReadState(System::Classes::TReader* Reader);
	
private:
	System::Classes::TNotifyEvent FOnModify;
	bool FThreadSafe;
	MESSAGE void __fastcall WMExitSizeMove(Winapi::Messages::TMessage &Msg);
	MESSAGE void __fastcall WMGetDlgCode(Winapi::Messages::TWMNoParams &Message);
	
public:
	__fastcall virtual TfrxDialogForm(System::Classes::TComponent* AOwner);
	__property System::Classes::TNotifyEvent OnModify = {read=FOnModify, write=FOnModify};
	__property bool ThreadSafe = {read=FThreadSafe, write=FThreadSafe, nodefault};
public:
	/* TCustomForm.CreateNew */ inline __fastcall virtual TfrxDialogForm(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TfrxDialogForm(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TfrxDialogForm(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Frxdialogform */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FRXDIALOGFORM)
using namespace Frxdialogform;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// FrxdialogformHPP
