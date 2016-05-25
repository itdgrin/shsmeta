
{******************************************}
{                                          }
{             FastReport v5.0              }
{               XLSX export                }
{                                          }
{         Copyright (c) 1998-2010          }
{             Fast Reports Inc.            }
{                                          }
{******************************************}

unit frxExportXLSX;

interface

{$I frx.inc}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, Types,
  StdCtrls, ExtCtrls, frxClass, frxExportMatrix, ShellAPI, ComCtrls, frxZip,
  frxOfficeOpen, frxImageConverter
{$IFDEF DELPHI16}
, System.UITypes
{$ENDIF}
;

type
  TfrxXLSXExportDialog = class(TForm)
    OkB: TButton;
    CancelB: TButton;
    sd: TSaveDialog;
    GroupPageRange: TGroupBox;
    DescrL: TLabel;
    AllRB: TRadioButton;
    CurPageRB: TRadioButton;
    PageNumbersRB: TRadioButton;
    PageNumbersE: TEdit;
    GroupOptions: TGroupBox;
    ContinuousCB: TCheckBox;
    SplitToSheetGB: TGroupBox;
    RPagesRB: TRadioButton;
    NotSplitRB: TRadioButton;
    RowsCountRB: TRadioButton;
    edChunk: TEdit;
    OpenCB: TCheckBox;
    PageBreaksCB: TCheckBox;
    WCB: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure PageNumbersEChange(Sender: TObject);
    procedure PageNumbersEKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  end;

{$IFDEF DELPHI16}
[ComponentPlatformsAttribute(pidWin32 or pidWin64)]
{$ENDIF}
  TfrxXLSXExport = class(TfrxCustomExportFilter)
  private
    FExportPageBreaks: Boolean;
    FEmptyLines: Boolean;
    FOpenAfterExport: Boolean;
    FMatrix: TfrxIEMatrix;
    FDocFolder: string;
    FContentTypes: TStream; // [Content_Types].xml
    FRels: TStream; // _rels/.rels
    FStyles: TStream; // xl/styles.xml
    FWorkbook: TStream; // xl/workbook.xml
    FSharedStrings: TStream; // sharedStrings.xml
    FWorkbookRels: TStream; // xl/_rels/workbook.xml.rels
    FFonts: TStrings; // <fonts> section in xl/styles.xml
    FFills: TStrings; // <fills> section in xl/styles.xml
    FBorders: TStrings; // <borders> section in xl/styles.xml
    FCellStyleXfs: TStrings; // <cellStyleXfs> section in xl/styles.xml
    FCellXfs: TStrings; // <cellXfs> section in xl/styles.xml
    FColors: TList; // <colors> section in xl/styles.xml
    FNumFmts: TStrings; // <numFmts> section in xl/styles.xml
    FStrings: TStrings; // <sst> section in xl/sharedStrings
    FStringsCount: Integer; // count of strings in the workbook
    FSingleSheet: Boolean;
    FChunkSize: Integer;
    FLastPage: TfrxMap;
    FWysiwyg: Boolean;
    FPictureType: TfrxPictureType;
    function AddString(s: string): Integer;
    function AddColor(c: TColor): Integer;
    procedure AddColors(const c: array of TColor);
    procedure AddSheet(m: TfrxMap);
  public
    constructor Create(Owner: TComponent); override;
    class function GetDescription: string; override;
    function ShowModal: TModalResult; override;
    function Start: Boolean; override;
    procedure Finish; override;
    procedure FinishPage(Page: TfrxReportPage; Index: Integer); override;
    procedure ExportObject(Obj: TfrxComponent); override;
  published
    property ChunkSize: Integer read FChunkSize write FChunkSize;
    property EmptyLines: Boolean read FEmptyLines write FEmptyLines default True;
    property ExportPageBreaks: Boolean read FExportPageBreaks write FExportPageBreaks default True;
    property OpenAfterExport: Boolean read FOpenAfterExport write FOpenAfterExport default False;
    property OverwritePrompt;
    property PictureType: TfrxPictureType read FPictureType write FPictureType;
    property SingleSheet: Boolean read FSingleSheet write FSingleSheet default True;
    property Wysiwyg: Boolean read FWysiwyg write FWysiwyg default True;
  end;

implementation

uses
  frxUtils, frxFileUtils, frxUnicodeUtils, frxRes, frxrcExports, frxGraphicUtils;

const
  StylesRid = 'rId1000'; // xl/styles.xml
  ThemeRid = 'rId2000'; // xl/theme1.xml
  SharedStringsRid = 'rId3000'; // xl/sharedStrings.xml
  WorkbookRid = 'rId4000'; // xl/workbook.xml
  CoreRid = 'rId5000'; // docProps/core.xml
  ColWidthFactor = 0.111317;
  RowHeightFactor = 0.754967;
  MarginFactor = 1 / 25.4;

var
  SetFormat : TFormatSettings;
{$R *.dfm}

{ TfrxXLSXExport }

class function TfrxXLSXExport.GetDescription: string;
begin
  Result := frxGet(9200);
end;

