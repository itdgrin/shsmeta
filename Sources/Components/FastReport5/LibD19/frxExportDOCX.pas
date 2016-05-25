
{******************************************}
{                                          }
{             FastReport v5.0              }
{               DOCX export                }
{                                          }
{         Copyright (c) 1998-2010          }
{             Fast Reports Inc.            }
{                                          }
{******************************************}

unit frxExportDOCX;

interface

{$I frx.inc}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, frxClass, ShellAPI, ComCtrls, frxZip, frxExportMatrix,
  frxImageConverter
{$IFDEF DELPHI16}
, System.UITypes
{$ENDIF}
;

type
  TfrxDOCXExportDialog = class(TForm)
    OkB: TButton;
    CancelB: TButton;
    sd: TSaveDialog;
    GroupPageRange: TGroupBox;
    DescrL: TLabel;
    AllRB: TRadioButton;
    CurPageRB: TRadioButton;
    PageNumbersRB: TRadioButton;
    PageNumbersE: TEdit;
    OpenCB: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure PageNumbersEChange(Sender: TObject);
    procedure PageNumbersEKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  end;

  TfrxDocxPage = record
    Width: Integer;
    Height: Integer;
    Margins: TRect;
  end;

{$IFDEF DELPHI16}
[ComponentPlatformsAttribute(pidWin32 or pidWin64)]
{$ENDIF}
  TfrxDOCXExport = class(TfrxCustomExportFilter)
  private
    FOpenAfterExport: Boolean;
    FDocFolder: string;
    FDocument: TStream; // word/document.xml
    FDocRels: TStream; // word/_rels/document.xml.rels
    FMatrix: TfrxIEMatrix;
    FLastPage: TfrxDocxPage;
    FPicNum: Integer;
    FFirstPage: Boolean;
    FPictureType: TfrxPictureType;
    function SubPath(const s: string): string;
    function SecPr: string;
  public
    constructor Create(Owner: TComponent); override;
    class function GetDescription: string; override;
    function ShowModal: TModalResult; override;
    function Start: Boolean; override;
    procedure Finish; override;
    procedure StartPage(Page: TfrxReportPage; Index: Integer); override;
    procedure FinishPage(Page: TfrxReportPage; Index: Integer); override;
    procedure ExportObject(Obj: TfrxComponent); override;
  published
    property OpenAfterExport: Boolean read FOpenAfterExport write FOpenAfterExport;
    property OverwritePrompt;
    property PictureType: TfrxPictureType read FPictureType write FPictureType;
  end;

implementation

uses
  frxUtils, frxFileUtils, frxUnicodeUtils, frxRes, frxrcExports, frxGraphicUtils,
  frxOfficeOpen;

{$R *.dfm}

const
  FileExt: string = '.docx';
  LenFactor: Double = 56.79;
  XFactor: Double = 15.50;
  YFactor: Double = 14.50;
  MMFactor: Double = 269.332;

{ TfrxDOCXExport }

function TfrxDOCXExport.SubPath(const s: string): string;
begin
  Result := FDocFolder + '/' + s;
end;

function TfrxDOCXExport.SecPr: string;
begin
  Result := Format('<w:sectPr><w:pgSz w:w="%d" w:h="%d"/>' +
    '<w:pgMar w:top="%d" w:right="%d" w:bottom="%d" w:left="%d" w:header="720" w:footer="720" w:gutter="0"/>' +
    '<w:cols w:space="720"/><w:noEndnote/></w:sectPr>',
    [FLastPage.Width, FLastPage.Height, FLastPage.Margins.Top, FLastPage.Margins.Right,
    FLastPage.Margins.Bottom, FLastPage.Margins.Left]);
end;

class function TfrxDOCXExport.GetDescription: string;
begin
  Result := frxGet(9203);
end;

function TfrxDOCXExport.ShowModal: TModalResult;
begin
  Result := mrOk; // Default
  if Assigned(Stream) then Exit;

  with TfrxDOCXExportDialog.Create(nil) do
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

      FOpenAfterExport := OpenCB.Checked;

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

