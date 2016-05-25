// CodeGear C++Builder
// Copyright (c) 1995, 2013 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'frxServerSessionManager.pas' rev: 26.00 (Windows)

#ifndef FrxserversessionmanagerHPP
#define FrxserversessionmanagerHPP

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
#include <Vcl.Forms.hpp>	// Pascal unit
#include <System.Win.ScktComp.hpp>	// Pascal unit
#include <frxServerReports.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Frxserversessionmanager
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TfrxSessionItem;
class PASCALIMPLEMENTATION TfrxSessionItem : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	bool FActive;
	bool FCompleted;
	System::UnicodeString FName;
	Frxserverreports::TfrxReportSession* FReportThread;
	System::UnicodeString FSessionId;
	System::Win::Scktcomp::TCustomWinSocket* FSocket;
	System::TDateTime FTimeComplete;
	System::TDateTime FTimeCreated;
	
public:
	__fastcall TfrxSessionItem(void);
	__fastcall virtual ~TfrxSessionItem(void);
	__property bool Active = {read=FActive, write=FActive, nodefault};
	__property System::UnicodeString SessionId = {read=FSessionId, write=FSessionId};
	__property System::Win::Scktcomp::TCustomWinSocket* Socket = {read=FSocket, write=FSocket};
	__property bool Completed = {read=FCompleted, write=FCompleted, nodefault};
	__property System::TDateTime TimeCreated = {read=FTimeCreated, write=FTimeCreated};
	__property System::TDateTime TimeComplete = {read=FTimeComplete, write=FTimeComplete};
	__property System::UnicodeString FileName = {read=FName, write=FName};
	__property Frxserverreports::TfrxReportSession* ReportThread = {read=FReportThread, write=FReportThread};
};


class DELPHICLASS TfrxSessionManager;
class PASCALIMPLEMENTATION TfrxSessionManager : public System::Classes::TThread
{
	typedef System::Classes::TThread inherited;
	
private:
	int FCleanUpTimeOut;
	TfrxSessionItem* FSession;
	System::Classes::TList* FSessionList;
	System::UnicodeString FSessionPath;
	bool FShutDown;
	bool FThreadActive;
	bool __fastcall CleanUpSession(System::UnicodeString SessionId);
	void __fastcall Clear(void);
	void __fastcall DeleteSession(void);
	void __fastcall DeleteSessionFolder(const System::UnicodeString DirName);
	void __fastcall SetSessionPath(const System::UnicodeString Value);
	int __fastcall GetCount(void);
	
protected:
	virtual void __fastcall Execute(void);
	
public:
	__fastcall TfrxSessionManager(void);
	__fastcall virtual ~TfrxSessionManager(void);
	TfrxSessionItem* __fastcall AddSession(System::UnicodeString SessionId, System::Win::Scktcomp::TCustomWinSocket* Socket);
	void __fastcall CompleteSession(System::Win::Scktcomp::TCustomWinSocket* Socket);
	void __fastcall CompleteSessionId(System::UnicodeString SessionId);
	TfrxSessionItem* __fastcall FindSessionBySocket(System::Win::Scktcomp::TCustomWinSocket* Socket);
	TfrxSessionItem* __fastcall FindSessionById(System::UnicodeString SessionId);
	void __fastcall CleanUp(void);
	__property int CleanUpTimeOut = {read=FCleanUpTimeOut, write=FCleanUpTimeOut, nodefault};
	__property System::UnicodeString SessionPath = {read=FSessionPath, write=SetSessionPath};
	__property int Count = {read=GetCount, nodefault};
};


class DELPHICLASS TfrxOldSessionsCleanupThread;
class PASCALIMPLEMENTATION TfrxOldSessionsCleanupThread : public System::Classes::TThread
{
	typedef System::Classes::TThread inherited;
	
private:
	System::UnicodeString FPath;
	
protected:
	virtual void __fastcall Execute(void);
	
public:
	__fastcall TfrxOldSessionsCleanupThread(const System::UnicodeString Dir);
	__property System::UnicodeString Path = {read=FPath, write=FPath};
public:
	/* TThread.Destroy */ inline __fastcall virtual ~TfrxOldSessionsCleanupThread(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE TfrxSessionManager* SessionManager;
}	/* namespace Frxserversessionmanager */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FRXSERVERSESSIONMANAGER)
using namespace Frxserversessionmanager;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// FrxserversessionmanagerHPP
