// CodeGear C++Builder
// Copyright (c) 1995, 2013 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'frxServerCache.pas' rev: 26.00 (Windows)

#ifndef FrxservercacheHPP
#define FrxservercacheHPP

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
#include <frxUtils.hpp>	// Pascal unit
#include <frxServerUtils.hpp>	// Pascal unit
#include <frxNetUtils.hpp>	// Pascal unit
#include <frxVariables.hpp>	// Pascal unit
#include <frxClass.hpp>	// Pascal unit
#include <frxServerLog.hpp>	// Pascal unit
#include <System.SyncObjs.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Frxservercache
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TfrxServerCacheItem;
class PASCALIMPLEMENTATION TfrxServerCacheItem : public System::Classes::TCollectionItem
{
	typedef System::Classes::TCollectionItem inherited;
	
private:
	System::UnicodeString FReportName;
	Frxvariables::TfrxVariables* FVariables;
	System::UnicodeString FFileName;
	System::TDateTime FExpTime;
	System::UnicodeString FSessionId;
	System::Classes::TStream* FStream;
	System::UnicodeString FInternalId;
	
public:
	__fastcall virtual TfrxServerCacheItem(System::Classes::TCollection* Collection);
	__fastcall virtual ~TfrxServerCacheItem(void);
	
__published:
	__property System::UnicodeString ReportName = {read=FReportName, write=FReportName};
	__property Frxvariables::TfrxVariables* Variables = {read=FVariables, write=FVariables};
	__property System::UnicodeString FileName = {read=FFileName, write=FFileName};
	__property System::TDateTime ExpTime = {read=FExpTime, write=FExpTime};
	__property System::UnicodeString SessionId = {read=FSessionId, write=FSessionId};
	__property System::Classes::TStream* Stream = {read=FStream, write=FStream};
	__property System::UnicodeString InternalId = {read=FInternalId, write=FInternalId};
};


class DELPHICLASS TfrxServerCacheSpool;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TfrxServerCacheSpool : public System::Classes::TCollection
{
	typedef System::Classes::TCollection inherited;
	
private:
	TfrxServerCacheItem* __fastcall GetItems(int Index);
	bool __fastcall EqualVariables(Frxvariables::TfrxVariables* const Var1, Frxvariables::TfrxVariables* const Var2);
	
public:
	__fastcall TfrxServerCacheSpool(void);
	__fastcall virtual ~TfrxServerCacheSpool(void);
	__property TfrxServerCacheItem* Items[int Index] = {read=GetItems};
	HIDESBASE void __fastcall Clear(void);
	
__published:
	HIDESBASE TfrxServerCacheItem* __fastcall Add(void);
	HIDESBASE TfrxServerCacheItem* __fastcall Insert(int Index);
	int __fastcall IndexOf(const System::UnicodeString ReportName, Frxvariables::TfrxVariables* const Variables, const System::UnicodeString SessionId);
};

#pragma pack(pop)

class DELPHICLASS TfrxServerCache;
class PASCALIMPLEMENTATION TfrxServerCache : public System::Classes::TThread
{
	typedef System::Classes::TThread inherited;
	
private:
	System::UnicodeString FCachePath;
	bool FActive;
	int FLatency;
	TfrxServerCacheSpool* FHeap;
	bool FMemoryCache;
	bool FThreadActive;
	void __fastcall SetActive(const bool Value);
	void __fastcall CleanUpFiles(void);
	void __fastcall RemoveExpired(void);
	
protected:
	virtual void __fastcall Execute(void);
	
public:
	__fastcall TfrxServerCache(void);
	__fastcall virtual ~TfrxServerCache(void);
	bool __fastcall GetCachedStream(Frxclass::TfrxReport* const Report, const System::UnicodeString ReportName, Frxvariables::TfrxVariables* const Variables, const System::UnicodeString Id);
	bool __fastcall GetCachedReportById(Frxclass::TfrxReport* const Report, const System::UnicodeString Id);
	void __fastcall Open(void);
	void __fastcall Close(void);
	void __fastcall Clear(void);
	void __fastcall AddReport(Frxclass::TfrxReport* const Report, const System::UnicodeString ReportName, Frxvariables::TfrxVariables* const Variables, const System::UnicodeString Id, const System::UnicodeString InternalId);
	__property bool Active = {read=FActive, write=SetActive, nodefault};
	__property System::UnicodeString CachePath = {read=FCachePath, write=FCachePath};
	__property int DefaultLatency = {read=FLatency, write=FLatency, nodefault};
	__property TfrxServerCacheSpool* Heap = {read=FHeap};
	__property bool MemoryCache = {read=FMemoryCache, write=FMemoryCache, nodefault};
};


//-- var, const, procedure ---------------------------------------------------
#define CACHE_PREFIX L"$fr"
extern DELPHI_PACKAGE System::Syncobjs::TCriticalSection* CacheCS1;
extern DELPHI_PACKAGE TfrxServerCache* ReportCache;
}	/* namespace Frxservercache */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FRXSERVERCACHE)
using namespace Frxservercache;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// FrxservercacheHPP
