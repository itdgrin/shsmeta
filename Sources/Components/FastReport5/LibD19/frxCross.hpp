// CodeGear C++Builder
// Copyright (c) 1995, 2013 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'frxCross.pas' rev: 26.00 (Windows)

#ifndef FrxcrossHPP
#define FrxcrossHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <Winapi.Windows.hpp>	// Pascal unit
#include <System.Types.hpp>	// Pascal unit
#include <System.SysUtils.hpp>	// Pascal unit
#include <System.Classes.hpp>	// Pascal unit
#include <Vcl.Controls.hpp>	// Pascal unit
#include <Vcl.Graphics.hpp>	// Pascal unit
#include <Vcl.Forms.hpp>	// Pascal unit
#include <frxClass.hpp>	// Pascal unit
#include <System.Variants.hpp>	// Pascal unit
#include <System.UITypes.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Frxcross
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TfrxCrossObject;
class PASCALIMPLEMENTATION TfrxCrossObject : public System::Classes::TComponent
{
	typedef System::Classes::TComponent inherited;
	
public:
	/* TComponent.Create */ inline __fastcall virtual TfrxCrossObject(System::Classes::TComponent* AOwner) : System::Classes::TComponent(AOwner) { }
	/* TComponent.Destroy */ inline __fastcall virtual ~TfrxCrossObject(void) { }
	
};


typedef System::UnicodeString TfrxPrintCellEvent;

typedef System::UnicodeString TfrxPrintHeaderEvent;

typedef System::UnicodeString TfrxCalcWidthEvent;

typedef System::UnicodeString TfrxCalcHeightEvent;

typedef void __fastcall (__closure *TfrxOnPrintCellEvent)(Frxclass::TfrxCustomMemoView* Memo, int RowIndex, int ColumnIndex, int CellIndex, const System::Variant &RowValues, const System::Variant &ColumnValues, const System::Variant &Value);

typedef void __fastcall (__closure *TfrxOnPrintHeaderEvent)(Frxclass::TfrxCustomMemoView* Memo, const System::Variant &HeaderIndexes, const System::Variant &HeaderValues, const System::Variant &Value);

typedef void __fastcall (__closure *TfrxOnCalcWidthEvent)(int ColumnIndex, const System::Variant &ColumnValues, System::Extended &Width);

typedef void __fastcall (__closure *TfrxOnCalcHeightEvent)(int RowIndex, const System::Variant &RowValues, System::Extended &Height);

struct TfrxCrossCell;
typedef TfrxCrossCell *PfrCrossCell;

#pragma pack(push,1)
struct DECLSPEC_DRECORD TfrxCrossCell
{
public:
	System::Variant Value;
	int Count;
	TfrxCrossCell *Next;
};
#pragma pack(pop)


enum DECLSPEC_DENUM TfrxCrossSortOrder : unsigned char { soAscending, soDescending, soNone, soGrouping };

enum DECLSPEC_DENUM TfrxCrossFunction : unsigned char { cfNone, cfSum, cfMin, cfMax, cfAvg, cfCount };

typedef System::DynamicArray<System::Variant> TfrxVariantArray;

typedef System::StaticArray<TfrxCrossSortOrder, 32> TfrxSortArray;

class DELPHICLASS TfrxIndexItem;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TfrxIndexItem : public System::Classes::TCollectionItem
{
	typedef System::Classes::TCollectionItem inherited;
	
private:
	TfrxVariantArray FIndexes;
	
public:
	__fastcall virtual ~TfrxIndexItem(void);
	__property TfrxVariantArray Indexes = {read=FIndexes, write=FIndexes};
public:
	/* TCollectionItem.Create */ inline __fastcall virtual TfrxIndexItem(System::Classes::TCollection* Collection) : System::Classes::TCollectionItem(Collection) { }
	
};

#pragma pack(pop)