function TfrxXLSXExport.ShowModal: TModalResult;
begin
  Result := mrOk; // Default
  if Assigned(Stream) then Exit;

  with TfrxXLSXExportDialog.Create(nil) do
  begin
    if SlaveExport then
    begin
      OpenCB.Enabled    := False;
      OpenCB.State      := cbGrayed;
      FOpenAfterExport  := False;
    end;

    if OverwritePrompt then
      sd.Options := sd.Options + [ofOverwritePrompt];

    sd.FileName := FileName;
    if (FileName = '') and not SlaveExport then
      sd.FileName :=
        ChangeFileExt(ExtractFileName(frxUnixPath2WinPath(Report.FileName)),
          sd.DefaultExt);

    OpenCB.Checked := FOpenAfterExport;
    NotSplitRB.Checked := SingleSheet;
    RPagesRB.Checked := not SingleSheet and (ChunkSize = 0);
    RowsCountRB.Checked := ChunkSize > 0;
    edChunk.Text := IntToStr(ChunkSize);
    WCB.Checked := Wysiwyg;
    ContinuousCB.Checked := not EmptyLines;
    PageBreaksCB.Checked := ExportPageBreaks;

    if PageNumbers <> '' then
    begin
      PageNumbersE.Text     := PageNumbers;
      PageNumbersRB.Checked := True;
    end;

    Result := ShowModal;
    if Result = mrOk then
    begin
      PageNumbers := '';
      CurPage     := False;

      if CurPageRB.Checked then
        CurPage := True
      else if PageNumbersRB.Checked then
        PageNumbers := PageNumbersE.Text;

      Wysiwyg := WCB.Checked;
      EmptyLines := not ContinuousCB.Checked;
      ExportPageBreaks := PageBreaksCB.Checked and (not ContinuousCB.Checked);

      FOpenAfterExport := OpenCB.Checked;
      SingleSheet := NotSplitRB.Checked;
      if RowsCountRB.Checked then
        try
          ChunkSize := StrToInt(edChunk.Text);
        except
          ChunkSize := 0;
        end;

      if not SlaveExport then
      begin
        if DefaultPath <> '' then
          sd.InitialDir := DefaultPath;

        if sd.Execute then
          FileName := sd.FileName
        else
          Result := mrCancel;
      end;
    end;

    Free;
  end;
end;

function TfrxXLSXExport.AddString(s: string): Integer;
begin
  Result := FStrings.Add(Escape(s));
end;

constructor TfrxXLSXExport.Create(Owner: TComponent);
begin
  inherited;
  DefaultExt := '.xlsx';
  FWysiwyg := True;
  FExportPageBreaks := True;
  FSingleSheet := True;
  FEmptyLines := True;
end;

function TfrxXLSXExport.AddColor(c: TColor): Integer;
var
  i, j, k: Integer;
begin
  c := RGBSwap(c);
  j := -1;
  k := 1000000;
  for i := 0 to FColors.Count - 1 do
    if Distance(Integer(FColors[i]), c) < k then
    begin
      k := Distance(Integer(FColors[i]), c);
      j := i;
    end;

  if (k = 0) or (FColors.Count = 56) then
  begin
    Result := j;
    Exit;
  end;

  Result := FColors.Add(Pointer(c));
end;

procedure TfrxXLSXExport.AddColors(const c: array of TColor);
var
  i: Integer;
begin
  for i := Low(c) to High(c) do
    AddColor(c[i]);
end;

