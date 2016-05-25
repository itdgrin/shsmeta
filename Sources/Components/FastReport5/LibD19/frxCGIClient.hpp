// CodeGear C++Builder
// Copyright (c) 1995, 2013 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'frxCGIClient.pas' rev: 26.00 (Windows)

#ifndef FrxcgiclientHPP
#define FrxcgiclientHPP

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
#include <System.Win.ScktComp.hpp>	// Pascal unit
#include <frxServerUtils.hpp>	// Pascal unit
#include <frxNetUtils.hpp>	// Pascal unit
#include <System.Variants.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Frxcgiclient
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TfrxCGIClient;
class DELPHICLASS TfrxCGIClientFields;
class DELPHICLASS TfrxCGIServerFields;
class DELPHICLASS TfrxClientThread;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TfrxCGIClient : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	bool FActive;
	System::Classes::TStrings* FAnswer;
	bool FBreaked;
	TfrxCGIClientFields* FClientFields;
	System::Classes::TStrings* FErrors;
	System::Classes::TStrings* FHeader;
	System::UnicodeString FHost;
	int FPort;
	System::UnicodeString FProxyHost;
	int FProxyPort;
	int FRetryCount;
	int FRetryTimeOut;
	TfrxCGIServerFields* FServerFields;
	System::Classes::TMemoryStream* FStream;
	System::Classes::TMemoryStream* FTempStream;
	TfrxClientThread* FThread;
	int FTimeOut;
	System::UnicodeString F_REQUEST_METHOD;
	System::UnicodeString F_REMOTE_USER;
	System::UnicodeString F_QUERY_STRING;
	System::UnicodeString F_REMOTE_HOST;
	System::UnicodeString F_SERVER_NAME;
	System::UnicodeString F_SERVER_PORT;
	System::UnicodeString F_HTTP_REFERER;
	System::UnicodeString F_HTTP_USER_AGENT;
	System::UnicodeString F_HTTP_AUTHORIZATION;
	System::UnicodeString F_HTTP_COOKIE;
	System::UnicodeString F_CGI_FILENAME;
	System::UnicodeString F_CONTENT_LENGTH;
	System::UnicodeString F_CONTENT;
	System::Classes::THandleStream* OutStream;
	bool IsHTML;
	System::UnicodeString FPostData;
	System::UnicodeString __fastcall GetCurrentUserName(void);
	void __fastcall DoConnect(System::TObject* Sender, System::Win::Scktcomp::TCustomWinSocket* Socket);
	void __fastcall DoDisconnect(System::TObject* Sender, System::Win::Scktcomp::TCustomWinSocket* Socket);
	void __fastcall DoError(System::TObject* Sender, System::Win::Scktcomp::TCustomWinSocket* Socket, System::Win::Scktcomp::TErrorEvent ErrorEvent, int &ErrorCode);
	void __fastcall DoRead(System::TObject* Sender, System::Win::Scktcomp::TCustomWinSocket* Socket);
	void __fastcall SetActive(const bool Value);
	void __fastcall SetClientFields(TfrxCGIClientFields* const Value);
	void __fastcall SetServerFields(TfrxCGIServerFields* const Value);
	void __fastcall PrepareCGIStream(System::Classes::TStream* IStream, System::Classes::TStream* OStream);
	void __fastcall ReplaceCGIReps(System::UnicodeString Sign1, System::UnicodeString Sign2, System::Classes::TStream* IStream, System::Classes::TStream* OStream);
	void __fastcall DeleteCGIReps(System::UnicodeString Sign, System::Classes::TStream* IStream, System::Classes::TStream* OStream);
	void __fastcall InsertCGIHref(System::AnsiString Sign, System::Classes::TStream* IStream, System::Classes::TStream* OStream);
	