class DELPHICLASS TfrxIndexCollection;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TfrxIndexCollection : public System::Classes::TCollection
{
	typedef System::Classes::TCollection inherited;
	
public:
	TfrxIndexItem* operator[](int Index) { return Items[Index]; }
	
private:
	int FIndexesCount;
	TfrxSortArray FSortOrder;
	TfrxIndexItem* __fastcall GetItems(int Index);
	
public:
	bool __fastcall Find(System::Variant const *Indexes, const int Indexes_Size, int &Index);
	HIDESBASE virtual TfrxIndexItem* __fastcall InsertItem(int Index, System::Variant const *Indexes, const int Indexes_Size);
	__property TfrxIndexItem* Items[int Index] = {read=GetItems/*, default*/};
public:
	/* TCollection.Create */ inline __fastcall TfrxIndexCollection(System::Classes::TCollectionItemClass ItemClass) : System::Classes::TCollection(ItemClass) { }
	/* TCollection.Destroy */ inline __fastcall virtual ~TfrxIndexCollection(void) { }
	
};

#pragma pack(pop)

class DELPHICLASS TfrxCrossRow;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TfrxCrossRow : public TfrxIndexItem
{
	typedef TfrxIndexItem inherited;
	
private:
	int FCellLevels;
	System::Classes::TList* FCells;
	void __fastcall CreateCell(int Index);
	
public:
	__fastcall virtual TfrxCrossRow(System::Classes::TCollection* Collection);
	__fastcall virtual ~TfrxCrossRow(void);
	PfrCrossCell __fastcall GetCell(int Index);
	System::Variant __fastcall GetCellValue(int Index1, int Index2);
	void __fastcall SetCellValue(int Index1, int Index2, const System::Variant &Value);
};

#pragma pack(pop)

class DELPHICLASS TfrxCrossRows;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TfrxCrossRows : public TfrxIndexCollection
{
	typedef TfrxIndexCollection inherited;
	
public:
	TfrxCrossRow* operator[](int Index) { return Items[Index]; }
	
private:
	int FCellLevels;
	HIDESBASE TfrxCrossRow* __fastcall GetItems(int Index);
	
public:
	__fastcall TfrxCrossRows(void);
	virtual TfrxIndexItem* __fastcall InsertItem(int Index, System::Variant const *Indexes, const int Indexes_Size);
	TfrxCrossRow* __fastcall Row(System::Variant const *Indexes, const int Indexes_Size);
	__property TfrxCrossRow* Items[int Index] = {read=GetItems/*, default*/};
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TfrxCrossRows(void) { }
	
};

#pragma pack(pop)

class DELPHICLASS TfrxCrossColumn;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TfrxCrossColumn : public TfrxIndexItem
{
	typedef TfrxIndexItem inherited;
	
private:
	int FCellIndex;
	
public:
	__property int CellIndex = {read=FCellIndex, write=FCellIndex, nodefault};
public:
	/* TfrxIndexItem.Destroy */ inline __fastcall virtual ~TfrxCrossColumn(void) { }
	
public:
	/* TCollectionItem.Create */ inline __fastcall virtual TfrxCrossColumn(System::Classes::TCollection* Collection) : TfrxIndexItem(Collection) { }
	
};

#pragma pack(pop)

class DELPHICLASS TfrxCrossColumns;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TfrxCrossColumns : public TfrxIndexCollection
{
	typedef TfrxIndexCollection inherited;
	
public:
	TfrxCrossColumn* operator[](int Index) { return Items[Index]; }
	
private:
	HIDESBASE TfrxCrossColumn* __fastcall GetItems(int Index);
	
public:
	__fastcall TfrxCrossColumns(void);
	TfrxCrossColumn* __fastcall Column(System::Variant const *Indexes, const int Indexes_Size);
	virtual TfrxIndexItem* __fastcall InsertItem(int Index, System::Variant const *Indexes, const int Indexes_Size);
	__property TfrxCrossColumn* Items[int Index] = {read=GetItems/*, default*/};
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TfrxCrossColumns(void) { }
	
};

#pragma pack(pop)

class DELPHICLASS TfrxCrossHeader;
class PASCALIMPLEMENTATION TfrxCrossHeader : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	TfrxCrossHeader* operator[](int Index) { return Items[Index]; }
	
