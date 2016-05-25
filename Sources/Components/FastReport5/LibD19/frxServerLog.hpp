// CodeGear C++Builder
// Copyright (c) 1995, 2013 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'frxServerLog.pas' rev: 26.00 (Windows)

#ifndef FrxserverlogHPP
#define FrxserverlogHPP

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
#include <System.SyncObjs.hpp>	// Pascal unit
#include <frxUtils.hpp>	// Pascal unit
#include <frxServerUtils.hpp>	// Pascal unit
#include <frxNetUtils.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Frxserverlog
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TfrxServerLog;
class PASCALIMPLEMENTATION TfrxServerLog : public System::Classes::TThread
{
	typedef System::Classes::TThread inherited;
	
private:
	int FCurrentReports;
	int FCurrentSessions;
	int FErrorsCount;
	System::Classes::TStringList* FLevelFName;
	System::Classes::TList* FLevels;
	System::UnicodeString FLogDir;
	bool FLogging;
	int FMaxReports;
	int FMaxReportTime;
	int FMaxSessions;
	int FTotalReports;
	int FTotalReportTime;
	int FTotalSessions;
	int FMaxLogSize;
	int FMaxLogFiles;
	System::Syncobjs::TCriticalSection* FCS;
	int FTotalCacheHits;
	bool FThreadActive;
	void __fastcall WriteFile(const System::UnicodeString FName, const System::UnicodeString Text);
	void __fastcall LogRotate(const System::UnicodeString FName);
	void __fastcall SetCurrentReports(int Value);
	void __fastcall SetCurrentSessions(int Value);
	
protected:
	virtual void __fastcall Execute(void);
	
public:
	__fastcall TfrxServerLog(void);
	__fastcall virtual ~TfrxServerLog(void);
	int __fastcall AddLevel(const System::UnicodeString FileName);
	void __fastcall Clear(void);
	void __fastcall Flush(void);
	void __fastcall ErrorReached(void);
	void __fastcall StartAddReportTime(int i);
	void __fastcall StatAddCurrentReport(void);
	void __fastcall StatAddCurrentSession(void);
	void __fastcall StatAddCacheHit(void);
	void __fastcall StatAddReports(int i);
	void __fastcall StatAddSessions(int i);
	void __fastcall StatRemoveCurrentReport(void);
	void __fastcall StatRemoveCurrentSession(void);
	void __fastcall Write(const int Level, const System::UnicodeString Msg);
	__property bool Active = {read=FLogging, write=FLogging, nodefault};
	__property int CurrentReports = {read=FCurrentReports, write=SetCurrentReports, nodefault};
	__property int CurrentSessions = {read=FCurrentSessions, write=SetCurrentSessions, nodefault};
	__property int ErrorsCount = {read=FErrorsCount, write=FErrorsCount, nodefault};
	__property System::UnicodeString LogDir = {read=FLogDir, write=FLogDir};
	__property int MaxReports = {read=FMaxReports, write=FMaxReports, nodefault};
	__property int MaxReportTime = {read=FMaxReportTime, write=FMaxReportTime, nodefault};
	__property int MaxSessions = {read=FMaxSessions, write=FMaxSessions, nodefault};
	__property int TotalReports = {read=FTotalReports, write=FTotalReports, nodefault};
	__property int TotalReportTime = {read=FTotalReportTime, write=FTotalReportTime, nodefault};
	__property int TotalSessions = {read=FTotalSessions, write=FTotalSessions, nodefault};
	__property int MaxLogSize = {read=FMaxLogSize, write=FMaxLogSize, nodefault};
	__property int MaxLogFiles = {read=FMaxLogFiles, write=FMaxLogFiles, nodefault};
	__property int TotalCacheHits = {read=FTotalCacheHits, write=FTotalCacheHits, nodefault};
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE TfrxServerLog* LogWriter;
static const System::Int8 ERROR_LEVEL = System::Int8(0x0);
static const System::Int8 ACCESS_LEVEL = System::Int8(0x1);
static const System::Int8 REFERER_LEVEL = System::Int8(0x2);
static const System::Int8 AGENT_LEVEL = System::Int8(0x3);
static const System::Int8 SERVER_LEVEL = System::Int8(0x4);
static const System::Int8 SCHEDULER_LEVEL = System::Int8(0x5);
}	/* namespace Frxserverlog */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FRXSERVERLOG)
using namespace Frxserverlog;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// FrxserverlogHPP
