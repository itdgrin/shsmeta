// CodeGear C++Builder
// Copyright (c) 1995, 2013 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'frxPictureCache.pas' rev: 26.00 (Windows)

#ifndef FrxpicturecacheHPP
#define FrxpicturecacheHPP

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
#include <frxClass.hpp>	// Pascal unit
#include <frxXML.hpp>	// Pascal unit
#include <System.Variants.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Frxpicturecache
{
//-- type declarations -------------------------------------------------------
#pragma pack(push,1)
struct DECLSPEC_DRECORD TfrxCacheItem
{
public:
	int Segment;
	int Offset;
};
#pragma pack(pop)


typedef TfrxCacheItem *PfrxCacheItem;

class DELPHICLASS TfrxCacheList;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TfrxCacheList : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	PfrxCacheItem operator[](int Index) { return Items[Index]; }
	
private:
	PfrxCacheItem __fastcall Get(int Index);
	
protected:
	System::Classes::TList* FItems;
	void __fastcall Clear(void);
	
public:
	__fastcall TfrxCacheList(void);
	__fastcall virtual ~TfrxCacheList(void);
	PfrxCacheItem __fastcall Add(void);
	int __fastcall Count(void);
	__property PfrxCacheItem Items[int Index] = {read=Get/*, default*/};
};

#pragma pack(pop)

class DELPHICLASS TfrxFileStream;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TfrxFileStream : public System::Classes::TFileStream
{
	typedef System::Classes::TFileStream inherited;
	
private:
	unsigned FSz;
	
public:
	virtual int __fastcall Seek(int Offset, System::Word Origin)/* overload */;
	virtual __int64 __fastcall Seek(const __int64 Offset, System::Classes::TSeekOrigin Origin)/* overload */;
public:
	/* TFileStream.Create */ inline __fastcall TfrxFileStream(const System::UnicodeString AFileName, System::Word Mode)/* overload */ : System::Classes::TFileStream(AFileName, Mode) { }
	/* TFileStream.Create */ inline __fastcall TfrxFileStream(const System::UnicodeString AFileName, System::Word Mode, unsigned Rights)/* overload */ : System::Classes::TFileStream(AFileName, Mode, Rights) { }
	/* TFileStream.Destroy */ inline __fastcall virtual ~TfrxFileStream(void) { }
	
/* Hoisted overloads: */
	
public:
	inline __int64 __fastcall  Seek _DEPRECATED_ATTRIBUTE0 (const __int64 Offset, System::Word Origin){ return System::Classes::TStream::Seek(Offset, Origin); }
	
};

#pragma pack(pop)

class DELPHICLASS TfrxMemoryStream;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TfrxMemoryStream : public System::Classes::TMemoryStream
{
	typedef System::Classes::TMemoryStream inherited;
	
private:
	unsigned FSz;
	
public:
	virtual int __fastcall Seek(int Offset, System::Word Origin)/* overload */;
	virtual __int64 __fastcall Seek(const __int64 Offset, System::Classes::TSeekOrigin Origin)/* overload */;
public:
	/* TMemoryStream.Destroy */ inline __fastcall virtual ~TfrxMemoryStream(void) { }
	
public:
	/* TObject.Create */ inline __fastcall TfrxMemoryStream(void) : System::Classes::TMemoryStream() { }
	
/* Hoisted overloads: */
	
public:
	inline __int64 __fastcall  Seek _DEPRECATED_ATTRIBUTE0 (const __int64 Offset, System::Word Origin){ return System::Classes::TStream::Seek(Offset, Origin); }
	
};

#pragma pack(pop)

class DELPHICLASS TfrxPictureCache;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TfrxPictureCache : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	TfrxCacheList* FItems;
	System::Classes::TList* FCacheStreamList;
	System::Classes::TStringList* FTempFile;
	System::UnicodeString FTempDir;
	bool FUseFileCache;
	void __fastcall Add(void);
	void __fastcall SetTempDir(const System::UnicodeString Value);
	void __fastcall SetUseFileCache(const bool Value);
	
public:
	__fastcall TfrxPictureCache(void);
	__fastcall virtual ~TfrxPictureCache(void);
	void __fastcall Clear(void);
	void __fastcall AddPicture(Frxclass::TfrxPictureView* Picture);
	void __fastcall GetPicture(Frxclass::TfrxPictureView* Picture);
	void __fastcall SaveToXML(Frxxml::TfrxXMLItem* Item);
	void __fastcall LoadFromXML(Frxxml::TfrxXMLItem* Item);
	void __fastcall AddSegment(void);
	__property bool UseFileCache = {read=FUseFileCache, write=SetUseFileCache, nodefault};
	__property System::UnicodeString TempDir = {read=FTempDir, write=SetTempDir};
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
}	/* namespace Frxpicturecache */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FRXPICTURECACHE)
using namespace Frxpicturecache;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// FrxpicturecacheHPP
