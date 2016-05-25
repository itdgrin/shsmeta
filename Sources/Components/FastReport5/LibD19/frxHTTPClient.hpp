// CodeGear C++Builder
// Copyright (c) 1995, 2013 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'frxHTTPClient.pas' rev: 26.00 (Windows)

#ifndef FrxhttpclientHPP
#define FrxhttpclientHPP

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
#include <frxGZip.hpp>	// Pascal unit
#include <frxmd5.hpp>	// Pascal unit
#include <System.Variants.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Frxhttpclient
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TfrxHTTPClient;
class DELPHICLASS TfrxHTTPClientFields;
class DELPHICLASS TfrxHTTPServerFields;
class DELPHICLASS TfrxClientThread;
class PASCALIMPLEMENTATION TfrxHTTPClient : public System::Classes::TComponent
{
	typedef System::Classes::TComponent inherited;
	
private:
	bool FActive;
	System::Classes::TStrings* FAnswer;
	bool FBreaked;
	TfrxHTTPClientFields* FClientFields;
	System::Classes::TStrings* FErrors;
	System::Classes::TStrings* FHeader;
	System::UnicodeString FHost;
	bool FMIC;
	int FPort;
	System::UnicodeString FProxyHost;
	int FProxyPort;
	int FRetryCount;
	int FRetryTimeOut;
	TfrxHTTPServerFields* FServerFields;
	System::Classes::TMemoryStream* FStream;
	System::Classes::TMemoryStream* FTempStream;
	TfrxClientThread* FThread;
	int FTimeOut;
	System::UnicodeString FProxyLogin;
	System::UnicodeString FProxyPassword;
	unsigned FConnectDelay;
	unsigned FAnswerDelay;
	void __fastcall DoConnect(System::TObject* Sender, System::Win::Scktcomp::TCustomWinSocket* Socket);
	void __fastcall DoDisconnect(System::TObject* Sender, System::Win::Scktcomp::TCustomWinSocket* Socket);
	void __fastcall DoError(System::TObject* Sender, System::Win::Scktcomp::TCustomWinSocket* Socket, System::Win::Scktcomp::TErrorEvent ErrorEvent, int &ErrorCode);
	void __fastcall DoRead(System::TObject* Sender, System::Win::Scktcomp::TCustomWinSocket* Socket);
	void __fastcall SetActive(const bool Value);
	void __fastcall SetClientFields(TfrxHTTPClientFields* const Value);
	void __fastcall SetServerFields(TfrxHTTPServerFields* const Value);
	
public:
	System::Classes::TThread* ParentThread;
	unsigned StreamSize;
	__fastcall virtual TfrxHTTPClient(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TfrxHTTPClient(void);
	void __fastcall Connect(void);
	void __fastcall Disconnect(void);
	void __fastcall Open(void);
	void __fastcall Close(void);
	__property System::Classes::TStrings* Answer = {read=FAnswer, write=FAnswer};
	__property bool Breaked = {read=FBreaked, nodefault};
	__property System::Classes::TStrings* Errors = {read=FErrors, write=FErrors};
	__property System::Classes::TStrings* Header = {read=FHeader, write=FHeader};
	__property System::Classes::TMemoryStream* Stream = {read=FStream, write=FStream};
	
__published:
	__property bool Active = {read=FActive, write=SetActive, nodefault};
	__property TfrxHTTPClientFields* ClientFields = {read=FClientFields, write=SetClientFields};
	__property System::UnicodeString Host = {read=FHost, write=FHost};
	__property bool MIC = {read=FMIC, write=FMIC, nodefault};
	__property int Port = {read=FPort, write=FPort, nodefault};
	__property System::UnicodeString ProxyHost = {read=FProxyHost, write=FProxyHost};
	__property int ProxyPort = {read=FProxyPort, write=FProxyPort, nodefault};
	__property System::UnicodeString ProxyLogin = {read=FProxyLogin, write=FProxyLogin};
	__property System::UnicodeString ProxyPassword = {read=FProxyPassword, write=FProxyPassword};
	__property int RetryCount = {read=FRetryCount, write=FRetryCount, nodefault};
	__property int RetryTimeOut = {read=FRetryTimeOut, write=FRetryTimeOut, nodefault};
	__property TfrxHTTPServerFields* ServerFields = {read=FServerFields, write=SetServerFields};
	__property int TimeOut = {read=FTimeOut, write=FTimeOut, nodefault};
	__property unsigned ConnectDelay = {read=FConnectDelay, nodefault};
	__property unsigned AnswerDelay = {read=FAnswerDelay, nodefault};
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TfrxHTTPServerFields : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
private:
	int FAnswerCode;
	System::UnicodeString FContentEncoding;
	System::UnicodeString FContentMD5;
	int FContentLength;
	System::UnicodeString FLocation;
	System::UnicodeString FSessionId;
	System::UnicodeString FCookie;
	
public:
	__fastcall TfrxHTTPServerFields(void);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	
__published:
	__property int AnswerCode = {read=FAnswerCode, write=FAnswerCode, nodefault};
	__property System::UnicodeString ContentEncoding = {read=FContentEncoding, write=FContentEncoding};
	__property System::UnicodeString ContentMD5 = {read=FContentMD5, write=FContentMD5};
	__property int ContentLength = {read=FContentLength, write=FContentLength, nodefault};
	__property System::UnicodeString Location = {read=FLocation, write=FLocation};
	__property System::UnicodeString SessionId = {read=FSessionId, write=FSessionId};
	__property System::UnicodeString Cookie = {read=FCookie, write=FCookie};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TfrxHTTPServerFields(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TfrxHTTPClientFields : public System::Classes::TPersistent
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
	System::UnicodeString FVariables;
	System::UnicodeString FAccept;
	System::UnicodeString FAcceptCharset;
	System::UnicodeString FContentType;
	System::UnicodeString FRange;
	
public:
	__fastcall TfrxHTTPClientFields(void);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	
__published:
	__property System::UnicodeString AcceptEncoding = {read=FAcceptEncoding, write=FAcceptEncoding};
	__property System::UnicodeString Accept = {read=FAccept, write=FAccept};
	__property System::UnicodeString AcceptCharset = {read=FAcceptCharset, write=FAcceptCharset};
	__property System::UnicodeString FileName = {read=FName, write=FName};
	__property System::UnicodeString Host = {read=FHost, write=FHost};
	__property System::UnicodeString HTTPVer = {read=FHTTPVer, write=FHTTPVer};
	__property System::UnicodeString Login = {read=FLogin, write=FLogin};
	__property System::UnicodeString Password = {read=FPassword, write=FPassword};
	__property Frxserverutils::TfrxHTTPQueryType QueryType = {read=FQueryType, write=FQueryType, nodefault};
	__property System::UnicodeString Referer = {read=FReferer, write=FReferer};
	__property System::UnicodeString UserAgent = {read=FUserAgent, write=FUserAgent};
	__property System::UnicodeString Variables = {read=FVariables, write=FVariables};
	__property System::UnicodeString ContentType = {read=FContentType, write=FContentType};
	__property System::UnicodeString Range = {read=FRange, write=FRange};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TfrxHTTPClientFields(void) { }
	
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TfrxClientThread : public System::Classes::TThread
{
	typedef System::Classes::TThread inherited;
	
protected:
	TfrxHTTPClient* FClient;
	void __fastcall DoOpen(void);
	virtual void __fastcall Execute(void);
	
public:
	System::Win::Scktcomp::TClientSocket* FSocket;
	__fastcall TfrxClientThread(TfrxHTTPClient* Client);
	__fastcall virtual ~TfrxClientThread(void);
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Frxhttpclient */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FRXHTTPCLIENT)
using namespace Frxhttpclient;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// FrxhttpclientHPP
