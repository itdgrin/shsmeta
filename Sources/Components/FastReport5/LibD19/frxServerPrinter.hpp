// CodeGear C++Builder
// Copyright (c) 1995, 2013 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'frxServerPrinter.pas' rev: 26.00 (Windows)

#ifndef FrxserverprinterHPP
#define FrxserverprinterHPP

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
#include <frxPrinter.hpp>	// Pascal unit
#include <frxClass.hpp>	// Pascal unit
#include <frxServerCache.hpp>	// Pascal unit
#include <frxUnicodeUtils.hpp>	// Pascal unit
#include <System.SyncObjs.hpp>	// Pascal unit
#include <frxServerTemplates.hpp>	// Pascal unit
#include <frxNetUtils.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Frxserverprinter
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TfrxServerPrinter;
class DELPHICLASS TfrxServerPrintQueue;
class PASCALIMPLEMENTATION TfrxServerPrinter : public System::Classes::TThread
{
	typedef System::Classes::TThread inherited;
	
private:
	TfrxServerPrintQueue* FQueue;
	Frxservertemplates::TfrxServerTemplate* FTemplate;
	bool FThreadActive;
	void __fastcall ProcessJobs(void);
	
protected:
	virtual void __fastcall Execute(void);
	
public:
	__fastcall TfrxServerPrinter(void);
	__fastcall virtual ~TfrxServerPrinter(void);
	System::UnicodeString __fastcall GetHTML(const System::UnicodeString SessionId, const System::UnicodeString Report);
	void __fastcall AddPrintJob(const System::UnicodeString SessionId, System::UnicodeString Printer, const System::UnicodeString Pages, int Copies, bool Collate, bool Reverse);
	__property TfrxServerPrintQueue* Queue = {read=FQueue};
	__property Frxservertemplates::TfrxServerTemplate* Template = {read=FTemplate};
};


class DELPHICLASS TfrxServerPrintJob;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TfrxServerPrintQueue : public System::Classes::TCollection
{
	typedef System::Classes::TCollection inherited;
	
private:
	TfrxServerPrintJob* __fastcall GetItems(int Index);
	
public:
	__fastcall TfrxServerPrintQueue(void);
	__fastcall virtual ~TfrxServerPrintQueue(void);
	__property TfrxServerPrintJob* Items[int Index] = {read=GetItems};
	HIDESBASE void __fastcall Clear(void);
	HIDESBASE TfrxServerPrintJob* __fastcall Add(void);
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TfrxServerPrintJob : public System::Classes::TCollectionItem
{
	typedef System::Classes::TCollectionItem inherited;
	
private:
	System::UnicodeString FSession;
	System::UnicodeString FFileName;
	Frxclass::TfrxReport* FReport;
	
public:
	__fastcall virtual TfrxServerPrintJob(System::Classes::TCollection* Collection);
	__fastcall virtual ~TfrxServerPrintJob(void);
	__property System::UnicodeString FileName = {read=FFileName, write=FFileName};
	__property System::UnicodeString Session = {read=FSession, write=FSession};
	__property Frxclass::TfrxReport* Report = {read=FReport};
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE System::Syncobjs::TCriticalSection* PrintCS1;
extern DELPHI_PACKAGE TfrxServerPrinter* ServerPrinter;
}	/* namespace Frxserverprinter */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FRXSERVERPRINTER)
using namespace Frxserverprinter;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// FrxserverprinterHPP
