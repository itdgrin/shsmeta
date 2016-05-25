
{******************************************}
{                                          }
{             FastReport v5.0              }
{        Open Document Format export       }
{                                          }
{         Copyright (c) 1998-2014          }
{          by Alexander Fediachov,         }
{             Fast Reports Inc.            }
{                                          }
{******************************************}

unit frxExportODF;

interface

{$I frx.inc}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, extctrls, Printers, frxClass, frxExportMatrix, frxProgress,
  frxXML, ShellAPI, frxImageConverter,  frxZip, Variants
{$IFDEF DELPHI16}
, System.UITypes
{$ENDIF}
;

type
  TfrxODFExportDialog = class(TForm)
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
    OpenCB: TCheckBox;
    BackgrCB: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure PageNumbersEChange(Sender: TObject);
    procedure PageNumbersEKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  end;

{$IFDEF DELPHI16}
[ComponentPlatformsAttribute(pidWin32 or pidWin64)]
{$ENDIF}
  TfrxODFExport = class(TfrxCustomExportFilter)
  private
    FExportPageBreaks: Boolean;
    FExportStyles: Boolean;
    FFirstPage: Boolean;
    FMatrix: TfrxIEMatrix;
    FOpenAfterExport: Boolean;
    FPageBottom: Extended;
    FPageLeft: Extended;
    FPageRight: Extended;
    FPageTop: Extended;
    FPageWidth: Extended;
    FPageHeight: Extended;
    FPageOrientation: TPrinterOrientation;
    FWysiwyg: Boolean;
    FSingleSheet: Boolean;
    FBackground: Boolean;
    FCreator: String;
    FEmptyLines: Boolean;
    FTempFolder: String;
    FZipFile: TfrxZipArchive;
    FThumbImage: TImage;
    FProgress: TfrxProgress;
    FExportType: String;
    FLanguage: string;
    FStyleNode: TfrxXMLItem;  // this node contains ODF styles
    FStyles: TList;           // List of TSpanStyle
    FPicCount: Integer;
    FCreationTime: TDateTime;
    FPictureType: TfrxPictureType;
    FRowStyleNames: TStrings;

    function  IsTerminated: Boolean;
    procedure DoOnProgress(Sender: TObject);
    function OdfPrepareString(const Str: WideString): WideString;
    function OdfGetFrameName(const FrameStyle:  TfrxFrameStyle): String;
    procedure OdfMakeHeader(const Item: TfrxXMLItem);
    procedure OdfCreateMeta(const FileName: String; const Creator: String);
    procedure OdfCreateManifest(const FileName: String; const PicCount: Integer; const MValue: String);
    procedure OdfCreateMime(const FileName: String; const MValue: String);
    procedure AddNumberStyle(Item: TfrxXMLItem; const StyleName, Fmt: string);
    procedure ExportBody(BodyNode: TfrxXMLItem);
    procedure AddPic(Node: TfrxXMLItem; Obj: TfrxIEMObject);
    procedure SplitOnTags( pNode: TfrxXMLItem; obj: TfrxIEMObject; line: WideString );
    function GetHeaderText(m: TfrxIEMatrix): string;
    function GetFooterText(m: TfrxIEMatrix): string;
    procedure CreateStyles;
    function CreateRowStyle(Row: Integer; PageBreakBefore: Boolean): string;
   procedure SetPictureType(PT: TfrxPictureType);

    // Exports a row from the matrix to an ODF node.

    procedure CreateRow(Node: TfrxXMLItem; Row: Integer; PageBreak: Boolean);

    // Exports a range of rows from the matrix to an ODF node
    // representing a report page.

    procedure ExportRows(PageNode: TfrxXMLItem; RowFirst, RowLast, PageIndex: Integer);

    // Creates an empty ODF cell.

    procedure CreatEmptyCell(Node: TfrxXMLItem);

    // Creates an adjacent empty cell.
    // Such cells are created when an object covers several
    // cells: one cell contains the object's data, the other
    // are adjacent empty cells.

    procedure CreateAdjacentCell(Node: TfrxXMLItem; Columns: Integer = 1);

    // Creates an ODF cell with text or a picture.

    procedure CreateDataCell(Node: TfrxXMLItem; Obj: TfrxIEMObject;
      RowsSpanned, ColsSpanned: Integer);

    //
    // Adds a named style to the ODF document
    // and returns the name of the added style.
    // If a style with the same parameters has
    // already been added, the duplicate is not
    // created.
    //

    function AddStyle(Color: TColor; Style: TFontStyles): WideString;

    // Checks whether a row in the matrix is empty.

    function IsRowEmpty(Row: Integer): Boolean;

  protected

    procedure ExportPage(Stream: TStream);

  public

    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    class function GetDescription: String; override;
    class function ProcessSpaces(const s: WideString): WideString;
    class function ProcessTabs(const s: WideString): WideString;
    class function ProcessControlSymbols(const s: WideString): WideString;

    function ShowModal: TModalResult; override;
    function Start: Boolean; override;
    procedure Finish; override;
    procedure FinishPage(Page: TfrxReportPage; Index: Integer); override;
    procedure StartPage(Page: TfrxReportPage; Index: Integer); override;
    procedure ExportObject(Obj: TfrxComponent); override;

    property ExportType: String read FExportType write FExportType;
    property ExportTitle;

  published

    property PictureType: TfrxPictureType read FPictureType write SetPictureType;
    property ExportStyles: Boolean read FExportStyles write FExportStyles default True;
    property ExportPageBreaks: Boolean read FExportPageBreaks write FExportPageBreaks default True;
    property OpenAfterExport: Boolean read FOpenAfterExport write FOpenAfterExport default False;
    property Wysiwyg: Boolean read FWysiwyg write FWysiwyg default True;
    property Background: Boolean read FBackground write FBackground default False;
    property Creator: String read FCreator write FCreator;
    property CreationTime: TDateTime read FCreationTime write FCreationTime;
    property EmptyLines: Boolean read FEmptyLines write FEmptyLines default True;
    property SingleSheet: Boolean read FSingleSheet write FSingleSheet default False;
    property Language: string read FLanguage write FLanguage; {default 'en'}
    property SuppressPageHeadersFooters;
    property OverwritePrompt;
  end;

{$IFDEF DELPHI16}
[ComponentPlatformsAttribute(pidWin32 or pidWin64)]
{$ENDIF}
  TfrxODSExport = class(TfrxODFExport)
  public
    constructor Create(AOwner: TComponent); override;
    class function GetDescription: String; override;
    property ExportTitle;
  published
    property ExportStyles;
    property ExportPageBreaks;
    property OpenAfterExport;
    property ShowProgress;
    property Wysiwyg;
    property Background;
    property Creator;
    property EmptyLines;
    property SuppressPageHeadersFooters;
    property OverwritePrompt;
    property PictureType;
  end;

{$IFDEF DELPHI16}
[ComponentPlatformsAttribute(pidWin32 or pidWin64)]
{$ENDIF}
  TfrxODTExport = class(TfrxODFExport)
  public
    constructor Create(AOwner: TComponent); override;
    class function GetDescription: String; override;
  published
    property ExportStyles;
    property ExportPageBreaks;
    property OpenAfterExport;
    property ShowProgress;
    property Wysiwyg;
    property Background;
    property Creator;
    property EmptyLines;
    property SuppressPageHeadersFooters;
    property OverwritePrompt;
    property PictureType;
  end;

