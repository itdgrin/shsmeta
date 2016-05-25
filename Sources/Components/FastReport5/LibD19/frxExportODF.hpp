// CodeGear C++Builder
// Copyright (c) 1995, 2013 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'frxExportODF.pas' rev: 26.00 (Windows)

#ifndef FrxexportodfHPP
#define FrxexportodfHPP

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
#include <Vcl.Controls.hpp>	// Pascal unit
#include <Vcl.Forms.hpp>	// Pascal unit
#include <Vcl.Dialogs.hpp>	// Pascal unit
#include <Vcl.StdCtrls.hpp>	// Pascal unit
#include <Vcl.ExtCtrls.hpp>	// Pascal unit
#include <Vcl.Printers.hpp>	// Pascal unit
#include <frxClass.hpp>	// Pascal unit
#include <frxExportMatrix.hpp>	// Pascal unit
#include <frxProgress.hpp>	// Pascal unit
#include <frxXML.hpp>	// Pascal unit
#include <Winapi.ShellAPI.hpp>	// Pascal unit
#include <frxImageConverter.hpp>	// Pascal unit
#include <frxZip.hpp>	// Pascal unit
#include <System.Variants.hpp>	// Pascal unit
#include <System.UITypes.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Frxexportodf
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TfrxODFExportDialog;
class PASCALIMPLEMENTATION TfrxODFExportDialog : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Stdctrls::TButton* OkB;
	Vcl::Stdctrls::TButton* CancelB;
	Vcl::Dialogs::TSaveDialog* SaveDialog1;
	Vcl::Stdctrls::TGroupBox* GroupPageRange;
	Vcl::Stdctrls::TLabel* DescrL;
	Vcl::Stdctrls::TRadioButton* AllRB;
	Vcl::Stdctrls::TRadioButton* CurPageRB;
	Vcl::Stdctrls::TRadioButton* PageNumbersRB;
	Vcl::Stdctrls::TEdit* PageNumbersE;
	Vcl::Stdctrls::TGroupBox* GroupQuality;
	Vcl::Stdctrls::TCheckBox* WCB;
	Vcl::Stdctrls::TCheckBox* ContinuousCB;
	Vcl::Stdctrls::TCheckBox* PageBreaksCB;
	Vcl::Stdctrls::TCheckBox* OpenCB;
	Vcl::Stdctrls::TCheckBox* BackgrCB;
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall PageNumbersEChange(System::TObject* Sender);
	void __fastcall PageNumbersEKeyPress(System::TObject* Sender, System::WideChar &Key);
	void __fastcall FormKeyDown(System::TObject* Sender, System::Word &Key, System::Classes::TShiftState Shift);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TfrxODFExportDialog(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TfrxODFExportDialog(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TfrxODFExportDialog(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TfrxODFExportDialog(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


class DELPHICLASS TfrxODFExport;
class PASCALIMPLEMENTATION TfrxODFExport : public Frxclass::TfrxCustomExportFilter
{
	typedef Frxclass::TfrxCustomExportFilter inherited;
	
private:
	bool FExportPageBreaks;
	bool FExportStyles;
	bool FFirstPage;
	Frxexportmatrix::TfrxIEMatrix* FMatrix;
	bool FOpenAfterExport;
	System::Extended FPageBottom;
	System::Extended FPageLeft;
	System::Extended FPageRight;
	System::Extended FPageTop;
	System::Extended FPageWidth;
	System::Extended FPageHeight;
	System::Uitypes::TPrinterOrientation FPageOrientation;
	bool FWysiwyg;
	bool FSingleSheet;
	bool FBackground;
	System::UnicodeString FCreator;
	bool FEmptyLines;
	System::UnicodeString FTempFolder;
	Frxzip::TfrxZipArchive* FZipFile;
	Vcl::Extctrls::TImage* FThumbImage;
	Frxprogress::TfrxProgress* FProgress;
	System::UnicodeString FExportType;
	System::UnicodeString FLanguage;
	Frxxml::TfrxXMLItem* FStyleNode;
	System::Classes::TList* FStyles;
	int FPicCount;
	System::TDateTime FCreationTime;
	Frximageconverter::TfrxPictureType FPictureType;
	System::Classes::TStrings* FRowStyleNames;
	bool __fastcall IsTerminated(void);
	void __fastcall DoOnProgress(System::TObject* Sender);
	System::WideString __fastcall OdfPrepareString(const System::WideString Str);
	System::UnicodeString __fastcall OdfGetFrameName(const Frxclass::TfrxFrameStyle FrameStyle);
	void __fastcall OdfMakeHeader(Frxxml::TfrxXMLItem* const Item);
	void __fastcall OdfCreateMeta(const System::UnicodeString FileName, const System::UnicodeString Creator);
	void __fastcall OdfCreateManifest(const System::UnicodeString FileName, const int PicCount, const System::UnicodeString MValue);
	void __fastcall OdfCreateMime(const System::UnicodeString FileName, const System::UnicodeString MValue);
	void __fastcall AddNumberStyle(Frxxml::TfrxXMLItem* Item, const System::UnicodeString StyleName, const System::UnicodeString Fmt);
	void __fastcall ExportBody(Frxxml::TfrxXMLItem* BodyNode);
	void __fastcall AddPic(Frxxml::TfrxXMLItem* Node, Frxexportmatrix::TfrxIEMObject* Obj);
	void __fastcall SplitOnTags(Frxxml::TfrxXMLItem* pNode, Frxexportmatrix::TfrxIEMObject* obj, System::WideString line);
	System::UnicodeString __fastcall GetHeaderText(Frxexportmatrix::TfrxIEMatrix* m);
	System::UnicodeString __fastcall GetFooterText(Frxexportmatrix::TfrxIEMatrix* m);
	void __fastcall CreateStyles(void);
	System::UnicodeString __fastcall CreateRowStyle(int Row, bool PageBreakBefore);
	void __fastcall SetPictureType(Frximageconverter::TfrxPictureType PT);
	void __fastcall CreateRow(Frxxml::TfrxXMLItem* Node, int Row, bool PageBreak);
	void __fastcall ExportRows(Frxxml::TfrxXMLItem* PageNode, int RowFirst, int RowLast, int PageIndex);
	void __fastcall CreatEmptyCell(Frxxml::TfrxXMLItem* Node);
	void __fastcall CreateAdjacentCell(Frxxml::TfrxXMLItem* Node, int Columns = 0x1);
	void __fastcall CreateDataCell(Frxxml::TfrxXMLItem* Node, Frxexportmatrix::TfrxIEMObject* Obj, int RowsSpanned, int ColsSpanned);
	System::WideString __fastcall AddStyle(System::Uitypes::TColor Color, System::Uitypes::TFontStyles Style);
	bool __fastcall IsRowEmpty(int Row);
	
protected:
	void __fastcall ExportPage(System::Classes::TStream* Stream);
	
public:
	__fastcall virtual TfrxODFExport(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TfrxODFExport(void);
	__classmethod virtual System::UnicodeString __fastcall GetDescription();
	__classmethod System::WideString __fastcall ProcessSpaces(const System::WideString s);
	__classmethod System::WideString __fastcall ProcessTabs(const System::WideString s);
	__classmethod System::WideString __fastcall ProcessControlSymbols(const System::WideString s);
	virtual System::Uitypes::TModalResult __fastcall ShowModal(void);
	virtual bool __fastcall Start(void);
	virtual void __fastcall Finish(void);
	virtual void __fastcall FinishPage(Frxclass::TfrxReportPage* Page, int Index);
	virtual void __fastcall StartPage(Frxclass::TfrxReportPage* Page, int Index);
	virtual void __fastcall ExportObject(Frxclass::TfrxComponent* Obj);
	__property System::UnicodeString ExportType = {read=FExportType, write=FExportType};
	__property ExportTitle = {default=0};
	
__published:
	__property Frximageconverter::TfrxPictureType PictureType = {read=FPictureType, write=SetPictureType, nodefault};
	__property bool ExportStyles = {read=FExportStyles, write=FExportStyles, default=1};
	__property bool ExportPageBreaks = {read=FExportPageBreaks, write=FExportPageBreaks, default=1};
	__property bool OpenAfterExport = {read=FOpenAfterExport, write=FOpenAfterExport, default=0};
	__property bool Wysiwyg = {read=FWysiwyg, write=FWysiwyg, default=1};
	__property bool Background = {read=FBackground, write=FBackground, default=0};
	__property System::UnicodeString Creator = {read=FCreator, write=FCreator};
	__property System::TDateTime CreationTime = {read=FCreationTime, write=FCreationTime};
	__property bool EmptyLines = {read=FEmptyLines, write=FEmptyLines, default=1};
	__property bool SingleSheet = {read=FSingleSheet, write=FSingleSheet, default=0};
	__property System::UnicodeString Language = {read=FLanguage, write=FLanguage};
	__property SuppressPageHeadersFooters;
	__property OverwritePrompt;
public:
	/* TfrxCustomExportFilter.CreateNoRegister */ inline __fastcall TfrxODFExport(void) : Frxclass::TfrxCustomExportFilter() { }
	
};


class DELPHICLASS TfrxODSExport;
class PASCALIMPLEMENTATION TfrxODSExport : public TfrxODFExport
{
	typedef TfrxODFExport inherited;
	
public:
	__fastcall virtual TfrxODSExport(System::Classes::TComponent* AOwner);
	__classmethod virtual System::UnicodeString __fastcall GetDescription();
	__property ExportTitle = {default=0};
	
__published:
	__property ExportStyles = {default=1};
	__property ExportPageBreaks = {default=1};
	__property OpenAfterExport = {default=0};
	__property ShowProgress;
	__property Wysiwyg = {default=1};
	__property Background = {default=0};
	__property Creator = {default=0};
	__property EmptyLines = {default=1};
	__property SuppressPageHeadersFooters;
	__property OverwritePrompt;
	__property PictureType;
public:
	/* TfrxODFExport.Destroy */ inline __fastcall virtual ~TfrxODSExport(void) { }
	
public:
	/* TfrxCustomExportFilter.CreateNoRegister */ inline __fastcall TfrxODSExport(void) : TfrxODFExport() { }
	
};


class DELPHICLASS TfrxODTExport;
class PASCALIMPLEMENTATION TfrxODTExport : public TfrxODFExport
{
	typedef TfrxODFExport inherited;
	
public:
	__fastcall virtual TfrxODTExport(System::Classes::TComponent* AOwner);
	__classmethod virtual System::UnicodeString __fastcall GetDescription();
	
__published:
	__property ExportStyles = {default=1};
	__property ExportPageBreaks = {default=1};
	__property OpenAfterExport = {default=0};
	__property ShowProgress;
	__property Wysiwyg = {default=1};
	__property Background = {default=0};
	__property Creator = {default=0};
	__property EmptyLines = {default=1};
	__property SuppressPageHeadersFooters;
	__property OverwritePrompt;
	__property PictureType;
public:
	/* TfrxODFExport.Destroy */ inline __fastcall virtual ~TfrxODTExport(void) { }
	
public:
	/* TfrxCustomExportFilter.CreateNoRegister */ inline __fastcall TfrxODTExport(void) : TfrxODFExport() { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Frxexportodf */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FRXEXPORTODF)
using namespace Frxexportodf;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// FrxexportodfHPP