function TfrxXLSXExport.Start: Boolean;
begin
  Result := False; // Default

  if SlaveExport then
    if Report.FileName <> '' then
      FileName := ChangeFileExt(GetTemporaryFolder +
        ExtractFileName(Report.FileName), '.xlsx')
    else
      FileName := ChangeFileExt(GetTempFile, '.xlsx');

  if (FileName = '') and not Assigned(Stream) then
    Exit;

  if (ExtractFilePath(FileName) = '') and (DefaultPath <> '') then
    FileName := DefaultPath + '\' + FileName;

  FMatrix := TfrxIEMatrix.Create(UseFileCache, Report.EngineOptions.TempDir);

  with FMatrix do
  begin
    Background      := False;
    BackgroundImage := False;
    Printable       := ExportNotPrintable;
    RichText        := False;
    PlainRich       := False;
    DeleteHTMLTags  := True;
    Images          := True;
    WrapText        := False;
    ShowProgress    := False;
    BrushAsBitmap   := False;
    EMFPictures     := True;
    EmptyLines      := Self.EmptyLines;
  end;

  if not Wysiwyg then
    FMatrix.Inaccuracy := 10.0
  else
    FMatrix.Inaccuracy := 2.0;

  FMatrix.DotMatrix := Report.DotMatrixReport;
  SuppressPageHeadersFooters := not EmptyLines;
  Result := True;

  { additional data }

  FFonts := TfrxStrList.Create;
  FFills := TfrxStrList.Create;
  FBorders := TfrxStrList.Create;
  FCellStyleXfs := TfrxStrList.Create;
  FNumFmts := TfrxStrList.Create;
  FStrings := TfrxStrList.Create;
  FStringsCount := 0;
  FCellXfs := TfrxStrList.Create;
  FColors := TList.Create;

  { file structure }

  FDocFolder := GetTempFile;
  DeleteFile(FDocFolder);
  FDocFolder := FDocFolder + '\';
  MkDir(FDocFolder);
  MkDir(FDocFolder + 'xl');
  MkDir(FDocFolder + 'xl/_rels');
  MkDir(FDocFolder + '_rels');
  MkDir(FDocFolder + 'xl/worksheets');
  MkDir(FDocFolder + 'xl/worksheets/_rels');
  MkDir(FDocFolder + 'xl/drawings');
  MkDir(FDocFolder + 'xl/drawings/_rels');
  MkDir(FDocFolder + 'xl/media');
  MkDir(FDocFolder + 'docProps');

  { [Content_Types].xml }

  FContentTypes := TFileStream.Create(FDocFolder + '[Content_Types].xml', fmCreate);
  with TfrxWriter.Create(FContentTypes) do
  begin
    Write(['<?xml version="1.0" encoding="UTF-8" standalone="yes"?>',
      '<Types xmlns="http://schemas.openxmlformats.org/package/2006/content-types">',
      '<Default Extension="xml" ContentType="application/xml"/>',
      '<Default Extension="rels" ContentType=',
      '"application/vnd.openxmlformats-package.relationships+xml"/>',
      '<Default Extension="emf" ContentType="image/x-emf"/>',
      '<Override PartName="/xl/styles.xml" ContentType=',
      '"application/vnd.openxmlformats-officedocument.spreadsheetml.styles+xml"/>',
      '<Override PartName="/xl/workbook.xml" ContentType=',
      '"application/vnd.openxmlformats-officedocument.spreadsheetml.sheet.main+xml"/>',
      '<Override PartName="/xl/sharedStrings.xml" ContentType=',
      '"application/vnd.openxmlformats-officedocument.spreadsheetml',
      '.sharedStrings+xml"/>',
      '<Override PartName="/docProps/core.xml" ContentType="application/vnd.',
      'openxmlformats-package.core-properties+xml"/>']);

    Free;
  end;

  { _rels/.rels }

  FRels := TFileStream.Create(FDocFolder + '_rels/.rels', fmCreate);
  with TfrxWriter.Create(FRels) do
  begin
    Write(['<?xml version="1.0" encoding="UTF-8" standalone="yes"?>',
      '<Relationships xmlns="http://schemas.openxmlformats.org/',
      'package/2006/relationships">',
      '<Relationship Id="', WorkbookRid, '" Type="http://schemas.openxmlformats.',
      'org/officeDocument/2006/relationships/officeDocument" Target="xl/workbook.xml"/>',
      '<Relationship Id="', CoreRid, '" Type="http://schemas.openxmlformats.org/package/',
      '2006/relationships/metadata/core-properties" Target="docProps/core.xml"/>',
      '</Relationships>']);

    Free;
  end;

  { docProps/core.xml }

  with TfrxFileWriter.Create(FDocFolder + 'docProps/core.xml') do
  begin
    Write(['<?xml version="1.0" encoding="UTF-8" standalone="yes"?>',
      '<cp:coreProperties xmlns:cp="http://schemas.openxmlformats.org/package/2006/',
      'metadata/core-properties" xmlns:dc="http://purl.org/dc/elements/1.1/"',
      ' xmlns:dcterms="http://purl.org/dc/terms/" xmlns:dcmitype="http://purl.org/',
      'dc/dcmitype/" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">',
      '<dc:creator>Fast Reports Inc.</dc:creator>', '</cp:coreProperties>']);

    Free;
  end;

  { xl/workbook.xml }

  FWorkbook := TFileStream.Create(FDocFolder + 'xl/workbook.xml', fmCreate);
  with TfrxWriter.Create(FWorkbook) do
  begin
    Write(['<?xml version="1.0" encoding="UTF-8" standalone="yes"?>',
      '<workbook xmlns="http://schemas.openxmlformats.org/',
      'spreadsheetml/2006/main" xmlns:r="http://schemas.openxmlformats.org/',
      'officeDocument/2006/relationships">',
      '<fileVersion appName="xl" lastEdited="4" lowestEdited="4"',
      ' rupBuild="4505"/>',
      '<workbookPr defaultThemeVersion="124226"/>',
      '<bookViews><workbookView xWindow="0" yWindow="0"',
      ' windowWidth="15480" windowHeight="8190" tabRatio="400" firstSheet="0"',
      ' activeTab="0"/></bookViews>',
      '<sheets>']);

    Free;
  end;

  { xl/styles.xml }

  FStyles := TFileStream.Create(FDocFolder + 'xl/styles.xml', fmCreate);
  WriteStr(FStyles, '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>');

  { xl/sharedStrings.xml }

  FSharedStrings := TFileStream.Create(FDocFolder + 'xl/sharedStrings.xml', fmCreate);
  WriteStr(FSharedStrings, '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>');

  { xl/_rels/workbook.xml.rels }

  FWorkbookRels := TFileStream.Create(FDocFolder + 'xl/_rels/workbook.xml.rels', fmCreate);
  with TfrxWriter.Create(FWorkbookRels) do
  begin
    Write(['<?xml version="1.0" encoding="UTF-8" standalone="yes"?>',
      '<Relationships xmlns="http://schemas.openxmlformats.org/',
      'package/2006/relationships">',
      '<Relationship Id="', StylesRid,
      '" Type="http://schemas.openxmlformats.org/officeDocument/2006/',
      'relationships/styles" Target="styles.xml"/>',
      '<Relationship Id="', SharedStringsRid,
      '" Type="http://schemas.openxmlformats.org/officeDocument/2006/',
      'relationships/sharedStrings" Target="sharedStrings.xml"/>']);

    Free;
  end;

  { <numFmts> section in xl/styles.xml }

  FNumFmts.Add('<numFmt numFmtId="5" formatCode=' +
    '"#,##0&quot;R.&quot;;\-#,##0&quot;R.&quot;"/>');

  { <cellStyleXfs> section in xl/styles.xml }

  FCellStyleXfs.Add('<xf numFmtId="0" fontId="0" fillId="0" borderId="0">' +
    '<alignment horizontal="left" vertical="top" wrapText="1"/></xf>');

  { <cellXfs> section in xl/styles.xml }

  FCellXfs.Add('<xf numFmtId="0" fontId="0" fillId="0" borderId="0" xfId="0">' +
    '<alignment horizontal="left" vertical="top" wrapText="1"/></xf>');

  { <colors> section in xl/styles.xml }
  AddColors([$00000000, $00FFFFFF, $00FF0000, $0000FF00, $000000FF,
    $00FFFF00, $00FF00FF, $0000FFFF]);

  { <fills> section in xl/styles.xml }

  FFills.Add('<fill><patternFill patternType="none"/></fill>');
  FFills.Add('<fill><patternFill patternType="gray125"/></fill>');

  { <fonts> section in xl/styles.xml }

  FFonts.Add('<font><sz val="12"/><color rgb="FF000000"/><name val="Arial"/></font>');
