
{******************************************}
{                                          }
{             FastReport v5.0              }
{            XML Excel export              }
{                                          }
{         Copyright (c) 1998-2014          }
{          by Alexander Fediachov,         }
{             Fast Reports Inc.            }
{                                          }
{******************************************}
{        Improved by Bysoev Alexander      }
{             Kanal-B@Yandex.ru            }
{******************************************}

unit frxExportXML;

interface

{$I frx.inc}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, extctrls, Printers, ComObj, frxClass, frxExportMatrix, frxProgress, Variants
{$IFDEF DELPHI16}
, System.UITypes
{$ENDIF}
;

type
  TfrxSplitToSheet = (ssNotSplit, ssRPages, ssPrintOnPrev, ssRowsCount);

  TfrxXMLExportDialog = class(TForm)
    OkB: TButton;
    CancelB: TButton;
    SaveDialog1: TSaveDialog;
    GroupPageRange: TGroupBox;
    DescrL: TLabel;
    AllRB: TRadioButton;
    CurPageRB: TRadioButton;
    PageNumbersRB: TRadioButton;
    PageNumbersE: TEdit;
    GroupQuality: TGroupBox;
    WCB: TCheckBox;
    ContinuousCB: TCheckBox;
    PageBreaksCB: TCheckBox;
    OpenExcelCB: TCheckBox;
    BackgrCB: TCheckBox;
    SplitToSheetGB: TGroupBox;
    RPagesRB: TRadioButton;
    PrintOnPrevRB: TRadioButton;
    RowsCountRB: TRadioButton;
    ERows: TEdit;
    NotSplitRB: TRadioButton;
    procedure FormCreate(Sender: TObject);
    procedure PageNumbersEChange(Sender: TObject);
    procedure PageNumbersEKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ERowsKeyPress(Sender: TObject; var Key: Char);
    procedure ERowsChange(Sender: TObject);
  end;

{$IFDEF DELPHI16}
[ComponentPlatformsAttribute(pidWin32 or pidWin64)]
{$ENDIF}
  TfrxXMLExport = class(TfrxCustomExportFilter)
  private
    FExportPageBreaks: Boolean;
    FExportStyles: Boolean;
    FFirstPage: Boolean;
    FMatrix: TfrxIEMatrix;
    FOpenExcelAfterExport: Boolean;
    FPageBottom: Extended;
    FPageLeft: Extended;
    FPageRight: Extended;
    FPageTop: Extended;
    FPageOrientation: TPrinterOrientation;
    FProgress: TfrxProgress;
    FWysiwyg: Boolean;
    FBackground: Boolean;
    FCreator: String;
    FEmptyLines: Boolean;
    FRowsCount: Integer;
    FSplit: TfrxSplitToSheet;

    procedure ExportPage(Stream: TStream);
    function ChangeReturns(const Str: String): String;
    function TruncReturns(const Str: WideString): WideString;
    procedure SetRowsCount(const Value: Integer);
  public
    constructor Create(AOwner: TComponent); override;
    class function GetDescription: String; override;
    function ShowModal: TModalResult; override;
    function Start: Boolean; override;
    procedure Finish; override;
    procedure FinishPage(Page: TfrxReportPage; Index: Integer); override;
    procedure StartPage(Page: TfrxReportPage; Index: Integer); override;
    procedure ExportObject(Obj: TfrxComponent); override;
  published
    property ExportStyles: Boolean read FExportStyles write FExportStyles default True;
    property ExportPageBreaks: Boolean read FExportPageBreaks write FExportPageBreaks default True;
    property OpenExcelAfterExport: Boolean read FOpenExcelAfterExport
      write FOpenExcelAfterExport default False;
    property Wysiwyg: Boolean read FWysiwyg write FWysiwyg default True;
    property Background: Boolean read FBackground write FBackground default False;
    property Creator: string read FCreator write FCreator;
    property EmptyLines: Boolean read FEmptyLines write FEmptyLines;
    property SuppressPageHeadersFooters;
    property OverwritePrompt;
    property RowsCount: Integer read FRowsCount write SetRowsCount;
    property Split: TfrxSplitToSheet read FSplit write FSplit;
  end;


implementation

uses frxUtils, frxFileUtils, frxUnicodeUtils, frxRes, frxrcExports, frxStorage, ShellApi;


