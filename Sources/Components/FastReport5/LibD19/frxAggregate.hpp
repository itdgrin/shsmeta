// CodeGear C++Builder
// Copyright (c) 1995, 2013 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'frxAggregate.pas' rev: 26.00 (Windows)

#ifndef FrxaggregateHPP
#define FrxaggregateHPP

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
#include <Vcl.Dialogs.hpp>	// Pascal unit
#include <frxClass.hpp>	// Pascal unit
#include <System.Variants.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Frxaggregate
{
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TfrxAggregateFunction : unsigned char { agSum, agAvg, agMin, agMax, agCount };

class DELPHICLASS TfrxAggregateItem;
class PASCALIMPLEMENTATION TfrxAggregateItem : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	TfrxAggregateFunction FAggregateFunction;
	Frxclass::TfrxDataBand* FBand;
	bool FCountInvisibleBands;
	bool FDontReset;
	System::UnicodeString FExpression;
	bool FIsPageFooter;
	System::Variant FItemsArray;
	int FItemsCount;
	System::Variant FItemsCountArray;
	System::Variant FItemsValue;
	bool FKeeping;
	int FLastCount;
	System::Variant FLastValue;
	System::UnicodeString FMemoName;
	System::UnicodeString FOriginalName;
	Frxclass::TfrxBand* FParentBand;
	Frxclass::TfrxReport* FReport;
	int FTempItemsCount;
	System::Variant FTempItemsValue;
	int FVColumn;
	
public:
	void __fastcall Calc(void);
	void __fastcall DeleteValue(void);
	void __fastcall Reset(void);
	void __fastcall StartKeep(void);
	void __fastcall EndKeep(void);
	System::Variant __fastcall Value(void);
public:
	/* TObject.Create */ inline __fastcall TfrxAggregateItem(void) : System::TObject() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TfrxAggregateItem(void) { }
	
};


class DELPHICLASS TfrxAggregateList;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TfrxAggregateList : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	TfrxAggregateItem* operator[](int Index) { return Items[Index]; }
	
private:
	System::Classes::TList* FList;
	Frxclass::TfrxReport* FReport;
	TfrxAggregateItem* __fastcall GetItem(int Index);
	void __fastcall FindAggregates(Frxclass::TfrxCustomMemoView* Memo, Frxclass::TfrxDataBand* DataBand);
	void __fastcall ParseName(const System::UnicodeString ComplexName, TfrxAggregateFunction &Func, System::UnicodeString &Expr, Frxclass::TfrxDataBand* &Band, bool &CountInvisible, bool &DontReset);
	__property TfrxAggregateItem* Items[int Index] = {read=GetItem/*, default*/};
	
public:
	__fastcall TfrxAggregateList(Frxclass::TfrxReport* AReport);
	__fastcall virtual ~TfrxAggregateList(void);
	void __fastcall Clear(void);
	void __fastcall ClearValues(void);
	void __fastcall AddItems(Frxclass::TfrxReportPage* Page);
	void __fastcall AddValue(Frxclass::TfrxBand* Band, int VColumn = 0x0);
	void __fastcall DeleteValue(Frxclass::TfrxBand* Band);
	void __fastcall EndKeep(void);
	void __fastcall Reset(Frxclass::TfrxBand* ParentBand);
	void __fastcall StartKeep(void);
	System::Variant __fastcall GetValue(Frxclass::TfrxBand* ParentBand, const System::UnicodeString ComplexName, int VColumn = 0x0)/* overload */;
	System::Variant __fastcall GetValue(Frxclass::TfrxBand* ParentBand, int VColumn, const System::UnicodeString Name, const System::UnicodeString Expression, Frxclass::TfrxBand* Band, int Flags)/* overload */;
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
}	/* namespace Frxaggregate */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FRXAGGREGATE)
using namespace Frxaggregate;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// FrxaggregateHPP
