// CodeGear C++Builder
// Copyright (c) 1995, 2013 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'frxEngine.pas' rev: 26.00 (Windows)

#ifndef FrxengineHPP
#define FrxengineHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.SysUtils.hpp>	// Pascal unit
#include <Winapi.Windows.hpp>	// Pascal unit
#include <Winapi.Messages.hpp>	// Pascal unit
#include <System.Types.hpp>	// Pascal unit
#include <System.Classes.hpp>	// Pascal unit
#include <Vcl.Graphics.hpp>	// Pascal unit
#include <Vcl.Controls.hpp>	// Pascal unit
#include <Vcl.Forms.hpp>	// Pascal unit
#include <Vcl.Dialogs.hpp>	// Pascal unit
#include <frxClass.hpp>	// Pascal unit
#include <frxAggregate.hpp>	// Pascal unit
#include <frxXML.hpp>	// Pascal unit
#include <frxDMPClass.hpp>	// Pascal unit
#include <System.Variants.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Frxengine
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TfrxHeaderListItem;
class PASCALIMPLEMENTATION TfrxHeaderListItem : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	Frxclass::TfrxBand* Band;
	System::Extended Left;
	bool IsInKeepList;
public:
	/* TObject.Create */ inline __fastcall TfrxHeaderListItem(void) : System::TObject() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TfrxHeaderListItem(void) { }
	
};


class DELPHICLASS TfrxHeaderList;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TfrxHeaderList : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	TfrxHeaderListItem* operator[](int Index) { return Items[Index]; }
	
private:
	System::Classes::TList* FList;
	int __fastcall GetCount(void);
	TfrxHeaderListItem* __fastcall GetItems(int Index);
	
public:
	__fastcall TfrxHeaderList(void);
	__fastcall virtual ~TfrxHeaderList(void);
	void __fastcall Clear(void);
	void __fastcall AddItem(Frxclass::TfrxBand* ABand, System::Extended ALeft, bool AInKeepList);
	void __fastcall RemoveItem(Frxclass::TfrxBand* ABand);
	__property int Count = {read=GetCount, nodefault};
	__property TfrxHeaderListItem* Items[int Index] = {read=GetItems/*, default*/};
};

#pragma pack(pop)

