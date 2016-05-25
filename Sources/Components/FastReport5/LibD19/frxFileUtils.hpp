// CodeGear C++Builder
// Copyright (c) 1995, 2013 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'frxFileUtils.pas' rev: 26.00 (Windows)

#ifndef FrxfileutilsHPP
#define FrxfileutilsHPP

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
#include <Winapi.ShlObj.hpp>	// Pascal unit
#include <Vcl.FileCtrl.hpp>	// Pascal unit
#include <System.Win.Registry.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Frxfileutils
{
//-- type declarations -------------------------------------------------------
//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE int __fastcall GetFileSize(const System::UnicodeString FileName);
extern DELPHI_PACKAGE int __fastcall StreamSearch(System::Classes::TStream* Strm, const int StartPos, const System::AnsiString Value);
extern DELPHI_PACKAGE System::UnicodeString __fastcall BrowseDialog(const System::UnicodeString Path, const System::UnicodeString Title = System::UnicodeString());
extern DELPHI_PACKAGE void __fastcall DeleteFolder(const System::UnicodeString DirName);
extern DELPHI_PACKAGE System::UnicodeString __fastcall GetFileMIMEType(const System::UnicodeString Extension);
}	/* namespace Frxfileutils */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FRXFILEUTILS)
using namespace Frxfileutils;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// FrxfileutilsHPP