{$R *.dfm}

const
  Xdivider = 1.6;
  Ydivider = 1.376;
  MargDiv = 26.6;
  XLMaxHeight = 409;


{ TfrxXMLExport }

constructor TfrxXMLExport.Create(AOwner: TComponent);
begin
  inherited;
  FExportPageBreaks := True;
  FExportStyles := True;
  FWysiwyg := True;
  FBackground := True;
  FCreator := 'FastReport';
  FilterDesc := frxGet(8105);
  DefaultExt := frxGet(8106);
  FEmptyLines := True;
end;

class function TfrxXMLExport.GetDescription: String;
begin
  Result := frxResources.Get('XlsXMLexport');
end;

function TfrxXMLExport.TruncReturns(const Str: WideString): WideString;
var
  l: Integer;
begin
  l := Length(Str);
  if (l > 1) and (Str[l - 1] = #13) and (Str[l] = #10) then
    Result := Copy(Str, 1, l - 2)
  else
    Result := Str;
end;

function TfrxXMLExport.ChangeReturns(const Str: string): string;
var
  i: Integer;
begin
  Result := '';

  for i := 1 to Length(Str) do
  case Str[i] of
    '&': Result := Result + '&amp;';
    '"': Result := Result + '&quot;';
    '<': Result := Result + '&lt;';
    '>': Result := Result + '&gt;';
    #13: {skip this symbol};
    #0..#12, #14..#31: Result := Result + '&#' + IntToStr(Ord(Str[i])) + ';';
    else Result := Result + Str[i]
  end
end;

procedure TfrxXMLExport.ExportPage(Stream: TStream);
var
  i, x, y, dx, dy, fx, fy, Page, LastPrevRow: Integer;
  {$IFDEF Delphi12}
  s: WideString;
  {$ELSE}
  s: string;
  {$ENDIF}
  sb, si, su, ss, decsep, thsep: String;
  dcol, drow: Extended;
  Vert, Horiz: String;
  obj: TfrxIEMObject;
  IEMPage: TfrxIEMPage;
  EStyle: TfrxIEMStyle;
  St, PrevPageName: String;
  PageBreak: TStringList;

  function IsDigits(const Str: String): Boolean;
  var
    i: Integer;
  begin
    Result := True;
    for i := 1 to Length(Str) do
      if not((AnsiChar(Str[i]) in ['0'..'9', ',' ,'.' ,'-', ' ', 'ð']) or (Ord(Str[i]) = 160)) then
      begin
        Result := False;
        break;
      end;
  end;

  procedure WriteExpLn(const str: String);
{$IFDEF Delphi12}
  var
    TempStr: AnsiString;
{$ENDIF}
  begin
{$IFDEF Delphi12}
    TempStr := UTF8Encode(str);
    if Length(TempStr) > 0 then
      Stream.Write(TempStr[1], Length(TempStr));
    Stream.Write(AnsiString(#13#10), 2);
{$ELSE}
    if Length(str) > 0 then
      Stream.Write(str[1], Length(str));
    Stream.Write(#13#10, 2);
{$ENDIF}
  end;

  procedure AlignFR2AlignExcel(HAlign: TfrxHAlign; VAlign: TfrxVAlign;
    var AlignH, AlignV: String);
  begin
    if HAlign = haLeft then
      AlignH := 'Left'
    else if HAlign = haRight then
      AlignH := 'Right'
    else if HAlign = haCenter then
      AlignH := 'Center'
    else if HAlign = haBlock then
      AlignH := 'Justify'
    else
      AlignH := '';
    if VAlign = vaTop then
      AlignV := 'Top'
    else if VAlign = vaBottom then
      AlignV := 'Bottom'
    else if VAlign = vaCenter then
      AlignV := 'Center'
    else
      AlignV := '';
  end;

  function ConvertFormat(const fstr, fdecsep, fthsep: string): string;
  var
    err, p : integer;
    s: string;
  begin
    result := '';
    s := '';
    if length(fstr)>0 then
    begin
      p := pos('.', fstr);
      if p > 0 then
      begin
        s := Copy(fstr, p+1, length(fstr)-p-1);
        val(s, p ,err);
        SetLength(s, p);
        if p>0 then
        begin
{$IFDEF Delphi12}
          s := StringOfChar(Char('0'), p);
{$ELSE}
          FillChar(s[1], p, '0');
{$ENDIF}
          s := '.' + s;
        end;
      end;
      case fstr[length(fstr)] of
        'n': result := '#,##0' + s;
        'f': result := '0' + s;
        'g': result := '0.##';
        'm': result := '#,##0.00';
//        'm': result := '#,##0.00&quotð.;&quot;';
      else
        result := '#,##0.00';
      end;
    end;
  end;

  procedure FinishWorkSheet;
  var
    i: Integer;
  begin
    WriteExpLn('</Table>');
    WriteExpLn('<WorksheetOptions xmlns="urn:schemas-microsoft-com:office:excel">');
    WriteExpLn('<PageSetup>');
    if FPageOrientation = poLandscape then
      WriteExpLn('<Layout x:Orientation="Landscape"/>');
    WriteExpLn('<PageMargins x:Bottom="' + frFloat2Str(FPageBottom / MargDiv, 2) +
      '" x:Left="' + frFloat2Str(FPageLeft / MargDiv, 2) +
      '" x:Right="' + frFloat2Str(FPageRight / MargDiv, 2) +
      '" x:Top="' + frFloat2Str(FPageTop / MargDiv, 2) + '"/>');
    WriteExpLn('</PageSetup>');
    WriteExpLn('</WorksheetOptions>');

    if FExportPageBreaks then
    begin
      WriteExpLn('<PageBreaks xmlns="urn:schemas-microsoft-com:office:excel">');
      WriteExpLn('<RowBreaks>');
      for i := 0 to PageBreak.Count - 1 do
      begin
        WriteExpLn('<RowBreak>');
        WriteExpLn('<Row>' + PageBreak[i] + '</Row>');
        WriteExpLn('</RowBreak>');
      end;
      WriteExpLn('</RowBreaks>');
      WriteExpLn('</PageBreaks>');
    end;
    if PageBreak.Count > 0 then
      LastPrevRow := LastPrevRow + StrToInt(PageBreak[PageBreak.Count - 1]);
    PageBreak.Clear;
    WriteExpLn('</Worksheet>');
  end;

  procedure StartWorkSheet(SheetName: String);
  var
    x:Integer;
  begin
    if SheetName = '' then SheetName := 'UnnamedPage_' + IntTostr(Page);
{$IFDEF Delphi12}
    WriteExpLn('<Worksheet ss:Name="' + SheetName + '">');
{$ELSE}
    WriteExpLn('<Worksheet ss:Name="' + UTF8Encode(SheetName) + '">');
{$ENDIF}

    WriteExpLn('<Table ss:ExpandedColumnCount="' + IntToStr(FMatrix.Width) + '"' +
      ' ss:ExpandedRowCount="' + IntToStr(FMatrix.Height) + '" x:FullColumns="1" x:FullRows="1">');

    for x := 1 to FMatrix.Width - 1 do
    begin
      dcol := (FMatrix.GetXPosById(x) - FMatrix.GetXPosById(x - 1)) / Xdivider;
      WriteExpLn('<Column ss:AutoFitWidth="0" ss:Width="' +
        frFloat2Str(dcol, 2) + '"/>');
    end;
  end;

  function BorderProp(fl: TfrxFrameLine): string;
  var
    sis: string;
  begin
    if fl.Width > 1 then i := 3 else i := 1;

    case fl.Style of
      fsSolid:      sis := 'Continuous';
      fsDash:       sis := 'Dash';
      fsDot:        sis := 'Dot';
      fsDashDot:    sis := 'Dot';
      fsDashDotDot: sis := 'Dot';
      fsDouble:     sis := 'Double';
      fsAltDot:     sis := 'Dot';
      fsSquare:     sis := 'Double';
    end;

    s := 'ss:Weight="' + IntToStr(i) + '" ';
    si := 'ss:Color="' + HTMLRGBColor(fl.Color) + '" ';
    Result := ' ss:LineStyle="' + sis + '" ' + s + si;
  end;

begin
  PageBreak := TStringList.Create;

  try
    if ShowProgress then
    begin
      FProgress := TfrxProgress.Create(nil);
      FProgress.Execute(FMatrix.PagesCount, 'Exporting pages', True, True);
    end;

    WriteExpLn('<?xml version="1.0"?>');
    WriteExpLn('<?mso-application progid="Excel.Sheet"?>');
{$IFDEF Delphi12}
    WriteExpLn('<?fr-application created="' + FCreator + '"?>');
{$ELSE}
    WriteExpLn('<?fr-application created="' + UTF8Encode(FCreator) + '"?>');
{$ENDIF}
    WriteExpLn('<?fr-application homesite="http://www.fast-report.com"?>');
    WriteExpLn('<Workbook xmlns="urn:schemas-microsoft-com:office:spreadsheet"');
    WriteExpLn(' xmlns:o="urn:schemas-microsoft-com:office:office"');
    WriteExpLn(' xmlns:x="urn:schemas-microsoft-com:office:excel"');
    WriteExpLn(' xmlns:ss="urn:schemas-microsoft-com:office:spreadsheet"');
    WriteExpLn(' xmlns:html="http://www.w3.org/TR/REC-html40">');
    WriteExpLn('<DocumentProperties xmlns="urn:schemas-microsoft-com:office:office">');
{$IFDEF Delphi12}
    WriteExpLn('<Title>' + Report.ReportOptions.Name + '</Title>');
    WriteExpLn('<Author>' + Report.ReportOptions.Author + '</Author>');
{$ELSE}
    WriteExpLn('<Title>' + UTF8Encode(Report.ReportOptions.Name) + '</Title>');
    WriteExpLn('<Author>' + UTF8Encode(Report.ReportOptions.Author) + '</Author>');
{$ENDIF}
//    WriteExpLn('<Created>' + DateToStr(CreationTime) + 'T' + TimeToStr(CreationTime) + 'Z</Created>');
{$IFDEF Delphi12}
    WriteExpLn('<Version>' + Report.ReportOptions.VersionMajor + '.' +
      Report.ReportOptions.VersionMinor + '.' +
      Report.ReportOptions.VersionRelease + '.' +
      Report.ReportOptions.VersionBuild + '</Version>');
{$ELSE}
    WriteExpLn('<Version>' + UTF8Encode(Report.ReportOptions.VersionMajor) + '.' +
      UTF8Encode(Report.ReportOptions.VersionMinor) + '.' +
      UTF8Encode(Report.ReportOptions.VersionRelease) + '.' +
      UTF8Encode(Report.ReportOptions.VersionBuild) + '</Version>');
{$ENDIF}
    WriteExpLn('</DocumentProperties>');
    WriteExpLn('<ExcelWorkbook xmlns="urn:schemas-microsoft-com:office:excel">');
    WriteExpLn('<ProtectStructure>False</ProtectStructure>');
    WriteExpLn('<ProtectWindows>False</ProtectWindows>');
    WriteExpLn('</ExcelWorkbook>');
    if FExportStyles then
    begin
      WriteExpLn('<Styles>');
      for x := 0 to FMatrix.StylesCount - 1 do
      begin
        EStyle := FMatrix.GetStyleById(x);
        s := 's' + IntToStr(x);
        WriteExpLn('<Style ss:ID="'+s+'">');
        if fsBold in EStyle.Font.Style then
          sb := ' ss:Bold="1"'
        else
          sb := '';
        if fsItalic in EStyle.Font.Style then
          si := ' ss:Italic="1"'
        else
          si := '';
        if fsUnderline in EStyle.Font.Style then
          su := ' ss:Underline="Single"'
        else
          su := '';
        if fsStrikeOut in EStyle.Font.Style then
          ss := ' ss:StrikeThrough="1"'
        else
          ss := '';
        WriteExpLn('<Font '+
          'ss:FontName="' + EStyle.Font.Name + '" '+
          'ss:Size="' + IntToStr(EStyle.Font.Size) + '" ' +
          'ss:Color="' + HTMLRGBColor(EStyle.Font.Color) + '"' + sb + si + su + ss + '/>');
        WriteExpLn('<Interior ss:Color="' + HTMLRGBColor(EStyle.Color) +
          '" ss:Pattern="Solid"/>');
        AlignFR2AlignExcel(EStyle.HAlign, EStyle.VAlign, Horiz, Vert);
        if (EStyle.Rotation > 0) and (EStyle.Rotation <= 90) then
          s := 'ss:Rotate="' + IntToStr(EStyle.Rotation) + '"'
        else  if (EStyle.Rotation < 360) and (EStyle.Rotation >= 270) then
          s := 'ss:Rotate="' + IntToStr(EStyle.Rotation - 360) + '"'
        else
          s := '';

        if EStyle.WordWrap then
          si := '" ss:WrapText="1" '
        else
          si := '" ss:WrapText="0" ';

        WriteExpLn('<Alignment ss:Horizontal="' + Horiz + '" ss:Vertical="' + Vert + si + s +'/>');
        WriteExpLn('<Borders>');
        if (ftLeft in EStyle.FrameTyp) then
          WriteExpLn('<Border ss:Position="Left"' + BorderProp(EStyle.LeftLine) + '/>');
        if (ftRight in EStyle.FrameTyp) then
          WriteExpLn('<Border ss:Position="Right"' + BorderProp(EStyle.RightLine) + '/>');
        if (ftTop in EStyle.FrameTyp) then
          WriteExpLn('<Border ss:Position="Top"' + BorderProp(EStyle.TopLine) + '/>');
        if (ftBottom in EStyle.FrameTyp) then
          WriteExpLn('<Border ss:Position="Bottom"' + BorderProp(EStyle.BottomLine) + '/>');
        WriteExpLn('</Borders>');

        if EStyle.DisplayFormat.DecimalSeparator = '' then
{$IFDEF DELPHI16}
          decsep := FormatSettings.DecimalSeparator
{$ELSE}
          decsep := DecimalSeparator
{$ENDIF}
        else
          decsep := EStyle.DisplayFormat.DecimalSeparator;

        if EStyle.DisplayFormat.ThousandSeparator = '' then
{$IFDEF DELPHI16}
          decsep := FormatSettings.ThousandSeparator
{$ELSE}
          decsep := ThousandSeparator
{$ENDIF}

        else
          decsep := EStyle.DisplayFormat.ThousandSeparator;

        if (EStyle.DisplayFormat.Kind = fkNumeric) and
          (EStyle.DisplayFormat.FormatStr <> '%2.2n') and
          (EStyle.DisplayFormat.FormatStr <> '') then
{$IFDEF Delphi12}
          WriteExpLn('<NumberFormat ss:Format="' + ConVertFormat(EStyle.DisplayFormat.FormatStr, decsep, thsep) + '"/>');
{$ELSE}
          WriteExpLn('<NumberFormat ss:Format="' + UTF8Encode(ConVertFormat(EStyle.DisplayFormat.FormatStr, decsep, thsep)) + '"/>');
{$ENDIF}
        WriteExpLn('</Style>');
      end;
      WriteExpLn('</Styles>');
    end;

    st := '';
    Page := 0;
    LastPrevRow := 0;
    IEMPage := FMatrix.IEPages[Page];
    if IEMPage <> nil then
      PrevPageName := IEMPage.PageName;
    StartWorkSheet(PrevPageName);
    for y := 0 to FMatrix.Height - 2 do
    begin
      drow := (FMatrix.GetYPosById(y + 1) - FMatrix.GetYPosById(y)) / Ydivider;
      WriteExpLn('<Row ss:Height="' + frFloat2Str(drow, 2) + '">');
      if (FMatrix.PagesCount > Page) or (FRowsCount > 0) then
        if (FMatrix.GetYPosById(y) >= FMatrix.GetPageBreak(Page)) or
        ((FRowsCount <= y + 1 - LastPrevRow) and (FRowsCount > 0)) then
        begin
          Inc(Page);
          PageBreak.Add(IntToStr(y + 1 - LastPrevRow));
          if ShowProgress then
          begin
            FProgress.Tick;
            if FProgress.Terminated then
              break;
          end;
        end;
      for x := 0 to FMatrix.Width - 1 do
      begin
        if ShowProgress then
          if FProgress.Terminated then
             break;
        si := ' ss:Index="' + IntToStr(x + 1) + '" ';
        i := FMatrix.GetCell(x, y);
        if (i <> -1) then
        begin
          Obj := FMatrix.GetObjectById(i);
          if Obj.Counter = 0 then
          begin
            FMatrix.GetObjectPos(i, fx, fy, dx, dy);
            Obj.Counter := 1;
            if Obj.IsText then
            begin
              if dx > 1 then
              begin
                s := 'ss:MergeAcross="' + IntToStr(dx - 1) + '" ';
                Inc(dx);
              end
              else
                s := '';
              if dy > 1 then
                sb := 'ss:MergeDown="' + IntToStr(dy - 1) + '" '
              else
                sb := '';
              if FExportStyles then
                st := 'ss:StyleID="' + 's' + IntToStr(Obj.StyleIndex) + '" '
              else
                st := '';
              WriteExpLn('<Cell' + si + s + sb + st + '>');

              s := TruncReturns(Obj.Memo.Text);
              if (Obj.Style.DisplayFormat.Kind = fkNumeric) and IsDigits(s) then
              begin

{$IFDEF DELPHI16}
                s := StringReplace(s, FormatSettings.ThousandSeparator, '', [rfReplaceAll]);
                s := StringReplace(s, FormatSettings.CurrencyString, '', [rfReplaceAll]);
                if Obj.Style.DisplayFormat.DecimalSeparator <> '' then
                  s := StringReplace(s, Obj.Style.DisplayFormat.DecimalSeparator, '.', [rfReplaceAll])
                else
                  s := StringReplace(s, FormatSettings.DecimalSeparator, '.', [rfReplaceAll]);
{$ELSE}
                s := StringReplace(s, ThousandSeparator, '', [rfReplaceAll]);
                s := StringReplace(s, CurrencyString, '', [rfReplaceAll]);
                if Obj.Style.DisplayFormat.DecimalSeparator <> '' then
                  s := StringReplace(s, Obj.Style.DisplayFormat.DecimalSeparator, '.', [rfReplaceAll])
                else
                  s := StringReplace(s, DecimalSeparator, '.', [rfReplaceAll]);
{$ENDIF}


                s := Trim(s);
                si := ' ss:Type="Number"';
{$IFDEF Delphi12}
                WriteExpLn('<Data' + si + '>' + s + '</Data>');
{$ELSE}
                WriteExpLn('<Data' + si + '>' + UTF8Encode(s) + '</Data>');
{$ENDIF}
              end
              else
              begin
                si := ' ss:Type="String"';
{$IFDEF Delphi12}
                s := ChangeReturns(s);
{$ELSE}
                s := ChangeReturns(UTF8Encode(s));
{$ENDIF}
                WriteExpLn('<Data' + si + '>' + s + '</Data>');
              end;
              WriteExpLn('</Cell>');
            end;
          end
        end
        else
          WriteExpLn('<Cell' + si + '/>');
      end;
      WriteExpLn('</Row>');


      if (FSplit = ssRowsCount) and
        ((FRowsCount <= y + 1 - LastPrevRow) and (FRowsCount > 0)) then
      begin
        FinishWorkSheet;
        StartWorkSheet('');
      end
      else
      begin
        IEMPage := FMatrix.IEPages[Page];
        if IEMPage <> nil then
          if ((FSplit = ssRPages) and (PrevpageName <> IEMPage.PageName))
            or ((FSplit = ssPrintOnPrev) and (PrevpageName <> IEMPage.PageName)
            and (Page > 0) and not IEMPage.PrintOnPreviousPage) then
          begin
            PrevpageName := IEMPage.PageName;
            FinishWorkSheet;
            StartWorkSheet(PrevPageName);
          end;
      end;

    end;

    FinishWorkSheet;
    WriteExpLn('</Workbook>');
  finally
    PageBreak.Free;
  end;
  if ShowProgress then
    FProgress.Free;
end;

function TfrxXMLExport.ShowModal: TModalResult;
begin
  if not Assigned(Stream) then
  begin
    with TfrxXMLExportDialog.Create(nil) do
    begin
      OpenExcelCB.Visible := not SlaveExport;
      if OverwritePrompt then
        SaveDialog1.Options := SaveDialog1.Options + [ofOverwritePrompt];
      if SlaveExport then
        FOpenExcelAfterExport := False;

      if (FileName = '') and (not SlaveExport) then
        SaveDialog1.FileName := ChangeFileExt(ExtractFileName(frxUnixPath2WinPath(Report.FileName)), SaveDialog1.DefaultExt)
      else
        SaveDialog1.FileName := FileName;

      ContinuousCB.Checked := (not EmptyLines) or SuppressPageHeadersFooters;
      PageBreaksCB.Checked := FExportPageBreaks and (not ContinuousCB.Checked);
      PrintOnPrevRB.Checked :=  (FSplit = ssPrintOnPrev);
      RPagesRB.Checked := (FSplit = ssRPages);
      NotSplitRB.Checked := (FSplit = ssNotSplit);
      if FRowsCount <> 0 then
      begin
        ERows.Text := IntToStr(FRowsCount);
        RowsCountRB.Checked := True;
      end;

      WCB.Checked := FWysiwyg;
      OpenExcelCB.Checked := FOpenExcelAfterExport;
      BackgrCB.Checked := FBackground;

      if PageNumbers <> '' then
      begin
        PageNumbersE.Text := PageNumbers;
        PageNumbersRB.Checked := True;
      end;

      Result := ShowModal;

      if Result = mrOk then
      begin
        PageNumbers := '';
        CurPage := False;
        if CurPageRB.Checked then
          CurPage := True
        else if PageNumbersRB.Checked then
          PageNumbers := PageNumbersE.Text;

        if RowsCountRB.Checked then
        begin
          FSplit := ssRowsCount;
          FRowsCount := StrToInt(ERows.Text);
        end
        else if PrintOnPrevRB.Checked then
          FSplit := ssPrintOnPrev
        else if RPagesRB.Checked then
          FSplit := ssRPages
        else
          FSplit := ssNotSplit;

        FExportPageBreaks := PageBreaksCB.Checked and (not ContinuousCB.Checked);
        EmptyLines := not ContinuousCB.Checked;
        SuppressPageHeadersFooters := ContinuousCB.Checked;
        FWysiwyg := WCB.Checked;
        FOpenExcelAfterExport := OpenExcelCB.Checked;
        FBackground := BackgrCB.Checked;

        if not SlaveExport then
        begin
          if DefaultPath <> '' then
            SaveDialog1.InitialDir := DefaultPath;
          if SaveDialog1.Execute then
            FileName := SaveDialog1.FileName
          else
            Result := mrCancel;
        end
      end;
      Free;
    end;
  end else
    Result := mrOk;
end;

function TfrxXMLExport.Start: Boolean;
begin
  if SlaveExport then
  begin
    if Report.FileName <> '' then
      FileName := ChangeFileExt(GetTemporaryFolder + ExtractFileName(Report.FileName), frxGet(8106))
    else
      FileName := ChangeFileExt(GetTempFile, frxGet(8106))
  end;
  if (FileName <> '') or Assigned(Stream) then
  begin
    if (ExtractFilePath(FileName) = '') and (DefaultPath <> '') then
      FileName := DefaultPath + '\' + FileName;
    FFirstPage := True;
    FMatrix := TfrxIEMatrix.Create(UseFileCache, Report.EngineOptions.TempDir);
    FMatrix.DotMatrix := Report.DotMatrixReport;
    FMatrix.ShowProgress := ShowProgress;
    FMatrix.MaxCellHeight := XLMaxHeight * Ydivider;
    FMatrix.Background := FBackground and FEmptyLines;
    FMatrix.BackgroundImage := False;
    FMatrix.Printable := ExportNotPrintable;
    FMatrix.RichText := True;
    FMatrix.PlainRich := True;
    FMatrix.EmptyLines := FEmptyLines;
    FExportPageBreaks := FExportPageBreaks and FEmptyLines;
    if FWysiwyg then
      FMatrix.Inaccuracy := 0.5
    else
      FMatrix.Inaccuracy := 10;
    FMatrix.DeleteHTMLTags := True;
    Result := True
  end
  else
    Result := False;
end;

procedure TfrxXMLExport.StartPage(Page: TfrxReportPage; Index: Integer);
begin
  if FFirstPage then
  begin
    FFirstPage := False;
    FPageLeft := Page.LeftMargin;
    FPageTop := Page.TopMargin;
    FPageBottom := Page.BottomMargin;
    FPageRight := Page.RightMargin;
    FPageOrientation := Page.Orientation;
  end;
end;

procedure TfrxXMLExport.ExportObject(Obj: TfrxComponent);
begin
  if Obj.Page <> nil then
    Obj.Page.Top := FMatrix.Inaccuracy;
  if Obj.Name = '_pagebackground' then
    Exit;
  if Obj is TfrxView then
    FMatrix.AddObject(TfrxView(Obj));
end;

procedure TfrxXMLExport.FinishPage(Page: TfrxReportPage; Index: Integer);
var
 IEMPage: TfrxIEMPage;
begin
  FMatrix.AddPage(Page.Orientation, Page.Width, Page.Height, Page.LeftMargin,
                  Page.TopMargin, Page.RightMargin, Page.BottomMargin, Page.MirrorMargins, Index);
  IEMPage := FMatrix.IEPages[Index];
  if IEMPage <> nil then
    with IEMPage do
    begin
       PageName := Page.Name;
       PrintOnPreviousPage := Page.PrintOnPreviousPage;
    end;

end;

procedure TfrxXMLExport.Finish;
var
  Exp: TStream;
//  Excel: Variant;
  CS: TCachedStream;
begin
  FMatrix.Prepare;
  try
    if Assigned(Stream) then
      Exp := Stream
    else
      Exp := TFileStream.Create(FileName, fmCreate);

    CS := TCachedStream.Create(Exp, False);

    try
      ExportPage(CS);
    finally
      CS.Free;

      if not Assigned(Stream) then
        Exp.Free;
    end;
    if FOpenExcelAfterExport and (not Assigned(Stream)) then
//{$IF FALSE}
//      try
//        begin
//          Excel := CreateOLEObject('Excel.Application');
//          Excel.Visible := True;
//          Excel.WorkBooks.Open(FileName);
//        end;
//      finally
//        Excel := Unassigned;
//      end;
//{$ELSE}
     ShellExecute(0,'open', PChar(FileName),nil,nil,SW_SHOWNORMAL);
//{$IFEND}
  except
    on e: Exception do
      case Report.EngineOptions.NewSilentMode of
        simSilent:        Report.Errors.Add(e.Message);
        simMessageBoxes:  frxErrorMsg(e.Message);
        simReThrow:       raise;
      end;
  end;
  FMatrix.Free;
end;

procedure TfrxXMLExport.SetRowsCount(const Value: Integer);
begin
  FRowsCount := Value;
  if Value > 0 then
    FSplit := ssRowsCount
  else
  begin
    FSplit := ssNotSplit;
    FRowsCount := 0;
  end;
end;

{ TfrxXMLExportDialog }

procedure TfrxXMLExportDialog.FormCreate(Sender: TObject);
begin
  Caption := frxGet(8100);
  OkB.Caption := frxGet(1);
  CancelB.Caption := frxGet(2);
  GroupPageRange.Caption := frxGet(7);
  AllRB.Caption := frxGet(3);
  CurPageRB.Caption := frxGet(4);
  PageNumbersRB.Caption := frxGet(5);
  DescrL.Caption := frxGet(9);
  GroupQuality.Caption := frxGet(8);
  ContinuousCB.Caption := frxGet(8950);
  PageBreaksCB.Caption := frxGet(6);
  WCB.Caption := frxGet(8102);
  BackgrCB.Caption := frxGet(8103);
  OpenExcelCB.Caption := frxGet(8104);
  SaveDialog1.Filter := frxGet(8105);
  SaveDialog1.DefaultExt := frxGet(8106);
  RowsCountRB.Caption := frxGet(9000);
  SplitToSheetGB.Caption := frxGet(9001);
  NotSplitRB.Caption := frxGet(9002);
  RPagesRB.Caption := frxGet(9003);
  PrintOnPrevRB.Caption := frxGet(9004);

  if UseRightToLeftAlignment then
    FlipChildren(True);
end;


procedure TfrxXMLExportDialog.PageNumbersEChange(Sender: TObject);
begin
  PageNumbersRB.Checked := True;
end;

procedure TfrxXMLExportDialog.PageNumbersEKeyPress(Sender: TObject;
  var Key: Char);
begin
  case key of
    '0'..'9':;
    #8, '-', ',':;
  else
    key := #0;
  end;
end;

procedure TfrxXMLExportDialog.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_F1 then
    frxResources.Help(Self);
end;

procedure TfrxXMLExportDialog.ERowsKeyPress(Sender: TObject;
  var Key: Char);
begin
  case key of
    '0'..'9', #8:;
  else
    key := #0;
  end;
end;

procedure TfrxXMLExportDialog.ERowsChange(Sender: TObject);
begin
  RowsCountRB.Checked := True;
end;

end.
