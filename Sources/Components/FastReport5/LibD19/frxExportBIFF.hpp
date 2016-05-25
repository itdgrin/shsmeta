// CodeGear C++Builder
// Copyright (c) 1995, 2013 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'frxExportBIFF.pas' rev: 26.00 (Windows)

#ifndef FrxexportbiffHPP
#define FrxexportbiffHPP

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
#include <Vcl.Forms.hpp>	// Pascal unit
#include <Vcl.Dialogs.hpp>	// Pascal unit
#include <Vcl.StdCtrls.hpp>	// Pascal unit
#include <Winapi.ShellAPI.hpp>	// Pascal unit
#include <Vcl.ComCtrls.hpp>	// Pascal unit
#include <Vcl.Controls.hpp>	// Pascal unit
#include <frxClass.hpp>	// Pascal unit
#include <frxExportMatrix.hpp>	// Pascal unit
#include <frxProgress.hpp>	// Pascal unit
#include <frxStorage.hpp>	// Pascal unit
#include <frxBIFF.hpp>	// Pascal unit
#include <frxOLEPS.hpp>	// Pascal unit
#include <frxEscher.hpp>	// Pascal unit
#include <frxDraftPool.hpp>	// Pascal unit
#include <frxBiffConverter.hpp>	// Pascal unit
#include <System.UITypes.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Frxexportbiff
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TfrxDraftSheet;
class PASCALIMPLEMENTATION TfrxDraftSheet : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	Frxbiffconverter::TfrxBiffPageOptions Options;
public:
	/* TObject.Create */ inline __fastcall TfrxDraftSheet(void) : System::TObject() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TfrxDraftSheet(void) { }
	
};


