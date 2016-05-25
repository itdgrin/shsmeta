// CodeGear C++Builder
// Copyright (c) 1995, 2013 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'frxIBXComponents.pas' rev: 26.00 (Windows)

#ifndef FrxibxcomponentsHPP
#define FrxibxcomponentsHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <Winapi.Windows.hpp>	// Pascal unit
#include <System.Classes.hpp>	// Pascal unit
#include <frxClass.hpp>	// Pascal unit
#include <frxCustomDB.hpp>	// Pascal unit
#include <Data.DB.hpp>	// Pascal unit
#include <IBDatabase.hpp>	// Pascal unit
#include <IBTable.hpp>	// Pascal unit
#include <IBQuery.hpp>	// Pascal unit
#include <System.Variants.hpp>	// Pascal unit
#include <fqbClass.hpp>	// Pascal unit
#include <frxDBSet.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Frxibxcomponents
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TfrxIBXComponents;
class PASCALIMPLEMENTATION TfrxIBXComponents : public Frxclass::TfrxDBComponents
{
	typedef Frxclass::TfrxDBComponents inherited;
	
private:
	Ibdatabase::TIBDatabase* FDefaultDatabase;
	TfrxIBXComponents* FOldComponents;
	
protected:
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	void __fastcall SetDefaultDatabase(Ibdatabase::TIBDatabase* Value);
	
public:
	__fastcall virtual TfrxIBXComponents(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TfrxIBXComponents(void);
	virtual System::UnicodeString __fastcall GetDescription(void);
	
__published:
	__property Ibdatabase::TIBDatabase* DefaultDatabase = {read=FDefaultDatabase, write=SetDefaultDatabase};
};


class DELPHICLASS TfrxIBXDatabase;
class PASCALIMPLEMENTATION TfrxIBXDatabase : public Frxclass::TfrxCustomDatabase
{
	typedef Frxclass::TfrxCustomDatabase inherited;
	
private:
	Ibdatabase::TIBDatabase* FDatabase;
	Ibdatabase::TIBTransaction* FTransaction;
	int __fastcall GetSQLDialect(void);
	void __fastcall SetSQLDialect(const int Value);
	
protected:
	virtual void __fastcall SetConnected(bool Value);
	virtual void __fastcall SetDatabaseName(const System::UnicodeString Value);
	virtual void __fastcall SetLoginPrompt(bool Value);
	virtual void __fastcall SetParams(System::Classes::TStrings* Value);
	virtual bool __fastcall GetConnected(void);
	virtual System::UnicodeString __fastcall GetDatabaseName(void);
	virtual bool __fastcall GetLoginPrompt(void);
	virtual System::Classes::TStrings* __fastcall GetParams(void);
	
public:
	__fastcall virtual TfrxIBXDatabase(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TfrxIBXDatabase(void);
	__classmethod virtual System::UnicodeString __fastcall GetDescription();
	virtual void __fastcall SetLogin(const System::UnicodeString Login, const System::UnicodeString Password);
	__property Ibdatabase::TIBDatabase* Database = {read=FDatabase};
	
__published:
	__property DatabaseName = {default=0};
	__property LoginPrompt = {default=1};
	__property Params;
	__property int SQLDialect = {read=GetSQLDialect, write=SetSQLDialect, nodefault};
	__property Connected = {default=0};
public:
	/* TfrxComponent.DesignCreate */ inline __fastcall virtual TfrxIBXDatabase(System::Classes::TComponent* AOwner, System::Word Flags) : Frxclass::TfrxCustomDatabase(AOwner, Flags) { }
	
};


class DELPHICLASS TfrxIBXTable;
class PASCALIMPLEMENTATION TfrxIBXTable : public Frxcustomdb::TfrxCustomTable
{
	typedef Frxcustomdb::TfrxCustomTable inherited;
	
private:
	TfrxIBXDatabase* FDatabase;
	Ibtable::TIBTable* FTable;
	void __fastcall SetDatabase(TfrxIBXDatabase* const Value);
	
protected:
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	virtual void __fastcall SetMaster(Data::Db::TDataSource* const Value);
	virtual void __fastcall SetMasterFields(const System::UnicodeString Value);
	virtual void __fastcall SetIndexFieldNames(const System::UnicodeString Value);
	virtual void __fastcall SetIndexName(const System::UnicodeString Value);
	virtual void __fastcall SetTableName(const System::UnicodeString Value);
	virtual System::UnicodeString __fastcall GetIndexFieldNames(void);
	virtual System::UnicodeString __fastcall GetIndexName(void);
	virtual System::UnicodeString __fastcall GetTableName(void);
	
public:
	__fastcall virtual TfrxIBXTable(System::Classes::TComponent* AOwner);
	__fastcall virtual TfrxIBXTable(System::Classes::TComponent* AOwner, System::Word Flags);
	__classmethod virtual System::UnicodeString __fastcall GetDescription();
	virtual void __fastcall BeforeStartReport(void);
	__property Ibtable::TIBTable* Table = {read=FTable};
	
__published:
	__property TfrxIBXDatabase* Database = {read=FDatabase, write=SetDatabase};
public:
	/* TfrxCustomDataset.Destroy */ inline __fastcall virtual ~TfrxIBXTable(void) { }
	
};


class DELPHICLASS TfrxIBXQuery;
class PASCALIMPLEMENTATION TfrxIBXQuery : public Frxcustomdb::TfrxCustomQuery
{
	typedef Frxcustomdb::TfrxCustomQuery inherited;
	
private:
	TfrxIBXDatabase* FDatabase;
	Ibquery::TIBQuery* FQuery;
	void __fastcall SetDatabase(TfrxIBXDatabase* const Value);
	
protected:
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	virtual void __fastcall SetMaster(Data::Db::TDataSource* const Value);
	virtual void __fastcall SetSQL(System::Classes::TStrings* Value);
	virtual System::Classes::TStrings* __fastcall GetSQL(void);
	
public:
	__fastcall virtual TfrxIBXQuery(System::Classes::TComponent* AOwner);
	__fastcall virtual TfrxIBXQuery(System::Classes::TComponent* AOwner, System::Word Flags);
	__classmethod virtual System::UnicodeString __fastcall GetDescription();
	virtual void __fastcall BeforeStartReport(void);
	virtual void __fastcall UpdateParams(void);
	virtual Fqbclass::TfqbEngine* __fastcall QBEngine(void);
	__property Ibquery::TIBQuery* Query = {read=FQuery};
	
__published:
	__property TfrxIBXDatabase* Database = {read=FDatabase, write=SetDatabase};
public:
	/* TfrxCustomQuery.Destroy */ inline __fastcall virtual ~TfrxIBXQuery(void) { }
	
};


class DELPHICLASS TfrxEngineIBX;
class PASCALIMPLEMENTATION TfrxEngineIBX : public Fqbclass::TfqbEngine
{
	typedef Fqbclass::TfqbEngine inherited;
	
private:
	Ibquery::TIBQuery* FQuery;
	
public:
	__fastcall virtual TfrxEngineIBX(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TfrxEngineIBX(void);
	virtual void __fastcall ReadTableList(System::Classes::TStrings* ATableList);
	virtual void __fastcall ReadFieldList(const System::UnicodeString ATableName, Fqbclass::TfqbFieldList* &AFieldList);
	virtual Data::Db::TDataSet* __fastcall ResultDataSet(void);
	virtual void __fastcall SetSQL(const System::UnicodeString Value);
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE TfrxIBXComponents* IBXComponents;
}	/* namespace Frxibxcomponents */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FRXIBXCOMPONENTS)
using namespace Frxibxcomponents;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// FrxibxcomponentsHPP
