// CodeGear C++Builder
// Copyright (c) 1995, 2013 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'frxExportImage.pas' rev: 26.00 (Windows)

#ifndef FrxexportimageHPP
#define FrxexportimageHPP

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
#include <frxClass.hpp>	// Pascal unit
#include <Vcl.Imaging.jpeg.hpp>	// Pascal unit
#include <System.Variants.hpp>	// Pascal unit
#include <System.UITypes.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Frxexportimage
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TfrxCustomImageExport;
class PASCALIMPLEMENTATION TfrxCustomImageExport : public Frxclass::TfrxCustomExportFilter
{
	typedef Frxclass::TfrxCustomExportFilter inherited;
	
private:
	Vcl::Graphics::TBitmap* FBitmap;
	bool FCrop;
	int FCurrentPage;
	int FJPEGQuality;
	int FMaxX;
	int FMaxY;
	int FMinX;
	int FMinY;
	bool FMonochrome;
	int FResolution;
	int FCurrentRes;
	bool FSeparate;
	int FYOffset;
	System::UnicodeString FFileSuffix;
	bool FFirstPage;
	bool FExportNotPrintable;
	bool __fastcall SizeOverflow(const System::Extended Val);
	
protected:
	double FPaperWidth;
	double FPaperHeight;
	System::Extended FDiv;
	virtual void __fastcall Save(void);
	virtual void __fastcall FinishExport(void);
	
public:
	__fastcall virtual TfrxCustomImageExport(System::Classes::TComponent* AOwner);
	virtual System::Uitypes::TModalResult __fastcall ShowModal(void);
	virtual bool __fastcall Start(void);
	virtual void __fastcall Finish(void);
	virtual void __fastcall FinishPage(Frxclass::TfrxReportPage* Page, int Index);
	virtual void __fastcall StartPage(Frxclass::TfrxReportPage* Page, int Index);
	virtual void __fastcall ExportObject(Frxclass::TfrxComponent* Obj);
	__property int JPEGQuality = {read=FJPEGQuality, write=FJPEGQuality, default=90};
	__property bool CropImages = {read=FCrop, write=FCrop, default=0};
	__property bool Monochrome = {read=FMonochrome, write=FMonochrome, default=0};
	__property int Resolution = {read=FResolution, write=FResolution, nodefault};
	__property bool SeparateFiles = {read=FSeparate, write=FSeparate, nodefault};
	__property bool ExportNotPrintable = {read=FExportNotPrintable, write=FExportNotPrintable, nodefault};
	__property OverwritePrompt;
public:
	/* TfrxCustomExportFilter.CreateNoRegister */ inline __fastcall TfrxCustomImageExport(void) : Frxclass::TfrxCustomExportFilter() { }
	/* TfrxCustomExportFilter.Destroy */ inline __fastcall virtual ~TfrxCustomImageExport(void) { }
	
};


class DELPHICLASS TfrxEMFExport;
class PASCALIMPLEMENTATION TfrxEMFExport : public TfrxCustomImageExport
{
	typedef TfrxCustomImageExport inherited;
	
private:
	Vcl::Graphics::TMetafile* FMetafile;
	Vcl::Graphics::TMetafileCanvas* FMetafileCanvas;
	
protected:
	virtual void __fastcall FinishExport(void);
	
public:
	virtual bool __fastcall Start(void);
	virtual void __fastcall StartPage(Frxclass::TfrxReportPage* Page, int Index);
	virtual void __fastcall ExportObject(Frxclass::TfrxComponent* Obj);
	__fastcall virtual TfrxEMFExport(System::Classes::TComponent* AOwner);
	__classmethod virtual System::UnicodeString __fastcall GetDescription();
	
__published:
	__property CropImages = {default=0};
	__property OverwritePrompt;
public:
	/* TfrxCustomExportFilter.CreateNoRegister */ inline __fastcall TfrxEMFExport(void) : TfrxCustomImageExport() { }
	/* TfrxCustomExportFilter.Destroy */ inline __fastcall virtual ~TfrxEMFExport(void) { }
	
};


class DELPHICLASS TfrxBMPExport;
class PASCALIMPLEMENTATION TfrxBMPExport : public TfrxCustomImageExport
{
	typedef TfrxCustomImageExport inherited;
	
protected:
	virtual void __fastcall Save(void);
	
public:
	__fastcall virtual TfrxBMPExport(System::Classes::TComponent* AOwner);
	__classmethod virtual System::UnicodeString __fastcall GetDescription();
	
__published:
	__property CropImages = {default=0};
	__property Monochrome = {default=0};
	__property OverwritePrompt;
public:
	/* TfrxCustomExportFilter.CreateNoRegister */ inline __fastcall TfrxBMPExport(void) : TfrxCustomImageExport() { }
	/* TfrxCustomExportFilter.Destroy */ inline __fastcall virtual ~TfrxBMPExport(void) { }
	
};