implementation

uses
  frxUtils,
  frxFileUtils,
  frxUnicodeUtils,
  frxRes,
  frxrcExports,
  frxGraphicUtils,
  jpeg;

{$R *.dfm}

const
  odfDivider = 38.5;
  odfPageDiv = 37.8;
  odfMargDiv = 10;
  odfHeaderSize = 20;
  odfRep = 'urn:oasis:names:tc:opendocument:xmlns:';

var
  odfXMLHeader: array[0..odfHeaderSize - 1] of array [0..1] of String = (
  ('xmlns:office', odfRep + 'office:1.0'),
  ('xmlns:style', odfRep + 'style:1.0'),
  ('xmlns:text', odfRep + 'text:1.0'),
  ('xmlns:table', odfRep + 'table:1.0'),
  ('xmlns:draw', odfRep + 'drawing:1.0'),
  ('xmlns:fo', odfRep + 'xsl-fo-compatible:1.0'),
  ('xmlns:xlink', 'http://www.w3.org/1999/xlink'),
  ('xmlns:dc', 'http://purl.org/dc/elements/1.1/'),
  ('xmlns:meta', odfRep + 'meta:1.0'),
  ('xmlns:number', odfRep + 'datastyle:1.0'),
  ('xmlns:svg', odfRep + 'svg-compatible:1.0'),
  ('xmlns:chart', odfRep + 'chart:1.0'),
  ('xmlns:dr3d', odfRep + 'dr3d:1.0'),
  ('xmlns:math', 'http://www.w3.org/1998/Math/MathML'),
  ('xmlns:form', odfRep + 'form:1.0'),
  ('xmlns:script', odfRep + 'script:1.0'),
  ('xmlns:dom', 'http://www.w3.org/2001/xml-events'),
  ('xmlns:xforms', 'http://www.w3.org/2002/xforms'),
  ('xmlns:xsd', 'http://www.w3.org/2001/XMLSchema'),
  ('xmlns:xsi', 'http://www.w3.org/2001/XMLSchema-instance'));

type
  TSpanStyle = class
  public
    Color:    TColor;
    Style:    TFontStyles;
    Name:     WideString;
  end;

  TAnsiCharSet = set of AnsiChar;

function FilterStr(const Src: string; const Chars: TAnsiCharSet): string;
var
  i: Integer;
begin
  Result := '';

  for i := 1 to Length(Src) do
    if AnsiChar(Src[i]) in Chars then
      Result := Result + Src[i];
end;

{ TfrxODFExport }

constructor TfrxODFExport.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FExportPageBreaks := True;
  FExportStyles := True;
  FWysiwyg := True;
  FBackground := True;
  FCreator := 'FastReport';
  FEmptyLines := True;
  FThumbImage := TImage.Create(nil);
  FLanguage := 'en';
  FRowStyleNames := TStringList.Create;
  TStringList(FRowStyleNames).Sorted := True;
end;

procedure TfrxODFExport.SetPictureType(PT: TfrxPictureType);
begin
  FPictureType := PT;
end;

procedure TfrxODFExport.AddNumberStyle(Item: TfrxXMLItem; const StyleName, Fmt: string);
var
  DecSep: Integer;
  DecPlaces: string;
begin
  DecSep := Pos('.', Fmt);

  if DecSep = 0 then
    DecPlaces := '0'
  else
    DecPlaces := FilterStr(Copy(Fmt, DecSep, Length(Fmt)), ['0'..'9']);

  if DecPlaces = '' then
    DecPlaces := '0';

  with Item do
  begin
    Name := 'number:number-style';

    Prop['style:name'] := StyleName;

    with Add do
    begin
      Name := 'number:number';

      Prop['number:decimal-places'] := DecPlaces;
      Prop['number:min-integer-digits'] := '1';
    end;
  end;
end;

class function TfrxODFExport.GetDescription: String;
begin
  Result := '';
end;

procedure TfrxODFExport.OdfCreateMeta(const FileName: String; const Creator: String);
var
  XML: TfrxXMLDocument;
begin
  XML := TfrxXMLDocument.Create;
  try
    XML.AutoIndent := True;
    XML.Root.Name := 'office:document-meta';
    XML.Root.Prop['xmlns:office'] := 'urn:oasis:names:tc:opendocument:xmlns:office:1.0';
    XML.Root.Prop['xmlns:xlink'] := 'http://www.w3.org/1999/xlink';
    XML.Root.Prop['xmlns:dc'] := 'http://purl.org/dc/elements/1.1/';
    XML.Root.Prop['xmlns:meta'] := 'urn:oasis:names:tc:opendocument:xmlns:meta:1.0';
    with XML.Root.Add do
    begin
      Name := 'office:meta';
      with Add do
      begin
        Name := 'meta:generator';
        Value := 'fast-report.com/Fast Report/build:' + FR_VERSION;
      end;
      with Add do
      begin
        Name := 'meta:initial-creator';
        Value := string(UTF8Encode(Creator));
      end;
      with Add do
      begin
        Name := 'meta:creation-date';
        Value := FormatDateTime('YYYY-MM-DD', CreationTime) + 'T' +
          FormatDateTime('HH:MM:SS', CreationTime);
      end;
    end;
    XML.SaveToFile(FileName);
  finally
    XML.Free;
  end;
end;

procedure TfrxODFExport.OdfCreateMime(const FileName: String; const MValue: String);
var
  f: TFileStream;
  s: AnsiString;
begin
  f := TFileStream.Create(FileName, fmCreate);
  try
    s := AnsiString('application/vnd.oasis.opendocument.' + MValue);
    f.Write(s[1], Length(s));
  finally
    f.Free;
  end;
end;

procedure TfrxODFExport.OdfCreateManifest(const FileName: String; const PicCount: Integer; const MValue: String);
var
  XML: TfrxXMLDocument;
  i: Integer;
  Fmime, s: String;
begin
  XML := TfrxXMLDocument.Create;
  try
    XML.AutoIndent := True;
    XML.Root.Name := 'manifest:manifest';
    XML.Root.Prop['xmlns:manifest'] := 'urn:oasis:names:tc:opendocument:xmlns:manifest:1.0';
    with XML.Root.Add do
    begin
      Name := 'manifest:file-entry';
      Prop['manifest:media-type'] := 'application/vnd.oasis.opendocument.' + MValue;
      Prop['manifest:full-path'] := '/';
    end;
    with XML.Root.Add do
    begin
      Name := 'manifest:file-entry';
      Prop['manifest:media-type'] := 'text/xml';
      Prop['manifest:full-path'] := 'content.xml';
    end;
    with XML.Root.Add do
    begin
      Name := 'manifest:file-entry';
      Prop['manifest:media-type'] := 'text/xml';
      Prop['manifest:full-path'] := 'styles.xml';
    end;
    with XML.Root.Add do
    begin
      Name := 'manifest:file-entry';
      Prop['manifest:media-type'] := 'text/xml';
      Prop['manifest:full-path'] := 'meta.xml';
    end;
    s := '.' + GetPicFileExtension(PictureType);
    FMime := GetFileMIMEType(s);
    for i := 1 to PicCount do
      with XML.Root.Add do
      begin
        Name := 'manifest:file-entry';
        Prop['manifest:media-type'] := FMime;
        Prop['manifest:full-path'] := 'Pictures/Pic' + IntToStr(i) + s;
      end;
    XML.SaveToFile(FileName);
  finally
    XML.Free;
  end;
