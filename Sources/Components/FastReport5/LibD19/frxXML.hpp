// CodeGear C++Builder
// Copyright (c) 1995, 2013 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'frxXML.pas' rev: 26.00 (Windows)

#ifndef FrxxmlHPP
#define FrxxmlHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <Winapi.Windows.hpp>	// Pascal unit
#include <System.SysUtils.hpp>	// Pascal unit
#include <System.Classes.hpp>	// Pascal unit
#include <System.Types.hpp>	// Pascal unit
#include <System.Variants.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Frxxml
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TfrxInvalidXMLException;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TfrxInvalidXMLException : public System::Sysutils::Exception
{
	typedef System::Sysutils::Exception inherited;
	
public:
	/* Exception.Create */ inline __fastcall TfrxInvalidXMLException(const System::UnicodeString Msg) : System::Sysutils::Exception(Msg) { }
	/* Exception.CreateFmt */ inline __fastcall TfrxInvalidXMLException(const System::UnicodeString Msg, System::TVarRec const *Args, const int Args_Size) : System::Sysutils::Exception(Msg, Args, Args_Size) { }
	/* Exception.CreateRes */ inline __fastcall TfrxInvalidXMLException(NativeUInt Ident)/* overload */ : System::Sysutils::Exception(Ident) { }
	/* Exception.CreateRes */ inline __fastcall TfrxInvalidXMLException(System::PResStringRec ResStringRec)/* overload */ : System::Sysutils::Exception(ResStringRec) { }
	/* Exception.CreateResFmt */ inline __fastcall TfrxInvalidXMLException(NativeUInt Ident, System::TVarRec const *Args, const int Args_Size)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_Size) { }
	/* Exception.CreateResFmt */ inline __fastcall TfrxInvalidXMLException(System::PResStringRec ResStringRec, System::TVarRec const *Args, const int Args_Size)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_Size) { }
	/* Exception.CreateHelp */ inline __fastcall TfrxInvalidXMLException(const System::UnicodeString Msg, int AHelpContext) : System::Sysutils::Exception(Msg, AHelpContext) { }
	/* Exception.CreateFmtHelp */ inline __fastcall TfrxInvalidXMLException(const System::UnicodeString Msg, System::TVarRec const *Args, const int Args_Size, int AHelpContext) : System::Sysutils::Exception(Msg, Args, Args_Size, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall TfrxInvalidXMLException(NativeUInt Ident, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall TfrxInvalidXMLException(System::PResStringRec ResStringRec, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall TfrxInvalidXMLException(System::PResStringRec ResStringRec, System::TVarRec const *Args, const int Args_Size, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_Size, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall TfrxInvalidXMLException(NativeUInt Ident, System::TVarRec const *Args, const int Args_Size, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_Size, AHelpContext) { }
	/* Exception.Destroy */ inline __fastcall virtual ~TfrxInvalidXMLException(void) { }
	
};

#pragma pack(pop)

class DELPHICLASS TfrxXMLItem;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TfrxXMLItem : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	TfrxXMLItem* operator[](int Index) { return Items[Index]; }
	
private:
	void *FData;
	System::Byte FHiOffset;
	System::Classes::TList* FItems;
	bool FLoaded;
	int FLoOffset;
	bool FModified;
	System::UnicodeString FName;
	TfrxXMLItem* FParent;
	System::UnicodeString FText;
	bool FUnloadable;
	System::UnicodeString FValue;
	int __fastcall GetCount(void);
	TfrxXMLItem* __fastcall GetItems(int Index);
	__int64 __fastcall GetOffset(void);
	void __fastcall SetOffset(const __int64 Value);
	System::UnicodeString __fastcall GetProp(System::UnicodeString Index);
	void __fastcall SetProp(System::UnicodeString Index, const System::UnicodeString Value);
	
public:
	__fastcall TfrxXMLItem(void);
	__fastcall virtual ~TfrxXMLItem(void);
	void __fastcall AddItem(TfrxXMLItem* Item);
	void __fastcall Clear(void);
	void __fastcall InsertItem(int Index, TfrxXMLItem* Item);
	TfrxXMLItem* __fastcall Add(void)/* overload */;
	TfrxXMLItem* __fastcall Add(System::UnicodeString Name)/* overload */;
	int __fastcall Find(const System::UnicodeString Name);
	TfrxXMLItem* __fastcall FindItem(const System::UnicodeString Name);
	int __fastcall IndexOf(TfrxXMLItem* Item);
	bool __fastcall PropExists(const System::UnicodeString Index);
	TfrxXMLItem* __fastcall Root(void);
	void __fastcall DeleteProp(const System::UnicodeString Index);
	__property int Count = {read=GetCount, nodefault};
	__property void * Data = {read=FData, write=FData};
	__property TfrxXMLItem* Items[int Index] = {read=GetItems/*, default*/};
	__property bool Loaded = {read=FLoaded, nodefault};
	__property bool Modified = {read=FModified, write=FModified, nodefault};
	__property System::UnicodeString Name = {read=FName, write=FName};
	__property __int64 Offset = {read=GetOffset, write=SetOffset};
	__property TfrxXMLItem* Parent = {read=FParent};
	__property System::UnicodeString Prop[System::UnicodeString Index] = {read=GetProp, write=SetProp};
	__property System::UnicodeString Text = {read=FText, write=FText};
	__property bool Unloadable = {read=FUnloadable, write=FUnloadable, nodefault};
	__property System::UnicodeString Value = {read=FValue, write=FValue};
};

#pragma pack(pop)

class DELPHICLASS TfrxXMLDocument;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TfrxXMLDocument : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	bool FAutoIndent;
	TfrxXMLItem* FRoot;
	System::UnicodeString FTempDir;
	System::UnicodeString FTempFile;
	System::Classes::TStream* FTempStream;
	bool FTempFileCreated;
	bool FOldVersion;
	void __fastcall CreateTempFile(void);
	void __fastcall DeleteTempFile(void);
	
public:
	__fastcall TfrxXMLDocument(void);
	__fastcall virtual ~TfrxXMLDocument(void);
	void __fastcall Clear(void);
	void __fastcall LoadItem(TfrxXMLItem* Item);
	void __fastcall UnloadItem(TfrxXMLItem* Item);
	void __fastcall SaveToStream(System::Classes::TStream* Stream);
	void __fastcall LoadFromStream(System::Classes::TStream* Stream, bool AllowPartialLoading = false);
	void __fastcall SaveToFile(const System::UnicodeString FileName);
	void __fastcall LoadFromFile(const System::UnicodeString FileName);
	__property bool AutoIndent = {read=FAutoIndent, write=FAutoIndent, nodefault};
	__property TfrxXMLItem* Root = {read=FRoot};
	__property System::UnicodeString TempDir = {read=FTempDir, write=FTempDir};
	__property bool OldVersion = {read=FOldVersion, nodefault};
};

#pragma pack(pop)

class DELPHICLASS TfrxXMLReader;
class PASCALIMPLEMENTATION TfrxXMLReader : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	char *FBuffer;
	int FBufPos;
	int FBufEnd;
	__int64 FPosition;
	__int64 FSize;
	System::Classes::TStream* FStream;
	bool FOldFormat;
	void __fastcall SetPosition(const __int64 Value);
	void __fastcall ReadBuffer(void);
	void __fastcall ReadItem(System::UnicodeString &NameS, System::UnicodeString &Text);
	
public:
	__fastcall TfrxXMLReader(System::Classes::TStream* Stream);
	__fastcall virtual ~TfrxXMLReader(void);
	void __fastcall RaiseException(void);
	void __fastcall ReadHeader(void);
	void __fastcall ReadRootItem(TfrxXMLItem* Item, bool ReadChildren = true);
	__property __int64 Position = {read=FPosition, write=SetPosition};
	__property __int64 Size = {read=FSize};
};