end;

procedure TfrxXLSXExport.ExportObject(Obj: TfrxComponent);
var
  v: TfrxView;
begin
  if Obj.Page <> nil then
    Obj.Page.Top := FMatrix.Inaccuracy;

  if Obj.Name = '_pagebackground' then
    Exit;

  if Obj is TfrxView then
  begin
    v := Obj as TfrxView;

    if ExportNotPrintable or v.Printable then
      FMatrix.AddObject(v);
  end;
end;

procedure TfrxXLSXExport.AddSheet(m: TfrxMap);

  function A1(x, y: Integer): string;
  begin
    Result := '';

    if x = 0 then
      Result := 'A'
    else if x < 26 then
      Result := Chr(Ord('A') + x)
    else
      Result := Chr(Ord('A') + x div 26 - 1) + Chr(Ord('A') + x mod 26);

    Result := Result + IntToStr(y + 1);
  end;

  function ColWidth(i: Integer): Double;
  begin
    with FMatrix do
      Result := ColWidthFactor * (GetXPosById(i + 1) - GetXPosById(i));
  end;

  function RowHeight(i: Integer): Double;
  begin
    with FMatrix do
      Result := RowHeightFactor * (GetYPosById(i + 1) - GetYPosById(i));
  end;

  function ColorText(col: TColor) : String;
  var
    R0,R1,G0,G1,B0,B1: Byte;
  begin
    R1 := GetRValue(col) and $f;
    R0 := (GetRValue(col) shr 4) and $f;
    G1 := GetGValue(col) and $f;;
    G0 := (GetGValue(col) shr 4) and $f;
    B1 := GetBValue(col) and $f;;
    B0 := (GetBValue(col) shr 4) and $f;
    Result := Format('FF%x%x%x%x%x%x', [R0,R1,G0,G1,B0,B1] );
  end;

  function Border(Side: string; line: TfrxFrameLine; Exists: Boolean): string;
  var
    BorderType: String;
  begin
    if not Exists then
      Result := Format('<%s/>', [Side])
    else begin
      case line.Style of
      fsSolid:        BorderType := 'thin';
      fsDash:         BorderType := 'dashed';
      fsDot:          BorderType := 'dotted';
      fsDashDot:      BorderType := 'dashDot';
      fsDashDotDot:   BorderType := 'dashDotDot';
      fsDouble:       BorderType := 'double';
      fsAltDot:       BorderType := 'dashDot';
      fsSquare:       BorderType := 'thin';
      else            BorderType := 'thin';
      end;
      Result := Format('<%s style="%s"><color rgb="%s"/></%s>',
        [Side, BorderType, ColorText(line.Color), Side], SetFormat);
    end;
  end;

  function XLHAlign(a: TfrxHAlign): string;
  begin
    case a of
      haLeft: Result := 'left';
      haRight: Result := 'right';
      haCenter: Result := 'center';
      else Result := 'left';
    end;
  end;

  function XLVAlign(a: TfrxVAlign): string;
  begin
    case a of
      vaTop: Result := 'top';
      vaBottom: Result := 'bottom';
      vaCenter: Result := 'center';
      else Result := 'top';
    end;
  end;

  function Pattern(s: TBrushStyle): string;
  begin
    case s of
      bsSolid: Result := 'solid';
      bsClear: Result := 'solid';
      else Result := 'none';
    end;
  end;

  function BoolToInt(b: Boolean): Integer;
  begin
    if b then
      Result := 1
    else
      Result := 0;
  end;

  function FS(const s: string; b: Boolean): string;
  begin
    if b then
      Result := s
    else
      Result := '';
  end;

  function Orientation(x: Integer): string;
  begin
    if x = 0 then
      Result := 'portrait'
    else
      Result := 'landscape';
  end;

  function GetCol(x: Double): Integer;
  var
    c: Integer;
  begin
    for c := 0 to FMatrix.Width - 1 do
      if FMatrix.GetXPosById(c) > x - 1e-6 then
        Break;

    Result := c;
  end;

  function GetRow(y: Double): Integer;
  var
    r: Integer;
  begin
    for r := 0 to FMatrix.Height - 1 do
      if FMatrix.GetYPosById(r) > y - 1e-6 then
        Break;

    Result := r;
  end;

  function GetFormatCode(f: TfrxFormat) : Integer;
  var
    res_count: Integer;
    i:  Integer;
    style: TfrxIEMStyle;
    format: TfrxFormat;
  begin
    res_count := 0;
    i := 0;
    while  i < FMatrix.GetStylesCount do
    begin
      style := FMatrix.GetStyleById(i);
      format := style.FDisplayFormat;

      if format.Kind = fkNumeric then begin
        Inc(res_count);
{$IFDEF Delphi7}
        if style.DisplayFormat.DisplayName  = f.DisplayName then begin
{$ELSE}
        if style.DisplayFormat.GetHashCode = f.GetHashCode then
        begin
{$ENDIF}
          Result := i + res_count;
          Exit;
        end;

      end;
      Inc(i);
    end;
    Result := 0;
  end;