public:
	System::Classes::TThread* ParentThread;
	unsigned StreamSize;
	__fastcall TfrxCGIClient(void);
	__fastcall virtual ~TfrxCGIClient(void);
	void __fastcall Connect(void);
	void __fastcall Disconnect(void);
	void __fastcall Open(void);
	void __fastcall Close(void);
	__property System::Classes::TStrings* Answer = {read=FAnswer, write=FAnswer};
	__property bool Breaked = {read=FBreaked, nodefault};
	__property System::Classes::TStrings* Errors = {read=FErrors, write=FErrors};
	__property System::Classes::TStrings* Header = {read=FHeader, write=FHeader};
	__property System::Classes::TMemoryStream* Stream = {read=FStream, write=FStream};
	__property TfrxCGIClientFields* ClientFields = {read=FClientFields, write=SetClientFields};
	__property TfrxCGIServerFields* ServerFields = {read=FServerFields, write=SetServerFields};
	__property bool Active = {read=FActive, write=SetActive, nodefault};
	__property System::UnicodeString Host = {read=FHost, write=FHost};
	__property int Port = {read=FPort, write=FPort, nodefault};
	__property System::UnicodeString ProxyHost = {read=FProxyHost, write=FProxyHost};
	__property int ProxyPort = {read=FProxyPort, write=FProxyPort, nodefault};
	__property int RetryCount = {read=FRetryCount, write=FRetryCount, nodefault};
	__property int RetryTimeOut = {read=FRetryTimeOut, write=FRetryTimeOut, nodefault};
	__property int TimeOut = {read=FTimeOut, write=FTimeOut, nodefault};
	__property System::UnicodeString PostData = {read=FPostData, write=FPostData};
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TfrxCGIServerFields : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
private:
	int FAnswerCode;
	System::UnicodeString FContentEncoding;
	int FContentLength;
	System::UnicodeString FLocation;
	System::UnicodeString FSessionId;
	
public:
	__fastcall TfrxCGIServerFields(void);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	__property int AnswerCode = {read=FAnswerCode, write=FAnswerCode, nodefault};
	__property System::UnicodeString ContentEncoding = {read=FContentEncoding, write=FContentEncoding};
	__property int ContentLength = {read=FContentLength, write=FContentLength, nodefault};
	__property System::UnicodeString Location = {read=FLocation, write=FLocation};
	__property System::UnicodeString SessionId = {read=FSessionId, write=FSessionId};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TfrxCGIServerFields(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TfrxCGIClientFields : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
private:
	System::UnicodeString FAcceptEncoding;
	System::UnicodeString FHost;
	System::UnicodeString FHTTPVer;
	System::UnicodeString FLogin;
	System::UnicodeString FName;
	System::UnicodeString FPassword;
	Frxserverutils::TfrxHTTPQueryType FQueryType;
	System::UnicodeString FReferer;
	System::UnicodeString FUserAgent;
	
public:
	__fastcall TfrxCGIClientFields(void);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	__property System::UnicodeString AcceptEncoding = {read=FAcceptEncoding, write=FAcceptEncoding};
	__property System::UnicodeString FileName = {read=FName, write=FName};
	__property System::UnicodeString Host = {read=FHost, write=FHost};
	__property System::UnicodeString HTTPVer = {read=FHTTPVer, write=FHTTPVer};
	__property System::UnicodeString Login = {read=FLogin, write=FLogin};
	__property System::UnicodeString Password = {read=FPassword, write=FPassword};
	__property Frxserverutils::TfrxHTTPQueryType QueryType = {read=FQueryType, write=FQueryType, nodefault};
	__property System::UnicodeString Referer = {read=FReferer, write=FReferer};
	__property System::UnicodeString UserAgent = {read=FUserAgent, write=FUserAgent};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TfrxCGIClientFields(void) { }
	
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TfrxClientThread : public System::Classes::TThread
{
	typedef System::Classes::TThread inherited;
	
protected:
	TfrxCGIClient* FClient;
	void __fastcall DoOpen(void);
	virtual void __fastcall Execute(void);
	
public:
	System::Win::Scktcomp::TClientSocket* FSocket;
	__fastcall TfrxClientThread(TfrxCGIClient* Client);
	__fastcall virtual ~TfrxClientThread(void);
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Frxcgiclient */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FRXCGICLIENT)
using namespace Frxcgiclient;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// FrxcgiclientHPP
