
{******************************************}
{                                          }
{             FastReport v5.0              }
{          Report Server engine            }
{                                          }
{         Copyright (c) 1998-2014          }
{          by Alexander Fediachov,         }
{             Fast Reports Inc.            }
{                                          }
{******************************************}

unit frxServerReports;

{$I frx.inc}
{$IFDEF Delphi12}
{$WARNINGS OFF}
{$ENDIF}

interface

uses
  Windows, SysUtils, Classes, Graphics, frxClass, frxExportHTML, frxExportRTF, frxExportBIFF, StdCtrls,
  frxExportText, frxExportCSV, frxExportPDF, frxExportXML, frxExportImage, frxVariables,
  frxXML, frxServerForms, frxServerCache, frxDCtrl, frxServerUtils, frxNetUtils,
  frxUnicodeUtils, frxServerLog, frxExportODF, frxServerPrinter, ActiveX, frxServerTemplates, frxImageConverter;

type
  TfrxReportSession = class(TThread)
  private
    FPath: String;
    FBasePath: String;
    FSessionId: String;
    FReportPath: String;
    FPageRange: String;
    FFormat: TfrxServerFormat;
    FMainDocument: String;
    FName: String;
    FVariables: TfrxVariables;
    FReportErrors: Boolean;
    FError: String;
    FResultPage: String;
    FReport: TfrxReport;
    FHTMLExport: TfrxHTMLExport;
    FXMLExport: TfrxXMLExport;
    FRTFExport: TfrxRTFExport;
    FTXTExport: TfrxSimpleTextExport;
    FJPGExport: TfrxJPEGExport;
    FBMPExport: TfrxBMPExport;
    FGIFExport: TfrxGIFExport;
    FTIFFExport: TfrxTIFFExport;
    FPDFExport: TfrxPDFExport;
    FCSVExport: TfrxCSVExport;
    FODSExport: TfrxODSExport;
    FODTExport: TfrxODTExport;
    FXLSExport: TfrxBIFFExport;
    FParentThread: TThread;
    CurPage: TfrxDialogPage;
    FParentReportServer: TComponent;
    FCached: Boolean;
    FNativeClient: Boolean;
    FStream: TMemoryStream;
    FCacheId: String;
    FPassword: String;
    FAuth: Boolean;
    FMessage: String;
    FPageNav: Boolean;
    FMultipage: Boolean;
    FUserLogin: String;
    FUserGroup: String;
    Fvarstr: String;
    FMime: String;
    FPrint: Boolean;
    FReportTitle: String;

    procedure DoExports;
    procedure DoError;
    procedure DoFillForm;
    procedure DoSaveForm;
    procedure ShowReportDialog(Page: TfrxDialogPage);
    procedure DoAfterBuildReport;
    function ExtractReportName(const FileName: String): String;
    procedure SetNavTemplate(const ReportName: String; Multipage: Boolean;
      PicsInSameFolder: Boolean;
      Prefix: String; TotalPages: Integer; var Template: String);
    procedure SetMainTemplate(const Title: String; const FrameFolder: String;
      Multipage: Boolean; Navigator: Boolean; var Template: String);
    procedure SetToolbarTemplate(CurrentPage: Integer; TotalPages: Integer; Multipage: Boolean; Navigator: Boolean; var Template: String);
//    procedure SetExportImage(Image: TGraphic; PicType: TfrxPictureType; var FileName: String);
    function GetResultFileName(const ext: String): String;
    function GetNavRequest(PageN: String): String;
    function GetExportButton(expName: String; exp: String): String;
  protected
    procedure Execute; override;
  public
    Active: Boolean;
    Continue: Boolean;
    DialogActive: Boolean;
    Readed: Boolean;
    constructor Create;
    destructor Destroy; override;

    property FileName: String read FName write FName;
    property ReportTitle: String read FReportTitle;
    property Format: TfrxServerFormat read FFormat write FFormat;
    property IndexFileName: String read FMainDocument write FMainDocument;
    property PageRange: String read FPageRange write FPageRange;
    property ParentThread: TThread read FParentThread write FParentThread;
    property ReportPath: String read FReportPath write FReportPath;
    property ResultPage: String read FResultPage;
    property RootPath: String read FBasePath write FBasePath;
    property SessionId: String read FSessionId write FSessionId;
    property CacheId: String read FCacheId write FCacheId;
    property Variables: TfrxVariables read FVariables write FVariables;
    property ParentReportServer: TComponent read FParentReportServer write FParentReportServer;
    property NativeClient: Boolean read FNativeClient write FNativeClient;
    property Stream: TMemoryStream read FStream write FStream;
    property Password: String read FPassword write FPassword;
    property Auth: Boolean read FAuth;
    property ReportMessage: String read FMessage;

    property PageNav: Boolean read FPageNav write FPageNav;
    property Multipage: Boolean read FMultipage write FMultipage;
    property UserLogin: String read FUserLogin write FUserLogin;
    property UserGroup: String read FUserGroup write FUserGroup;
    property Mime: String read FMime;
    property Print: Boolean read FPrint write FPrint;
  end;