function TfrxDOCXExport.Start: Boolean;
begin
  Result := False; // Default

  if SlaveExport then
    if Report.FileName <> '' then
      FileName := ChangeFileExt(GetTemporaryFolder +
        ExtractFileName(Report.FileName), FileExt)
    else
      FileName := ChangeFileExt(GetTempFile, FileExt);

  if (FileName = '') and not Assigned(Stream) then
    Exit;

  if (ExtractFilePath(FileName) = '') and (DefaultPath <> '') then
    FileName := DefaultPath + '\' + FileName;

  Result := True;
  FPicNum := 1;
  FFirstPage := True;

  { file structure }

  FDocFolder := GetTempFile;
  DeleteFile(FDocFolder);
  CreateDirs(FDocFolder, ['', '_rels', 'docProps', 'word', 'word/theme', 'word/_rels', 'word/media' ]);

  { [Content_Types].xml }

  with TfrxFileWriter.Create(SubPath('[Content_Types].xml')) do
  begin
    Write(['<?xml version="1.0" encoding="UTF-8" standalone="yes"?>',
      '<Types xmlns="http://schemas.openxmlformats.org/package/2006/content-types">',
      '<Default Extension="emf" ContentType="image/x-emf"/>',
      '<Default Extension="rels" ContentType="application/vnd.openxmlformats-package.relationships+xml"/>',
      '<Default Extension="xml" ContentType="application/xml"/>',
      '<Override PartName="/word/document.xml" ContentType="application/vnd.openxmlformats-officedocument.wordprocessingml.document.main+xml"/>',
      '<Override PartName="/word/styles.xml" ContentType="application/vnd.openxmlformats-officedocument.wordprocessingml.styles+xml"/>',
      '<Override PartName="/docProps/app.xml" ContentType="application/vnd.openxmlformats-officedocument.extended-properties+xml"/>',
      '<Override PartName="/word/settings.xml" ContentType="application/vnd.openxmlformats-officedocument.wordprocessingml.settings+xml"/>',
//      '<Override PartName="/word/theme/theme1.xml" ContentType="application/vnd.openxmlformats-officedocument.theme+xml"/>',
      '<Override PartName="/word/fontTable.xml" ContentType="application/vnd.openxmlformats-officedocument.wordprocessingml.fontTable+xml"/>',
//      '<Override PartName="/word/webSettings.xml" ContentType="application/vnd.openxmlformats-officedocument.wordprocessingml.webSettings+xml"/>',
      '<Override PartName="/docProps/core.xml" ContentType="application/vnd.openxmlformats-package.core-properties+xml"/>',
      '</Types>']);

    Free;
  end;

  { _rels/.rels }

  with TfrxFileWriter.Create(SubPath('_rels/.rels')) do
  begin
    Write(['<?xml version="1.0" encoding="UTF-8" standalone="yes"?>',
      '<Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships">',
      '<Relationship Id="rId3" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/extended-properties" Target="docProps/app.xml"/>',
      '<Relationship Id="rId2" Type="http://schemas.openxmlformats.org/package/2006/relationships/metadata/core-properties" Target="docProps/core.xml"/>',
      '<Relationship Id="rId1" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/officeDocument" Target="word/document.xml"/>',
      '</Relationships>']);

    Free;
  end;

  { docProps/core.xml }

  with TfrxFileWriter.Create(SubPath('docProps/core.xml')) do
  begin
    Write(['<?xml version="1.0" encoding="UTF-8" standalone="yes"?>',
      '<cp:coreProperties xmlns:cp="http://schemas.openxmlformats.org/package/2006/metadata/core-properties"',
      ' xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:dcterms="http://purl.org/dc/terms/" xmlns:dcmitype="http://purl.org/dc/dcmitype/" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">',
      '<dc:title></dc:title>',
      '<dc:subject></dc:subject>',
      '<dc:creator>FastReports</dc:creator>',
      '<cp:keywords></cp:keywords>',
      '<dc:description></dc:description>',
      '<cp:lastModifiedBy>User</cp:lastModifiedBy>',
      '<cp:revision>2</cp:revision>',
      '<dcterms:created xsi:type="dcterms:W3CDTF">2010-05-06T08:40:00Z</dcterms:created>',
      '<dcterms:modified xsi:type="dcterms:W3CDTF">2010-05-06T08:40:00Z</dcterms:modified>',
      '</cp:coreProperties>']);

    Free;
  end;

  { docProps/app.xml }

  with TfrxFileWriter.Create(SubPath('docProps/app.xml')) do
  begin
    Write(['<?xml version="1.0" encoding="UTF-8" standalone="yes"?>',
      '<Properties xmlns="http://schemas.openxmlformats.org/officeDocument/2006/extended-properties" xmlns:vt="http://schemas.openxmlformats.org/officeDocument/2006/docPropsVTypes">',
      '<Template>Normal.dotm</Template>',
      '<TotalTime>1</TotalTime>',

      // todo: are these lines really needed ?
      //'<Pages>6</Pages>',
      //'<Words>2340</Words>',
      //'<Characters>13340</Characters>',
      //'<Lines>111</Lines>',
      //'<Paragraphs>31</Paragraphs>',
      //'<CharactersWithSpaces>15649</CharactersWithSpaces>',

      '<Application>FastReports</Application>',
      '<DocSecurity>0</DocSecurity>',
      '<ScaleCrop>false</ScaleCrop>',
      '<Company></Company>',
      '<LinksUpToDate>false</LinksUpToDate>',
      '<SharedDoc>false</SharedDoc>',
      '<HyperlinksChanged>false</HyperlinksChanged>',
      '<AppVersion>12.0000</AppVersion>',
      '</Properties>']);

    Free;
  end;

  { word/_rels/document.xml.rels }

  FDocRels := TFileStream.Create(SubPath('word/_rels/document.xml.rels'), fmCreate);
  with TfrxWriter.Create(FDocRels) do
  begin
    Write(['<?xml version="1.0" encoding="UTF-8" standalone="yes"?>',
      '<Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships">',
//      '<Relationship Id="rId3" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/webSettings" Target="webSettings.xml"/>',
      '<Relationship Id="rId2" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/settings" Target="settings.xml"/>',
      '<Relationship Id="rId1" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/styles" Target="styles.xml"/>',
//      '<Relationship Id="rId5" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/theme" Target="theme/theme1.xml"/>',
      '<Relationship Id="rId4" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/fontTable" Target="fontTable.xml"/>']);

    Free;
  end;

  { word/webSettings.xml }
{
  with TfrxFileWriter.Create(SubPath('word/webSettings.xml')) do
  begin
    Write(['<?xml version="1.0" encoding="UTF-8" standalone="yes"?>',
      '<w:webSettings xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/relationships" xmlns:w="http://schemas.openxmlformats.org/wordprocessingml/2006/main">',
      '<w:optimizeForBrowser/>',
      '</w:webSettings>']);

    Free;
  end;
}
  { word/styles.xml }

  with TResourceStream.Create(HInstance, 'OfficeOpenStyles', 'XML') do
  begin
    SaveToFile(SubPath('word/styles.xml'));
    Free;
  end;

  { word/fontTable.xml }

  with TResourceStream.Create(HInstance, 'DocxFontTable', 'XML') do
  begin
    SaveToFile(SubPath('word/fontTable.xml'));
    Free;
  end;

  { word/settings.xml }

  with TResourceStream.Create(HInstance, 'OfficeOpenSettings', 'XML') do
  begin
    SaveToFile(SubPath('word/settings.xml'));
    Free;
  end;

  { word/theme/theme1.xml }
{
  with TResourceStream.Create(HInstance, 'OfficeOpenTheme', 'XML') do
  begin
    SaveToFile(SubPath('word/theme/theme1.xml'));
    Free;
  end;
}
  { word/document.xml }

  FDocument := TFileStream.Create(SubPath('word/document.xml'), fmCreate);
  with TfrxWriter.Create(FDocument) do
  begin
    Write(['<?xml version="1.0" encoding="UTF-8" standalone="yes"?>',
      '<w:document xmlns:ve="http://schemas.openxmlformats.org/markup-compatibility/2006"',
      ' xmlns:o="urn:schemas-microsoft-com:office:office"',
      ' xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/relationships"',
      ' xmlns:m="http://schemas.openxmlformats.org/officeDocument/2006/math"',
      ' xmlns:v="urn:schemas-microsoft-com:vml"',
      ' xmlns:wp="http://schemas.openxmlformats.org/drawingml/2006/wordprocessingDrawing"',
      ' xmlns:w10="urn:schemas-microsoft-com:office:word" xmlns:w="http://schemas.openxmlformats.org/wordprocessingml/2006/main" xmlns:wne="http://schemas.microsoft.com/office/word/2006/wordml">',
      '<w:body>']);

    Free;
  end;