class DELPHICLASS TfrxXMLWriter;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TfrxXMLWriter : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	bool FAutoIndent;
	System::AnsiString FBuffer;
	System::Classes::TStream* FStream;
	System::Classes::TStream* FTempStream;
	void __fastcall FlushBuffer(void);
	void __fastcall WriteLn(const System::AnsiString s);
	void __fastcall WriteItem(TfrxXMLItem* Item, int Level = 0x0);
	
public:
	__fastcall TfrxXMLWriter(System::Classes::TStream* Stream);
	void __fastcall WriteHeader(void);
	void __fastcall WriteRootItem(TfrxXMLItem* RootItem);
	__property System::Classes::TStream* TempStream = {read=FTempStream, write=FTempStream};
	__property bool AutoIndent = {read=FAutoIndent, write=FAutoIndent, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TfrxXMLWriter(void) { }
	
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE System::UnicodeString __fastcall frxStrToXML(const System::UnicodeString s);
extern DELPHI_PACKAGE System::UnicodeString __fastcall frxXMLToStr(const System::UnicodeString s);
extern DELPHI_PACKAGE System::UnicodeString __fastcall frxValueToXML(const System::Variant &Value);
}	/* namespace Frxxml */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FRXXML)
using namespace Frxxml;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// FrxxmlHPP
