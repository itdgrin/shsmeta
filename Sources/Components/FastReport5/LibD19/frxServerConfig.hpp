// CodeGear C++Builder
// Copyright (c) 1995, 2013 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'frxServerConfig.pas' rev: 26.00 (Windows)

#ifndef FrxserverconfigHPP
#define FrxserverconfigHPP

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
#include <System.SyncObjs.hpp>	// Pascal unit
#include <frxXML.hpp>	// Pascal unit
#include <frxUtils.hpp>	// Pascal unit
#include <frxServerUtils.hpp>	// Pascal unit
#include <System.IniFiles.hpp>	// Pascal unit
#include <frxServerLog.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Frxserverconfig
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TfrxConfig;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TfrxConfig : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	Frxxml::TfrxXMLDocument* FXML;
	System::Classes::TStrings* FErrors;
	System::Classes::TStringList* FLines;
	System::Syncobjs::TCriticalSection* FCS;
	System::UnicodeString FFileName;
	System::UnicodeString FConfigFolder;
	void __fastcall UpdateLines(void);
	void __fastcall AddLine(const System::UnicodeString Name, const System::UnicodeString Value, Frxxml::TfrxXMLItem* XMLItem);
	int __fastcall GetCount(void);
	
public:
	System::UnicodeString ServerMessage;
	__fastcall TfrxConfig(void);
	__fastcall virtual ~TfrxConfig(void);
	HRESULT __fastcall LoadFromStream(System::Classes::TStream* Stream);
	HRESULT __fastcall SaveToStream(System::Classes::TStream* Stream);
	HRESULT __fastcall LoadFromFile(const System::UnicodeString FileName);
	HRESULT __fastcall SaveToFile(const System::UnicodeString FileName);
	System::UnicodeString __fastcall GetValue(const System::UnicodeString Name);
	int __fastcall GetNumber(const System::UnicodeString Name);
	bool __fastcall GetBool(const System::UnicodeString Name);
	System::UnicodeString __fastcall CheckValue(const System::UnicodeString Name, const System::UnicodeString Current);
	void __fastcall SetValue(const System::UnicodeString Name, const System::UnicodeString Value);
	void __fastcall SetBool(const System::UnicodeString Name, const bool Value);
	void __fastcall Clear(void);
	void __fastcall ConfigListToFile(const System::UnicodeString FileName);
	void __fastcall Reload(void);
	__property System::Classes::TStringList* Lines = {read=FLines};
	__property Frxxml::TfrxXMLDocument* XML = {read=FXML};
	__property int Count = {read=GetCount, nodefault};
	__property System::UnicodeString ConfigFolder = {read=FConfigFolder, write=FConfigFolder};
};

#pragma pack(pop)

class DELPHICLASS TfrxConfigItem;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TfrxConfigItem : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	System::UnicodeString FValue;
	Frxxml::TfrxXMLItem* FXMLItem;
	
public:
	__property System::UnicodeString Value = {read=FValue, write=FValue};
	__property Frxxml::TfrxXMLItem* XMLItem = {read=FXMLItem, write=FXMLItem};
public:
	/* TObject.Create */ inline __fastcall TfrxConfigItem(void) : System::TObject() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TfrxConfigItem(void) { }
	
};

#pragma pack(pop)

class DELPHICLASS TfrxServerConfig;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TfrxServerConfig : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
private:
	bool FGzip;
	System::UnicodeString FIndexFileName;
	bool FLogging;
	System::UnicodeString FLogin;
	System::UnicodeString FLogPath;
	bool FMIC;
	bool FNoCacheHeader;
	Frxserverutils::TfrxServerOutputFormats FOutputFormats;
	System::UnicodeString FPassword;
	int FPort;
	System::UnicodeString FReportPath;
	System::UnicodeString FRootPath;
	int FSessionTimeOut;
	int FSocketTimeOut;
	System::UnicodeString FReportCachePath;
	int FDefaultCacheLatency;
	bool FReportCaching;
	int FMaxLogFiles;
	int FMaxLogSize;
	System::UnicodeString FDatabase;
	System::UnicodeString FDatabaseLogin;
	System::UnicodeString FDatabasePassword;
	bool FReportsList;
	System::UnicodeString FConfigFolder;
	
public:
	void __fastcall LoadFromFile(const System::UnicodeString FileName);
	void __fastcall SaveToFile(const System::UnicodeString FileName);
	
__published:
	__property bool Compression = {read=FGzip, write=FGzip, nodefault};
	__property System::UnicodeString IndexFileName = {read=FIndexFileName, write=FIndexFileName};
	__property bool Logging = {read=FLogging, write=FLogging, nodefault};
	__property int MaxLogSize = {read=FMaxLogSize, write=FMaxLogSize, nodefault};
	__property int MaxLogFiles = {read=FMaxLogFiles, write=FMaxLogFiles, nodefault};
	__property System::UnicodeString Login = {read=FLogin, write=FLogin};
	__property System::UnicodeString LogPath = {read=FLogPath, write=FLogPath};
	__property bool MIC = {read=FMIC, write=FMIC, nodefault};
	__property bool NoCacheHeader = {read=FNoCacheHeader, write=FNoCacheHeader, nodefault};
	__property Frxserverutils::TfrxServerOutputFormats OutputFormats = {read=FOutputFormats, write=FOutputFormats, nodefault};
	__property System::UnicodeString Password = {read=FPassword, write=FPassword};
	__property int Port = {read=FPort, write=FPort, nodefault};
	__property System::UnicodeString ReportPath = {read=FReportPath, write=FReportPath};
	__property System::UnicodeString ReportCachePath = {read=FReportCachePath, write=FReportCachePath};
	__property bool ReportCaching = {read=FReportCaching, write=FReportCaching, nodefault};
	__property int DefaultCacheLatency = {read=FDefaultCacheLatency, write=FDefaultCacheLatency, nodefault};
	__property System::UnicodeString RootPath = {read=FRootPath, write=FRootPath};
	__property int SessionTimeOut = {read=FSessionTimeOut, write=FSessionTimeOut, nodefault};
	__property int SocketTimeOut = {read=FSocketTimeOut, write=FSocketTimeOut, nodefault};
	__property System::UnicodeString Database = {read=FDatabase, write=FDatabase};
	__property System::UnicodeString DatabaseLogin = {read=FDatabaseLogin, write=FDatabaseLogin};
	__property System::UnicodeString DatabasePassword = {read=FDatabasePassword, write=FDatabasePassword};
	__property bool ReportsList = {read=FReportsList, write=FReportsList, nodefault};
	__property System::UnicodeString ConfigFolder = {read=FConfigFolder, write=FConfigFolder};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TfrxServerConfig(void) { }
	
public:
	/* TObject.Create */ inline __fastcall TfrxServerConfig(void) : System::Classes::TPersistent() { }
	
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE TfrxConfig* ServerConfig;
#define FR_SERVER_CONFIG_VERSION L"2.4.0"
}	/* namespace Frxserverconfig */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FRXSERVERCONFIG)
using namespace Frxserverconfig;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// FrxserverconfigHPP
