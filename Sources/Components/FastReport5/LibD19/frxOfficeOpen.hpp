// CodeGear C++Builder
// Copyright (c) 1995, 2013 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'frxOfficeOpen.pas' rev: 26.00 (Windows)

#ifndef FrxofficeopenHPP
#define FrxofficeopenHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.Classes.hpp>	// Pascal unit
#include <System.SysUtils.hpp>	// Pascal unit
#include <Vcl.Graphics.hpp>	// Pascal unit
#include <frxClass.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Frxofficeopen
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TfrxStrList;
class PASCALIMPLEMENTATION TfrxStrList : public System::Classes::TStringList
{
	typedef System::Classes::TStringList inherited;
	
public:
	virtual int __fastcall AddObject(const System::UnicodeString s, System::TObject* Obj);
public:
	/* TStringList.Create */ inline __fastcall TfrxStrList(void)/* overload */ : System::Classes::TStringList() { }
	/* TStringList.Create */ inline __fastcall TfrxStrList(bool OwnsObjects)/* overload */ : System::Classes::TStringList(OwnsObjects) { }
	/* TStringList.Destroy */ inline __fastcall virtual ~TfrxStrList(void) { }
	
};


class DELPHICLASS TfrxWriter;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TfrxWriter : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	System::Classes::TStream* FStream;
	bool FOwn;
	
public:
	__fastcall TfrxWriter(System::Classes::TStream* Stream, bool Own);
	__fastcall virtual ~TfrxWriter(void);
	void __fastcall Write(System::UnicodeString s, bool UCS = false)/* overload */;
	void __fastcall Write(System::UnicodeString const *a, const int a_Size, bool UCS = false)/* overload */;
	void __fastcall Write(const System::UnicodeString Section, System::Classes::TStrings* StrList)/* overload */;
	void __fastcall Write(const System::UnicodeString Fmt, System::TVarRec const *f, const int f_Size)/* overload */;
};

#pragma pack(pop)

class DELPHICLASS TfrxFileWriter;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TfrxFileWriter : public TfrxWriter
{
	typedef TfrxWriter inherited;
	
public:
	__fastcall TfrxFileWriter(System::UnicodeString FileName);
public:
	/* TfrxWriter.Destroy */ inline __fastcall virtual ~TfrxFileWriter(void) { }
	
};

#pragma pack(pop)

struct DECLSPEC_DRECORD TfrxMap
{
public:
	int FirstRow;
	int LastRow;
	Frxclass::TfrxRect Margins;
	int PaperSize;
	int PageOrientation;
	int Index;
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE void __fastcall Exchange(int &a, int &b);
extern DELPHI_PACKAGE System::WideString __fastcall CleanTrash(const System::WideString s);
extern DELPHI_PACKAGE System::Uitypes::TColor __fastcall RGBSwap(System::Uitypes::TColor c);
extern DELPHI_PACKAGE int __fastcall Distance(int c1, int c2);
extern DELPHI_PACKAGE System::WideString __fastcall Escape(System::WideString s);
extern DELPHI_PACKAGE void __fastcall CreateDirs(const System::UnicodeString RootDir, System::UnicodeString const *SubDirs, const int SubDirs_Size);
extern DELPHI_PACKAGE void __fastcall WriteStr(System::Classes::TStream* Stream, const System::UnicodeString s, bool UCS = false);
extern DELPHI_PACKAGE void __fastcall WriteStrList(System::Classes::TStream* Stream, const System::UnicodeString Section, System::Classes::TStrings* StrList);
}	/* namespace Frxofficeopen */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FRXOFFICEOPEN)
using namespace Frxofficeopen;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// FrxofficeopenHPP