end;

procedure TfrxDOCXExport.StartPage(Page: TfrxReportPage; Index: Integer);
begin
  FMatrix := TfrxIEMatrix.Create(UseFileCache, Report.EngineOptions.TempDir);

  with FMatrix do
  begin
    Background      := False;
    BackgroundImage := False;
    Printable       := ExportNotPrintable;
    RichText        := False;
    PlainRich       := False;
    Inaccuracy      := 2;
    DeleteHTMLTags  := True;
    Images          := True;
    WrapText        := False;
    ShowProgress    := False;
    EmptyLines      := True;
    BrushAsBitmap   := False;
    EMFPictures     := True;
    MaxCellWidth    := 500;
    MaxCellHeight   := 500;
  end;

  if not FFirstPage then
    with TfrxWriter.Create(FDocument) do
    begin
      Write(['<w:p>',
        '<w:pPr><w:widowControl w:val="0"/><w:autoSpaceDE w:val="0"/>',
        '<w:autoSpaceDN w:val="0"/><w:adjustRightInd w:val="0"/><w:spacing w:after="0" w:line="240" w:lineRule="auto"/>',
        '<w:rPr><w:rFonts w:ascii="Tahoma" w:hAnsi="Tahoma" w:cs="Tahoma"/><w:sz w:val="24"/>',
        '<w:szCs w:val="24"/></w:rPr>', SecPr, '</w:pPr></w:p>']);

      Free;
    end;

  FFirstPage := False;