private:
	Frxclass::TfrxRect FBounds;
	System::Classes::TList* FMemos;
	System::Classes::TList* FTotalMemos;
	TfrxVariantArray FCounts;
	int FCellIndex;
	int FCellLevels;
	TfrxVariantArray FFuncValues;
	bool FHasCellHeaders;
	int FIndex;
	bool FIsCellHeader;
	bool FIsIndex;
	bool FIsTotal;
	System::Classes::TList* FItems;
	int FLevelsCount;
	Frxclass::TfrxCustomMemoView* FMemo;
	bool FNoLevels;
	TfrxCrossHeader* FParent;
	Frxclass::TfrxPoint FSize;
	int FTotalIndex;
	System::Variant FValue;
	bool FVisible;
	int FDefaultHeight;
	TfrxCrossHeader* __fastcall AddCellHeader(System::Classes::TList* Memos, int Index, int CellIndex);
	TfrxCrossHeader* __fastcall AddChild(Frxclass::TfrxCustomMemoView* Memo);
	void __fastcall AddFuncValues(System::Variant const *Values, const int Values_Size, System::Variant const *Counts, const int Counts_Size, TfrxCrossFunction const *CellFunctions, const int CellFunctions_Size);
	void __fastcall AddValues(System::Variant const *Values, const int Values_Size, bool Unsorted);
	void __fastcall Reset(TfrxCrossFunction const *CellFunctions, const int CellFunctions_Size);
	int __fastcall GetCount(void);
	TfrxCrossHeader* __fastcall GetItems(int Index);
	int __fastcall GetLevel(void);
	System::Extended __fastcall GetHeight(void);
	System::Extended __fastcall GetWidth(void);
	
public:
	__fastcall TfrxCrossHeader(int CellLevels);
	__fastcall virtual ~TfrxCrossHeader(void);
	virtual void __fastcall CalcBounds(void) = 0 ;
	virtual void __fastcall CalcSizes(int MaxWidth, int MinWidth, bool AutoSize) = 0 ;
	System::Classes::TList* __fastcall AllItems(void);
	int __fastcall Find(const System::Variant &Value);
	System::Variant __fastcall GetIndexes(void);
	System::Variant __fastcall GetValues(void);
	System::Classes::TList* __fastcall TerminalItems(void);
	System::Classes::TList* __fastcall IndexItems(void);
	__property Frxclass::TfrxRect Bounds = {read=FBounds, write=FBounds};
	__property int Count = {read=GetCount, nodefault};
	__property bool HasCellHeaders = {read=FHasCellHeaders, write=FHasCellHeaders, nodefault};
	__property System::Extended Height = {read=GetHeight};
	__property bool IsTotal = {read=FIsTotal, nodefault};
	__property TfrxCrossHeader* Items[int Index] = {read=GetItems/*, default*/};
	__property int Level = {read=GetLevel, nodefault};
	__property Frxclass::TfrxCustomMemoView* Memo = {read=FMemo};
	__property TfrxCrossHeader* Parent = {read=FParent};
	__property System::Variant Value = {read=FValue, write=FValue};
	__property bool Visible = {read=FVisible, write=FVisible, nodefault};
	__property System::Extended Width = {read=GetWidth};
	__property int DefaultHeight = {read=FDefaultHeight, write=FDefaultHeight, nodefault};
};


class DELPHICLASS TfrxCrossColumnHeader;
class PASCALIMPLEMENTATION TfrxCrossColumnHeader : public TfrxCrossHeader
{
	typedef TfrxCrossHeader inherited;
	
private:
	TfrxCrossHeader* FCorner;
	
public:
	virtual void __fastcall CalcBounds(void);
	virtual void __fastcall CalcSizes(int MaxWidth, int MinWidth, bool AutoSize);
public:
	/* TfrxCrossHeader.Create */ inline __fastcall TfrxCrossColumnHeader(int CellLevels) : TfrxCrossHeader(CellLevels) { }
	/* TfrxCrossHeader.Destroy */ inline __fastcall virtual ~TfrxCrossColumnHeader(void) { }
	
};


class DELPHICLASS TfrxCrossRowHeader;
class PASCALIMPLEMENTATION TfrxCrossRowHeader : public TfrxCrossHeader
{
	typedef TfrxCrossHeader inherited;
	
private:
	TfrxCrossHeader* FCorner;
	
public:
	virtual void __fastcall CalcBounds(void);
	virtual void __fastcall CalcSizes(int MaxWidth, int MinWidth, bool AutoSize);
public:
	/* TfrxCrossHeader.Create */ inline __fastcall TfrxCrossRowHeader(int CellLevels) : TfrxCrossHeader(CellLevels) { }
	/* TfrxCrossHeader.Destroy */ inline __fastcall virtual ~TfrxCrossRowHeader(void) { }
	
};


