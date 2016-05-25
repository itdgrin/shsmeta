// CodeGear C++Builder
// Copyright (c) 1995, 2013 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'frxBDEComponents.pas' rev: 26.00 (Windows)

#ifndef FrxbdecomponentsHPP
#define FrxbdecomponentsHPP

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
#include <frxClass.hpp>	// Pascal unit
#include <frxCustomDB.hpp>	// Pascal unit
#include <Data.DB.hpp>	// Pascal unit
#include <Bde.DBTables.hpp>	// Pascal unit
#include <System.Variants.hpp>	// Pascal unit
#include <fqbClass.hpp>	// Pascal unit
#include <frxDBSet.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Frxbdecomponents
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TfrxBDEComponents;
class PASCALIMPLEMENTATION TfrxBDEComponents : public Frxclass::TfrxDBComponents
{
	typedef Frxclass::TfrxDBComponents inherited;
	
private:
	System::UnicodeString FDefaultDatabase;
	System::UnicodeString FDefaultSession;
	TfrxBDEComponents* FOldComponents;
	
public:
	__fastcall virtual TfrxBDEComponents(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TfrxBDEComponents(void);
	virtual System::UnicodeString __fastcall GetDescription(void);
	
__published:
	__property System::UnicodeString DefaultDatabase = {read=FDefaultDatabase, write=FDefaultDatabase};
	__property System::UnicodeString DefaultSession = {read=FDefaultSession, write=FDefaultSession};
};


class DELPHICLASS TfrxBDEDatabase;
class PASCALIMPLEMENTATION TfrxBDEDatabase : public Frxclass::TfrxCustomDatabase
{
	typedef Frxclass::TfrxCustomDatabase inherited;
	
private:
	Bde::Dbtables::TDatabase* FDatabase;
	void __fastcall SetAliasName(const System::UnicodeString Value);
	void __fastcall SetDriverName(const System::UnicodeString Value);
	System::UnicodeString __fastcall GetAliasName(void);
	System::UnicodeString __fastcall GetDriverName(void);
	
protected:
	virtual bool __fastcall GetConnected(void);
	virtual System::UnicodeString __fastcall GetDatabaseName(void);
	virtual bool __fastcall GetLoginPrompt(void);
	virtual System::Classes::TStrings* __fastcall GetParams(void);
	virtual void __fastcall SetConnected(bool Value);
	virtual void __fastcall SetDatabaseName(const System::UnicodeString Value);
	virtual void __fastcall SetLoginPrompt(bool Value);
	virtual void __fastcall SetParams(System::Classes::TStrings* Value);
	
public:
	__fastcall virtual TfrxBDEDatabase(System::Classes::TComponent* AOwner);
	__classmethod virtual System::UnicodeString __fastcall GetDescription();
	__property Bde::Dbtables::TDatabase* Database = {read=FDatabase};
	
__published:
	__property System::UnicodeString AliasName = {read=GetAliasName, write=SetAliasName};
	__property DatabaseName = {default=0};
	__property System::UnicodeString DriverName = {read=GetDriverName, write=SetDriverName};
	__property LoginPrompt = {default=1};
	__property Params;
	__property Connected = {default=0};
public:
	/* TfrxDialogComponent.Destroy */ inline __fastcall virtual ~TfrxBDEDatabase(void) { }
	
public:
	/* TfrxComponent.DesignCreate */ inline __fastcall virtual TfrxBDEDatabase(System::Classes::TComponent* AOwner, System::Word Flags) : Frxclass::TfrxCustomDatabase(AOwner, Flags) { }
	
};


class DELPHICLASS TfrxBDETable;
class PASCALIMPLEMENTATION TfrxBDETable : public Frxcustomdb::TfrxCustomTable
{
	typedef Frxcustomdb::TfrxCustomTable inherited;
	
private:
	Bde::Dbtables::TTable* FTable;
	void __fastcall SetDatabaseName(const System::UnicodeString Value);
	System::UnicodeString __fastcall GetDatabaseName(void);
	void __fastcall SetSessionName(const System::UnicodeString Value);
	System::UnicodeString __fastcall GetSessionName(void);
	
protected:
	virtual void __fastcall SetMaster(Data::Db::TDataSource* const Value);
	virtual void __fastcall SetMasterFields(const System::UnicodeString Value);
	virtual void __fastcall SetIndexName(const System::UnicodeString Value);
	virtual void __fastcall SetIndexFieldNames(const System::UnicodeString Value);
	virtual void __fastcall SetTableName(const System::UnicodeString Value);
	virtual System::UnicodeString __fastcall GetIndexName(void);
	virtual System::UnicodeString __fastcall GetIndexFieldNames(void);
	virtual System::UnicodeString __fastcall GetTableName(void);
	
public:
	__fastcall virtual TfrxBDETable(System::Classes::TComponent* AOwner);
	__classmethod virtual System::UnicodeString __fastcall GetDescription();
	__property Bde::Dbtables::TTable* Table = {read=FTable};
	
__published:
	__property System::UnicodeString DatabaseName = {read=GetDatabaseName, write=SetDatabaseName};
	__property System::UnicodeString SessionName = {read=GetSessionName, write=SetSessionName};
public:
	/* TfrxCustomDataset.Destroy */ inline __fastcall virtual ~TfrxBDETable(void) { }
	
public:
	/* TfrxComponent.DesignCreate */ inline __fastcall virtual TfrxBDETable(System::Classes::TComponent* AOwner, System::Word Flags) : Frxcustomdb::TfrxCustomTable(AOwner, Flags) { }
	
};


class DELPHICLASS TfrxBDEQuery;
class PASCALIMPLEMENTATION TfrxBDEQuery : public Frxcustomdb::TfrxCustomQuery
{
	typedef Frxcustomdb::TfrxCustomQuery inherited;
	
private:
	Bde::Dbtables::TQuery* FQuery;
	void __fastcall SetDatabaseName(const System::UnicodeString Value);
	System::UnicodeString __fastcall GetDatabaseName(void);
	void __fastcall SetSessionName(const System::UnicodeString Value);
	System::UnicodeString __fastcall GetSessionName(void);
	
protected:
	virtual void __fastcall SetMaster(Data::Db::TDataSource* const Value);
	virtual void __fastcall SetSQL(System::Classes::TStrings* Value);
	virtual System::Classes::TStrings* __fastcall GetSQL(void);
	
public:
	__fastcall virtual TfrxBDEQuery(System::Classes::TComponent* AOwner);
	__classmethod virtual System::UnicodeString __fastcall GetDescription();
	virtual void __fastcall UpdateParams(void);
	virtual Fqbclass::TfqbEngine* __fastcall QBEngine(void);
	__property Bde::Dbtables::TQuery* Query = {read=FQuery};
	
__published:
	__property System::UnicodeString DatabaseName = {read=GetDatabaseName, write=SetDatabaseName};
	__property System::UnicodeString SessionName = {read=GetSessionName, write=SetSessionName};
public:
	/* TfrxCustomQuery.Destroy */ inline __fastcall virtual ~TfrxBDEQuery(void) { }
	
public:
	/* TfrxComponent.DesignCreate */ inline __fastcall virtual TfrxBDEQuery(System::Classes::TComponent* AOwner, System::Word Flags) : Frxcustomdb::TfrxCustomQuery(AOwner, Flags) { }
	
};


class DELPHICLASS TfrxEngineBDE;
class PASCALIMPLEMENTATION TfrxEngineBDE : public Fqbclass::TfqbEngine
{
	typedef Fqbclass::TfqbEngine inherited;
	
private:
	Bde::Dbtables::TQuery* FQuery;
	
public:
	__fastcall virtual TfrxEngineBDE(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TfrxEngineBDE(void);
	virtual void __fastcall ReadTableList(System::Classes::TStrings* ATableList);
	virtual void __fastcall ReadFieldList(const System::UnicodeString ATableName, Fqbclass::TfqbFieldList* &AFieldList);
	virtual Data::Db::TDataSet* __fastcall ResultDataSet(void);
	virtual void __fastcall SetSQL(const System::UnicodeString Value);
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE TfrxBDEComponents* BDEComponents;
}	/* namespace Frxbdecomponents */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FRXBDECOMPONENTS)
using namespace Frxbdecomponents;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// FrxbdecomponentsHPP
