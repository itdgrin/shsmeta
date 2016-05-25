// CodeGear C++Builder
// Copyright (c) 1995, 2013 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'frxCodeUtils.pas' rev: 26.00 (Windows)

#ifndef FrxcodeutilsHPP
#define FrxcodeutilsHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <Winapi.Windows.hpp>	// Pascal unit
#include <System.Classes.hpp>	// Pascal unit
#include <System.SysUtils.hpp>	// Pascal unit
#include <System.TypInfo.hpp>	// Pascal unit
#include <System.Variants.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Frxcodeutils
{
//-- type declarations -------------------------------------------------------
//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE void __fastcall frxAddCodeRes(void);
extern DELPHI_PACKAGE void __fastcall frxGetEventHandlersList(System::Classes::TStrings* Code, const System::UnicodeString Language, System::Typinfo::PTypeInfo EventType, System::Classes::TStrings* List);
extern DELPHI_PACKAGE int __fastcall frxLocateEventHandler(System::Classes::TStrings* Code, const System::UnicodeString Language, const System::UnicodeString EventName);
extern DELPHI_PACKAGE int __fastcall frxLocateMainProc(System::Classes::TStrings* Code, const System::UnicodeString Language);
extern DELPHI_PACKAGE int __fastcall frxAddEvent(System::Classes::TStrings* Code, const System::UnicodeString Language, System::Typinfo::PTypeInfo EventType, const System::UnicodeString EventName);
extern DELPHI_PACKAGE void __fastcall frxEmptyCode(System::Classes::TStrings* Code, const System::UnicodeString Language);
}	/* namespace Frxcodeutils */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FRXCODEUTILS)
using namespace Frxcodeutils;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// FrxcodeutilsHPP