implementation

uses frxServer, frxXMLSerializer, frxServerConfig, frxRes, frxrcExports;

{ TfrxReportSession }

constructor TfrxReportSession.Create;
var
  s: string;
begin
  inherited Create(True);
  Active := True;
  try
    FReport := TfrxReport.Create(nil);
    FReport.Engine.OnRunDialog := ShowReportDialog;
    FReport.EngineOptions.SilentMode := True;
    FReport.EngineOptions.EnableThreadSafe := True;
    FReport.EngineOptions.UseFileCache := ServerConfig.GetBool('server.reports.usefilecache');
    FReport.EngineOptions.MaxMemSize := StrToInt(ServerConfig.CheckValue('server.reports.maxmemsize', '10'));
    FReport.EngineOptions.TempDir := ServerConfig.CheckValue('server.reports.temp', '');
    s := frxGetAbsPathDir(ServerConfig.GetValue('server.reports.scripts'), ServerConfig.ConfigFolder);
    FReport.Script.IncludePath.Add(s);
    FReport.ShowProgress := False;
  except
    on E:Exception do
    begin
      FReport := nil;
      FError := 'TfrxReport create error. ' + E.Message;
      DoError;
    end;
  end;
end;

destructor TfrxReportSession.Destroy;
begin
  Terminate;
  PMessages;
  while DialogActive do
  begin
    Sleep(10);
    PMessages;
  end;
  if Assigned(FReport) then
  try
    FReport.Free;
  except
    on e: Exception do
    begin
      FError := 'TfrxReport destroy error ' + e.Message;
      DoError;
    end;
  end;
  inherited;
end;

procedure TfrxReportSession.Execute;
var
  i: Integer;
  VName: AnsiString;
  VValue: Variant;
  s: AnsiString;
  FResPrep: Boolean;