class DELPHICLASS TfrxCrossCorner;
class PASCALIMPLEMENTATION TfrxCrossCorner : public TfrxCrossColumnHeader
{
	typedef TfrxCrossColumnHeader inherited;
	
public:
	/* TfrxCrossHeader.Create */ inline __fastcall TfrxCrossCorner(int CellLevels) : TfrxCrossColumnHeader(CellLevels) { }
	/* TfrxCrossHeader.Destroy */ inline __fastcall virtual ~TfrxCrossCorner(void) { }
	
};


class DELPHICLASS TfrxCutBandItem;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TfrxCutBandItem : public System::Classes::TCollectionItem
{
	typedef System::Classes::TCollectionItem inherited;
	
public:
	Frxclass::TfrxBand* Band;
	int FromIndex;
	int ToIndex;
	__fastcall virtual ~TfrxCutBandItem(void);
public:
	/* TCollectionItem.Create */ inline __fastcall virtual TfrxCutBandItem(System::Classes::TCollection* Collection) : System::Classes::TCollectionItem(Collection) { }
	
};

#pragma pack(pop)

class DELPHICLASS TfrxCutBands;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TfrxCutBands : public System::Classes::TCollection
{
	typedef System::Classes::TCollection inherited;
	
public:
	TfrxCutBandItem* operator[](int Index) { return Items[Index]; }
	
private:
	TfrxCutBandItem* __fastcall GetItems(int Index);
	
public:
	__fastcall TfrxCutBands(void);
	HIDESBASE void __fastcall Add(Frxclass::TfrxBand* ABand, int AFromIndex, int AToIndex);
	__property TfrxCutBandItem* Items[int Index] = {read=GetItems/*, default*/};
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TfrxCutBands(void) { }
	
};

#pragma pack(pop)

class DELPHICLASS TfrxGridLineItem;
class PASCALIMPLEMENTATION TfrxGridLineItem : public System::Classes::TCollectionItem
{
	typedef System::Classes::TCollectionItem inherited;
	
public:
	System::Extended Coord;
	System::Classes::TList* Objects;
	__fastcall virtual TfrxGridLineItem(System::Classes::TCollection* Collection);
	__fastcall virtual ~TfrxGridLineItem(void);
};


class DELPHICLASS TfrxGridLines;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TfrxGridLines : public System::Classes::TCollection
{
	typedef System::Classes::TCollection inherited;
	
public:
	TfrxGridLineItem* operator[](int Index) { return Items[Index]; }
	
private:
	TfrxGridLineItem* __fastcall GetItems(int Index);
	
public:
	__fastcall TfrxGridLines(void);
	HIDESBASE void __fastcall Add(System::TObject* AObj, System::Extended ACoord);
	__property TfrxGridLineItem* Items[int Index] = {read=GetItems/*, default*/};
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TfrxGridLines(void) { }
	
};

#pragma pack(pop)

