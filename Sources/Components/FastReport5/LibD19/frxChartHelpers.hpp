// CodeGear C++Builder
// Copyright (c) 1995, 2013 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'frxChartHelpers.pas' rev: 26.00 (Windows)

#ifndef FrxcharthelpersHPP
#define FrxcharthelpersHPP

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
#include <frxChart.hpp>	// Pascal unit
#include <VCLTee.TeeProcs.hpp>	// Pascal unit
#include <VCLTee.TeEngine.hpp>	// Pascal unit
#include <VCLTee.Chart.hpp>	// Pascal unit
#include <VCLTee.Series.hpp>	// Pascal unit
#include <VCLTee.TeCanvas.hpp>	// Pascal unit
#include <VCLTee.GanttCh.hpp>	// Pascal unit
#include <VCLTee.TeeShape.hpp>	// Pascal unit
#include <VCLTee.BubbleCh.hpp>	// Pascal unit
#include <VCLTee.ArrowCha.hpp>	// Pascal unit
#include <System.Variants.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Frxcharthelpers
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TfrxSeriesHelper;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TfrxSeriesHelper : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	virtual System::UnicodeString __fastcall GetParamNames(void) = 0 ;
	virtual void __fastcall AddValues(Vcltee::Teengine::TChartSeries* Series, const System::UnicodeString v1, const System::UnicodeString v2, const System::UnicodeString v3, const System::UnicodeString v4, const System::UnicodeString v5, const System::UnicodeString v6, Frxchart::TfrxSeriesXType XType) = 0 ;
public:
	/* TObject.Create */ inline __fastcall TfrxSeriesHelper(void) : System::TObject() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TfrxSeriesHelper(void) { }
	
};

#pragma pack(pop)

class DELPHICLASS TfrxStdSeriesHelper;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TfrxStdSeriesHelper : public TfrxSeriesHelper
{
	typedef TfrxSeriesHelper inherited;
	
public:
	virtual System::UnicodeString __fastcall GetParamNames(void);
	virtual void __fastcall AddValues(Vcltee::Teengine::TChartSeries* Series, const System::UnicodeString v1, const System::UnicodeString v2, const System::UnicodeString v3, const System::UnicodeString v4, const System::UnicodeString v5, const System::UnicodeString v6, Frxchart::TfrxSeriesXType XType);
public:
	/* TObject.Create */ inline __fastcall TfrxStdSeriesHelper(void) : TfrxSeriesHelper() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TfrxStdSeriesHelper(void) { }
	
};

#pragma pack(pop)

class DELPHICLASS TfrxPieSeriesHelper;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TfrxPieSeriesHelper : public TfrxSeriesHelper
{
	typedef TfrxSeriesHelper inherited;
	
public:
	virtual System::UnicodeString __fastcall GetParamNames(void);
	virtual void __fastcall AddValues(Vcltee::Teengine::TChartSeries* Series, const System::UnicodeString v1, const System::UnicodeString v2, const System::UnicodeString v3, const System::UnicodeString v4, const System::UnicodeString v5, const System::UnicodeString v6, Frxchart::TfrxSeriesXType XType);
public:
	/* TObject.Create */ inline __fastcall TfrxPieSeriesHelper(void) : TfrxSeriesHelper() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TfrxPieSeriesHelper(void) { }
	
};

#pragma pack(pop)

class DELPHICLASS TfrxGanttSeriesHelper;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TfrxGanttSeriesHelper : public TfrxSeriesHelper
{
	typedef TfrxSeriesHelper inherited;
	
public:
	virtual System::UnicodeString __fastcall GetParamNames(void);
	virtual void __fastcall AddValues(Vcltee::Teengine::TChartSeries* Series, const System::UnicodeString v1, const System::UnicodeString v2, const System::UnicodeString v3, const System::UnicodeString v4, const System::UnicodeString v5, const System::UnicodeString v6, Frxchart::TfrxSeriesXType XType);
public:
	/* TObject.Create */ inline __fastcall TfrxGanttSeriesHelper(void) : TfrxSeriesHelper() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TfrxGanttSeriesHelper(void) { }
	
};

#pragma pack(pop)

class DELPHICLASS TfrxArrowSeriesHelper;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TfrxArrowSeriesHelper : public TfrxSeriesHelper
{
	typedef TfrxSeriesHelper inherited;
	
public:
	virtual System::UnicodeString __fastcall GetParamNames(void);
	virtual void __fastcall AddValues(Vcltee::Teengine::TChartSeries* Series, const System::UnicodeString v1, const System::UnicodeString v2, const System::UnicodeString v3, const System::UnicodeString v4, const System::UnicodeString v5, const System::UnicodeString v6, Frxchart::TfrxSeriesXType XType);
public:
	/* TObject.Create */ inline __fastcall TfrxArrowSeriesHelper(void) : TfrxSeriesHelper() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TfrxArrowSeriesHelper(void) { }
	
};

#pragma pack(pop)

class DELPHICLASS TfrxBubbleSeriesHelper;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TfrxBubbleSeriesHelper : public TfrxSeriesHelper
{
	typedef TfrxSeriesHelper inherited;
	
public:
	virtual System::UnicodeString __fastcall GetParamNames(void);
	virtual void __fastcall AddValues(Vcltee::Teengine::TChartSeries* Series, const System::UnicodeString v1, const System::UnicodeString v2, const System::UnicodeString v3, const System::UnicodeString v4, const System::UnicodeString v5, const System::UnicodeString v6, Frxchart::TfrxSeriesXType XType);
public:
	/* TObject.Create */ inline __fastcall TfrxBubbleSeriesHelper(void) : TfrxSeriesHelper() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TfrxBubbleSeriesHelper(void) { }
	
};

#pragma pack(pop)

typedef System::TMetaClass* TfrxSeriesHelperClass;

//-- var, const, procedure ---------------------------------------------------
static const System::Int8 frxNumSeries = System::Int8(0xb);
extern DELPHI_PACKAGE System::StaticArray<Frxchart::TSeriesClass, 11> frxChartSeries;
extern DELPHI_PACKAGE System::StaticArray<TfrxSeriesHelperClass, 11> frxSeriesHelpers;
extern DELPHI_PACKAGE TfrxSeriesHelper* __fastcall frxFindSeriesHelper(Vcltee::Teengine::TChartSeries* Series);
}	/* namespace Frxcharthelpers */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FRXCHARTHELPERS)
using namespace Frxcharthelpers;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// FrxcharthelpersHPP
