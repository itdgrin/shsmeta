// CodeGear C++Builder
// Copyright (c) 1995, 2013 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'frxPreviewPages.pas' rev: 26.00 (Windows)

#ifndef FrxpreviewpagesHPP
#define FrxpreviewpagesHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <Winapi.Windows.hpp>	// Pascal unit
#include <Winapi.Messages.hpp>	// Pascal unit
#include <System.Types.hpp>	// Pascal unit
#include <System.SysUtils.hpp>	// Pascal unit
#include <System.Classes.hpp>	// Pascal unit
#include <Vcl.Graphics.hpp>	// Pascal unit
#include <Vcl.Controls.hpp>	// Pascal unit
#include <Vcl.Forms.hpp>	// Pascal unit
#include <Vcl.Dialogs.hpp>	// Pascal unit
#include <frxClass.hpp>	// Pascal unit
#include <frxXML.hpp>	// Pascal unit
#include <frxPictureCache.hpp>	// Pascal unit
#include <System.Variants.hpp>	// Pascal unit
#include <System.UITypes.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Frxpreviewpages
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TfrxOutline;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TfrxOutline : public Frxclass::TfrxCustomOutline
{
	typedef Frxclass::TfrxCustomOutline inherited;
	
protected:
	virtual int __fastcall GetCount(void);
	
public:
	Frxxml::TfrxXMLItem* __fastcall Root(void);
	virtual void __fastcall AddItem(const System::UnicodeString Text, int Top);
	virtual void __fastcall LevelDown(int Index);
	virtual void __fastcall LevelRoot(void);
	virtual void __fastcall LevelUp(void);
	virtual void __fastcall GetItem(int Index, System::UnicodeString &Text, int &Page, int &Top);
	virtual void __fastcall ShiftItems(Frxxml::TfrxXMLItem* From, int NewTop);
	virtual Frxxml::TfrxXMLItem* __fastcall GetCurPosition(void);
public:
	/* TfrxCustomOutline.Create */ inline __fastcall virtual TfrxOutline(Frxclass::TfrxCustomPreviewPages* APreviewPages) : Frxclass::TfrxCustomOutline(APreviewPages) { }
	
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TfrxOutline(void) { }
	
};

#pragma pack(pop)

class DELPHICLASS TfrxDictionary;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TfrxDictionary : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	System::Classes::TStringList* FNames;
	System::Classes::TStringList* FSourceNames;
	
public:
	__fastcall TfrxDictionary(void);
	__fastcall virtual ~TfrxDictionary(void);
	void __fastcall Add(const System::UnicodeString Name, const System::UnicodeString SourceName, System::TObject* Obj);
	void __fastcall Clear(void);
	System::UnicodeString __fastcall AddUnique(const System::UnicodeString Base, const System::UnicodeString SourceName, System::TObject* Obj);
	System::UnicodeString __fastcall CreateUniqueName(const System::UnicodeString Base);
	System::UnicodeString __fastcall GetSourceName(const System::UnicodeString Name);
	System::TObject* __fastcall GetObject(const System::UnicodeString Name);
	__property System::Classes::TStringList* Names = {read=FNames};
	__property System::Classes::TStringList* SourceNames = {read=FSourceNames};
};

#pragma pack(pop)

