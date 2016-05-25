// CodeGear C++Builder
// Copyright (c) 1995, 2013 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'frxusers.pas' rev: 26.00 (Windows)

#ifndef FrxusersHPP
#define FrxusersHPP

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
#include <frxXML.hpp>	// Pascal unit
#include <frxFileUtils.hpp>	// Pascal unit
#include <frxUtils.hpp>	// Pascal unit
#include <frxmd5.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Frxusers
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TfrxUsers;
class DELPHICLASS TfrxUserGroupItem;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TfrxUsers : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	Frxxml::TfrxXMLDocument* FXML;
	System::Classes::TStringList* FUsersList;
	System::Classes::TStringList* FGroupsList;
	void __fastcall UnpackUsersTree(void);
	void __fastcall PackUsersTree(void);
	
public:
	__fastcall TfrxUsers(void);
	__fastcall virtual ~TfrxUsers(void);
	void __fastcall Clear(void);
	bool __fastcall CheckPassword(const System::UnicodeString UserName, const System::UnicodeString Password);
	bool __fastcall AllowLogin(const System::UnicodeString UserName, const System::UnicodeString Password);
	bool __fastcall AllowGroupLogin(const System::UnicodeString UserName);
	bool __fastcall UserExists(const System::UnicodeString UserName);
	bool __fastcall GroupExists(const System::UnicodeString GroupName);
	bool __fastcall ChPasswd(const System::UnicodeString UserName, const System::UnicodeString NewPassword);
	TfrxUserGroupItem* __fastcall AddUser(const System::UnicodeString UserName);
	TfrxUserGroupItem* __fastcall AddGroup(const System::UnicodeString GroupName);
	TfrxUserGroupItem* __fastcall GetGroup(const System::UnicodeString GroupName);
	TfrxUserGroupItem* __fastcall GetUser(const System::UnicodeString UserName);
	bool __fastcall MemberOfGroup(const System::UnicodeString User, const System::UnicodeString Group);
	System::UnicodeString __fastcall GetUserIndex(const System::UnicodeString User);
	System::UnicodeString __fastcall GetGroupOfUser(const System::UnicodeString User);
	void __fastcall LoadFromFile(const System::UnicodeString FileName);
	void __fastcall AddUserToGroup(const System::UnicodeString UserName, const System::UnicodeString GroupName);
	void __fastcall RemoveUserFromGroup(const System::UnicodeString Username, const System::UnicodeString GroupName);
	void __fastcall RemoveGroupFromUser(const System::UnicodeString GroupName, const System::UnicodeString Username);
	void __fastcall DeleteUser(const System::UnicodeString UserName);
	void __fastcall DeleteGroup(const System::UnicodeString GroupName);
	void __fastcall SaveToFile(const System::UnicodeString FileName);
	__property System::Classes::TStringList* UserList = {read=FUsersList};
	__property System::Classes::TStringList* GroupList = {read=FGroupsList};
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TfrxUserGroupItem : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	bool FActive;
	System::UnicodeString FPassword;
	System::UnicodeString FName;
	System::UnicodeString FEmail;
	System::UnicodeString FFullName;
	System::UnicodeString FAuthType;
	bool FIsGroup;
	System::Classes::TStringList* FMembers;
	System::UnicodeString FIndexFile;
	
public:
	__fastcall TfrxUserGroupItem(void);
	__fastcall virtual ~TfrxUserGroupItem(void);
	__property System::UnicodeString Name = {read=FName, write=FName};
	__property bool Active = {read=FActive, write=FActive, nodefault};
	__property System::UnicodeString FullName = {read=FFullName, write=FFullName};
	__property System::UnicodeString Email = {read=FEmail, write=FEmail};
	__property System::UnicodeString Password = {read=FPassword, write=FPassword};
	__property System::UnicodeString AuthType = {read=FAuthType, write=FAuthType};
	__property bool IsGroup = {read=FIsGroup, write=FIsGroup, nodefault};
	__property System::Classes::TStringList* Members = {read=FMembers};
	__property System::UnicodeString IndexFile = {read=FIndexFile, write=FIndexFile};
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE TfrxUsers* ServerUsers;
}	/* namespace Frxusers */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FRXUSERS)
using namespace Frxusers;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// FrxusersHPP