end;

constructor TfrxDOCXExport.Create(Owner: TComponent);
begin
  inherited;
  DefaultExt := '.docx';
end;

procedure TfrxDOCXExport.ExportObject(Obj: TfrxComponent);
var
  v: TfrxView;
begin
  if not (Obj is TfrxView) then
    Exit;

  v := Obj as TfrxView;

  if (v.Name = '_pagebackground') or not v.Printable and not ExportNotPrintable then
    Exit;

  FMatrix.AddObject(v);
end;

procedure TfrxDOCXExport.FinishPage(Page: TfrxReportPage; Index: Integer);

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
    Result := Format('%x%x%x%x%x%x', [R0,R1,G0,G1,B0,B1] );
  end;

  function BorderStyle(style: TfrxFrameStyle): String;
  begin
      case style of
      fsSolid:        Result := 'single';
      fsDash:         Result := 'dashed';
      fsDot:          Result := 'dotted';
      fsDashDot:      Result := 'dashDot';
      fsDashDotDot:   Result := 'dashDotDot';
      fsDouble:       Result := 'double';
      fsAltDot:       Result := 'dashDot';
      fsSquare:       Result := 'thin';
      else            Result := 'thin';
      end;
  end;

  function GetBorder( fl: TfrxFrameLine; ex: Bool): string;
  begin
    if ex then
      Result := Format('w:val="%s" w:sz="%d" w:space="0" w:color="#%s"',
        [ BorderStyle(fl.Style), 4, ColorText(fl.Color) ])
    else
      Result := 'w:val="nil"';
  end;

  function GetVAlign(a: TfrxVAlign): string;
  begin
    case a of
      vaTop: Result := 'top';
      vaBottom: Result := 'bottom';
      vaCenter: Result := 'center';
      else Result := 'top';
    end;
  end;

  function GetHAlign(a: TfrxHAlign): string;
  begin
    case a of
      haLeft: Result := 'left';
      haRight: Result := 'right';
      haCenter: Result := 'center';
      haBlock: Result := 'both';
      else Result := 'left';
    end;
  end;

  function BStr(b: Boolean; s: string): string;
  begin
    if b then
      Result := s
    else
      Result := '';
  end;

  function GetFont(f: TFont): string;
  begin
    Result := Format('<w:rPr><w:rFonts w:ascii="%s" w:hAnsi="%s" w:cs="%s"/>%s<w:bCs/><w:color w:val="#%.6X"/>' +
    '<w:sz w:val="%d"/><w:szCs w:val="%d"/></w:rPr>',
    [f.Name, f.Name, f.Name, BStr(fsBold in f.Style, '<w:b/>'), RGBSwap(f.Color), f.Size * 2, f.Size * 2]);
  end;

  function GetMerging(r, c: Integer): string;
  var
    i, x, y, dx, dy: Integer;
  begin
    Result := '';
    i := FMatrix.GetCell(c, r);
    if i < 0 then
      Exit;

    FMatrix.GetObjectPos(i, x, y, dx, dy);

    if dy > 1 then
      if r = y then
        Result := '<w:vMerge w:val="restart"/>'
      else
        Result := '<w:vMerge/>';
  end;

  function GetText(const s: string): string;
  begin
    if s = '' then
      Result := ''
    else
      Result := '<w:t>' + Escape(s) + '</w:t>';
  end;

  function GetPicture(m: TMetafile): string;
  var
    w, h: Integer;
    id, pic: string;
  begin
    if m.Width = 0 then
    begin
      Result := '';
      Exit;
    end;

    w := Round(m.MMWidth * MMFactor);
    h := Round(m.MMHeight * MMFactor);
    id := 'picId' + IntToStr(FPicNum);
    pic := 'image' + IntToStr(FPicNum) + '.emf';

    with TfrxWriter.Create(FDocRels) do
    begin
      Write('<Relationship Id="%s" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/image"' +
        ' Target="media/%s"/>', [id, pic]);

      Free;
    end;

    SaveGraphicAs(m, SubPath('word/media/' + pic), PictureType);
    Inc(FPicNum);

    Result := Format('<w:drawing><wp:inline distT="0" distB="0" distL="0" distR="0">' +
      '<wp:extent cx="%d" cy="%d"/><wp:effectExtent l="0" t="0" r="0" b="0"/>' +
      '<wp:docPr id="1" name="Picture"/><wp:cNvGraphicFramePr>' +
      '<a:graphicFrameLocks xmlns:a="http://schemas.openxmlformats.org/drawingml/2006/main" noChangeAspect="1"/>' +
      '</wp:cNvGraphicFramePr><a:graphic xmlns:a="http://schemas.openxmlformats.org/drawingml/2006/main">' +
      '<a:graphicData uri="http://schemas.openxmlformats.org/drawingml/2006/picture">' +
      '<pic:pic xmlns:pic="http://schemas.openxmlformats.org/drawingml/2006/picture">' +
      '<pic:nvPicPr><pic:cNvPr id="0" name="Picture"/><pic:cNvPicPr>' +
      '<a:picLocks noChangeAspect="1" noChangeArrowheads="1"/></pic:cNvPicPr></pic:nvPicPr>' +
      '<pic:blipFill><a:blip r:embed="%s"/><a:srcRect/><a:stretch><a:fillRect/></a:stretch></pic:blipFill>' +
      '<pic:spPr bwMode="auto"><a:xfrm><a:off x="0" y="0"/><a:ext cx="%d" cy="%d"/></a:xfrm>' +
      '<a:prstGeom prst="rect"><a:avLst/></a:prstGeom><a:noFill/><a:ln w="9525"><a:noFill/><a:miter lim="800000"/>' +
      '<a:headEnd/><a:tailEnd/></a:ln></pic:spPr></pic:pic></a:graphicData></a:graphic></wp:inline></w:drawing>',
      [w, h, id, w, h]);
  end;