class DELPHICLASS TfrxPreviewPages;
class PASCALIMPLEMENTATION TfrxPreviewPages : public Frxclass::TfrxCustomPreviewPages
{
	typedef Frxclass::TfrxCustomPreviewPages inherited;
	
private:
	bool FAllowPartialLoading;
	int FCopyNo;
	TfrxDictionary* FDictionary;
	int FFirstObjectIndex;
	int FFirstPageIndex;
	int FFirstOutlineIndex;
	int FLogicalPageN;
	System::Classes::TStringList* FPageCache;
	Frxxml::TfrxXMLItem* FPagesItem;
	Frxpicturecache::TfrxPictureCache* FPictureCache;
	System::Extended FPrintScale;
	System::Classes::TList* FSourcePages;
	System::Classes::TStream* FTempStream;
	Frxxml::TfrxXMLDocument* FXMLDoc;
	int FXMLSize;
	System::Extended FLastY;
	Frxclass::TfrxView* FLastObjectOver;
	void __fastcall AfterLoad(void);
	void __fastcall BeforeSave(void);
	void __fastcall ClearPageCache(void);
	void __fastcall ClearSourcePages(void);
	Frxxml::TfrxXMLItem* __fastcall CurXMLPage(void);
	Frxclass::TfrxComponent* __fastcall GetObject(const System::UnicodeString Name);
	void __fastcall DoLoadFromStream(void);
	void __fastcall DoSaveToStream(void);
	
protected:
	virtual int __fastcall GetCount(void);
	virtual Frxclass::TfrxReportPage* __fastcall GetPage(int Index);
	virtual System::Types::TPoint __fastcall GetPageSize(int Index);
	
public:
	__fastcall virtual TfrxPreviewPages(Frxclass::TfrxReport* AReport);
	__fastcall virtual ~TfrxPreviewPages(void);
	virtual void __fastcall Clear(void);
	virtual void __fastcall Initialize(void);
	void __fastcall AddAnchor(const System::UnicodeString Text);
	virtual void __fastcall AddObject(Frxclass::TfrxComponent* Obj);
	virtual void __fastcall AddPage(Frxclass::TfrxReportPage* Page);
	virtual void __fastcall AddPicture(Frxclass::TfrxPictureView* Picture);
	virtual void __fastcall AddSourcePage(Frxclass::TfrxReportPage* Page);
	virtual void __fastcall AddToSourcePage(Frxclass::TfrxComponent* Obj);
	virtual void __fastcall BeginPass(void);
	virtual void __fastcall ClearFirstPassPages(void);
	virtual void __fastcall CutObjects(int APosition);
	virtual void __fastcall Finish(void);
	virtual void __fastcall IncLogicalPageNumber(void);
	virtual void __fastcall ResetLogicalPageNumber(void);
	virtual void __fastcall PasteObjects(System::Extended X, System::Extended Y);
	virtual void __fastcall ShiftAnchors(int From, int NewTop);
	void __fastcall UpdatePageDimensions(Frxclass::TfrxReportPage* Page, System::Extended Width, System::Extended Height);
	virtual bool __fastcall BandExists(Frxclass::TfrxBand* Band);
	Frxxml::TfrxXMLItem* __fastcall FindAnchor(const System::UnicodeString Text);
	int __fastcall GetAnchorPage(const System::UnicodeString Text);
	virtual int __fastcall GetAnchorCurPosition(void);
	virtual int __fastcall GetCurPosition(void);
	virtual System::Extended __fastcall GetLastY(System::Extended ColumnPosition = 0.000000E+00);
	virtual int __fastcall GetLogicalPageNo(void);
	virtual int __fastcall GetLogicalTotalPages(void);
	virtual void __fastcall DrawPage(int Index, Vcl::Graphics::TCanvas* Canvas, System::Extended ScaleX, System::Extended ScaleY, System::Extended OffsetX, System::Extended OffsetY);
	virtual void __fastcall AddEmptyPage(int Index);
	virtual void __fastcall DeletePage(int Index);
	virtual void __fastcall ModifyPage(int Index, Frxclass::TfrxReportPage* Page);
	virtual void __fastcall AddFrom(Frxclass::TfrxReport* Report);
	virtual void __fastcall LoadFromStream(System::Classes::TStream* Stream, bool AllowPartialLoading = false);
	virtual void __fastcall SaveToStream(System::Classes::TStream* Stream);
	virtual bool __fastcall LoadFromFile(const System::UnicodeString FileName, bool ExceptionIfNotFound = false);
	virtual void __fastcall SaveToFile(const System::UnicodeString FileName);
	virtual bool __fastcall Print(void);
	virtual bool __fastcall Export(Frxclass::TfrxCustomExportFilter* Filter);
	virtual void __fastcall ObjectOver(int Index, int X, int Y, System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, System::Extended Scale, System::Extended OffsetX, System::Extended OffsetY, System::Uitypes::TCursor &Cursor, Frxclass::TfrxMouseIntEvents MouseEvent);
	__property System::Classes::TList* SourcePages = {read=FSourcePages};
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Frxpreviewpages */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FRXPREVIEWPAGES)
using namespace Frxpreviewpages;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// FrxpreviewpagesHPP
