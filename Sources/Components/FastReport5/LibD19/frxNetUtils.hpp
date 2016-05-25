// CodeGear C++Builder
// Copyright (c) 1995, 2013 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'frxNetUtils.pas' rev: 26.00 (Windows)

#ifndef FrxnetutilsHPP
#define FrxnetutilsHPP

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
#include <System.Win.Registry.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Frxnetutils
{
//-- type declarations -------------------------------------------------------
//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE System::UnicodeString __fastcall GMTDateTimeToRFCDateTime(const System::TDateTime D);
extern DELPHI_PACKAGE System::UnicodeString __fastcall DateTimeToRFCDateTime(const System::TDateTime D);
extern DELPHI_PACKAGE System::UnicodeString __fastcall PadLeft(const System::UnicodeString S, const System::WideChar PadChar, const int Len);
extern DELPHI_PACKAGE System::UnicodeString __fastcall PadRight(const System::UnicodeString S, const System::WideChar PadChar, const int Len);
extern DELPHI_PACKAGE System::AnsiString __fastcall Base64Encode(const System::AnsiString S);
extern DELPHI_PACKAGE System::AnsiString __fastcall Base64Decode(const System::AnsiString S);
extern DELPHI_PACKAGE System::UnicodeString __fastcall GetFileMIMEType(const System::UnicodeString FileName);
extern DELPHI_PACKAGE System::UnicodeString __fastcall GetSocketErrorText(const int ErrorCode);
extern DELPHI_PACKAGE void __fastcall PMessages(void);
extern DELPHI_PACKAGE System::UnicodeString __fastcall UpdateCookies(const System::UnicodeString Header, const System::UnicodeString Cookies);
extern DELPHI_PACKAGE System::AnsiString __fastcall ParseHeaderField(const System::AnsiString Field, const System::AnsiString Header);
}	/* namespace Frxnetutils */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FRXNETUTILS)
using namespace Frxnetutils;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// FrxnetutilsHPP