begin
  if FReport <> nil then
  begin
    LogWriter.StatAddCurrentReport;
    FResultPage := '';
    DialogActive := False;
    Readed := False;
    FCached := True;
    FAuth := False;

    CoInitialize(nil);

    if Assigned(FReport) then
    begin
      FPath := FBasePath + FSessionId;
      try
        if Assigned(TfrxReportServer(FParentReportServer).OnGetReport) then
          TfrxReportServer(FParentReportServer).OnGetReport(ExtractReportName(FName), FReport, FUserLogin)
        else
          if FileExists(FName) then
            try
              FReport.LoadFromFile(FName)
            except
              on E:Exception do
              begin
                FError := 'Report load error. ' + E.Message;
                DoError;
              end;
            end
          else
          begin
            FError := 'Report not found: ' + FName;
            DoError;
          end;
      except
        on E:Exception do
        begin
          FError := 'Report load error: ' + FName + E.Message;
          DoError;
        end;
      end;
      if FReport.ReportOptions.Password <> '' then
        s := FPassword
      else
        s := '';
      if FReport.ReportOptions.Password = s then
      begin
        fvarstr := '';
        if Assigned(FVariables) then
        begin
          for i := 0 to FVariables.Count - 1 do
          begin
            VName := FVariables.Items[i].Name;
            VValue := TfrxVariable(FVariables.Items[i]).Value;
            if FReport.ScriptLanguage = 'PascalScript' then
              VValue := QuotedStr(StringReplace(UnQuoteStr(VValue), '''', '''''', [rfReplaceAll]))
            else
              VValue := '"' + StringReplace(UnQuoteStr(VValue), '''', '""', [rfReplaceAll]) + '"';
            FReport.Variables[VName] := VValue;
            fvarstr := fvarstr + '&' + Vname + '=' + Str2HTML(UnQuoteStr(TfrxVariable(FVariables.Items[i]).Value));
          end;
        end;

        if FUserLogin <> '' then
        begin
          FReport.Variables['AUTHLOGIN'] := QuotedStr(FUserLogin);
          FReport.Variables['AUTHGROUP'] := QuotedStr(FUserGroup);
        end
        else
        begin
          FReport.Variables['AUTHLOGIN'] := QuotedStr('');
          FReport.Variables['AUTHGROUP'] := QuotedStr('');
        end;

        FReport.ReportOptions.ConnectionName := ServerConfig.GetValue('server.database.connection');

        if not ReportCache.GetCachedStream(FReport, ExtractReportName(FName), FReport.Variables, FCacheId) then
        try
          FResPrep := False;
          try
            FResPrep := FReport.PrepareReport;
          except
            on e: Exception do
            begin
              FError := 'Report not prepared: ' + e.Message;
              DoError;
            end;
          end;
          if FResPrep then
          begin
            if FCached then
              ReportCache.AddReport(FReport, ExtractReportName(FName), FReport.Variables, '', FSessionId)
            else
              ReportCache.AddReport(FReport, ExtractReportName(FName), FReport.Variables, FSessionId, FSessionId);
          end
          else begin
            FError := 'Report prepare error: ' + FReport.Errors.Text;
            DoError;
          end;
        except
          on e: Exception do
          begin
            FError := 'Report prepare exception: ' + FReport.Errors.Text + e.Message;
            DoError;
          end;
        end;

        if Assigned(TfrxReportServer(FParentReportServer).OnAfterBuildReport) then
          DoAfterBuildReport;

        if (not FReportErrors) and (not DialogActive) and (not Terminated) then
        begin
          try
            DoExports();
          except
            on e: Exception do
            begin
              FError := 'Export error: ' + e.Message;
              DoError;
            end;
          end;
        end;

      end
      else
      begin
        FAuth := True;
        FReport.Errors.Add('Authentification required')
      end;
    end;
    FMessage := FReport.Errors.Text;
    LogWriter.StatRemoveCurrentReport;
    Active := False;
    Sleep(3000);
  end;
end;

procedure TfrxReportSession.DoExports;
var
  s: string;
  i: Integer;
begin
  if (FFormat = sfXML) and (ServerConfig.GetBool('server.exports.xml.active')) then
  begin
    FXMLExport := TfrxXMLExport.Create(nil);
    try
      FXMLExport.ShowDialog := False;
      FXMLExport.ShowProgress := False;
      FXMLExport.PageNumbers := FPageRange;
      FXMLExport.UseFileCache := FReport.EngineOptions.UseFileCache;
      FXMLExport.SuppressPageHeadersFooters := ServerConfig.GetBool('server.exports.xml.continuous');
      FXMLExport.EmptyLines := ServerConfig.GetBool('server.exports.xml.emptylines');
      FXMLExport.ExportPageBreaks := ServerConfig.GetBool('server.exports.xml.pagebreaks');
      FXMLExport.ExportStyles := ServerConfig.GetBool('server.exports.xml.styles');
      FXMLExport.Wysiwyg := ServerConfig.GetBool('server.exports.xml.wysiwyg');
      FXMLExport.Background := ServerConfig.GetBool('server.exports.xml.background');
      s := ServerConfig.GetValue('server.exports.xml.splitype');
      if s = 'pages' then
        FXMLExport.Split := ssRPages
      else if s = 'printonprev' then
        FXMLExport.Split := ssPrintOnPrev
      else if s = 'rowscount' then
        FXMLExport.Split := ssRowsCount
      else
        FXMLExport.Split := ssNotSplit;
      FXMLExport.RowsCount := ServerConfig.GetNumber('server.exports.xml.splitrowscount');
      FResultPage := GetResultFileName(ServerConfig.GetValue('server.exports.xml.extension'));
      FMime := ServerConfig.GetValue('server.exports.xml.mimetype');
      FXMLExport.FileName := FPath + FResultPage;
      FReport.Export(FXMLExport);
    finally
      FXMLExport.Free;
    end
  end else if (FFormat = sfXLS) then
  begin
    FXLSExport := TfrxBIFFExport.Create(nil);
    try
      FXLSExport.ShowDialog := False;
      FXLSExport.ShowProgress := False;
      FXLSExport.PageNumbers := FPageRange;
      FXLSExport.UseFileCache := FReport.EngineOptions.UseFileCache;
      FResultPage := GetResultFileName('xls');
      FMime := 'application/vnd.ms-excel';
      FXLSExport.FileName := FPath + FResultPage;
      FReport.Export(FXLSExport);
    finally
      FXLSExport.Free;
    end
  end else if (FFormat = sfODS) and (ServerConfig.GetBool('server.exports.ods.active')) then
  begin
    FODSExport := TfrxODSExport.Create(nil);
    try
      FODSExport.ShowDialog := False;
      FODSExport.ShowProgress := False;
      FODSExport.PageNumbers := FPageRange;
      FODSExport.UseFileCache := FReport.EngineOptions.UseFileCache;
      FODSExport.SuppressPageHeadersFooters := ServerConfig.GetBool('server.exports.ods.continuous');
      FODSExport.EmptyLines := ServerConfig.GetBool('server.exports.ods.emptylines');
      FODSExport.ExportPageBreaks := ServerConfig.GetBool('server.exports.ods.pagebreaks');
      FODSExport.Wysiwyg := ServerConfig.GetBool('server.exports.ods.wysiwyg');
      FODSExport.Background := ServerConfig.GetBool('server.exports.ods.background');
      FResultPage := GetResultFileName('ods');
      FMime := ServerConfig.GetValue('server.exports.ods.mimetype');
      FODSExport.FileName := FPath + FResultPage;
      FReport.Export(FODSExport);
    finally
      FODSExport.Free;
    end
  end else if (FFormat = sfODT) and (ServerConfig.GetBool('server.exports.odt.active')) then
  begin
    FODTExport := TfrxODTExport.Create(nil);
    try
      FODTExport.ShowDialog := False;
      FODTExport.ShowProgress := False;
      FODTExport.PageNumbers := FPageRange;
      FODTExport.UseFileCache := FReport.EngineOptions.UseFileCache;
      FODTExport.SuppressPageHeadersFooters := ServerConfig.GetBool('server.exports.odt.continuous');
      FODTExport.EmptyLines := ServerConfig.GetBool('server.exports.odt.emptylines');
      FODTExport.ExportPageBreaks := ServerConfig.GetBool('server.exports.odt.pagebreaks');
      FODTExport.Wysiwyg := ServerConfig.GetBool('server.exports.odt.wysiwyg');
      FODTExport.Background := ServerConfig.GetBool('server.exports.odt.background');
      FResultPage := GetResultFileName('odt');
      FMime := ServerConfig.GetValue('server.exports.odt.mimetype');
      FODTExport.FileName := FPath + FResultPage;
      FReport.Export(FODTExport);
    finally
      FODTExport.Free;
    end
  end else if (FFormat = sfRTF) and (ServerConfig.GetBool('server.exports.rtf.active')) then
  begin
    FRTFExport := TfrxRTFExport.Create(nil);
    try
      FRTFExport.ShowDialog := False;
      FRTFExport.ShowProgress := False;
      FRTFExport.PageNumbers := FPageRange;
      FRTFExport.UseFileCache := FReport.EngineOptions.UseFileCache;
      FRTFExport.ExportPageBreaks := ServerConfig.GetBool('server.exports.rtf.pagebreaks');
      FRTFExport.ExportPictures := ServerConfig.GetBool('server.exports.rtf.pictures');
      FRTFExport.Wysiwyg := ServerConfig.GetBool('server.exports.rtf.wysiwyg');
      FResultPage := GetResultFileName('rtf');
      FMime := ServerConfig.GetValue('server.exports.rtf.mimetype');
      FRTFExport.FileName := FPath + FResultPage;
      FReport.Export(FRTFExport);
    finally
      FRTFExport.Free;
    end
  end else if (FFormat = sfCSV) and (ServerConfig.GetBool('server.exports.csv.active')) then
  begin
    FCSVExport := TfrxCSVExport.Create(nil);
    try
      FCSVExport.ShowDialog := False;
      FCSVExport.ShowProgress := False;
      FCSVExport.PageNumbers := FPageRange;
      FCSVExport.UseFileCache := FReport.EngineOptions.UseFileCache;
      FCSVExport.OEMCodepage := ServerConfig.GetBool('server.exports.csv.oemcodepage');
      FCSVExport.Separator := ServerConfig.CheckValue('server.exports.csv.separator', ';');
      FResultPage := GetResultFileName('csv');
      FMime := ServerConfig.GetValue('server.exports.csv.mimetype');
      FCSVExport.FileName := FPath + FResultPage;
      FReport.Export(FCSVExport);
    finally
      FCSVExport.Free;
    end
  end else if (FFormat = sfTXT) and (ServerConfig.GetBool('server.exports.txt.active'))  then
  begin
    FTXTExport := TfrxSimpleTextExport.Create(nil);
    try
      FTXTExport.ShowDialog := False;
      FTXTExport.ShowProgress := False;
      FTXTExport.PageNumbers := FPageRange;
      FTXTExport.UseFileCache := FReport.EngineOptions.UseFileCache;
      FTXTExport.PageBreaks := ServerConfig.GetBool('server.exports.txt.pagebreaks');
      FTXTExport.OEMCodepage := ServerConfig.GetBool('server.exports.txt.oemcodepage');
      FResultPage := GetResultFileName('txt');
      FMime := ServerConfig.GetValue('server.exports.txt.mimetype');
      FTXTExport.FileName := FPath + FResultPage;
      FReport.Export(FTXTExport);
    finally
      FTXTExport.Free;
    end
  end else if (FFormat = sfJPG) and (ServerConfig.GetBool('server.exports.jpg.active')) then
  begin
    FJPGExport := TfrxJPEGExport.Create(nil);
    try
      FJPGExport.ShowDialog := False;
      FJPGExport.PageNumbers := FPageRange;
      FJPGExport.UseFileCache := FReport.EngineOptions.UseFileCache;
      FJPGExport.CropImages := ServerConfig.GetBool('server.exports.jpg.crop');
      FJPGExport.Monochrome := ServerConfig.GetBool('server.exports.jpg.monochrome');
      FJPGExport.JPEGQuality := StrToInt(ServerConfig.CheckValue('server.exports.jpg.quality', '80'));
      FJPGExport.Resolution := StrToInt(ServerConfig.CheckValue('server.exports.jpg.resolution', '72'));
      FJPGExport.SeparateFiles := not ServerConfig.GetBool('server.exports.jpg.singlefile');
      FResultPage := GetResultFileName('jpg');
      FMime := ServerConfig.GetValue('server.exports.jpg.mimetype');
      FJPGExport.FileName := FPath + FResultPage;
      FReport.Export(FJPGExport);
      FResultPage := GetResultFileName('1.jpg');
    finally
      FJPGExport.Free;
    end
  end else if (FFormat = sfBMP) and (ServerConfig.GetBool('server.exports.bmp.active')) then
  begin
    FBMPExport := TfrxBMPExport.Create(nil);
    try
      FBMPExport.ShowDialog := False;
      FBMPExport.PageNumbers := FPageRange;
      FBMPExport.UseFileCache := FReport.EngineOptions.UseFileCache;
      FBMPExport.CropImages := ServerConfig.GetBool('server.exports.bmp.crop');
      FBMPExport.Monochrome := ServerConfig.GetBool('server.exports.bmp.monochrome');
      FBMPExport.Resolution := StrToInt(ServerConfig.CheckValue('server.exports.bmp.resolution', '72'));
      FBMPExport.SeparateFiles := not ServerConfig.GetBool('server.exports.bmp.singlefile');
      FResultPage := GetResultFileName('bmp');
      FMime := ServerConfig.GetValue('server.exports.bmp.mimetype');
      FBMPExport.FileName := FPath + FResultPage;
      FReport.Export(FBMPExport);
      FResultPage := GetResultFileName('1.bmp');
    finally
      FBMPExport.Free;
    end
  end else if (FFormat = sfGIF) and (ServerConfig.GetBool('server.exports.gif.active')) then
  begin
    FGIFExport := TfrxGIFExport.Create(nil);
    try
      FGIFExport.ShowDialog := False;
      FGIFExport.PageNumbers := FPageRange;
      FGIFExport.UseFileCache := FReport.EngineOptions.UseFileCache;
      FGIFExport.CropImages := ServerConfig.GetBool('server.exports.gif.crop');
      FGIFExport.Resolution := StrToInt(ServerConfig.CheckValue('server.exports.gif.resolution', '72'));
      FGIFExport.SeparateFiles := not ServerConfig.GetBool('server.exports.gif.singlefile');
      FResultPage := GetResultFileName('gif');
      FMime := ServerConfig.GetValue('server.exports.gif.mimetype');
      FGIFExport.FileName := FPath + FResultPage;
      FReport.Export(FGIFExport);
      FResultPage := GetResultFileName('1.gif');
    finally
      FGIFExport.Free;
    end
  end else if (FFormat = sfTIFF) and (ServerConfig.GetBool('server.exports.tiff.active')) then
  begin
    FTIFFExport := TfrxTIFFExport.Create(nil);
    try
      FTIFFExport.ShowDialog := False;
      FTIFFExport.PageNumbers := FPageRange;
      FTIFFExport.UseFileCache := FReport.EngineOptions.UseFileCache;
      FTIFFExport.CropImages := ServerConfig.GetBool('server.exports.tiff.crop');
      FTIFFExport.Monochrome := ServerConfig.GetBool('server.exports.tiff.monochrome');
      FTIFFExport.Resolution := StrToInt(ServerConfig.CheckValue('server.exports.tiff.resolution', '72'));
      FTIFFExport.SeparateFiles := not ServerConfig.GetBool('server.exports.tiff.singlefile');
      FResultPage := GetResultFileName('tif');
      FMime := ServerConfig.GetValue('server.exports.tiff.mimetype');
      FTIFFExport.FileName := FPath + FResultPage;
      FReport.Export(FTIFFExport);
      FResultPage := GetResultFileName('1.tif');
    finally
      FTIFFExport.Free;
    end
  end else if (FFormat = sfPDF) and (ServerConfig.GetBool('server.exports.pdf.active')) then
  begin
    FPDFExport := TfrxPDFExport.Create(nil);
    try
      FPDFExport.ShowDialog := False;
      FPDFExport.PageNumbers := FPageRange;
      FPDFExport.EmbeddedFonts := ServerConfig.GetBool('server.exports.pdf.embeddedfonts');
      FResultPage := GetResultFileName('pdf');
      FMime := ServerConfig.GetValue('server.exports.pdf.mimetype');
      FPDFExport.FileName := FPath + FResultPage;
      FPDFExport.Background := ServerConfig.GetBool('server.exports.pdf.background');
      FPDFExport.UseFileCache := FReport.EngineOptions.UseFileCache;
      FPDFExport.Outline := ServerConfig.GetBool('server.exports.pdf.outline') and FReport.PreviewOptions.OutlineVisible;
      FPDFExport.HTMLTags := ServerConfig.GetBool('server.exports.pdf.htmltags');
      FPDFExport.PrintOptimized := ServerConfig.GetBool('server.exports.pdf.printoptimized');
      FReport.Export(FPDFExport);
    finally
      FPDFExport.Free;
    end
  end else if (FFormat = sfFRP) and (ServerConfig.GetBool('server.exports.fp3.active')) then
  begin
    FResultPage := GetResultFileName('fp3');
    FMime := ServerConfig.GetValue('server.exports.fp3.mimetype');
    FMime := 'application/fastreport';
    FReport.PreviewPages.SaveToFile(FPath + FResultPage);
  end else
  // default output
  if (ServerConfig.GetBool('server.exports.html.active')) then
  begin
    FHTMLExport := TfrxHTMLExport.Create(nil);
    try
      FMime := ServerConfig.GetValue('server.exports.html.mimetype');
      FHTMLExport.ShowDialog := False;
      FHTMLExport.ShowProgress := False;
      FHTMLExport.AbsLinks := True;
      FHTMLExport.Server := True;
      FHTMLExport.PageNumbers := FPageRange;
      FHTMLExport.FixedWidth := ServerConfig.GetBool('server.exports.html.fixedwidth');
      FHTMLExport.PicsInSameFolder := ServerConfig.GetBool('server.exports.html.allinonefolder');
      FHTMLExport.Multipage := FMultipage;
      FHTMLExport.Navigator := FPageNav;
      s := ServerConfig.GetValue('server.exports.html.picsformat');
      if s = 'jpeg' then
        FHTMLExport.PictureType := gpJPG
      else
        FHTMLExport.PictureType := gpGIF;
      FHTMLExport.ExportPictures := ServerConfig.GetBool('server.exports.html.pictures');
      FHTMLExport.ExportStyles := ServerConfig.GetBool('server.exports.html.styles');
      FHTMLExport.Background := ServerConfig.GetBool('server.exports.html.background');
      FHTMLExport.UseFileCache := FReport.EngineOptions.UseFileCache;
      FHTMLExport.ReportPath := frxGetAbsPathDir(ServerConfig.GetValue('server.reports.path'), ServerConfig.ConfigFolder);
      FHTMLExport.URLTarget := ServerConfig.GetValue('server.exports.html.urltarget');
      FHTMLExport.UseTemplates := True;

      if FPrint then
      begin
        FHTMLExport.Print := true;
        FHTMLExport.Navigator := false;
        FHTMLExport.Multipage := false;
      end;

      if Assigned(FParentReportServer) then
      begin

        if TfrxReportServer(FParentReportServer).PrintPDF then
          FHTMLExport.PrintLink := 'result?report=' + Str2HTML(ExtractReportName(FName)) +
            '&format=PDF&pagerange=' + FPageRange +
            '&cacheid=' + FSessionId;

        FHTMLExport.OnGetNavTemplate := SetNavTemplate;
        FHTMLExport.OnGetMainTemplate := SetMainTemplate;
        FHTMLExport.OnGetToolbarTemplate := SetToolbarTemplate;
        //FHTMLExport.OnExportImage := SetExportImage;
      end;

      FHTMLExport.RefreshLink := 'result?report=' + Str2HTML(ExtractReportName(FName)) + '&multipage=' + IntToStr(ord(FHTMLExport.Multipage));

      if Assigned(FVariables) then
      begin
        for i := 0 to FVariables.Count - 1 do
          FHTMLExport.PrintLink := FHTMLExport.PrintLink + '&' +
            UnQuoteStr(Str2HTML(FVariables.Items[i].Name)) + '=' +
            UnQuoteStr(Str2HTML(FVariables.Items[i].Value));
        for i := 0 to FVariables.Count - 1 do
          FHTMLExport.RefreshLink := FHTMLExport.RefreshLink + '&' +
            UnQuoteStr(Str2HTML(FVariables.Items[i].Name)) + '=' +
            UnQuoteStr(Str2HTML(FVariables.Items[i].Value));
      end;

      s := ServerConfig.GetValue('server.http.indexfile');
      FResultPage := '\' + s;
      FHTMLExport.FileName := FPath + FResultPage;
      FReport.Export(FHTMLExport);

      if (not FHTMLExport.Navigator) and FHTMLExport.Multipage then
        FResultPage := '\' + ChangeFileExt(s, '.1.html')

    finally
      FHTMLExport.Free;
    end
  end;
end;

{procedure TfrxReportSession.SetExportImage(Image: TGraphic; PicType: TfrxPictureType; var FileName: String);
begin
  // to-do
end;}

procedure TfrxReportSession.DoError;
begin
  FReportErrors := True;
  LogWriter.Write(ERROR_LEVEL, DateTimeToStr(Now) + #9 + FSessionId + #9'report session error: ' + FError);
  LogWriter.ErrorReached;
end;

procedure TfrxReportSession.ShowReportDialog(Page: TfrxDialogPage);
begin
  CurPage := Page;
  FCached := False;
  DoSaveForm;
  Continue := False;
  DialogActive := True;
  FReport.DoNotifyEvent(Page, Page.OnActivate);
  while (not Continue) and (not Terminated) do
  begin
    Sleep(1);
    PMessages;
  end;
  DoFillForm;
  DialogActive := False;
  FReport.DoNotifyEvent(Page, Page.OnDeactivate);
  while (not Readed) and (not Terminated) do
  begin
    Sleep(1);
    PMessages;
  end;
  Sleep(300);
end;

procedure TfrxReportSession.DoFillForm;
var
  i, j: Integer;
  Control: TfrxDialogControl;
  s: AnsiString;
  Reader: TfrxXMLSerializer;
begin
  if FNativeClient and (FStream.Size > 0) then
  begin
    FStream.Position := 0;
    Reader := TfrxXMLSerializer.Create(FStream);
    try
      Reader.Owner := FReport;
      try
        Reader.ReadRootComponent(CurPage, nil);
      except
        on E:Exception do
        begin
          FError := 'Dialog form error: ' + e.Message;
          DoError;
        end;
      end;
    finally
      Reader.Free;
    end
  end
  else if (not Terminated) and Assigned(FVariables) then
  begin
    for i := 0 to CurPage.AllObjects.Count - 1 do
    begin
       Control := TfrxDialogControl(CurPage.AllObjects[i]);
       if Control.Parent <> nil then
         s := Control.Parent.Name + '_' + Control.Name
       else
         s:= Control.Name;
       j := FVariables.IndexOf(s);
       if (j = -1) and (Control.Parent <> nil) and (Pos('_', s) > 0) then
         j := FVariables.IndexOf(Control.Parent.Name);
       if j <> -1 then
       begin
         s := FVariables.Items[j].Value;
         s := UnQuoteStr(s);
         if Control is TfrxEditControl then
           TfrxEditControl(Control).Text := s;
         if Control is TfrxDateEditControl then
           TfrxDateEditControl(Control).Date := StrToDate(s);
         if (Control is TfrxCheckBoxControl) then
         begin
           if (Pos(Control.Name, s) > 0) then
             TfrxCheckBoxControl(Control).Checked := True
           else
             TfrxCheckBoxControl(Control).Checked := False;
         end;
         if (Control is TfrxRadioButtonControl) then
         begin
           if (Pos(Control.Name, s) > 0) then
             TfrxRadioButtonControl(Control).Checked := True
           else
             TfrxRadioButtonControl(Control).Checked := False;
         end;
         if Control is TfrxMemoControl then
           TfrxMemoControl(Control).Text := s;
         if Control is TfrxComboBoxControl then
           TfrxComboBoxControl(Control).ItemIndex := StrToInt(s);
       end else
       begin
         if Control is TfrxCheckBoxControl then
           TfrxCheckBoxControl(Control).Checked := False;
         if Control is TfrxRadioButtonControl then
           TfrxRadioButtonControl(Control).Checked := False;
       end;
    end;
  end;
end;

procedure TfrxReportSession.DoSaveForm;
var
  WebForm: TfrxWebForm;
  f: TFileStream;
begin
  if not FNativeClient then
  begin
    WebForm := TfrxWebForm.Create(CurPage, FSessionId);
    try
      WebForm.ReportName := ExtractReportName(FReport.FileName);
      WebForm.Prepare;
      FResultPage := '\' + 'form.html';
      WebForm.SaveFormToFile(FPath + FResultPage);
    finally
      WebForm.Free;
    end;
  end
  else begin
    FResultPage := '\' + 'result.frm';
    f := TFileStream.Create(FPath + FResultPage, fmCreate);
    try
      CurPage.SaveToStream(f);
    finally
      FlushFileBuffers(f.Handle);
      f.Free;
    end;
  end;
end;

procedure TfrxReportSession.DoAfterBuildReport;
begin
  TfrxReportServer(ParentReportServer).OnAfterBuildReport(FName, FVariables, FUserLogin);
end;

function TfrxReportSession.ExtractReportName(const FileName: String): String;
begin
  Result := StringReplace(FileName, frxGetAbsPathDir(ServerConfig.GetValue('server.reports.path'), ServerConfig.ConfigFolder), '', [])
end;


procedure TfrxReportSession.SetNavTemplate(const ReportName: String;
  Multipage: Boolean; PicsInSameFolder: Boolean; Prefix: String; TotalPages: Integer;
  var Template: String);
begin
  Template := '';
end;

procedure TfrxReportSession.SetToolbarTemplate(CurrentPage: Integer; TotalPages: Integer; Multipage: Boolean; Navigator: Boolean; var Template: String);
var
  FTemplate: TfrxServerTemplate;
  navigation, s, id: String;
begin
  Template := '';
  if Navigator then
  begin
    FTemplate := TfrxServerTemplate.Create;
    try
      FTemplate.SetTemplate('toolbar');
      navigation := '';

      navigation := navigation + '<div class="td divider">&nbsp;</div>' +
        '<ul class="td nav">' +
        '<li><input class="nav export_button" type="button" value=""/>' +
        '<ul class="round">' +
        GetExportButton('Acrobat PDF', 'PDF') +
        GetExportButton('Rich Text', 'RTF') +
        GetExportButton('Open Document Text', 'ODT') +
        GetExportButton('Open Document Spreadsheet', 'ODS') +
        GetExportButton('Excel table', 'XLS') +
        GetExportButton('XML table', 'XML') +
        GetExportButton('Comma separated text', 'CSV') +
        GetExportButton('Plain text', 'TXT') +
        GetExportButton('FastReport prepared', 'FP3') +
        '</ul></li></ul>';

      // print
      navigation := navigation + '<div class="td divider">&nbsp;</div>' +
        '<ul class="td nav"><li><input class="nav print_button" type="button" value="" title="Print" onclick="' +
        'window.open(window.location + ''&print=1'', ''_blank'')"/></li></ul>';

      // refresh
      navigation := navigation + '<div class="td divider">&nbsp;</div>' +
        '<ul class="td nav"><li><input class="nav refresh_button" type="button" value="" title="Refresh" onclick="' +
        'window.location.reload(true)"/></li></ul>';

      if (TotalPages > 1) and Multipage then
      begin
         if CurrentPage = 1 then
           s := 'disabled=disabled'
         else
          s := '';
         navigation := navigation + '<div class="td divider">&nbsp;</div><input class="td nav first_button" type="button" name="first" value="" ' +
         s +
         ' title="First" onclick="' +
         GetNavRequest('1') +'"/>';

         navigation := navigation + '<div class="td divider">&nbsp;</div><input class="td nav prev_button" type="button" name="prev" value="" ' +
         s +
         ' title="Previous" onclick="' +
         GetNavRequest(IntToStr(CurrentPage - 1)) +'"/>';

         id := 'FrReportPageN';
         s := '<input class="td input center" type="text" name="page" value="' +
            IntToStr(CurrentPage) + '" ' +
            'size="4" onchange="' +
            GetNavRequest(''' + document.getElementById(''FrReportPageN'').value + ''') +
            '" title="Enter page" id="' + id + '"/>';

         navigation := navigation + s + '<div class="td delim">/</div>';

         s := '<input class="td input center" type="text" value="' +
         IntToStr(TotalPages) + '" size="4" readonly="readonly" title="Total pages"/>';

         navigation := navigation + s;

         if CurrentPage = TotalPages then
           s := 'disabled=disabled'
         else
          s := '';
         navigation := navigation + '<input class="td nav next_button" type="button" name="next" value="" ' +
         s +
         ' title="Next" onclick="' +
         GetNavRequest(IntToStr(CurrentPage + 1)) +'"/>';

         navigation := navigation + '<div class="td divider">&nbsp;</div><input class="td nav last_button" type="button" name="last" value="" ' +
         s +
         ' title="Last" onclick="' +
         GetNavRequest(IntToStr(TotalPages)) +'"/>';
      end;

      FTemplate.Variables.AddVariable('navigation', navigation);
      FTemplate.Variables.AddVariable('reportid', '<input type="hidden" name="object" value="' + FSessionId + '"/>');
      FTemplate.Prepare;
      Template := FTemplate.TemplateStrings.Text;
    finally
      FTemplate.Free;
    end;
  end;
end;

function TfrxReportSession.GetNavRequest(PageN: String): String;
begin
  result := 'frRequestServer(''/' + FSessionId + '/index.' + PageN + '.html'')';
end;

function TfrxReportSession.GetExportButton(expName: String; exp: String): String;
begin
  result := '<li class="menuitem"><input class="menutext" type="button" name="format" value="' + expName + '" onclick="window.open(window.location + ''&format=' +
    exp + ''')"/></li>';
end;


procedure TfrxReportSession.SetMainTemplate(const Title,
  FrameFolder: String; Multipage: Boolean; Navigator: Boolean; var Template: String);
var
  FTemplate: TfrxServerTemplate;
  s: String;
begin
  Template := '';
  FReportTitle := Title;
  FTemplate := TfrxServerTemplate.Create;
  try
    FTemplate.SetTemplate('index');
    FTemplate.Variables.AddVariable('TITLE', Title);
    FTemplate.Variables.AddVariable('SESSION', FSessionId);
    if Multipage then
      s := '1.html'
    else
    if Navigator then
      s := 'main.html'
    else
      s := 'html';
    FTemplate.Variables.AddVariable('INDEX', '/' + FSessionId + '/index.' + s);
    FTemplate.Prepare;
    Template := FTemplate.TemplateStrings.Text;
  finally
    FTemplate.Free;
  end;
end;

function TfrxReportSession.GetResultFileName(const ext: String): String;
begin
  Result := '\' +  StringReplace(StringReplace(StringReplace(ExtractFileName(ExtractReportName(FName)),
    '.fr3', '', [rfReplaceAll]), '.', '_', [rfReplaceAll]), ' ', '_', [rfReplaceAll]) +
    '_' + FormatDateTime('YYYYMMDDHHMM', Now) + '.' + ext;
end;

end.