var
  f, i, j, k, l, x, y, dx, dy: Integer;
  Obj: TfrxIEMObject;
  r: TfrxRect;
  MCells: array of TRect; // merged cells
  StrList: TStrings;
  StylesMap: array of Integer;
  Pictures: TList; // of TfrxIEMObject
  s: string;
  ss: TStream; // xl/worksheets/sheetXXX.xml
  style: TfrxIEMStyle;
  rotor: string;
begin
  WriteStr(FContentTypes, '<Override PartName="/xl/worksheets/sheet' + IntToStr(m.Index) +
    '.xml" ContentType="application/vnd.openxmlformats-officedocument.spreadsheetml' +
    '.worksheet+xml"/>');

  WriteStr(FWorkbook, Format('<sheet name="Page %d" sheetId="%d" r:id="rId%d"/>',
    [m.Index, m.Index, m.Index], SetFormat));

  WriteStr(FWorkbookRels, Format('<Relationship Id="rId%d" Type="http://schemas.' +
    'openxmlformats.org/officeDocument/2006/relationships/worksheet" ' +
    'Target="worksheets/sheet%d.xml"/>', [m.Index, m.Index], SetFormat));

  ss := TFileStream.Create(FDocFolder + 'xl/worksheets/sheet' + IntToStr(m.Index) +
    '.xml', fmCreate);

  with TfrxWriter.Create(ss) do
  begin
    Write(['<?xml version="1.0" encoding="UTF-8" standalone="yes"?>',
      '<worksheet xmlns="http://schemas.openxmlformats.org/',
      'spreadsheetml/2006/main" xmlns:r="http://schemas.openxmlformats.org/',
      'officeDocument/2006/relationships">',
      Format('<dimension ref="%s:%s"/>',
        [A1(0, 0), A1(FMatrix.Width - 1, m.LastRow - m.FirstRow)]),
      '<sheetViews><sheetView showGridLines="1"',
      ' workbookViewId="0"/></sheetViews>']);

    Free;
  end;

  { columns widths }

  WriteStr(ss, '<cols>');

  for i := 0 to FMatrix.Width - 2 do
    WriteStr(ss, Format('<col min="%d" max="%d" width="%f" customWidth="1"/>',
      [i + 1, i + 1, ColWidth(i)], SetFormat));

  WriteStr(ss, '</cols>');

  { merged cells }

  SetLength(MCells, FMatrix.GetObjectsCount);

  for i := 0 to High(MCells) do
    with MCells[i] do
    begin
      Left := 1000000;
      Top := 1000000;
      Right := -1;
      Bottom := -1;
    end;

  { cell styles }

  SetLength(StylesMap, FMatrix.GetStylesCount);

  { First default border }
  style := FMatrix.GetStyleById(0);
  FBorders.Add('<border>' +
    Border('left', style.LeftLine, False) +
    Border('right', style.RightLine, False) +
    Border('top', style.TopLine, False) +
    Border('bottom', style.BottomLine, False) +
    '</border>');

  with FMatrix do
    for i := 0 to GetStylesCount - 1 do
      with GetStyleById(i) do
      begin
        f := GetFormatCode( FDisplayFormat );
        j := FFonts.Add(Format('<font>' + FS('<b/>', fsBold in Font.Style) +
          FS('<i/>', fsItalic in Font.Style) + FS('<u/>', fsUnderline in Font.Style) +
          '<sz val="%d"/><color rgb="%s"/><name val="%s"/><charset val="%d"/></font>',
          [Font.Size, ColorText(Font.Color), Font.Name, Font.Charset], SetFormat));

          style := FMatrix.GetStyleById(i);

        k := FBorders.Add('<border>' +
          Border('left', style.LeftLine, ftLeft in FrameTyp) +
          Border('right', style.RightLine, ftRight in FrameTyp) +
          Border('top', style.TopLine, ftTop in FrameTyp) +
          Border('bottom', style.BottomLine, ftBottom in FrameTyp) +
          '</border>');

        l := FFills.Add(Format('<fill><patternFill patternType="%s">' +
          '<fgColor indexed="%d"/></patternFill></fill>', [Pattern(BrushStyle),
          AddColor(Color)] ));

        rotor := '';
        if Rotation <> 0 then begin
          if Rotation <= 90 then
            rotor := IntToStr( Rotation)
          else if Rotation >= 270 then
            rotor := IntToStr( Rotation - 90 )
          else
            rotor := '0';  // Limit  of angle between +90 and -90 degrees

          rotor := ' textRotation="' + rotor + '" ';
        end;

        StylesMap[i] := FCellXfs.Add(Format('<xf numFmtId="%d" fontId="%d" fillId="%d"' +
          ' borderId="%d" xfId="0" applyNumberFormat="0" applyFont="1" applyFill="1"' +
          ' applyBorder="1" applyAlignment="1" applyProtection="1">' +
          '<alignment horizontal="%s" vertical="%s" wrapText="%d"' +  rotor +
          ' readingOrder="1"/></xf>', [f, j, l, k, XLHAlign(HAlign),
          XLVAlign(VAlign), BoolToInt(True)], SetFormat))
      end;

  { cells }

  WriteStr(ss, '<sheetData>');

  for i := m.FirstRow to m.LastRow do
  begin
    WriteStr(ss, Format('<row r="%d" ht="%f" customHeight="1">',
      [i - m.FirstRow + 1, RowHeight(i)], SetFormat));

    for j := 0 to FMatrix.Width - 2 do
    begin
      Obj := FMatrix.GetObject(j, i);
      if Obj = nil then Continue;

      with MCells[FMatrix.GetCell(j, i)] do
      begin
        k := i - m.FirstRow;
        if j < Left then Left := j;
        if j > Right then Right := j;
        if k < Top then Top := k;
        if k > Bottom then Bottom := k;
      end;

      k := AddString(String(Utf8Encode(Obj.Memo.Text)));
      WriteStr(ss, Format('<c r="%s" s="%d" t="s">',
        [A1(j, i - m.FirstRow), StylesMap[Obj.StyleIndex]], SetFormat));

      WriteStr(ss, Format('<v>%d</v>', [k], SetFormat));
      WriteStr(ss, '</c>');
    end;

    WriteStr(ss, '</row>');
  end;

  WriteStr(ss, '</sheetData>');

  { merged cells }

  StrList := TStringList.Create;

  for i := 0 to High(MCells) do
    with MCells[i] do
    if (Left <= Right) and (Top <= Bottom) and
      ((Right - Left + 1) * (Bottom - Top + 1) > 1) then
      StrList.Add(Format('<mergeCell ref="%s:%s"/>', [A1(Left, Top), A1(Right, Bottom)], SetFormat));

  if StrList.Count > 0 then
  begin
    WriteStr(ss, Format('<mergeCells count="%d">', [StrList.Count], SetFormat));
    StrList.SaveToStream(ss);
    WriteStr(ss, '</mergeCells>');
  end;

  StrList.Free;

  { pictures }

  Pictures := TList.Create;

  for i := 0 to FMatrix.GetObjectsCount - 1 do
  begin
    FMatrix.GetObjectPos(i, x, y, dx, dy);

    with FMatrix.GetObjectById(i) do
      if (Metafile <> nil) and (Metafile.Width > 0) and (Metafile.Height > 0) and
        (y >= m.FirstRow) and (y + dy - 1 <= m.LastRow) then
        Pictures.Add(FMatrix.GetObjectById(i));
  end;

  if Pictures.Count = 0 then
  begin
    Pictures.Free;
    Pictures := nil;
  end
  else
  begin
    WriteStr(FContentTypes, Format('<Override PartName="/xl/drawings/drawing%d.xml"' +
      ' ContentType="application/vnd.openxmlformats-officedocument.drawing+xml"/>',
      [m.Index], SetFormat));

    { xl/worksheets/_rels/sheetXXX.xml.rels }

    with TfrxFileWriter.Create(Format('%sxl/worksheets/_rels/sheet%d.xml.rels',
      [FDocFolder, m.Index], SetFormat)) do
    begin
      Write(['<?xml version="1.0" encoding="UTF-8" standalone="yes"?>',
        '<Relationships xmlns="http://schemas.openxmlformats.org/',
        'package/2006/relationships">',
        Format('<Relationship Id="rId1" Type="http://schemas.' +
          'openxmlformats.org/officeDocument/2006/relationships/drawing"' +
          ' Target="../drawings/drawing%d.xml"/>', [m.Index], SetFormat),
        '</Relationships>']);

      Free;
    end;

    { xl/drawings/_rels/drawingXXX.xml.rels }

    with TfrxFileWriter.Create(Format('%sxl/drawings/_rels/drawing%d.xml.rels',
      [FDocFolder, m.Index], SetFormat)) do
    begin
      Write(['<?xml version="1.0" encoding="UTF-8" standalone="yes"?>',
        '<Relationships xmlns="http://schemas.openxmlformats.org/',
        'package/2006/relationships">']);

      for i := 0 to Pictures.Count - 1 do
      begin
        // The extension must be "emf", regardless what the actual format is.
        s := Format('image-s%d-p%d%s', [m.Index, i + 1, '.emf'], SetFormat);

        Write(Format('<Relationship Id="rId%d" Type="http://schemas.' +
          'openxmlformats.org/officeDocument/2006/relationships/image"' +
          ' Target="../media/%s"/>', [i + 1, s], SetFormat));

        SaveGraphicAs(
          TfrxIEMObject(Pictures[i]).Metafile,
          FDocFolder + 'xl/media/' + s,
          PictureType);
      end;

      Write('</Relationships>');
      Free;
    end;

    { xl/drawings/drawingXXX.xml }

    with TfrxFileWriter.Create(Format('%sxl/drawings/drawing%d.xml',
      [FDocFolder, m.Index])) do
    begin
      Write(['<?xml version="1.0" encoding="UTF-8" standalone="yes"?>',
        '<xdr:wsDr xmlns:xdr="http://schemas.openxmlformats.org/drawingml',
        '/2006/spreadsheetDrawing" xmlns:a="http://schemas.openxmlformats.org/',
        'drawingml/2006/main">']);

      for i := 0 to Pictures.Count - 1 do
      begin
        r := FMatrix.GetObjectBounds(TfrxIEMObject(Pictures[i]));

        with TfrxIEMObject(Pictures[i]) do
          Write(['<xdr:twoCellAnchor><xdr:from><xdr:col>', IntToStr(GetCol(r.Left)),
            '</xdr:col><xdr:colOff>0</xdr:colOff><xdr:row>',
            IntToStr(GetRow(r.Top) - m.FirstRow),
            '</xdr:row><xdr:rowOff>0</xdr:rowOff></xdr:from><xdr:to><xdr:col>',
            IntToStr(GetCol(r.Right)), '</xdr:col><xdr:colOff>0</xdr:colOff>',
            '<xdr:row>', IntToStr(GetRow(r.Bottom) - m.FirstRow),
            '</xdr:row><xdr:rowOff>0',
            '</xdr:rowOff></xdr:to><xdr:pic><xdr:nvPicPr><xdr:cNvPr id="1025"',
            ' name="Picture 1"/><xdr:cNvPicPr><a:picLocks noChangeAspect="1"',
            ' noChangeArrowheads="1"/></xdr:cNvPicPr></xdr:nvPicPr><xdr:blipFill>',
            '<a:blip xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/',
            'relationships" r:embed="rId', IntToStr(i + 1), '"/><a:srcRect/><a:stretch>',
            '<a:fillRect/></a:stretch></xdr:blipFill><xdr:spPr bwMode="auto"><a:xfrm>',
            '<a:off x="0" y="0"/><a:ext cx="9525" cy="9525"/></a:xfrm><a:prstGeom',
            ' prst="rect"><a:avLst/></a:prstGeom><a:noFill/></xdr:spPr></xdr:pic>',
            '<xdr:clientData/></xdr:twoCellAnchor>']);
      end;

      for i := 0 to Pictures.Count - 1 do
        with TfrxIEMObject(Pictures[i]) do
          Write(['<xdr:twoCellAnchor editAs="absolute"><xdr:from><xdr:col>0</xdr:col>',
            '<xdr:colOff>0</xdr:colOff><xdr:row>0</xdr:row><xdr:rowOff>0</xdr:rowOff>',
            '</xdr:from><xdr:to><xdr:col>0</xdr:col><xdr:colOff>0</xdr:colOff>',
            '<xdr:row>0</xdr:row><xdr:rowOff>0</xdr:rowOff></xdr:to>',
            '<xdr:sp macro="" textlink=""><xdr:nvSpPr><xdr:cNvPr id="1024"',
            ' name="AutoShape 0"/><xdr:cNvSpPr><a:spLocks noChangeAspect="1"',
            ' noChangeArrowheads="1"/></xdr:cNvSpPr></xdr:nvSpPr><xdr:spPr bwMode="auto">',
            '<a:xfrm><a:off x="0" y="0"/><a:ext cx="0" cy="0"/></a:xfrm>',
            '<a:prstGeom prst="rect"><a:avLst/></a:prstGeom><a:noFill/></xdr:spPr>',
            '</xdr:sp><xdr:clientData fPrintsWithSheet="0"/></xdr:twoCellAnchor>']);

      Write('</xdr:wsDr>');
      Free;
    end;

    Pictures.Free;
  end;

  { page setup }

  with TfrxWriter.Create(ss) do
  begin
    Write(Format('<pageMargins left="%f" right="%f" top="%f" bottom="%f"' +
      ' header="0" footer="0"/>', [m.Margins.Left * MarginFactor,
      m.Margins.Right * MarginFactor, m.Margins.Top * MarginFactor,
      m.Margins.Bottom * MarginFactor], SetFormat));

    Write([Format('<pageSetup paperSize="%d" firstPageNumber="0"' +
      ' orientation="%s" useFirstPageNumber="1" errors="blank"' +
      ' horizontalDpi="300" verticalDpi="300"/>', [m.PaperSize,
      Orientation(m.PageOrientation)]), '<headerFooter alignWithMargins="0"/>']);

    Free;
  end;

  { row breaks }

  if SingleSheet then
  begin
    StrList := TStringList.Create;
    j := 0;

    for i := m.FirstRow to m.LastRow do
      if FMatrix.GetCellYPos(i) >= FMatrix.GetPageBreak(j) then
      begin
        StrList.Add(Format('<brk id="%d" max="16383" man="1"/>', [i]));
        Inc(j);
      end;

    WriteStr(ss, Format('<rowBreaks count="%d" manualBreakCount="%d">',
      [StrList.Count, StrList.Count]));

    StrList.SaveToStream(ss);
    WriteStr(ss, '</rowBreaks>');
    StrList.Free;
  end;

  { drawing }

  if Pictures <> nil then
    WriteStr(ss, '<drawing r:id="rId1"/>');

  { ending }

  WriteStr(ss, '</worksheet>');

  { free resources }

  ss.Free;
