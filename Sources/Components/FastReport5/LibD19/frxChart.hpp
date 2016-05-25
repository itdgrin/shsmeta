// CodeGear C++Builder
// Copyright (c) 1995, 2013 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'frxChart.pas' rev: 26.00 (Windows)

#ifndef FrxchartHPP
#define FrxchartHPP

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
#include <Vcl.Graphics.hpp>	// Pascal unit
#include <Vcl.Menus.hpp>	// Pascal unit
#include <Vcl.Controls.hpp>	// Pascal unit
#include <frxCollections.hpp>	// Pascal unit
#include <frxClass.hpp>	// Pascal unit
#include <VCLTee.TeeProcs.hpp>	// Pascal unit
#include <VCLTee.TeEngine.hpp>	// Pascal unit
#include <VCLTee.Chart.hpp>	// Pascal unit
#include <VCLTee.Series.hpp>	// Pascal unit
#include <VCLTee.TeCanvas.hpp>	// Pascal unit
#include <System.Variants.hpp>	// Pascal unit
#include <System.UITypes.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Frxchart
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TfrxChartObject;
class PASCALIMPLEMENTATION TfrxChartObject : public System::Classes::TComponent
{
	typedef System::Classes::TComponent inherited;
	
public:
	/* TComponent.Create */ inline __fastcall virtual TfrxChartObject(System::Classes::TComponent* AOwner) : System::Classes::TComponent(AOwner) { }
	/* TComponent.Destroy */ inline __fastcall virtual ~TfrxChartObject(void) { }
	
};


typedef System::TMetaClass* TChartClass;

enum DECLSPEC_DENUM TfrxSeriesDataType : unsigned char { dtDBData, dtBandData, dtFixedData };

enum DECLSPEC_DENUM TfrxSeriesSortOrder : unsigned char { soNone, soAscending, soDescending };

enum DECLSPEC_DENUM TfrxSeriesXType : unsigned char { xtText, xtNumber, xtDate };

typedef System::TMetaClass* TSeriesClass;

enum DECLSPEC_DENUM TfrxChartSeries : unsigned char { csLine, csArea, csPoint, csBar, csHorizBar, csPie, csGantt, csFastLine, csArrow, csBubble, csChartShape, csHorizArea, csHorizLine, csPolar, csRadar, csPolarBar, csGauge, csSmith, csPyramid, csDonut, csBezier, csCandle, csVolume, csPointFigure, csHistogram, csHorizHistogram, csErrorBar, csError, csHighLow, csFunnel, csBox, csHorizBox, csSurface, csContour, csWaterFall, csColorGrid, csVector3D, csTower, csTriSurface, csPoint3D, csBubble3D, csMyPoint, csBarJoin, csBar3D };

class DELPHICLASS TfrxSeriesItem;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TfrxSeriesItem : public Frxcollections::TfrxCollectionItem
{
	typedef Frxcollections::TfrxCollectionItem inherited;
	
private:
	Frxclass::TfrxDataBand* FDataBand;
	Frxclass::TfrxDataSet* FDataSet;
	System::UnicodeString FDataSetName;
	TfrxSeriesDataType FDataType;
	TfrxSeriesSortOrder FSortOrder;
	int FTopN;
	System::UnicodeString FTopNCaption;
	System::UnicodeString FSource1;
	System::UnicodeString FSource2;
	System::UnicodeString FSource3;
	System::UnicodeString FSource4;
	System::UnicodeString FSource5;
	System::UnicodeString FSource6;
	TfrxSeriesXType FXType;
	System::UnicodeString FValues1;
	System::UnicodeString FValues2;
	System::UnicodeString FValues3;
	System::UnicodeString FValues4;
	System::UnicodeString FValues5;
	System::UnicodeString FValues6;
	System::Classes::TStringList* Fsl1;
	System::Classes::TStringList* Fsl2;
	System::Classes::TStringList* Fsl3;
	System::Classes::TStringList* Fsl4;
	System::Classes::TStringList* Fsl5;
	System::Classes::TStringList* Fsl6;
	void __fastcall FillSeries(Vcltee::Teengine::TChartSeries* Series);
	void __fastcall SetDataSet(Frxclass::TfrxDataSet* const Value);
	void __fastcall SetDataSetName(const System::UnicodeString Value);
	System::UnicodeString __fastcall GetDataSetName(void);
	
protected:
	virtual bool __fastcall IsNameStored(void);
	
public:
	__fastcall virtual TfrxSeriesItem(System::Classes::TCollection* Collection);
	__fastcall virtual ~TfrxSeriesItem(void);
	
__published:
	__property TfrxSeriesDataType DataType = {read=FDataType, write=FDataType, nodefault};
	__property Frxclass::TfrxDataBand* DataBand = {read=FDataBand, write=FDataBand};
	__property Frxclass::TfrxDataSet* DataSet = {read=FDataSet, write=SetDataSet};
	__property System::UnicodeString DataSetName = {read=GetDataSetName, write=SetDataSetName};
	__property TfrxSeriesSortOrder SortOrder = {read=FSortOrder, write=FSortOrder, nodefault};
	__property int TopN = {read=FTopN, write=FTopN, nodefault};
	__property System::UnicodeString TopNCaption = {read=FTopNCaption, write=FTopNCaption};
	__property TfrxSeriesXType XType = {read=FXType, write=FXType, nodefault};
	__property System::UnicodeString Source1 = {read=FSource1, write=FSource1};
	__property System::UnicodeString Source2 = {read=FSource2, write=FSource2};
	__property System::UnicodeString Source3 = {read=FSource3, write=FSource3};
	__property System::UnicodeString Source4 = {read=FSource4, write=FSource4};
	__property System::UnicodeString Source5 = {read=FSource5, write=FSource5};
	__property System::UnicodeString Source6 = {read=FSource6, write=FSource6};
	__property System::UnicodeString Values1 = {read=FValues1, write=FValues1};
	__property System::UnicodeString Values2 = {read=FValues2, write=FValues2};
	__property System::UnicodeString Values3 = {read=FValues3, write=FValues3};
	__property System::UnicodeString Values4 = {read=FValues4, write=FValues4};
	__property System::UnicodeString Values5 = {read=FValues5, write=FValues5};
	__property System::UnicodeString Values6 = {read=FValues6, write=FValues6};
	__property System::UnicodeString XSource = {read=FSource1, write=FSource1};
	__property System::UnicodeString YSource = {read=FSource2, write=FSource2};
	__property System::UnicodeString XValues = {read=FValues1, write=FValues1};
	__property System::UnicodeString YValues = {read=FValues2, write=FValues2};
};

