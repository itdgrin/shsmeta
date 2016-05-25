// CodeGear C++Builder
// Copyright (c) 1995, 2013 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'frxADOComponents.pas' rev: 26.00 (Windows)

#ifndef FrxadocomponentsHPP
#define FrxadocomponentsHPP

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
#include <Data.Win.ADODB.hpp>	// Pascal unit
#include <Winapi.ADOInt.hpp>	// Pascal unit
#include <System.Variants.hpp>	// Pascal unit
#include <fqbClass.hpp>	// Pascal unit
#include <frxDBSet.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Frxadocomponents
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TfrxADOComponents;
class PASCALIMPLEMENTATION TfrxADOComponents : public Frxclass::TfrxDBComponents
{
	typedef Frxclass::TfrxDBComponents inherited;
	
private:
	Data::Win::Adodb::TADOConnection* FDefaultDatabase;
	TfrxADOComponents* FOldComponents;
	
protected:
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	void __fastcall SetDefaultDatabase(Data::Win::Adodb::TADOConnection* Value);
	
public:
	__fastcall virtual TfrxADOComponents(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TfrxADOComponents(void);
	virtual System::UnicodeString __fastcall GetDescription(void);
	
__published:
	__property Data::Win::Adodb::TADOConnection* DefaultDatabase = {read=FDefaultDatabase, write=SetDefaultDatabase};
};


class DELPHICLASS TfrxADODatabase;
class PASCALIMPLEMENTATION TfrxADODatabase : public Frxclass::TfrxCustomDatabase
{
	typedef Frxclass::TfrxCustomDatabase inherited;
	
private:
	Data::Win::Adodb::TADOConnection* FDatabase;
	
protected:
	virtual void __fastcall SetConnected(bool Value);
	virtual void __fastcall SetDatabaseName(const System::UnicodeString Value);
	virtual void __fastcall SetLoginPrompt(bool Value);
	virtual bool __fastcall GetConnected(void);
	virtual System::UnicodeString __fastcall GetDatabaseName(void);
	virtual bool __fastcall GetLoginPrompt(void);
	void __fastcall ADOBeforeConnect(System::TObject* Sende);
	void __fastcall ADOAfterDisconnect(System::TObject* Sende);
	
public:
	__fastcall virtual TfrxADODatabase(System::Classes::TComponent* AOwner);
	__classmethod virtual System::UnicodeString __fastcall GetDescription();
	virtual void __fastcall SetLogin(const System::UnicodeString Login, const System::UnicodeString Password);
	virtual System::WideString __fastcall ToString(void);
	virtual void __fastcall FromString(const System::WideString Connection);
	__property Data::Win::Adodb::TADOConnection* Database = {read=FDatabase};
	
__published:
	__property DatabaseName = {default=0};
	__property LoginPrompt = {default=1};
	__property Connected = {default=0};
public:
	/* TfrxDialogComponent.Destroy */ inline __fastcall virtual ~TfrxADODatabase(void) { }
	
public:
	/* TfrxComponent.DesignCreate */ inline __fastcall virtual TfrxADODatabase(System::Classes::TComponent* AOwner, System::Word Flags) : Frxclass::TfrxCustomDatabase(AOwner, Flags) { }
	
};


class DELPHICLASS TfrxADOTable;
class PASCALIMPLEMENTATION TfrxADOTable : public Frxcustomdb::TfrxCustomTable
{
	typedef Frxcustomdb::TfrxCustomTable inherited;
	
private:
	TfrxADODatabase* FDatabase;
	Data::Win::Adodb::TADOTable* FTable;
	void __fastcall SetDatabase(TfrxADODatabase* Value);
	
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
	__fastcall virtual TfrxADOTable(System::Classes::TComponent* AOwner);
	__fastcall virtual TfrxADOTable(System::Classes::TComponent* AOwner, System::Word Flags);
	__classmethod virtual System::UnicodeString __fastcall GetDescription();
	virtual void __fastcall BeforeStartReport(void);
	__property Data::Win::Adodb::TADOTable* Table = {read=FTable};
	
__published:
	__property TfrxADODatabase* Database = {read=FDatabase, write=SetDatabase};
public:
	/* TfrxCustomDataset.Destroy */ inline __fastcall virtual ~TfrxADOTable(void) { }
	
};


class DELPHICLASS TfrxADOQuery;
class PASCALIMPLEMENTATION TfrxADOQuery : public Frxcustomdb::TfrxCustomQuery
{
	typedef Frxcustomdb::TfrxCustomQuery inherited;
	
private:
	TfrxADODatabase* FDatabase;
	Data::Win::Adodb::TADOQuery* FQuery;
	System::Classes::TStrings* FStrings;
	bool FLock;
	void __fastcall SetDatabase(TfrxADODatabase* Value);
	int __fastcall GetCommandTimeout(void);
	void __fastcall SetCommandTimeout(const int Value);
	Data::Win::Adodb::TADOLockType __fastcall GetLockType(void);
	void __fastcall SetLockType(const Data::Win::Adodb::TADOLockType Value);
	
protected:
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	virtual void __fastcall OnChangeSQL(System::TObject* Sender);
	virtual void __fastcall SetMaster(Data::Db::TDataSource* const Value);
	virtual void __fastcall SetSQL(System::Classes::TStrings* Value);
	virtual System::Classes::TStrings* __fastcall GetSQL(void);
	
public:
	__fastcall virtual TfrxADOQuery(System::Classes::TComponent* AOwner);
	__fastcall virtual TfrxADOQuery(System::Classes::TComponent* AOwner, System::Word Flags);
	__fastcall virtual ~TfrxADOQuery(void);
	__classmethod virtual System::UnicodeString __fastcall GetDescription();
	virtual void __fastcall BeforeStartReport(void);
	virtual void __fastcall UpdateParams(void);
	virtual Fqbclass::TfqbEngine* __fastcall QBEngine(void);
	__property Data::Win::Adodb::TADOQuery* Query = {read=FQuery};
	
__published:
	__property int CommandTimeout = {read=GetCommandTimeout, write=SetCommandTimeout, nodefault};
	__property TfrxADODatabase* Database = {read=FDatabase, write=SetDatabase};
	__property Data::Win::Adodb::TADOLockType LockType = {read=GetLockType, write=SetLockType, nodefault};
};


class DELPHICLASS TfrxEngineADO;
class PASCALIMPLEMENTATION TfrxEngineADO : public Fqbclass::TfqbEngine
{
	typedef Fqbclass::TfqbEngine inherited;
	
private:
	Data::Win::Adodb::TADOQuery* FQuery;
	
public:
	__fastcall virtual TfrxEngineADO(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TfrxEngineADO(void);
	virtual void __fastcall ReadTableList(System::Classes::TStrings* ATableList);
	virtual void __fastcall ReadFieldList(const System::UnicodeString ATableName, Fqbclass::TfqbFieldList* &AFieldList);
	virtual Data::Db::TDataSet* __fastcall ResultDataSet(void);
	virtual void __fastcall SetSQL(const System::UnicodeString Value);
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE TfrxADOComponents* ADOComponents;
extern DELPHI_PACKAGE void __fastcall frxParamsToTParameters(Frxcustomdb::TfrxCustomQuery* Query, Data::Win::Adodb::TParameters* Params);
extern DELPHI_PACKAGE void __fastcall frxADOGetTableNames(Data::Win::Adodb::TADOConnection* conADO, System::Classes::TStrings* List, bool SystemTables);
}	/* namespace Frxadocomponents */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FRXADOCOMPONENTS)
using namespace Frxadocomponents;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// FrxadocomponentsHPP