end;

procedure TfrxXLSXExport.FinishPage(Page: TfrxReportPage; Index: Integer);
var
  m: TfrxMap;
begin
  m.Margins.Left := Page.LeftMargin;
  m.Margins.Right := Page.RightMargin;
  m.Margins.Top := Page.TopMargin;
  m.Margins.Bottom := Page.BottomMargin;
  m.PaperSize := Page.PaperSize;
  m.PageOrientation := Integer(Page.Orientation);

  FLastPage := m;

  with Page do
    FMatrix.AddPage(Orientation, Width, Height, LeftMargin,
      TopMargin, RightMargin, BottomMargin, MirrorMargins, Index);

  if (ChunkSize = 0) and not SingleSheet then
  begin
    FMatrix.Prepare;
    m.FirstRow := 0;
    m.LastRow := FMatrix.Height - 2;
    m.Index := Index + 1;
    AddSheet(m);
    FMatrix.Clear;
  end;
end;

procedure TfrxXLSXExport.Finish;
var
  i: Integer;
  Zip: TfrxZipArchive;
  f: TStream;
  m: TfrxMap;
begin
  if SingleSheet then
  begin
    FMatrix.Prepare;
    m := FLastPage;
    m.FirstRow := 0;
    m.LastRow := FMatrix.Height - 2;
    m.Index := 1;
    AddSheet(m);
    FMatrix.Clear;
  end
  else if ChunkSize > 0 then
  begin
    FMatrix.Prepare;
    m := FLastPage;
    m.FirstRow := 0;
    m.Index := 1;

    while m.FirstRow < FMatrix.Height - 1 do
    begin
      m.LastRow := m.FirstRow + ChunkSize - 1;
      if m.LastRow > FMatrix.Height - 2 then
        m.LastRow := FMatrix.Height - 2;

      AddSheet(m);
      Inc(m.FirstRow, ChunkSize);
      Inc(m.Index);
    end;

    FMatrix.Clear;
  end;

  FMatrix.Free;
  WriteStr(FContentTypes, '</Types>');
  WriteStr(FWorkbook, '</sheets><calcPr calcId="124519"/></workbook>');

  { xl/styles.xml }

  with TfrxWriter.Create(FStyles) do
  begin
    Write(['<styleSheet xmlns="http://schemas.openxmlformats.org/',
      'spreadsheetml/2006/main">']);

    Write('numFmts', FNumFmts);
    Write('fonts', FFonts);
    Write('fills', FFills);
    Write('borders', FBorders);
    Write('cellStyleXfs', FCellStyleXfs);
    Write('cellXfs', FCellXfs);

    Write(['<cellStyles count="1"><cellStyle name="Normal" xfId="0"',
      ' builtinId="0"/></cellStyles><dxfs count="0"/>',
      '<tableStyles count="0" defaultTableStyle="TableStyleMedium9"',
      ' defaultPivotStyle="PivotStyleLight16"/>',
      '<colors><indexedColors>']);

    for i := 0 to FColors.Count - 1 do
      Write('<rgbColor rgb="%x"/>', [Integer(FColors[i])]);

    Write('</indexedColors></colors></styleSheet>');
    Free;
  end;

  { xl/sharedStrings.xml }

  with TfrxWriter.Create(FSharedStrings) do
  begin
    Write('<sst xmlns="http://schemas.openxmlformats.org/' +
      'spreadsheetml/2006/main" count="%d" uniqueCount="%d">',
      [FStringsCount, FStrings.Count]);

    for i := 0 to FStrings.Count - 1 do
    begin
      Write('<si><t>');
      // note: in unicode delphi12+ Utf8Encode has no effect: when converted to widestring it does utf8decode automatically
      Write(FStrings[i], {$IFDEF Delphi12}True{$ELSE}False{$ENDIF});
      Write('</t></si>');
    end;

    Write('</sst>');
    Free;
  end;

  { xl/_rels/workbook.xml.rels }

  WriteStr(FWorkbookRels, '</Relationships>');

  { free resources }

  FFonts.Free;
  FFills.Free;
  FBorders.Free;
  FCellXfs.Free;
  FCellStyleXfs.Free;
  FColors.Free;
  FNumFmts.Free;
  FStrings.Free;

  { close files }

  FContentTypes.Free;
  FRels.Free;
  FStyles.Free;
  FSharedStrings.Free;
  FWorkbookRels.Free;
  FWorkbook.Free;

  { compress data }

  if Assigned(Stream) then
    f := Stream
  else
    try
      f := TFileStream.Create(FileName, fmCreate);
    except
      f := nil;
    end;

  if Assigned(f) then
  begin
    Zip := TfrxZipArchive.Create;
    try
      Zip.RootFolder := AnsiString(FDocFolder);
      Zip.AddDir(AnsiString(FDocFolder));
      Zip.SaveToStream(f);
    finally
      Zip.Free;
    end;
  end;

  if not Assigned(Stream) then
    f.Free;

  DeleteFolder(FDocFolder);

  if FOpenAfterExport then
    ShellExecute(GetDesktopWindow, 'open', PChar(FileName), nil, nil, SW_SHOW);