#pragma pack(pop)

class DELPHICLASS TfrxSeriesData;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TfrxSeriesData : public Frxcollections::TfrxCollection
{
	typedef Frxcollections::TfrxCollection inherited;
	
public:
	TfrxSeriesItem* operator[](int Index) { return Items[Index]; }
	
private:
	Frxclass::TfrxReport* FReport;
	TfrxSeriesItem* __fastcall GetSeries(int Index);
	
public:
	__fastcall TfrxSeriesData(Frxclass::TfrxReport* Report);
	HIDESBASE TfrxSeriesItem* __fastcall Add(void);
	__property TfrxSeriesItem* Items[int Index] = {read=GetSeries/*, default*/};
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TfrxSeriesData(void) { }
	
};

#pragma pack(pop)

class DELPHICLASS TfrxChartView;
class PASCALIMPLEMENTATION TfrxChartView : public Frxclass::TfrxView
{
	typedef Frxclass::TfrxView inherited;
	
private:
	Vcltee::Chart::TCustomChart* FChart;
	TfrxSeriesData* FSeriesData;
	bool FIgnoreNulls;
	bool FNotFillSeries;
	System::Uitypes::TColor FSavedColor;
	int FHlIndex;
	System::UnicodeString FClickedVal1;
	System::UnicodeString FClickedVal2;
	System::UnicodeString FClickedVal3;
	System::UnicodeString FClickedVal4;
	System::UnicodeString FClickedVal5;
	System::UnicodeString FClickedVal6;
	System::Uitypes::TColor FHighlightColor;
	void __fastcall FillChart(void);
	void __fastcall ReadData(System::Classes::TStream* Stream);
	void __fastcall ReadData1(System::Classes::TReader* Reader);
	void __fastcall ReadData2(System::Classes::TReader* Reader);
	void __fastcall WriteData(System::Classes::TStream* Stream);
	void __fastcall WriteData1(System::Classes::TWriter* Writer);
	void __fastcall WriteData2(System::Classes::TWriter* Writer);
	
protected:
	virtual void __fastcall DefineProperties(System::Classes::TFiler* Filer);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	virtual void __fastcall CreateChart(void);
	__classmethod virtual TChartClass __fastcall GetChartClass();
	
public:
	__fastcall virtual TfrxChartView(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TfrxChartView(void);
	virtual void __fastcall DoMouseMove(int X, int Y, System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, bool &Refresh);
	virtual void __fastcall DoMouseEnter(Frxclass::TfrxComponent* Sender, bool &Refresh);
	virtual void __fastcall DoMouseLeave(Frxclass::TfrxComponent* Sender, bool &Refresh);
	__classmethod virtual System::UnicodeString __fastcall GetDescription();
	virtual void __fastcall Draw(Vcl::Graphics::TCanvas* Canvas, System::Extended ScaleX, System::Extended ScaleY, System::Extended OffsetX, System::Extended OffsetY);
	virtual void __fastcall AfterPrint(void);
	virtual void __fastcall GetData(void);
	virtual void __fastcall BeforeStartReport(void);
	virtual void __fastcall OnNotify(System::TObject* Sender);
	void __fastcall ClearSeries(void);
	void __fastcall AddSeries(TfrxChartSeries Series);
	__property Vcltee::Chart::TCustomChart* Chart = {read=FChart};
	__property TfrxSeriesData* SeriesData = {read=FSeriesData};
	__property int HighlightIndex = {read=FHlIndex, nodefault};
	__property System::UnicodeString ClickedVal1 = {read=FClickedVal1};
	__property System::UnicodeString ClickedVal2 = {read=FClickedVal2};
	__property System::UnicodeString ClickedVal3 = {read=FClickedVal3};
	__property System::UnicodeString ClickedVal4 = {read=FClickedVal4};
	__property System::UnicodeString ClickedVal5 = {read=FClickedVal5};
	__property System::UnicodeString ClickedVal6 = {read=FClickedVal6};
	
__published:
	__property bool IgnoreNulls = {read=FIgnoreNulls, write=FIgnoreNulls, default=0};
	__property System::Uitypes::TColor HighlightColor = {read=FHighlightColor, write=FHighlightColor, default=-16777190};
	__property FillType = {default=0};
	__property Fill;
	__property Cursor = {default=0};
	__property Frame;
	__property TagStr = {default=0};
	__property URL = {default=0};
public:
	/* TfrxComponent.DesignCreate */ inline __fastcall virtual TfrxChartView(System::Classes::TComponent* AOwner, System::Word Flags) : Frxclass::TfrxView(AOwner, Flags) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Frxchart */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FRXCHART)
using namespace Frxchart;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// FrxchartHPP