var
  i, r, c1, c2: Integer;
  Obj: TfrxIEMObject;
  w: Integer;
  s: TfrxIEMStyle;
  rotate: String;
begin
  with FLastPage do
  begin
    Width := Round(Page.PaperWidth * LenFactor);
    Height := Round(Page.PaperHeight * LenFactor);

    with Margins do
    begin
      Left := Round(Page.LeftMargin * LenFactor);
      Right := Round(Page.RightMargin * LenFactor);
      Top := Round(Page.TopMargin * LenFactor);
      Bottom := Round(Page.BottomMargin * LenFactor);
    end;
  end;

  FMatrix.Prepare;

  for i := 0 to FMatrix.GetObjectsCount - 1 do
    FMatrix.GetObjectById(i).Counter := 0;

  with TfrxWriter.Create(FDocument) do
  begin
    Write('<w:tbl>');

    Write(['<w:tblPr><w:tblW w:w="0" w:type="auto"/><w:tblInd w:w="15" w:type="dxa"/>',
      '<w:tblLayout w:type="fixed"/><w:tblCellMar><w:left w:w="15" w:type="dxa"/>',
      '<w:right w:w="15" w:type="dxa"/></w:tblCellMar><w:tblLook w:val="0000"/>',
      '</w:tblPr>']);

    Write('<w:tblGrid>');

    for i := 0 to FMatrix.Width - 2 do
    begin
      w := Round(XFactor * (FMatrix.GetXPosById(i + 1) - FMatrix.GetXPosById(i)));
      Write('<w:gridCol w:w="%d"/>', [w]);
    end;

    Write('</w:tblGrid>');

    for r := 0 to FMatrix.Height - 2 do
    begin
      Write('<w:tr>');

      Write('<w:tblPrEx><w:tblCellMar><w:top w:w="0" w:type="dxa"/><w:bottom w:w="0" w:type="dxa"/>' +
        '</w:tblCellMar></w:tblPrEx><w:trPr><w:trHeight w:hRule="exact" w:val="%d"/></w:trPr>',
        [Round(YFactor * (FMatrix.GetYPosById(r + 1) - FMatrix.GetYPosById(r)))]);

      c1 := 0;
      while c1 < FMatrix.Width - 1 do
      begin
        c2 := c1;
        w := 0;

        with FMatrix do
          while (c2 < Width - 1) and (GetCell(c1, r) = GetCell(c2, r)) do
          begin
            Inc(w, Round(XFactor * (GetXPosById(c2 + 1) - GetXPosById(c2))));
            Inc(c2);
          end;

        Dec(c2);

        Write('<w:tc>');
        Write('<w:tcPr><w:tcW w:w="%d" w:type="dxa"/>', [w]);

        if c2 > c1 then
          Write('<w:gridSpan w:val="%d"/>', [c2 - c1 + 1]);

        Obj := FMatrix.GetObject(c1, r);
        s := FMatrix.GetStyle(c1, r);

        Write(GetMerging(r, c1));

        if (s <> nil) then
          Write('<w:tcBorders><w:top %s/><w:left %s/><w:bottom %s/><w:right %s/></w:tcBorders>',
            [GetBorder(s.TopLine, ftTop in s.FrameTyp),
            GetBorder(s.LeftLine, ftLeft in s.FrameTyp),
            GetBorder(s.BottomLine, ftBottom in s.FrameTyp),
            GetBorder(s.RightLine, ftRight in s.FrameTyp)]);

        if Obj <> nil then begin
          Write('<w:shd w:val="clear" w:color="auto" w:fill="#%.6X"/><w:vAlign w:val="%s"/>',
            [RGBSwap(s.Color), GetVAlign(s.VAlign)]);
          if Obj.Style.Rotation <> 0 then begin
            case Obj.Style.Rotation of
              90:   rotate := 'btLr';
              270:  rotate := 'tbRlV';
            else
              rotate := 'lrTb';
            end;
            Write('<w:textDirection w:val="' + rotate + '" />');
          end;
        end;

        Write('</w:tcPr>');

        Write('<w:p>');

        Write('<w:pPr><w:widowControl w:val="0"/>' +
          '<w:autoSpaceDE w:val="0"/><w:autoSpaceDN w:val="0"/><w:adjustRightInd w:val="0"/>' +
          '<w:spacing w:before="29" w:after="0" w:line="213" w:lineRule="auto"/><w:ind w:left="15"/>');

        if Obj <> nil then
        begin
          Write('<w:jc w:val="%s"/>', [GetHAlign(s.HAlign)]);
          Write(GetFont(s.Font));
        end;

        Write('</w:pPr>');

        if (Obj <> nil) and (Obj.Counter = 0) then
          if Obj.Metafile.Width > 0 then
            Write(['<w:r>', GetFont(s.Font), GetPicture(Obj.Metafile), '</w:r>'])
          else
            for i := 0 to Obj.Memo.Count - 1 do
              // note: in unicode delphi12+ Utf8Encode has no effect: when converted to widestring it does utf8decode automatically
              Write(['<w:r>', GetFont(s.Font), BStr(i > 0, '<w:br/>'), GetText(String(Utf8Encode(Obj.Memo[i]))), '</w:r>'], {$IFDEF Delphi12}True{$ELSE}False{$ENDIF});

        Write('</w:p></w:tc>');
        c1 := c2 + 1;

        if Obj <> nil then
          Obj.Counter := 1;
      end;

      Write('</w:tr>');
    end;

    Write('</w:tbl>');
    Free;
  end;

  FMatrix.Free;