class DELPHICLASS TfrxBIFFExportDialog;
class PASCALIMPLEMENTATION TfrxBIFFExportDialog : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Stdctrls::TButton* OkB;
	Vcl::Stdctrls::TButton* CancelB;
	Vcl::Comctrls::TPageControl* pc1;
	Vcl::Comctrls::TTabSheet* tsGeneral;
	Vcl::Stdctrls::TGroupBox* GroupPageRange;
	Vcl::Stdctrls::TLabel* DescrL;
	Vcl::Stdctrls::TRadioButton* AllRB;
	Vcl::Stdctrls::TRadioButton* CurPageRB;
	Vcl::Stdctrls::TRadioButton* PageNumbersRB;
	Vcl::Stdctrls::TEdit* PageNumbersE;
	Vcl::Stdctrls::TGroupBox* gbGroup;
	Vcl::Stdctrls::TRadioButton* rbOriginal;
	Vcl::Stdctrls::TRadioButton* rbSingle;
	Vcl::Stdctrls::TRadioButton* rbChunks;
	Vcl::Stdctrls::TEdit* edChunk;
	Vcl::Dialogs::TSaveDialog* sd;
	Vcl::Comctrls::TTabSheet* tsInfo;
	Vcl::Stdctrls::TLabel* lbTitle;
	Vcl::Stdctrls::TEdit* edTitle;
	Vcl::Stdctrls::TLabel* lbAuthor;
	Vcl::Stdctrls::TEdit* edAuthor;
	Vcl::Stdctrls::TLabel* lbKeywords;
	Vcl::Stdctrls::TEdit* edKeywords;
	Vcl::Stdctrls::TLabel* lbRevision;
	Vcl::Stdctrls::TEdit* edRevision;
	Vcl::Stdctrls::TLabel* lbAppName;
	Vcl::Stdctrls::TEdit* edAppName;
	Vcl::Stdctrls::TLabel* lbSubject;
	Vcl::Stdctrls::TEdit* edSubject;
	Vcl::Stdctrls::TLabel* lbCategory;
	Vcl::Stdctrls::TEdit* edCategory;
	Vcl::Stdctrls::TLabel* lbCompany;
	Vcl::Stdctrls::TEdit* edCompany;
	Vcl::Stdctrls::TLabel* lbManager;
	Vcl::Stdctrls::TEdit* edManager;
	Vcl::Stdctrls::TLabel* lbComment;
	Vcl::Stdctrls::TMemo* edComment;
	Vcl::Comctrls::TTabSheet* tsProt;
	Vcl::Stdctrls::TLabel* lbPass;
	Vcl::Stdctrls::TEdit* edPass1;
	Vcl::Stdctrls::TLabel* lbPassInfo;
	Vcl::Stdctrls::TLabel* lbPassConf;
	Vcl::Stdctrls::TEdit* edPass2;
	Vcl::Stdctrls::TCheckBox* OpenCB;
	Vcl::Stdctrls::TCheckBox* cbAutoCreateFile;
	Vcl::Comctrls::TTabSheet* TabSheet1;
	Vcl::Stdctrls::TCheckBox* cbPreciseQuality;
	Vcl::Stdctrls::TCheckBox* cbPictures;
	Vcl::Stdctrls::TCheckBox* cbGridLines;
	Vcl::Stdctrls::TCheckBox* cbFit;
	Vcl::Stdctrls::TCheckBox* cbDelEmptyRows;
	Vcl::Stdctrls::TCheckBox* cbFormulas;
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall PageNumbersEChange(System::TObject* Sender);
	void __fastcall PageNumbersEKeyPress(System::TObject* Sender, System::WideChar &Key);
	void __fastcall FormKeyDown(System::TObject* Sender, System::Word &Key, System::Classes::TShiftState Shift);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TfrxBIFFExportDialog(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TfrxBIFFExportDialog(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TfrxBIFFExportDialog(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TfrxBIFFExportDialog(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


class DELPHICLASS TfrxBIFFExport;
class PASCALIMPLEMENTATION TfrxBIFFExport : public Frxclass::TfrxCustomExportFilter
{
	typedef Frxclass::TfrxCustomExportFilter inherited;
	
private:
	bool FOpenAfterExport;
	int FParallelPages;
	Frxprogress::TfrxProgress* FProgress;
	bool FSingleSheet;
	bool FDeleteEmptyRows;
	int FChunkSize;
	bool FGridLines;
	System::Extended FInaccuracy;
	bool FFitPages;
	bool FPictures;
	System::Extended FRowHeightScale;
	bool FExportFormulas;
	Frxexportmatrix::TfrxIEMatrix* FMatrix;
	Frxbiff::TBiffWorkbook* FWB;
	int FZCW;
	int FTSW;
	Frxbiffconverter::TfrxPageInfo FLastPage;
	Frxdraftpool::TDpDraftPool* FDraftPool;
	System::AnsiString FAuthor;
	System::AnsiString FComment;
	System::AnsiString FKeywords;
	System::AnsiString FRevision;
	System::AnsiString FAppName;
	System::AnsiString FSubject;
	System::AnsiString FCategory;
	System::AnsiString FCompany;
	System::AnsiString FTitle;
	unsigned FAccess;
	System::AnsiString FManager;
	System::WideString FPassword;
	void __fastcall SetChunkSize(int Value);
	void __fastcall SetPassword(const System::WideString s);
	void __fastcall SetParallelPages(int Count);
	void __fastcall SetRowHeightScale(System::Extended Value);
	Frxbiffconverter::TfrxBiffPageOptions __fastcall GetExportOptionsDraft(void);
	void __fastcall SaveWorkbook(System::Classes::TStream* s);
	void __fastcall SaveSI(System::Classes::TStream* s);
	void __fastcall SaveDSI(System::Classes::TStream* s);
	void __fastcall InitProgressBar(int Steps, System::UnicodeString Text);
	void __fastcall StepProgressBar(void);
	void __fastcall FreeProgressBar(void);
	
public:
	__fastcall virtual TfrxBIFFExport(System::Classes::TComponent* AOwner);
	__classmethod virtual System::UnicodeString __fastcall GetDescription();
	virtual System::Uitypes::TModalResult __fastcall ShowModal(void);
	virtual bool __fastcall Start(void);
	virtual void __fastcall Finish(void);
	virtual void __fastcall FinishPage(Frxclass::TfrxReportPage* Page, int Index);
	virtual void __fastcall StartPage(Frxclass::TfrxReportPage* Page, int Index);
	virtual void __fastcall ExportObject(Frxclass::TfrxComponent* Obj);
	bool __fastcall UseParallelPages(void);
	Frxexportmatrix::TfrxIEMatrix* __fastcall CreateMatrix(void);
	void __fastcall ExportPage(System::TObject* Draft);
	
__published:
	__property bool OpenAfterExport = {read=FOpenAfterExport, write=FOpenAfterExport, default=0};
	__property OverwritePrompt;
	__property bool SingleSheet = {read=FSingleSheet, write=FSingleSheet, default=0};
	__property bool DeleteEmptyRows = {read=FDeleteEmptyRows, write=FDeleteEmptyRows, default=0};
	__property System::Extended RowHeightScale = {read=FRowHeightScale, write=SetRowHeightScale};
	__property int ChunkSize = {read=FChunkSize, write=SetChunkSize, nodefault};
	__property bool GridLines = {read=FGridLines, write=FGridLines, default=1};
	__property System::Extended Inaccuracy = {read=FInaccuracy, write=FInaccuracy};
	__property bool FitPages = {read=FFitPages, write=FFitPages, nodefault};
	__property bool Pictures = {read=FPictures, write=FPictures, nodefault};
	__property System::AnsiString Author = {read=FAuthor, write=FAuthor};
	__property System::AnsiString Comment = {read=FComment, write=FComment};
	__property System::AnsiString Keywords = {read=FKeywords, write=FKeywords};
	__property System::AnsiString Revision = {read=FRevision, write=FRevision};
	__property System::AnsiString AppName = {read=FAppName, write=FAppName};
	__property System::AnsiString Subject = {read=FSubject, write=FSubject};
	__property System::AnsiString Category = {read=FCategory, write=FCategory};
	__property System::AnsiString Company = {read=FCompany, write=FCompany};
	__property System::AnsiString Title = {read=FTitle, write=FTitle};
	__property System::AnsiString Manager = {read=FManager, write=FManager};
	__property System::WideString Password = {read=FPassword, write=SetPassword};
	__property int ParallelPages = {read=FParallelPages, write=SetParallelPages, nodefault};
	__property bool ExportFormulas = {read=FExportFormulas, write=FExportFormulas, default=1};
public:
	/* TfrxCustomExportFilter.CreateNoRegister */ inline __fastcall TfrxBIFFExport(void) : Frxclass::TfrxCustomExportFilter() { }
	/* TfrxCustomExportFilter.Destroy */ inline __fastcall virtual ~TfrxBIFFExport(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Frxexportbiff */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FRXEXPORTBIFF)
using namespace Frxexportbiff;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// FrxexportbiffHPP