class DELPHICLASS TfrxTIFFExport;
class PASCALIMPLEMENTATION TfrxTIFFExport : public TfrxCustomImageExport
{
	typedef TfrxCustomImageExport inherited;
	
private:
	bool FMultiImage;
	bool FIsStreamCreated;
	void __fastcall SaveTiffToStream(System::Classes::TStream* const Stream, Vcl::Graphics::TBitmap* const Bitmap, bool Split, bool WriteHeader = true);
	
protected:
	virtual void __fastcall Save(void);
	
public:
	__fastcall virtual TfrxTIFFExport(System::Classes::TComponent* AOwner);
	__classmethod virtual System::UnicodeString __fastcall GetDescription();
	virtual bool __fastcall Start(void);
	virtual void __fastcall Finish(void);
	virtual void __fastcall FinishPage(Frxclass::TfrxReportPage* Page, int Index);
	virtual void __fastcall StartPage(Frxclass::TfrxReportPage* Page, int Index);
	
__published:
	__property CropImages = {default=0};
	__property Monochrome = {default=0};
	__property OverwritePrompt;
	__property bool MultiImage = {read=FMultiImage, write=FMultiImage, default=0};
public:
	/* TfrxCustomExportFilter.CreateNoRegister */ inline __fastcall TfrxTIFFExport(void) : TfrxCustomImageExport() { }
	/* TfrxCustomExportFilter.Destroy */ inline __fastcall virtual ~TfrxTIFFExport(void) { }
	
};


class DELPHICLASS TfrxJPEGExport;
class PASCALIMPLEMENTATION TfrxJPEGExport : public TfrxCustomImageExport
{
	typedef TfrxCustomImageExport inherited;
	
protected:
	virtual void __fastcall Save(void);
	
public:
	__fastcall virtual TfrxJPEGExport(System::Classes::TComponent* AOwner);
	__classmethod virtual System::UnicodeString __fastcall GetDescription();
	
__published:
	__property JPEGQuality = {default=90};
	__property CropImages = {default=0};
	__property Monochrome = {default=0};
	__property OverwritePrompt;
public:
	/* TfrxCustomExportFilter.CreateNoRegister */ inline __fastcall TfrxJPEGExport(void) : TfrxCustomImageExport() { }
	/* TfrxCustomExportFilter.Destroy */ inline __fastcall virtual ~TfrxJPEGExport(void) { }
	
};


class DELPHICLASS TfrxGIFExport;
class PASCALIMPLEMENTATION TfrxGIFExport : public TfrxCustomImageExport
{
	typedef TfrxCustomImageExport inherited;
	
protected:
	virtual void __fastcall Save(void);
	
public:
	__fastcall virtual TfrxGIFExport(System::Classes::TComponent* AOwner);
	__classmethod virtual System::UnicodeString __fastcall GetDescription();
	
__published:
	__property CropImages = {default=0};
	__property Monochrome = {default=0};
	__property OverwritePrompt;
public:
	/* TfrxCustomExportFilter.CreateNoRegister */ inline __fastcall TfrxGIFExport(void) : TfrxCustomImageExport() { }
	/* TfrxCustomExportFilter.Destroy */ inline __fastcall virtual ~TfrxGIFExport(void) { }
	
};


class DELPHICLASS TfrxPNGExport;
class PASCALIMPLEMENTATION TfrxPNGExport : public TfrxCustomImageExport
{
	typedef TfrxCustomImageExport inherited;
	
protected:
	virtual void __fastcall Save(void);
	
public:
	__fastcall virtual TfrxPNGExport(System::Classes::TComponent* AOwner);
	__classmethod virtual System::UnicodeString __fastcall GetDescription();
	
__published:
	__property CropImages = {default=0};
	__property Monochrome = {default=0};
	__property OverwritePrompt;
public:
	/* TfrxCustomExportFilter.CreateNoRegister */ inline __fastcall TfrxPNGExport(void) : TfrxCustomImageExport() { }
	/* TfrxCustomExportFilter.Destroy */ inline __fastcall virtual ~TfrxPNGExport(void) { }
	
};


class DELPHICLASS TfrxIMGExportDialog;
class PASCALIMPLEMENTATION TfrxIMGExportDialog : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Stdctrls::TButton* OK;
	Vcl::Stdctrls::TButton* Cancel;
	Vcl::Stdctrls::TGroupBox* GroupPageRange;
	Vcl::Stdctrls::TGroupBox* GroupBox1;
	Vcl::Stdctrls::TCheckBox* CropPage;
	Vcl::Stdctrls::TLabel* Label2;
	Vcl::Stdctrls::TEdit* Quality;
	Vcl::Stdctrls::TCheckBox* Mono;
	Vcl::Dialogs::TSaveDialog* SaveDialog1;
	Vcl::Stdctrls::TLabel* DescrL;
	Vcl::Stdctrls::TRadioButton* AllRB;
	Vcl::Stdctrls::TRadioButton* CurPageRB;
	Vcl::Stdctrls::TRadioButton* PageNumbersRB;
	Vcl::Stdctrls::TEdit* PageNumbersE;
	Vcl::Stdctrls::TLabel* Label1;
	Vcl::Stdctrls::TEdit* Resolution;
	Vcl::Stdctrls::TCheckBox* SeparateCB;
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall PageNumbersEChange(System::TObject* Sender);
	void __fastcall PageNumbersEKeyPress(System::TObject* Sender, System::WideChar &Key);
	void __fastcall FormKeyDown(System::TObject* Sender, System::Word &Key, System::Classes::TShiftState Shift);
	
private:
	TfrxCustomImageExport* FFilter;
	void __fastcall SetFilter(TfrxCustomImageExport* const Value);
	
public:
	__property TfrxCustomImageExport* Filter = {read=FFilter, write=SetFilter};
public:
	/* TCustomForm.Create */ inline __fastcall virtual TfrxIMGExportDialog(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TfrxIMGExportDialog(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TfrxIMGExportDialog(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TfrxIMGExportDialog(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE void __fastcall GIFSaveToFile(const System::UnicodeString FileName, Vcl::Graphics::TBitmap* const Bitmap);
}	/* namespace Frxexportimage */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FRXEXPORTIMAGE)
using namespace Frxexportimage;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// FrxexportimageHPP