class DELPHICLASS TfrxCustomCrossView;
class PASCALIMPLEMENTATION TfrxCustomCrossView : public Frxclass::TfrxView
{
	typedef Frxclass::TfrxView inherited;
	
private:
	System::Extended FAddHeight;
	System::Extended FAddWidth;
	bool FAllowDuplicates;
	bool FAutoSize;
	bool FBorder;
	System::Classes::TStrings* FCellFields;
	System::StaticArray<TfrxCrossFunction, 32> FCellFunctions;
	int FCellLevels;
	bool FClearBeforePrint;
	TfrxCutBands* FColumnBands;
	System::Classes::TStrings* FColumnFields;
	TfrxCrossColumnHeader* FColumnHeader;
	int FColumnLevels;
	TfrxCrossColumns* FColumns;
	TfrxSortArray FColumnSort;
	TfrxCrossCorner* FCorner;
	int FDefHeight;
	bool FDotMatrix;
	bool FDownThenAcross;
	System::Types::TPoint FFirstMousePos;
	int FGapX;
	int FGapY;
	TfrxGridLines* FGridUsed;
	TfrxGridLines* FGridX;
	TfrxGridLines* FGridY;
	bool FJoinEqualCells;
	bool FKeepTogether;
	System::Types::TPoint FLastMousePos;
	int FMaxWidth;
	int FMinWidth;
	bool FMouseDown;
	int FMovingObjects;
	TfrxCustomCrossView* FNextCross;
	System::Extended FNextCrossGap;
	bool FNoColumns;
	bool FNoRows;
	bool FPlainCells;
	bool FRepeatHeaders;
	TfrxCutBands* FRowBands;
	System::Classes::TStrings* FRowFields;
	TfrxCrossRowHeader* FRowHeader;
	int FRowLevels;
	TfrxCrossRows* FRows;
	TfrxSortArray FRowSort;
	bool FShowColumnHeader;
	bool FShowColumnTotal;
	bool FShowCorner;
	bool FShowRowHeader;
	bool FShowRowTotal;
	bool FShowTitle;
	bool FSuppressNullRecords;
	bool FKeepRowsTogether;
	System::Classes::TList* FAllMemos;
	System::Classes::TList* FCellMemos;
	System::Classes::TList* FCellHeaderMemos;
	System::Classes::TList* FColumnMemos;
	System::Classes::TList* FColumnTotalMemos;
	System::Classes::TList* FCornerMemos;
	System::Classes::TList* FRowMemos;
	System::Classes::TList* FRowTotalMemos;
	TfrxCalcHeightEvent FOnCalcHeight;
	TfrxCalcWidthEvent FOnCalcWidth;
	TfrxPrintCellEvent FOnPrintCell;
	TfrxPrintHeaderEvent FOnPrintColumnHeader;
	TfrxPrintHeaderEvent FOnPrintRowHeader;
	TfrxOnCalcHeightEvent FOnBeforeCalcHeight;
	TfrxOnCalcWidthEvent FOnBeforeCalcWidth;
	TfrxOnPrintCellEvent FOnBeforePrintCell;
	TfrxOnPrintHeaderEvent FOnBeforePrintColumnHeader;
	TfrxOnPrintHeaderEvent FOnBeforePrintRowHeader;
	void __fastcall CalcBounds(System::Extended addWidth, System::Extended addHeight);
	void __fastcall CalcTotal(TfrxCrossHeader* Header, TfrxIndexCollection* Source);
	void __fastcall CalcTotals(void);
	void __fastcall CreateHeader(TfrxCrossHeader* Header, TfrxIndexCollection* Source, System::Classes::TList* Totals, bool TotalVisible);
	void __fastcall CreateHeaders(void);
	void __fastcall BuildColumnBands(void);
	void __fastcall BuildRowBands(void);
	void __fastcall ClearMatrix(void);
	void __fastcall ClearMemos(void);
	void __fastcall CreateCellHeaderMemos(int NewCount);
	void __fastcall CreateCellMemos(int NewCount);
	void __fastcall CreateColumnMemos(int NewCount);
	void __fastcall CreateCornerMemos(int NewCount);
	void __fastcall CreateRowMemos(int NewCount);
	void __fastcall CorrectDMPBounds(Frxclass::TfrxCustomMemoView* Memo);
	void __fastcall DoCalcHeight(int Row, System::Extended &Height);
	void __fastcall DoCalcWidth(int Column, System::Extended &Width);
	void __fastcall DoOnCell(Frxclass::TfrxCustomMemoView* Memo, int Row, int Column, int Cell, const System::Variant &Value);
	void __fastcall DoOnColumnHeader(Frxclass::TfrxCustomMemoView* Memo, TfrxCrossHeader* Header);
	void __fastcall DoOnRowHeader(Frxclass::TfrxCustomMemoView* Memo, TfrxCrossHeader* Header);
	void __fastcall InitMatrix(void);
	void __fastcall InitMemos(bool AddToScript);
	void __fastcall ReadMemos(System::Classes::TStream* Stream);
	void __fastcall RenderMatrix(void);
	void __fastcall SetCellFields(System::Classes::TStrings* const Value);
	void __fastcall SetCellFunctions(int Index, const TfrxCrossFunction Value);
	void __fastcall SetColumnFields(System::Classes::TStrings* const Value);
	void __fastcall SetColumnSort(int Index, TfrxCrossSortOrder Value);
	void __fastcall SetDotMatrix(const bool Value);
	void __fastcall SetRowFields(System::Classes::TStrings* const Value);
	void __fastcall SetRowSort(int Index, TfrxCrossSortOrder Value);
	void __fastcall SetupOriginalComponent(Frxclass::TfrxComponent* Obj1, Frxclass::TfrxComponent* Obj2);
	void __fastcall UpdateVisibility(void);
	void __fastcall WriteMemos(System::Classes::TStream* Stream);
	Frxclass::TfrxCustomMemoView* __fastcall CreateMemo(Frxclass::TfrxComponent* Parent);
	TfrxCrossFunction __fastcall GetCellFunctions(int Index);
	Frxclass::TfrxCustomMemoView* __fastcall GetCellHeaderMemos(int Index);
	Frxclass::TfrxCustomMemoView* __fastcall GetCellMemos(int Index);
	Frxclass::TfrxCustomMemoView* __fastcall GetColumnMemos(int Index);
	TfrxCrossSortOrder __fastcall GetColumnSort(int Index);
	Frxclass::TfrxCustomMemoView* __fastcall GetColumnTotalMemos(int Index);
	Frxclass::TfrxCustomMemoView* __fastcall GetCornerMemos(int Index);
	System::Classes::TList* __fastcall GetNestedObjects(void);
	Frxclass::TfrxCustomMemoView* __fastcall GetRowMemos(int Index);
	TfrxCrossSortOrder __fastcall GetRowSort(int Index);
	Frxclass::TfrxCustomMemoView* __fastcall GetRowTotalMemos(int Index);
	
protected:
	virtual void __fastcall DefineProperties(System::Classes::TFiler* Filer);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	virtual void __fastcall SetCellLevels(const int Value);
	virtual void __fastcall SetColumnLevels(const int Value);
	virtual void __fastcall SetRowLevels(const int Value);
	virtual System::Classes::TList* __fastcall GetContainerObjects(void);
	
public:
	__fastcall virtual TfrxCustomCrossView(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TfrxCustomCrossView(void);
	virtual void __fastcall Draw(Vcl::Graphics::TCanvas* Canvas, System::Extended ScaleX, System::Extended ScaleY, System::Extended OffsetX, System::Extended OffsetY);
	virtual void __fastcall BeforePrint(void);
	virtual void __fastcall BeforeStartReport(void);
	virtual void __fastcall GetData(void);
	virtual void __fastcall AddSourceObjects(void);
	virtual bool __fastcall ContainerAdd(Frxclass::TfrxComponent* Obj);
	virtual bool __fastcall ContainerMouseDown(System::TObject* Sender, int X, int Y);
	virtual void __fastcall ContainerMouseMove(System::TObject* Sender, int X, int Y);
	virtual void __fastcall ContainerMouseUp(System::TObject* Sender, int X, int Y);
	void __fastcall AddValue(System::Variant const *Rows, const int Rows_Size, System::Variant const *Columns, const int Columns_Size, System::Variant const *Cells, const int Cells_Size);
	void __fastcall ApplyStyle(Frxclass::TfrxStyles* Style);
	void __fastcall BeginMatrix(void);
	void __fastcall EndMatrix(void);
	virtual void __fastcall FillMatrix(void);
	void __fastcall GetStyle(Frxclass::TfrxStyles* Style);
	int __fastcall ColCount(void);
	Frxclass::TfrxPoint __fastcall DrawCross(Vcl::Graphics::TCanvas* Canvas, System::Extended ScaleX, System::Extended ScaleY, System::Extended OffsetX, System::Extended OffsetY);
	System::Variant __fastcall GetColumnIndexes(int AColumn);
	System::Variant __fastcall GetRowIndexes(int ARow);
	System::Variant __fastcall GetValue(int ARow, int AColumn, int ACell);
	virtual bool __fastcall IsCrossValid(void);
	bool __fastcall IsGrandTotalColumn(int Index);
	bool __fastcall IsGrandTotalRow(int Index);
	bool __fastcall IsTotalColumn(int Index);
	bool __fastcall IsTotalRow(int Index);
	int __fastcall RowCount(void);
	System::Extended __fastcall RowHeaderWidth(void);
	System::Extended __fastcall ColumnHeaderHeight(void);
	__property TfrxCrossColumnHeader* ColumnHeader = {read=FColumnHeader};
	__property TfrxCrossRowHeader* RowHeader = {read=FRowHeader};
	__property TfrxCrossCorner* Corner = {read=FCorner};
	__property bool NoColumns = {read=FNoColumns, nodefault};
	__property bool NoRows = {read=FNoRows, nodefault};
	__property System::Classes::TStrings* CellFields = {read=FCellFields, write=SetCellFields};
	__property TfrxCrossFunction CellFunctions[int Index] = {read=GetCellFunctions, write=SetCellFunctions};
	__property Frxclass::TfrxCustomMemoView* CellMemos[int Index] = {read=GetCellMemos};
	__property Frxclass::TfrxCustomMemoView* CellHeaderMemos[int Index] = {read=GetCellHeaderMemos};
	__property bool ClearBeforePrint = {read=FClearBeforePrint, write=FClearBeforePrint, nodefault};
	__property System::Classes::TStrings* ColumnFields = {read=FColumnFields, write=SetColumnFields};
	__property Frxclass::TfrxCustomMemoView* ColumnMemos[int Index] = {read=GetColumnMemos};
	__property TfrxCrossSortOrder ColumnSort[int Index] = {read=GetColumnSort, write=SetColumnSort};
	__property Frxclass::TfrxCustomMemoView* ColumnTotalMemos[int Index] = {read=GetColumnTotalMemos};
	__property Frxclass::TfrxCustomMemoView* CornerMemos[int Index] = {read=GetCornerMemos};
	__property bool DotMatrix = {read=FDotMatrix, nodefault};
	__property System::Classes::TStrings* RowFields = {read=FRowFields, write=SetRowFields};
	__property Frxclass::TfrxCustomMemoView* RowMemos[int Index] = {read=GetRowMemos};
	__property TfrxCrossSortOrder RowSort[int Index] = {read=GetRowSort, write=SetRowSort};
	__property Frxclass::TfrxCustomMemoView* RowTotalMemos[int Index] = {read=GetRowTotalMemos};
	__property TfrxOnCalcHeightEvent OnBeforeCalcHeight = {read=FOnBeforeCalcHeight, write=FOnBeforeCalcHeight};
	__property TfrxOnCalcWidthEvent OnBeforeCalcWidth = {read=FOnBeforeCalcWidth, write=FOnBeforeCalcWidth};
	__property TfrxOnPrintCellEvent OnBeforePrintCell = {read=FOnBeforePrintCell, write=FOnBeforePrintCell};
	__property TfrxOnPrintHeaderEvent OnBeforePrintColumnHeader = {read=FOnBeforePrintColumnHeader, write=FOnBeforePrintColumnHeader};
	__property TfrxOnPrintHeaderEvent OnBeforePrintRowHeader = {read=FOnBeforePrintRowHeader, write=FOnBeforePrintRowHeader};
	
__published:
	__property System::Extended AddHeight = {read=FAddHeight, write=FAddHeight};
	__property System::Extended AddWidth = {read=FAddWidth, write=FAddWidth};
	__property bool AllowDuplicates = {read=FAllowDuplicates, write=FAllowDuplicates, default=1};
	__property bool AutoSize = {read=FAutoSize, write=FAutoSize, default=1};
	__property bool Border = {read=FBorder, write=FBorder, default=1};
	__property int CellLevels = {read=FCellLevels, write=SetCellLevels, default=1};
	__property int ColumnLevels = {read=FColumnLevels, write=SetColumnLevels, default=1};
	__property int DefHeight = {read=FDefHeight, write=FDefHeight, default=0};
	__property bool DownThenAcross = {read=FDownThenAcross, write=FDownThenAcross, nodefault};
	__property int GapX = {read=FGapX, write=FGapX, default=3};
	__property int GapY = {read=FGapY, write=FGapY, default=3};
	__property bool JoinEqualCells = {read=FJoinEqualCells, write=FJoinEqualCells, default=0};
	__property bool KeepTogether = {read=FKeepTogether, write=FKeepTogether, default=0};
	__property bool KeepRowsTogether = {read=FKeepRowsTogether, write=FKeepRowsTogether, default=0};
	__property int MaxWidth = {read=FMaxWidth, write=FMaxWidth, default=200};
	__property int MinWidth = {read=FMinWidth, write=FMinWidth, default=0};
	__property TfrxCustomCrossView* NextCross = {read=FNextCross, write=FNextCross};
	__property System::Extended NextCrossGap = {read=FNextCrossGap, write=FNextCrossGap};
	__property bool PlainCells = {read=FPlainCells, write=FPlainCells, default=0};
	__property bool RepeatHeaders = {read=FRepeatHeaders, write=FRepeatHeaders, default=1};
	__property int RowLevels = {read=FRowLevels, write=SetRowLevels, default=1};
	__property bool ShowColumnHeader = {read=FShowColumnHeader, write=FShowColumnHeader, default=1};
	__property bool ShowColumnTotal = {read=FShowColumnTotal, write=FShowColumnTotal, default=1};
	__property bool ShowCorner = {read=FShowCorner, write=FShowCorner, default=1};
	__property bool ShowRowHeader = {read=FShowRowHeader, write=FShowRowHeader, default=1};
	__property bool ShowRowTotal = {read=FShowRowTotal, write=FShowRowTotal, default=1};
	__property bool ShowTitle = {read=FShowTitle, write=FShowTitle, default=1};
	__property bool SuppressNullRecords = {read=FSuppressNullRecords, write=FSuppressNullRecords, default=1};
	__property TfrxCalcHeightEvent OnCalcHeight = {read=FOnCalcHeight, write=FOnCalcHeight};
	__property TfrxCalcWidthEvent OnCalcWidth = {read=FOnCalcWidth, write=FOnCalcWidth};
	__property TfrxPrintCellEvent OnPrintCell = {read=FOnPrintCell, write=FOnPrintCell};
	__property TfrxPrintHeaderEvent OnPrintColumnHeader = {read=FOnPrintColumnHeader, write=FOnPrintColumnHeader};
	__property TfrxPrintHeaderEvent OnPrintRowHeader = {read=FOnPrintRowHeader, write=FOnPrintRowHeader};
public:
	/* TfrxComponent.DesignCreate */ inline __fastcall virtual TfrxCustomCrossView(System::Classes::TComponent* AOwner, System::Word Flags) : Frxclass::TfrxView(AOwner, Flags) { }
	
};


class DELPHICLASS TfrxCrossView;
class PASCALIMPLEMENTATION TfrxCrossView : public TfrxCustomCrossView
{
	typedef TfrxCustomCrossView inherited;
	
protected:
	virtual void __fastcall SetCellLevels(const int Value);
	virtual void __fastcall SetColumnLevels(const int Value);
	virtual void __fastcall SetRowLevels(const int Value);
	
public:
	__classmethod virtual System::UnicodeString __fastcall GetDescription();
	virtual bool __fastcall IsCrossValid(void);
public:
	/* TfrxCustomCrossView.Create */ inline __fastcall virtual TfrxCrossView(System::Classes::TComponent* AOwner) : TfrxCustomCrossView(AOwner) { }
	/* TfrxCustomCrossView.Destroy */ inline __fastcall virtual ~TfrxCrossView(void) { }
	
public:
	/* TfrxComponent.DesignCreate */ inline __fastcall virtual TfrxCrossView(System::Classes::TComponent* AOwner, System::Word Flags) : TfrxCustomCrossView(AOwner, Flags) { }
	
};


class DELPHICLASS TfrxDBCrossView;
class PASCALIMPLEMENTATION TfrxDBCrossView : public TfrxCustomCrossView
{
	typedef TfrxCustomCrossView inherited;
	
public:
	__classmethod virtual System::UnicodeString __fastcall GetDescription();
	virtual bool __fastcall IsCrossValid(void);
	virtual void __fastcall FillMatrix(void);
	
__published:
	__property CellFields;
	__property ColumnFields;
	__property DataSet;
	__property DataSetName = {default=0};
	__property RowFields;
public:
	/* TfrxCustomCrossView.Create */ inline __fastcall virtual TfrxDBCrossView(System::Classes::TComponent* AOwner) : TfrxCustomCrossView(AOwner) { }
	/* TfrxCustomCrossView.Destroy */ inline __fastcall virtual ~TfrxDBCrossView(void) { }
	
public:
	/* TfrxComponent.DesignCreate */ inline __fastcall virtual TfrxDBCrossView(System::Classes::TComponent* AOwner, System::Word Flags) : TfrxCustomCrossView(AOwner, Flags) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Frxcross */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FRXCROSS)
using namespace Frxcross;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// FrxcrossHPP