end;

procedure TfrxDOCXExport.Finish;
var
  Zip: TfrxZipArchive;
  f: TStream;
begin
  with TfrxWriter.Create(FDocRels) do
  begin
    Write('</Relationships>');
    Free;
  end;

  with TfrxWriter.Create(FDocument) do
  begin
    Write(['<w:p/>',
      SecPr, '</w:body></w:document>']);

    Free;
  end;

  FDocRels.Free;
  FDocument.Free;

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
      Zip.RootFolder := AnsiString(FDocFolder + '\');
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

{ TfrxDOCXExportDialog }

procedure TfrxDOCXExportDialog.FormCreate(Sender: TObject);

  procedure AssignTexts(Root: TWinControl);
  var
    c: TControl;
    i: LongInt;
  begin
    with Root do
      if Tag > 0 then
        SetTextBuf(PChar(frxGet(Tag)));

    with Root do
      for i := 0 to ControlCount - 1 do
      begin
        c := Controls[i];

        with c do
          if Tag > 0 then
            SetTextBuf(PChar(frxGet(Tag)));

        if c is TWinControl then
          AssignTexts(c as TWinControl);
      end;
  end;

begin
  AssignTexts(Self);

  if UseRightToLeftAlignment then
    FlipChildren(True);
end;

procedure TfrxDOCXExportDialog.PageNumbersEChange(Sender: TObject);
begin
  PageNumbersRB.Checked := True;
end;

procedure TfrxDOCXExportDialog.PageNumbersEKeyPress(Sender: TObject;
  var Key: Char);
begin
  case key of
    '0'..'9':;
    #8, '-', ',':;
  else
    key := #0;
  end;
end;

procedure TfrxDOCXExportDialog.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_F1 then
    frxResources.Help(Self);
end;

end.