end;

{ TfrxXLSXExportDialog }

procedure TfrxXLSXExportDialog.FormCreate(Sender: TObject);
begin
  Text := frxGet(9200);
  OkB.Caption := frxGet(1);
  CancelB.Caption := frxGet(2);
  GroupPageRange.Caption := frxGet(7);
  AllRB.Caption := frxGet(3);
  CurPageRB.Caption := frxGet(4);
  PageNumbersRB.Caption := frxGet(5);
  DescrL.Caption := frxGet(9);
  GroupOptions.Caption := frxGet(8);
  ContinuousCB.Caption := frxGet(8950);
  PageBreaksCB.Caption := frxGet(6);
  WCB.Caption := frxGet(8102);
  SplitToSheetGB.Caption := frxGet(9001);
  NotSplitRB.Caption := frxGet(9002);
  RPagesRB.Caption := frxGet(9003);
  RowsCountRB.Caption := frxGet(9000);
  OpenCB.Caption := frxGet(8104);


  if UseRightToLeftAlignment then
    FlipChildren(True);
end;

procedure TfrxXLSXExportDialog.PageNumbersEChange(Sender: TObject);
begin
  PageNumbersRB.Checked := True;
end;

procedure TfrxXLSXExportDialog.PageNumbersEKeyPress(Sender: TObject;
  var Key: Char);
begin
  case key of
    '0'..'9':;
    #8, '-', ',':;
  else
    key := #0;
  end;
end;

procedure TfrxXLSXExportDialog.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_F1 then
    frxResources.Help(Self);
end;

initialization

SetFormat.DecimalSeparator := '.';

end.