end;

function TfrxODFExport.OdfPrepareString(const Str: WideString): WideString;
var
  i: Integer;
  s: WideString;
begin
  Result := '';
  s := Str;
  if Copy(s, Length(s) - 1, 4) = #13#10 then
    Delete(s, Length(s) - 1, 4);
  for i := 1 to Length(s) do
  begin
    if s[i] = '&' then
      Result := Result + '&amp;'
    else
    if s[i] = '"' then
      Result := Result + '&quot;'
    else if s[i] = '<' then
      Result := Result + '&lt;'
    else if s[i] = '>' then
      Result := Result + '&gt;'
    else if (s[i] <> #10) then
      Result := Result + s[i]
  end;
end;

class function TfrxODFExport.ProcessSpaces(const s: WideString): WideString;

  function Ch(i: Integer): WideChar;
  begin
    if (i > 0) and (i <= Length(s)) then
      Result := s[i]
    else
      Result := #0;
  end;

  function Ts(n: Integer): WideString;
  begin
    if n = 1 then
      Result := '<text:s/>'
    else
      Result := '<text:s text:c="' + IntToStr(n) + '"/>';
  end;

const
  Space: WideChar = ' ';
var
  f, i: Integer;
begin
  if s = '' then
  begin
    Result := '';
    Exit;
  end;

  f := 1;
  Result := '';

  for i := 1 to Length(s) do
    if (s[f] = Space) <> (s[i] = Space) then
      if s[f] = Space then
      begin
        Result := Result + Ts(i - f);
        f := i;
      end
      else if (i > 0) and (s[i - 1] = Space) or (i = Length(s)) then
      begin
        Result := Result + Copy(s, f, i - f);
        f := i;
      end;

  i := Length(s) + 1;

  if s[f] = Space then
    Result := Result + Ts(i - f)
  else
    Result := Result + Copy(s, f, i - f);
end;

class function TfrxODFExport.ProcessTabs(const s: WideString): WideString;
begin
  Result := StringReplace(s, #9, '<text:tab/>', [rfReplaceAll]);
end;

class function TfrxODFExport.ProcessControlSymbols(const s: WideString): WideString;
var
  i, j: Integer;
begin
  SetLength(Result, Length(s));
  i := 0;

  for j := 1 to Length(s) do
    if Ord(s[j]) > 31 then
    begin
      i := i + 1;
      Result[i] := s[j];
    end;

  SetLength(Result, i);
end;

function TfrxODFExport.OdfGetFrameName(const FrameStyle:  TfrxFrameStyle): String;
begin
  if FrameStyle = fsDouble then
    Result := 'double'
  else
    Result := 'solid';
end;

procedure TfrxODFExport.OdfMakeHeader(const Item: TfrxXMLItem);
var
  i: Integer;
begin
  for i := 0 to odfHeaderSize - 1 do
    Item.Prop[odfXMLHeader[i][0]] := odfXMLHeader[i][1];
end;

procedure TfrxODFExport.CreatEmptyCell(Node: TfrxXMLItem);
begin
  Node.Name := 'table:table-cell';
end;

procedure TfrxODFExport.CreateAdjacentCell(Node: TfrxXMLItem; Columns: Integer = 1);
begin
  Node.Name := 'table:covered-table-cell';
  Node.Prop['table:style-name'] := 'ceb';

  if Columns > 1 then
    Node.Prop['table:number-columns-repeated'] := IntToStr(Columns);
end;

procedure TfrxODFExport.CreateDataCell(Node: TfrxXMLItem; Obj: TfrxIEMObject;
  RowsSpanned, ColsSpanned: Integer);
var
  k: Integer;
  sl: TStringList;
  s, s2: WideString;
  LineNode: TfrxXMLItem;

begin

  with Node do
  begin
    Name := 'table:table-cell';
    Prop['table:style-name'] := 'ce' + IntToStr(Obj.StyleIndex);

    if (RowsSpanned > 1) or (ColsSpanned > 1) then
    begin
      Prop['table:number-columns-spanned'] := IntToStr(ColsSpanned);
      Prop['table:number-rows-spanned'] := IntToStr(RowsSpanned);
    end;

    // text cell

    if Obj.IsText then
    begin
      s := Obj.Memo.Text;

      if not Obj.HTMLTags then
        s := OdfPrepareString(s);

      s := ProcessSpaces(s);
      s := ProcessTabs(s);
      s := ProcessControlSymbols(s);

      with Obj.Style.DisplayFormat do
        if Kind <> fkNumeric then
        begin
          {$IFNDEF Delphi12}
          s := UTF8Encode(s);
          {$ENDIF}

          Prop['office:value-type'] := 'string';

          sl := TStringList.Create;
          sl.Text := s;

          for k := 0 to sl.Count - 1 do
          begin
            LineNode := Add;
            LineNode.Name := 'text:p';

            if ExportType = 'text' then
              LineNode.Prop['text:style-name'] := 'p' + IntToStr(Obj.StyleIndex);

            if (Obj.URL <> '') and (Obj.URL[1] <> '#') and (Obj.URL[1] <> '@') then
            begin
              LineNode := LineNode.Add;
              with LineNode do
              begin
                Name := 'text:a';
                Prop['xlink:href'] := Obj.URL;
              end;
            end;

            if Obj.HTMLTags then
              SplitOnTags(LineNode, Obj, sl[k])
            else
              LineNode.Value := sl[k];
          end;

          sl.Free;
        end
        else
        begin
          s2 := '';

          for k := 1 to Length(s) do
            if AnsiChar(s[k]) in ['0'..'9', '-'] then
              s2 := s2 + s[k]
            else
{$IFDEF DELPHI16}
              if (Char(s[k]) = FormatSettings.DecimalSeparator) or (s[k] = DecimalSeparator) then
                s2 := s2 + FormatSettings.DecimalSeparator;
{$ELSE}
              if (Char(s[k]) = SysUtils.DecimalSeparator) or (s[k] = DecimalSeparator) then
                s2 := s2 + SysUtils.DecimalSeparator;
{$ENDIF}


          Prop['office:value-type'] := 'float';

{$IFDEF DELPHI16}
          Prop['office:value'] := string(UTF8Encode(
              StringReplace(s2, FormatSettings.DecimalSeparator, '.', [rfReplaceAll])));
{$ELSE}
          Prop['office:value'] := string(UTF8Encode(
              StringReplace(s2, SysUtils.DecimalSeparator, '.', [rfReplaceAll])));
{$ENDIF}


          s := WideString(UTF8Encode(s));

          with Add do
          begin
            Name := 'text:p';
            Value := s;

            if ExportType = 'text' then
              Prop['text:style-name'] := 'p' + IntToStr(Obj.StyleIndex);
          end;
        end;
    end

    // picture cell

    else if (Obj.Image <> nil) or (Obj.Metafile.Width > 0) then
      if FExportType <> 'text' then
        AddPic(Add, Obj)
      else
        with Add do
        begin
          Name := 'text:p';
          AddPic(Add, Obj);
        end
  end;
end;

procedure TfrxODFExport.CreateRow(Node: TfrxXMLItem; Row: Integer; PageBreak: Boolean);
var
  x: Integer;
  Obj: TfrxIEMObject;
  fx, fy, dx, dy: Integer;
  acn: Integer; // number of consequent adjacent cells

  procedure FlushAdjacentCells();
  begin
    if acn > 0 then
    begin
      CreateAdjacentCell(Node.Add, acn);
      acn := 0;
    end;
  end;

begin
  Node.Name := 'table:table-row';
  Node.Prop['table:style-name'] := CreateRowStyle(Row, PageBreak);

  acn := 0;

  for x := 0 to FMatrix.Width - 2 do
  begin
    Obj := FMatrix.GetObject(x, Row);

    // empty cell

    if Obj = nil then
    begin
      FlushAdjacentCells;
      CreatEmptyCell(Node.Add);
    end

    // cell belonging to an already visited object

    else if Obj.Counter <> 0 then
      Inc(acn)

    // cell that's not been visited before

    else
    begin
      FlushAdjacentCells;
      Obj.Counter := 1;
      FMatrix.GetObjectPos(FMatrix.GetCell(x, Row), fx, fy, dx, dy);
      CreateDataCell(Node.Add, Obj, dy, dx);
    end;
  end;

  FlushAdjacentCells;
end;

function TfrxODFExport.CreateRowStyle(Row: Integer; PageBreakBefore: Boolean): string;
var
  Height: Extended;
begin
  Height := (FMatrix.GetYPosById(Row + 1) - FMatrix.GetYPosById(Row)) / odfDivider;
  Result := 'ro' + frFloat2Str(Height, 3);

  if PageBreakBefore then
    Result := Result + 'b';

  if FRowStyleNames.IndexOf(Result) >= 0 then
    Exit;

  FRowStyleNames.Add(Result);

  with FStyleNode.Add do
  begin
    Name := 'style:style';

    Prop['style:name'] := Result;
    Prop['style:family'] := 'table-row';

    with Add do
    begin
      Name := 'style:table-row-properties';

      if PageBreakBefore then
        Prop['fo:break-before'] := 'page'
      else
        Prop['fo:break-before'] := 'auto';

      Prop['style:row-height'] := frFloat2Str(Height, 3) + 'cm';
    end;
  end;
end;

procedure TfrxODFExport.AddPic(Node: TfrxXMLItem; Obj: TfrxIEMObject);
var
  s: string;
  r: TfrxRect;
begin
  r := FMatrix.GetObjectBounds(Obj);

  with Node do
  begin
    s := 'Pic' + IntToStr(FPicCount) + '.' + GetPicFileExtension(PictureType);

    if (Obj.Metafile <> nil) and (Obj.Metafile.Width > 0) and (Obj.Metafile.Height > 0) then
      SaveGraphicAs(Obj.Metafile, FTempFolder + 'Pictures\' + s, PictureType)
    else if (Obj.Image <> nil) then
      SaveGraphicAs(Obj.Image, FTempFolder + 'Pictures\' + s, PictureType);

    Name := 'draw:frame';
    Prop['draw:z-index'] := '0';
    Prop['draw:name'] := 'Picture' + IntToStr(FPicCount);
    Prop['draw:style-name'] := 'gr1';
    Prop['draw:text-style-name'] := 'P1';
    Prop['svg:width'] := frFloat2Str((r.Right - r.Left) / odfDivider, 3) + 'cm';
    Prop['svg:height'] := frFloat2Str((r.Bottom - r.Top) / odfDivider, 3) + 'cm';
    Prop['svg:x'] := '0cm';
    Prop['svg:y'] := '0cm';

    with Add do
    begin
      Name := 'draw:image';
      Prop['xlink:href'] := 'Pictures/' + s;
      Prop['xlink:type'] := 'simple';
      Prop['xlink:show'] := 'embed';
      Prop['text:anchor-type'] := 'frame';
      Prop['xlink:actuate'] := 'onLoad';
    end;
  end;

  Inc(FPicCount);
end;

procedure TfrxODFExport.SplitOnTags(pNode: TfrxXMLItem;
  obj: TfrxIEMObject; line: WideString);
var
  orig:   WideString;
  sub:    WideString;
  subTag: TfrxHTMLTag;

  procedure SuppressEndingTrash( var s: WideString );
  var
    len: LongWord;
  begin
    if s = '' then Exit;
    len := Length(s);
    while ( len > 0 ) and ( s[len] < #32 ) do Dec(len);
    SetLength( s, len );
  end;

  procedure Reset;
  begin
    subTag := Nil;
    sub := '';
  end;

  function Empty: Boolean;
  begin
    Result := subTag = Nil;
  end;

  procedure Flush;
  begin
    with pNode.Add do
    begin
      Name  := 'text:span';
      Value := sub;
      Prop['text:style-name'] := AddStyle( subTag.Color, subTag.Style );
    end;
  end;

  procedure AddTag( tag: TfrxHTMLTag );
  begin
    sub := sub + orig[tag.Position];
    subTag := tag;
  end;

  function Same( tag: TfrxHTMLTag ): Boolean;
  begin
    Result := False;
    if subTag = Nil then Exit;

    with subTag do
      Result := ( Color = tag.Color ) and ( Style = tag.Style );
  end;

var
  list:   TfrxHTMLTagsList;
  tags:   TfrxHTMLTags;
  tag:    TfrxHTMLTag;
  i, j:   LongInt;

begin
  if line = '' then Exit;

  list := TfrxHTMLTagsList.Create;
  list.AllowTags := True;

  with obj.Style.Font do
    list.SetDefaults( Color, 0, Style );

  orig := line;
  list.ExpandHTMLTags(line);

  for i := 0 to list.Count - 1 do
  begin
    tags := list[i];
    if tags.Count = 0 then Continue;
    Reset;

    for j := 0 to tags.Count - 1 do
    begin
      tag := tags[j];

      if not Empty and not Same(tag) then
      begin
        Flush;
        Reset;
      end;

      AddTag(tag);
    end;
  end;

  Flush;
  list.Destroy;
end;

function TfrxODFExport.AddStyle(Color: TColor; Style: TFontStyles): WideString;
var
  i: LongInt;
  s: TSpanStyle;
begin
  for i := 0 to FStyles.Count - 1 do
  begin
    s := TSpanStyle(FStyles[i]);
    if (s.Color = Color) and (s.Style = Style) then
    begin
      Result := s.Name;
      Exit;
    end;
  end;

  s := TSpanStyle.Create;
  FStyles.Add(s);

  s.Color := Color;
  s.Style := Style;
  s.Name  := 'ss-' + IntToStr(FStyles.Count);

  with FStyleNode.Add do
  begin
    Name := 'style:style';
    Prop['style:name'] := s.Name;
    Prop['style:family'] := 'text';

    with Add do
    begin
      Name := 'style:text-properties';
      Prop['fo:color'] := HTMLRGBColor(Color);
    end;

    if fsItalic in s.Style then
      with Add do
      begin
        Name := 'style:text-properties';
        Prop['fo:font-style'] := 'italic';
        Prop['style:font-style-asian'] := 'italic';
        Prop['style:font-style-complex'] := 'italic';
      end;

    if fsBold in s.Style then
      with Add do
      begin
        Name := 'style:text-properties';
        Prop['fo:font-weight'] := 'bold';
        Prop['style:font-weight-asian'] := 'bold';
        Prop['style:font-weight-complex'] := 'bold';
      end;

    if fsUnderline in s.Style then
      with Add do
      begin
        Name := 'style:text-properties';
        Prop['style:text-underline-style'] := 'solid';
        Prop['style:text-underline-width'] := 'auto';
        Prop['style:text-underline-color'] := 'font-color';
      end;

    // todo: struck-out text
  end;

  Result := s.Name;
end;

function TfrxODFExport.GetHeaderText(m: TfrxIEMatrix): string;
var
  i: LongInt;
begin
  for i := 0 to m.GetObjectsCount - 1 do
    with m.GetObjectById(i) do
      if Header then
        Result := Result + Memo.Text;

  Result := OdfPrepareString(Result);
end;

function TfrxODFExport.IsRowEmpty(Row: Integer): Boolean;
var
  Col: Integer;
begin
  for Col := 0 to FMatrix.Width - 1 do
    if FMatrix.GetCell(Col, Row) >= 0 then
    begin
      Result := False;
      Exit;
    end;

  Result := True;
end;

function TfrxODFExport.IsTerminated: Boolean;
begin
  Result := (FProgress <> nil) and FProgress.Terminated
end;

function TfrxODFExport.GetFooterText(m: TfrxIEMatrix): string;
var
  i: LongInt;
begin
  for i := 0 to m.GetObjectsCount - 1 do
    with m.GetObjectById(i) do
      if Footer then
        Result := Result + Memo.Text;

  Result := OdfPrepareString(Result);
end;

procedure TfrxODFExport.CreateStyles;
var
  XML: TfrxXMLDocument;
  f, h: string;
begin
  f := GetFooterText(FMatrix);
  h := GetHeaderText(FMatrix);

  XML := TfrxXMLDocument.Create;
  try
    XML.AutoIndent := True;
    XML.Root.Name := 'office:document-styles';
    OdfMakeHeader(XML.Root);

    with XML.Root.Add do
    begin
      Name := 'office:styles';

      with Add do
      begin
        Name := 'style:default-style';
        Prop['style:family'] := 'paragraph';
      end;

      with Add do
      begin
        Name := 'style:paragraph-properties';

        Prop['style:text-autospace'] := 'ideograph-alpha';
        Prop['style:punctuation-wrap'] := 'hanging';
        Prop['style:line-break'] := 'strict';
        Prop['style:writing-mode'] := 'page';
      end;

      with Add do
      begin
        Name := 'style:text-properties';

        Prop['fo:color'] := '#000000';
        Prop['style:font-name'] := 'Times New Roman';
        Prop['fo:font-size'] := '12pt';
        Prop['fo:language'] := LowerCase(Language);
        Prop['fo:country'] := UpperCase(Language);
        Prop['style:font-name-asian'] := 'Arial Unicode MS';
        Prop['style:font-size-asian'] := '12pt';
        Prop['style:language-asian'] := LowerCase(Language);
        Prop['style:country-asian'] := UpperCase(Language);
        Prop['style:font-name-complex'] := 'Tahoma1';
        Prop['style:font-size-complex'] := '12pt';
        Prop['style:language-complex'] := LowerCase(Language);
        Prop['style:country-complex'] := UpperCase(Language);
      end;
    end;

    with XML.Root.Add do
    begin
      Name := 'office:automatic-styles';

      with Add do
      begin
        Name := 'style:page-layout';
        Prop['style:name'] := 'pm1';
        with Add do
        begin
          Name := 'style:page-layout-properties';
          Prop['fo:page-width'] := frFloat2Str( FPageWidth / odfPageDiv, 1) + 'cm';
          Prop['fo:page-height'] := frFloat2Str( FPageHeight / odfPageDiv, 1) + 'cm';
          Prop['fo:margin-top'] := frFloat2Str(FPageTop / odfMargDiv, 3) + 'cm';
          Prop['fo:margin-bottom'] := frFloat2Str(FPageBottom / odfMargDiv, 3) + 'cm';
          Prop['fo:margin-left'] := frFloat2Str(FPageLeft / odfMargDiv, 3) + 'cm';
          Prop['fo:margin-right'] := frFloat2Str(FPageRight / odfMargDiv, 3) + 'cm';
        end;
      end;
    end;

    with XML.Root.Add do
    begin
      Name := 'office:master-styles';
      with Add do
      begin
        Name := 'style:master-page';
        Prop['style:name'] := 'PageDef';
        Prop['style:page-layout-name'] := 'pm1';

        if h <> '' then
          with Add do
          begin
            Name := 'style:header';
            with Add do
            begin
              Name := 'text:p';
              Value := h;
            end;
          end;

        if f <> '' then
          with Add do
          begin
            Name := 'style:footer';
            with Add do
            begin
              Name := 'text:p';
              Value := f;
            end;
          end;
      end;
    end;

    XML.SaveToFile(FTempFolder + 'styles.xml');
  finally
    XML.Free;
  end;
end;

procedure SaveJpeg(img: TPicture; DestinationFilename: string );
var
  jpeg: TJpegImage;
begin
  jpeg := TJpegImage.Create;
  jpeg.Assign(img.Bitmap);
  jpeg.SaveToFile(DestinationFilename);
  jpeg.Free;
end;

procedure TfrxODFExport.ExportPage(Stream: TStream);
var
  XML: TfrxXMLDocument;
  s: WideString;
  FList: TStringList;
  i: Integer;
  Style: TfrxIEMStyle;
  d: Extended;

  function BorderProp( fl: TfrxFrameLine ) : string;
  begin
    Result := frFloat2Str(fl.Width / odfDivider, 3) + 'cm ' +
      OdfGetFrameName(fl.Style) + ' ' + HTMLRGBColor(fl.Color);
  end;

begin
  if ShowProgress then
    FProgress.Execute(FMatrix.Height - 1, frxResources.Get('ProgressWait'), True, True);
  FTempFolder := GetTempFile;
  DeleteFile(FTempFolder);
  FTempFolder := FTempFolder + '\';
  MkDir(FTempFolder);
  MkDir(FTempFolder + 'Pictures');
  MkDir(FTempFolder + 'Thumbnails');
  FPicCount := 0;
//{$IF FALSE}
//  FThumbImage.Picture.SaveToFile(FTempFolder + 'Thumbnails\thumbnail.bmp');
//{$ELSE}
  SaveJpeg( FThumbImage.Picture, FTempFolder + 'Thumbnails\thumbnail.jpg');
//{$IFEND}
  CreateStyles;

  XML := TfrxXMLDocument.Create;
  try
    XML.AutoIndent := False;
//    XML.AutoIndent := True;
    XML.Root.Name := 'office:document-content';
    OdfMakeHeader(XML.Root);
    with XML.Root.Add do
      Name := 'office:scripts';
    // font styles
    FList := TStringList.Create;
    try
      FList.Sorted := True;
      for i := 0 to FMatrix.StylesCount - 1 do
      begin
        Style := FMatrix.GetStyleById(i);
        if (Style.Font <> nil) and (FList.IndexOf(Style.Font.Name) = -1) then
          FList.Add(Style.Font.Name);
      end;
      with XML.Root.Add do
      begin
        Name := 'office:font-face-decls';
        for i := 0 to FList.Count - 1 do
        begin
          with Add do
          begin
            Name := 'style:font-face';
            Prop['style:name'] := FList[i];
            Prop['svg:font-family'] := '&apos;' + FList[i] + '&apos;';
            Prop['style:font-pitch'] := 'variable';
          end;
        end;
      end;
    finally
      FList.Free;
    end;

    FStyleNode := XML.Root.Add;
    FStyles := TList.Create;

    with FStyleNode do
    begin
      Name := 'office:automatic-styles';

      with Add do
      begin
        Name := 'style:style';

        Prop['style:style-name'] := 'pagebreak';
        Prop['style:style-family'] := 'paragraph';
        Prop['style:parent-style-name'] := 'Default';

        with Add do
        begin
          Name := 'style:paragraph-properties';
          Prop['fo:break-after'] := 'page';
        end;
      end;

      FList := TStringList.Create;
      try
        FList.Sorted := True;
        for i := 1 to FMatrix.Width - 1 do
        begin
          d := (FMatrix.GetXPosById(i) - FMatrix.GetXPosById(i - 1)) / odfDivider;
          s := frFloat2Str(d, 3);
          if FList.IndexOf(s) = -1 then
            FList.Add(s);
        end;
        for i := 0 to FList.Count - 1 do
        begin
          with Add do
          begin
            Name := 'style:style';
            Prop['style:name'] := 'co' + FList[i];
            Prop['style:family'] := 'table-column';
            with Add do
            begin
              Name := 'style:table-column-properties';
              Prop['fo:break-before'] := 'auto';
              Prop['style:column-width'] := FList[i] + 'cm';
            end;
          end;
        end;
      finally
        FList.Free;
      end;

      FRowStyleNames.Clear;

      // table style
      with Add do
      begin
        Name := 'style:style';
        Prop['style:name'] := 'ta1';
        Prop['style:family'] := 'table';
        Prop['style:master-page-name'] := 'PageDef';
        with Add do
        begin
          Name := 'style:table-properties';
          Prop['table:display'] := 'true';
          Prop['style:writing-mode'] := 'lr-tb';  /// RTL - LTR?
        end;
      end;

      // cells styles
      with Add do
      begin
        Name := 'style:style';
        Prop['style:name'] := 'ceb';
        Prop['style:family'] := 'table-cell';
        Prop['style:display'] := 'false';
      end;

      for i := 0 to FMatrix.StylesCount - 1 do
      begin
        Style := FMatrix.GetStyleById(i);

        if Style.DisplayFormat.Kind = fkNumeric then
          AddNumberStyle(Add, 'N' + IntToStr(i), Style.DisplayFormat.FormatStr);
      end;

      for i := 0 to FMatrix.StylesCount - 1 do
      begin
        Style := FMatrix.GetStyleById(i);

        with Add do
        begin
          Name := 'style:style';
          Prop['style:name'] := 'ce' + IntToStr(i);
          Prop['style:family'] := 'table-cell';
          Prop['style:parent-style-name'] := 'Default';

          if Style.DisplayFormat.Kind = fkNumeric then
            Prop['style:data-style-name'] := 'N' + IntToStr(i);

          if FExportType <> 'text' then
          begin
            with Add do
            begin
              Name := 'style:text-properties';
              Prop['style:font-name'] := Style.Font.Name;
              Prop['fo:font-size'] := IntToStr(Style.Font.Size) + 'pt';

              if fsUnderline in Style.Font.Style then
              begin
                Prop['style:text-underline-style'] := 'solid';
                Prop['style:text-underline-width'] := 'auto';
                Prop['style:text-underline-color'] := 'font-color';
              end;

              if fsItalic in Style.Font.Style then
                Prop['fo:font-style'] := 'italic';

              if fsBold in Style.Font.Style then
                Prop['fo:font-weight'] := 'bold';

              Prop['fo:color'] := HTMLRGBColor(Style.Font.Color);
            end;

            with Add do
            begin
              Name := 'style:paragraph-properties';
              if Style.HAlign = haLeft then
                Prop['fo:text-align'] := 'start';
              if Style.HAlign = haCenter then
                Prop['fo:text-align'] := 'center';
              if Style.HAlign = haRight then
                Prop['fo:text-align'] := 'end';
              if Style.GapX <> 0 then
              begin
                Prop['fo:margin-left'] := frFloat2Str(Style.GapX / odfDivider, 3) + 'cm';
                Prop['fo:margin-right'] := Prop['fo:margin-left'];
              end;
            end;
          end;

          with Add do
          begin
            Name := 'style:table-cell-properties';

            if Style.Color = clNone then
              Prop['fo:background-color'] := 'transparent'
            else
              Prop['fo:background-color'] := HTMLRGBColor(Style.Color);

            Prop['style:repeat-content'] := 'false';
            if Style.Rotation > 0 then
            begin
              Prop['style:rotation-angle'] := IntToStr(Style.Rotation);
              Prop['style:rotation-align'] := 'none';
            end;
            if Style.VAlign = vaCenter then
              Prop['style:vertical-align'] := 'middle';
            if Style.VAlign = vaTop then
              Prop['style:vertical-align'] := 'top';
            if Style.VAlign = vaBottom then
              Prop['style:vertical-align'] := 'bottom';
            if (ftLeft in Style.FrameTyp) then
              Prop['fo:border-left'] := BorderProp( Style.LeftLine);
            if (ftRight in Style.FrameTyp) then
              Prop['fo:border-right'] := BorderProp( Style.RightLine);
            if (ftTop in Style.FrameTyp) then
              Prop['fo:border-top'] := BorderProp( Style.TopLine);
            if (ftBottom in Style.FrameTyp) then
              Prop['fo:border-bottom'] := BorderProp( Style.BottomLine);
            if Style.WordWrap then
              Prop['fo:wrap-option'] := 'wrap';
          end;
        end;
      end;

      if FExportType = 'text' then
      begin
        // text styles
        with Add do
        begin
          Name := 'style:style';
          Prop['style:name'] := 'pb';
          Prop['style:family'] := 'paragraph';
          Prop['style:display'] := 'false';
        end;
        for i := 0 to FMatrix.StylesCount - 1 do
        begin
          Style := FMatrix.GetStyleById(i);
          with Add do
          begin
            Name := 'style:style';
            Prop['style:name'] := 'p' + IntToStr(i);
            Prop['style:family'] := 'paragraph';
            Prop['style:parent-style-name'] := 'Default';
            with Add do
            begin
              Name := 'style:text-properties';
              Prop['fo:letter-spacing'] := frFloat2Str(Style.CharSpacing/96, 4) + 'in';
              Prop['style:font-name'] := Style.Font.Name;
              Prop['fo:font-size'] := IntToStr(Style.Font.Size) + 'pt';
              if fsUnderline in Style.Font.Style then
              begin
                Prop['style:text-underline-style'] := 'solid';
                Prop['style:text-underline-width'] := 'auto';
                Prop['style:text-underline-color'] := 'font-color';
              end;
              if fsItalic in Style.Font.Style then
                Prop['fo:font-style'] := 'italic';
              if fsBold in Style.Font.Style then
                Prop['fo:font-weight'] := 'bold';
              Prop['fo:color'] := HTMLRGBColor(Style.Font.Color);
            end;
            with Add do
            begin
              Name := 'style:paragraph-properties';
              if Style.HAlign = haLeft then
                Prop['fo:text-align'] := 'start';
              if Style.HAlign = haCenter then
                Prop['fo:text-align'] := 'center';
              if Style.HAlign = haRight then
                Prop['fo:text-align'] := 'end';
              if Style.GapX <> 0 then
              begin
                Prop['fo:margin-left'] := frFloat2Str(Style.GapX / odfDivider, 3) + 'cm';
                Prop['fo:margin-right'] := Prop['fo:margin-left'];
              end;
            end;
          end;
        end;
      end;
      // pic style
      with Add do
      begin
        Name := 'style:style';
        Prop['style:name'] := 'gr1';
        Prop['style:family'] := 'graphic';
        with Add do
        begin
          Name := 'style:graphic-properties';
          Prop['draw:stroke'] := 'none';
          Prop['draw:fill'] := 'none';
          Prop['draw:textarea-horizontal-align'] := 'left';
          Prop['draw:textarea-vertical-align'] := 'top';
          Prop['draw:color-mode'] := 'standard';
          Prop['draw:luminance'] := '0%';
          Prop['draw:contrast'] := '0%';
          Prop['draw:gamma'] := '100%';
          Prop['draw:red'] := '0%';
          Prop['draw:green'] := '0%';
          Prop['draw:blue'] := '0%';
          Prop['fo:clip'] := 'rect(0cm 0cm 0cm 0cm)';
          Prop['draw:image-opacity'] := '100%';
          Prop['style:mirror'] := 'none';
        end;
      end;
    end;

    ExportBody(XML.Root.Add);
    XML.SaveToFile(FTempFolder + 'content.xml');
  finally
    XML.Free;

    for i := 0 to FStyles.Count - 1 do
      TObject(FStyles[i]).Free;

    FStyles.Free;
  end;
  MkDir(FTempFolder + 'META-INF');
  s := FExportType;
  OdfCreateManifest(FTempFolder + 'META-INF\manifest.xml', FPicCount, s);
  OdfCreateMime(FTempFolder + 'mimetype', s);
  OdfCreateMeta(FTempFolder + 'meta.xml', Creator);
  FZipFile := TfrxZipArchive.Create;
  try
{$IFDEF Delphi12}
    FZipFile.RootFolder := AnsiString(FTempFolder);
    FZipFile.AddDir(AnsiString(FTempFolder));
{$ELSE}
    FZipFile.RootFolder := FTempFolder;
    FZipFile.AddDir(FTempFolder);
{$ENDIF}
    if ShowProgress then
    begin
      FProgress.Execute(FZipFile.FileCount, frxResources.Get('ProgressWait'), True, True);
      FZipFile.OnProgress := DoOnProgress;
    end;
    FZipFile.SaveToStream(Stream);
  finally
    FZipFile.Free;
  end;
  DeleteFolder(FTempFolder);
end;

function TfrxODFExport.ShowModal: TModalResult;
begin
  if not Assigned(Stream) then
  begin
    with TfrxODFExportDialog.Create(nil) do
    begin
      SaveDialog1.DefaultExt := DefaultExt;
      SaveDialog1.Filter := FilterDesc;
      Caption := ExportTitle; 
      OpenCB.Visible := not SlaveExport;
      if OverwritePrompt then
        SaveDialog1.Options := SaveDialog1.Options + [ofOverwritePrompt];
      if SlaveExport then
        FOpenAfterExport := False;

      if (FileName = '') and (not SlaveExport) then
        SaveDialog1.FileName := ChangeFileExt(ExtractFileName(frxUnixPath2WinPath(Report.FileName)), SaveDialog1.DefaultExt)
      else
        SaveDialog1.FileName := FileName;

      ContinuousCB.Checked := SingleSheet;
      PageBreaksCB.Checked := ExportPageBreaks;
      WCB.Checked := Wysiwyg;
      OpenCB.Checked := OpenAfterExport;
      BackgrCB.Checked := Background;

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

        ExportPageBreaks := PageBreaksCB.Checked;
        SingleSheet := ContinuousCB.Checked;
        FWysiwyg := WCB.Checked;
        FOpenAfterExport := OpenCB.Checked;
        FBackground := BackgrCB.Checked;

        CreationTime := Now;
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

function TfrxODFExport.Start: Boolean;
begin
  if SlaveExport then
  begin
    if Report.FileName <> '' then
      FileName := ChangeFileExt(GetTemporaryFolder + ExtractFileName(Report.FileName), DefaultExt)
    else
      FileName := ChangeFileExt(GetTempFile, DefaultExt)
  end;
  FThumbImage.Width := 0;
  FThumbImage.Height := 0;
  if (FileName <> '') or Assigned(Stream) then
  begin
    if (ExtractFilePath(FileName) = '') and (DefaultPath <> '') then
      FileName := DefaultPath + '\' + FileName;
    FFirstPage := True;

    FMatrix := TfrxIEMatrix.Create(UseFileCache, Report.EngineOptions.TempDir);
    FMatrix.RotatedAsImage := False;
    FMatrix.ShowProgress := ShowProgress;
    FMatrix.Background := FBackground and FEmptyLines;
    FMatrix.BackgroundImage := False;
    FMatrix.Printable := ExportNotPrintable;
    FMatrix.RichText := PictureType <> gpEMF;
    FMatrix.PlainRich := PictureType <> gpEMF;
    FMatrix.EmptyLines := FEmptyLines;
    FMatrix.WrapText := False;
    FMatrix.EMFPictures := True;
    if FWysiwyg then
      FMatrix.Inaccuracy := 0.5
    else
      FMatrix.Inaccuracy := 10;
    FMatrix.DeleteHTMLTags := False;
    Result := True
  end
  else
    Result := False;
end;

procedure TfrxODFExport.StartPage(Page: TfrxReportPage; Index: Integer);
begin
  if FFirstPage then
  begin
    FPageLeft := Page.LeftMargin;
    FPageTop := Page.TopMargin;
    FPageBottom := Page.BottomMargin;
    FPageRight := Page.RightMargin;
    FPageOrientation := Page.Orientation;
    FPageWidth := Page.Width;
    FPageHeight := Page.Height;
    FThumbImage.Width := Round(Page.Width / 5);
    FThumbImage.Height := Round(Page.Height / 5);
  end;
end;

procedure TfrxODFExport.ExportRows(PageNode: TfrxXMLItem; RowFirst, RowLast, PageIndex: Integer);
var
  x, y: Integer;
  d: Extended;
  s: string;
  PageBreak: Boolean;
begin
  //DbgPrintMatrix(FMatrix, RowFirst, RowLast);

  while (RowLast >= RowFirst) and IsRowEmpty(RowLast) do
    Dec(RowLast);

  while (RowLast >= RowFirst) and IsRowEmpty(RowFirst) do
    Inc(RowFirst);

  with PageNode do
  begin
    Name := 'table:table';

    Prop['table:name'] := string(UTF8Encode(frxGet(8322) + ' ' + IntToStr(PageIndex + 1)));
    Prop['table:style-name'] := 'ta1';
    Prop['table:print'] := 'false';

    for x := 0 to FMatrix.Width - 2 do
      with Add do
      begin
        Name := 'table:table-column';
        d := (FMatrix.GetXPosById(x + 1) - FMatrix.GetXPosById(x)) / odfDivider;
        s := frFloat2Str(d, 3);
        Prop['table:style-name'] := 'co' + s;
      end;

    for y := RowFirst to RowLast do
    begin
      PageBreak := ExportPageBreaks and
        (FMatrix.PagesCount > PageIndex) and
        (FMatrix.GetYPosById(y) >= FMatrix.GetPageBreak(PageIndex));

      CreateRow(Add, y, PageBreak);

      if PageBreak then
        Inc(PageIndex);
    end;
  end;
end;

procedure TfrxODFExport.ExportBody(BodyNode: TfrxXMLItem);
var
  y1, y2, Page: Integer;
begin
  BodyNode.Name := 'office:body';

  with BodyNode.Add do
  begin
    if ExportType = 'text' then
    begin
      Name := 'office:text';
      Prop['text:use-soft-page-breaks'] := 'true';
    end
    else
      Name := 'office:spreadsheet';

    Page := 0;
    y1 := 0;

    if not SingleSheet then
      with FMatrix do
        for y2 := 0 to Height - 2 do
          if (PagesCount > Page) and (GetYPosById(y2) >= GetPageBreak(Page)) then
          begin
            ExportRows(Add, y1, y2 - 1, Page);
            y1 := y2;
            Page := Page + 1;

            if ExportPageBreaks then
              with Add do
              begin
                Name := 'text:p';
                Prop['text:style-name'] := 'pagebreak';
              end;

            DoOnProgress(Self);

            if IsTerminated then
              Break;
          end;

    if not IsTerminated then
      ExportRows(Add, y1, FMatrix.Height - 2, Page);

    DoOnProgress(Self);
  end;
end;

procedure TfrxODFExport.ExportObject(Obj: TfrxComponent);
var
  Pic: TfrxPictureView;
begin
  { TfrxPreviewPages.Export adds a TfrxPictureView component
    to each page. This component represents the background
    picture. If the picture is not set and the background color is clNone,
    then this component may be discarded.

    The background component causes creation lots of quasi-components
    that waste memory and time, so if possible the background should be
    discarded. }

  if (Obj.Name = '_pagebackground') then
    if not Background then
      Exit
    else if (Obj is TfrxPictureView) then
    begin
      Pic := TfrxPictureView(Obj);

      if (Pic.Picture.Width*Pic.Picture.Height = 0) and (Pic.Color = clNone) then
        Exit;
    end;

  if (Obj is TfrxView) and (ExportNotPrintable or TfrxView(Obj).Printable) then
  begin
    FMatrix.AddObject(TfrxView(Obj));
    if FFirstPage then
    begin
      FThumbImage.Canvas.Lock;
      try
        TfrxView(Obj).Draw(FThumbImage.Canvas, 0.2, 0.2, Obj.Left / 5, Obj.Top / 5);
      finally
        FThumbImage.Canvas.Unlock;
      end;
    end;
  end;
end;

procedure TfrxODFExport.FinishPage(Page: TfrxReportPage; Index: Integer);
begin
  FFirstPage := False;
  FMatrix.AddPage(Page.Orientation, Page.Width, Page.Height, Page.LeftMargin,
                  Page.TopMargin, Page.RightMargin, Page.BottomMargin, Page.MirrorMargins, Index);
end;

procedure TfrxODFExport.Finish;
var
  Exp: TStream;
begin
  try
    Exp := nil;
    FProgress := nil;

    try
      if ShowProgress then
        FProgress := TfrxProgress.Create(nil);

      FMatrix.Prepare;

      if Assigned(Stream) then
        Exp := Stream
      else
        Exp := TFileStream.Create(FileName, fmCreate);

      ExportPage(Exp);
    finally
      FProgress.Free;
      FMatrix.Free;

      if not Assigned(Stream) then
        Exp.Free;
    end;
  except
    on e: Exception do
      case Report.EngineOptions.NewSilentMode of
        simSilent:        Report.Errors.Add(e.Message);
        simMessageBoxes:  frxErrorMsg(e.Message);
        simReThrow:       raise;
      end;
  end;

  if OpenAfterExport and not Assigned(Stream) then
    ShellExecute(GetDesktopWindow, 'open', PChar(FileName), nil, nil, SW_SHOW);
end;

destructor TfrxODFExport.Destroy;
begin
  FThumbImage.Free;
  FRowStyleNames.Free;
  inherited;
end;

procedure TfrxODFExport.DoOnProgress(Sender: TObject);
begin
  if ShowProgress then
    FProgress.Tick;
end;

{ TfrxODSExport }

constructor TfrxODSExport.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ExportType := 'spreadsheet';
  FilterDesc := frxResources.Get('ODSExportFilter');
  DefaultExt := frxGet(8960);
  ExportTitle := frxResources.Get('ODSExport');
end;

class function TfrxODSExport.GetDescription: String;
begin
  Result := frxResources.Get('ODSExport');
end;

{ TfrxODTExport }

constructor TfrxODTExport.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ExportType := 'text';
  FilterDesc := frxResources.Get('ODTExportFilter');
  DefaultExt := frxGet(8961);
  ExportTitle := frxResources.Get('ODTExport');
end;

class function TfrxODTExport.GetDescription: String;
begin
  Result := frxResources.Get('ODTExport');
end;

{ TfrxODFExportDialog }

procedure TfrxODFExportDialog.FormCreate(Sender: TObject);
begin
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
  OpenCB.Caption := frxGet(8706);

  if UseRightToLeftAlignment then
    FlipChildren(True);
end;


procedure TfrxODFExportDialog.PageNumbersEChange(Sender: TObject);
begin
  PageNumbersRB.Checked := True;
end;

procedure TfrxODFExportDialog.PageNumbersEKeyPress(Sender: TObject;
  var Key: Char);
begin
  case key of
    '0'..'9':;
    #8, '-', ',':;
  else
    key := #0;
  end;
end;

procedure TfrxODFExportDialog.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_F1 then
    frxResources.Help(Self);
end;

end.