class DELPHICLASS TfrxEngine;
class PASCALIMPLEMENTATION TfrxEngine : public Frxclass::TfrxCustomEngine
{
	typedef Frxclass::TfrxCustomEngine inherited;
	
private:
	Frxaggregate::TfrxAggregateList* FAggregates;
	bool FCallFromAddPage;
	bool FCallFromEndPage;
	Frxclass::TfrxBand* FCurBand;
	Frxclass::TfrxBand* FLastBandOnPage;
	bool FDontShowHeaders;
	TfrxHeaderList* FHeaderList;
	bool FFirstReportPage;
	System::Extended FFirstColumnY;
	bool FIsFirstBand;
	bool FIsFirstPage;
	bool FIsLastPage;
	bool FTitlePrinted;
	System::Classes::TStrings* FHBandNamesTree;
	Frxclass::TfrxBand* FKeepBand;
	bool FKeepFooter;
	bool FKeeping;
	bool FKeepHeader;
	System::Extended FKeepCurY;
	System::Extended FPrevFooterHeight;
	Frxxml::TfrxXMLItem* FKeepOutline;
	int FKeepPosition;
	int FKeepAnchor;
	bool FCallFromPHeader;
	Frxclass::TfrxNullBand* FOutputTo;
	Frxclass::TfrxReportPage* FPage;
	System::Extended FPageCurX;
	Frxclass::TfrxBand* FStartNewPageBand;
	System::Classes::TList* FVHeaderList;
	Frxclass::TfrxBand* FVMasterBand;
	System::Classes::TList* FVPageList;
	void __fastcall AddBandOutline(Frxclass::TfrxBand* Band);
	void __fastcall AddColumn(void);
	void __fastcall AddPage(void);
	void __fastcall AddPageOutline(void);
	void __fastcall AddToHeaderList(Frxclass::TfrxBand* Band);
	void __fastcall AddToVHeaderList(Frxclass::TfrxBand* Band);
	void __fastcall CheckBandColumns(Frxclass::TfrxDataBand* Band, int ColumnKeepPos, System::Extended SaveCurY);
	void __fastcall CheckDrill(Frxclass::TfrxDataBand* Master, Frxclass::TfrxGroupHeader* Band);
	void __fastcall CheckGroups(Frxclass::TfrxDataBand* Master, Frxclass::TfrxGroupHeader* Band, int ColumnKeepPos, System::Extended SaveCurY);
	void __fastcall CheckSubReports(Frxclass::TfrxBand* Band);
	void __fastcall CheckSuppress(Frxclass::TfrxBand* Band);
	void __fastcall DoShow(Frxclass::TfrxBand* Band);
	void __fastcall DrawSplit(Frxclass::TfrxBand* Band);
	void __fastcall EndColumn(void);
	void __fastcall EndKeep(Frxclass::TfrxBand* Band);
	void __fastcall InitGroups(Frxclass::TfrxDataBand* Master, Frxclass::TfrxGroupHeader* Band, int Index, bool ResetLineN = false);
	void __fastcall InitPage(void);
	void __fastcall NotifyObjects(Frxclass::TfrxBand* Band);
	void __fastcall OutlineRoot(void);
	void __fastcall OutlineUp(Frxclass::TfrxBand* Band);
	void __fastcall PreparePage(System::Classes::TStrings* ErrorList, bool PrepareVBands);
	void __fastcall PrepareShiftTree(Frxclass::TfrxBand* Band);
	void __fastcall RemoveFromHeaderList(Frxclass::TfrxBand* Band);
	void __fastcall RemoveFromVHeaderList(Frxclass::TfrxBand* Band);
	void __fastcall ResetSuppressValues(Frxclass::TfrxBand* Band);
	void __fastcall RunPage(Frxclass::TfrxReportPage* Page);
	void __fastcall RunReportPages(Frxclass::TfrxReportPage* APage);
	void __fastcall ShowGroupFooters(Frxclass::TfrxGroupHeader* Band, int Index, Frxclass::TfrxDataBand* Master);
	void __fastcall ShowVBands(Frxclass::TfrxBand* HBand);
	void __fastcall StartKeep(Frxclass::TfrxBand* Band, int Position = 0x0);
	void __fastcall Stretch(Frxclass::TfrxBand* Band);
	void __fastcall UnStretch(Frxclass::TfrxBand* Band);
	bool __fastcall CanShow(System::TObject* Obj, bool PrintIfDetailEmpty);
	Frxclass::TfrxBand* __fastcall FindBand(Frxclass::TfrxBandClass Band);
	bool __fastcall RunDialogs(void);
	
protected:
	virtual System::Extended __fastcall GetPageHeight(void);
	
public:
	__fastcall virtual TfrxEngine(Frxclass::TfrxReport* AReport);
	__fastcall virtual ~TfrxEngine(void);
	virtual void __fastcall EndPage(void);
	virtual void __fastcall NewColumn(void);
	virtual void __fastcall NewPage(void);
	virtual bool __fastcall Run(bool ARunDialogs, bool AClearLast = false, Frxclass::TfrxPage* APage = (Frxclass::TfrxPage*)(0x0));
	virtual void __fastcall ShowBand(Frxclass::TfrxBand* Band)/* overload */;
	virtual void __fastcall ShowBand(Frxclass::TfrxBandClass Band)/* overload */;
	virtual System::Extended __fastcall HeaderHeight(void);
	virtual System::Extended __fastcall FooterHeight(void);
	virtual System::Extended __fastcall FreeSpace(void);
	virtual void __fastcall BreakAllKeep(void);
	virtual System::Variant __fastcall GetAggregateValue(const System::UnicodeString Name, const System::UnicodeString Expression, Frxclass::TfrxBand* Band, int Flags);
	bool __fastcall Initialize(void);
	void __fastcall Finalize(void);
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Frxengine */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FRXENGINE)
using namespace Frxengine;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// FrxengineHPP
