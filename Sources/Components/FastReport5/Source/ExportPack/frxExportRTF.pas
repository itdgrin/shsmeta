
{******************************************}
{                                          }
{             FastReport v5.0              }
{            RTF export filter             }
{                                          }
{         Copyright (c) 1998-2014          }
{          by Alexander Fediachov,         }
{             Fast Reports Inc.            }
{                                          }
{******************************************}

unit frxExportRTF;

interface

{$I frx.inc}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, extctrls, ComObj, Printers, frxClass, ShellAPI, frxExportMatrix, 
  Variants, frxProgress, ComCtrls, frxGraphicUtils,
  frxImageConverter
{$IFDEF DELPHI16}
, System.UITypes
{$ENDIF}
;

type
  TfrxHeaderFooterMode = (hfText, hfPrint, hfNone);

  TfrxRTFExportDialog = class(TForm)
    OkB: TButton;
    CancelB: TButton;
    GroupPageRange: TGroupBox;
    DescrL: TLabel;
    AllRB: TRadioButton;
    CurPageRB: TRadioButton;
    PageNumbersRB: TRadioButton;
    PageNumbersE: TEdit;
    GroupQuality: TGroupBox;
    WCB: TCheckBox;
    PageBreaksCB: TCheckBox;
    PicturesCB: TCheckBox;
    OpenCB: TCheckBox;
    SaveDialog1: TSaveDialog;
    ContinuousCB: TCheckBox;
    HeadFootL: TLabel;
    PColontitulCB: TComboBox;
    procedure FormCreate(Sender: TObject);
    procedure PageNumbersEChange(Sender: TObject);
    procedure PageNumbersEKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  end;

{$IFDEF DELPHI16}
[ComponentPlatformsAttribute(pidWin32 or pidWin64)]
{$ENDIF}
  TfrxRTFExport = class(TfrxCustomExportFilter)
  private
    FColorTable: TStringList;
    FCurrentPage: Integer;
    FDataList: TList;
    FExportPageBreaks: Boolean;
    FExportPictures: Boolean;
    FFirstPage: Boolean;
    FFontTable: TStringList;
    FCharsetTable: TStringList;
    FMatrix: TfrxIEMatrix;
    FOpenAfterExport: Boolean;
    FProgress: TfrxProgress;
    FWysiwyg: Boolean;
    FCreator: String;
    FHeaderFooterMode: TfrxHeaderFooterMode;
    FAutoSize: Boolean;
    FPictureType: TfrxPictureType;

    function TruncReturns(const Str: WideString): WideString;
    function GetRTFBorders(const Style: TfrxIEMStyle): string;
    function GetRTFColor(const c: DWORD): string;
    function GetRTFFontStyle(const f: TFontStyles): String;
    function GetRTFFontColor(const f: String): String;
    function GetRTFFontName(const f: String; const charset: Integer): String;
    function GetRTFHAlignment(const HAlign: TfrxHAlign) : String;
    function GetRTFVAlignment(const VAlign: TfrxVAlign) : String;
    function StrToRTFSlash(const Value: WideString): WideString;
    function StrToRTFUnicodeEx(const Value: WideString): String;
    function StrToRTFUnicode(const Value: WideString): String;
    procedure ExportPage(const Stream: TStream);
    procedure PrepareExport;
    procedure SaveGraphic(Graphic: TGraphic; Stream: TStream;
      Width, Height: Extended; PicType: TfrxPictureType);
  public
    constructor Create(AOwner: TComponent); override;
    class function GetDescription: String; override;
    function ShowModal: TModalResult; override;
    function Start: boolean; override;
    procedure Finish; override;
    procedure FinishPage(Page: TfrxReportPage; Index: Integer); override;
    procedure StartPage(Page: TfrxReportPage; Index: Integer); override;
    procedure ExportObject(Obj: TfrxComponent); override;
  published
    property PictureType: TfrxPictureType read FPictureType write FPictureType;
    property ExportPageBreaks: Boolean read FExportPageBreaks write FExportPageBreaks default True;
    property ExportPictures: Boolean read FExportPictures write FExportPictures default True;
    property OpenAfterExport: Boolean read FOpenAfterExport write FOpenAfterExport default False;
    property Wysiwyg: Boolean read FWysiwyg write FWysiwyg;
    property Creator: String read FCreator write FCreator;
    property SuppressPageHeadersFooters;
    property HeaderFooterMode: TfrxHeaderFooterMode read FHeaderFooterMode write FHeaderFooterMode;
    property AutoSize: Boolean read FAutoSize write FAutoSize;
    property OverwritePrompt;
  end;


implementation

uses frxUtils, frxFileUtils, frxRes, frxrcExports, frxGML;

{$R *.dfm}

const
  Xdivider = 15.05;
  Ydivider = 15;
  Ydivider_last = 14.5;
  PageDivider = 15.02;
  MargDivider = 56.48;
  FONT_DIVIDER = 15;
  IMAGE_DIVIDER = 25.3;


{ TfrxRTFExport }

constructor TfrxRTFExport.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ShowDialog := True;
  FExportPageBreaks := True;
  FExportPictures := True;
  FWysiwyg := True;
  FHeaderFooterMode := hfText;
  FAutoSize := False;
  FCreator := 'FastReport';
  FilterDesc := frxGet(8504);
  DefaultExt := frxGet(8505);
end;

class function TfrxRTFExport.GetDescription: String;
begin
  Result := frxResources.Get('RTFexport');
end;

function TfrxRTFExport.TruncReturns(const Str: WideString): WideString;
var
  l: Integer;
begin
  l := Length(Str);
  if (l > 1) and (Str[l - 1] = #13) and (Str[l] = #10) then
    Result := Copy(Str, 1, l - 2)
  else
    Result := Str;
end;

function TfrxRTFExport.StrToRTFSlash(const Value: WideString): WideString;
var
  i: integer;
begin
  result := '';
  for i := 1 to Length(Value) do
  begin
    if Value[i] = '\' then
      result := result + '\\'
    else if Value[i] = '{' then
      result := result + '\{'
    else if Value[i] = '}' then
      result := result + '\}'
    else if (Value[i] = #13) and (i < (Length(Value) - 1)) and (Value[i + 1] = #10) then
      result := result + '\line'#13
    else
      result := result + Value[i];
  end;
end;

function TfrxRTFExport.StrToRTFUnicodeEx(const Value: WideString): String;
var
  s: WideString;
begin
  s := StrToRTFSlash(Value);
  Result := StrToRTFUnicode(s);
end;

function TfrxRTFExport.StrToRTFUnicode(const Value: WideString): String;
var
  i: integer;
  pwc: ^Word;
begin
  result := '';
  for i := 1 to Length(Value) do
  begin
    pwc := @Value[i];
    if pwc^ > 127 then
      result := result + '\u' + IntToStr(pwc^) + '\''3f'
    else
      result := result + Chr(pwc^);
  end;
end;

function TfrxRTFExport.GetRTFBorders(const Style: TfrxIEMStyle): string;
var
  brdrw: String;
  brdrc: String;
  brdrs: String;

  function BorderProp( fl: TfrxFrameLine ) : String;
  begin
    brdrw := '\brdrs\brdrw' + IntToStr(Round(fl.Width * 20));
    brdrc := '\brdrcf' + GetRTFFontColor(GetRTFColor(fl.Color));
    if fl.Style = fsDouble then
      brdrs := '\brdrdb'
    else if fl.Style <> fsSolid then
      brdrs := '\brdrdashsm'
    else brdrs := '';
    Result := brdrw + brdrc + brdrs;
  end;

begin
  Result := '';
  if ftTop in Style.FrameTyp then
    Result := Result + '\clbrdrt' + BorderProp(Style.TopLine);
  if ftLeft in Style.FrameTyp then
    Result := Result + '\clbrdrl' + BorderProp(Style.LeftLine);
  if ftBottom in Style.FrameTyp then
    Result := Result + '\clbrdrb' + BorderProp(Style.BottomLine);
  if ftRight in Style.FrameTyp then
    Result := Result + '\clbrdrr' + BorderProp(Style.RightLine);
end;

function TfrxRTFExport.GetRTFColor(const c: DWORD): string;
var
  cn: DWORD;
begin
  cn := ColorToRGB(c);
  Result := '\red' + IntToStr(GetRValue(cn)) +
            '\green' + IntToStr(GetGValue(cn)) +
            '\blue' + IntToStr(GetBValue(cn)) + ';'
end;

function TfrxRTFExport.GetRTFFontStyle(const f: TFontStyles): String;
begin
  Result := '';
  if fsItalic in f then Result := '\i';
  if fsBold in f then Result := Result + '\b';
  if fsUnderline in f then Result := Result + '\ul';
end;

function TfrxRTFExport.GetRTFFontColor(const f: String): String;
var
  i: Integer;
begin
  i := FColorTable.IndexOf(f);
  if i <> -1 then
    Result := IntToStr(i + 1)
  else
  begin
    FColorTable.Add(f);
    Result := IntToStr(FColorTable.Count);
  end;
end;

function TfrxRTFExport.GetRTFFontName(const f: String; const Charset: Integer): String;
var
  i: Integer;
begin
  i := FFontTable.IndexOf(f);
  if i <> -1 then
    Result := IntToStr(i)
  else
  begin
    FFontTable.Add(f);
    FCharsetTable.Add(IntToStr(charset));
    Result := IntToStr(FFontTable.Count - 1);
  end;
end;

function TfrxRTFExport.GetRTFHAlignment(const HAlign: TfrxHAlign) : String;
begin
  case HAlign of
    haLeft:   Result := '\ql';
    haRight:  Result := '\qr';
    haCenter: Result := '\qc';
    haBlock:  Result := '\qj';
    else      Result := '\ql';
  end;
end;

function TfrxRTFExport.GetRTFVAlignment(const VAlign: TfrxVAlign) : String;
begin
  if (VAlign = vaTop) then Result := '\clvertalt'
  else if (VAlign = vaCenter) then Result := '\clvertalc'
  else if (VAlign = vaBottom) then Result := '\clvertalb'
  else Result := '\clvertalt';
end;

procedure TfrxRTFExport.PrepareExport;

  { Memo with RTF content is actually a valid
    RTF document, with its own font table, color
    table etc. Before such a memo can be written
    to an output document it must be prepaired:

      - extract printable data
      - remove \pard tags
      - synchronize font entries with the document's ones
      - synchronize color entries with the document's ones }

  function PrepareRtfMemo(const Text: AnsiString): AnsiString;
  var
    Doc: TGmlRtf;
    Content: TGmlRtfGroup;
    Stream: TMemoryStream;
    i, j, f, fid: Integer;
    PardNode, PardParent: TGmlRtfNode;
    PardIndex: Integer;
    List: TList;
    c: TGmlRtfControl;
  begin
    Result := '';
    if Text = '' then
      Exit;

    Doc := nil;
    Content := nil;

    try

      { Load the RTF document and get access
        to list of top level nodes. }

      Doc := TGmlRtf.Create(Text);

      { Find the first \pard tag.
        The actual content starts from this tag. }

      PardNode := Doc.Root.Find('pard');
      if PardNode = nil then
        raise Exception.Create('RTF text in a memo does not contain \\pard tags');

      PardParent := TGmlRtfNode(PardNode.FParent);
      PardIndex := PardNode.SelfSubIndex;

      { Remove all \pard tags. These tags are
        leaves of the RTF tree, hence removing
        them will not change the structure of
        the tree. }

      List := Doc.Root.FindAll('pard');

      for i := 0 to List.Count - 1 do
        TGmlNode(List[i]).Remove;

      List.Free;

      { Copy the actual content. }

      Content := TGmlRtfGroup.Create;
      with Content do
      begin
        FDoc := Doc;
        FSubNodes := PardParent.Select(PardIndex);
      end;

      { Map local font indexes to global
        font indexes. }

      List := Content.FindAll('f');

      for i := 0 to Doc.FontsCount - 1 do
      begin
        with Doc.Font(i) do
        begin
          fid := Index;
          try
            f := StrToInt(GetRTFFontName(string(Name), Charset));
          except
            f := 0;
          end;
        end;

        for j := 0 to List.Count - 1 do
        begin
          c := TGmlRtfControl(List[j]);
          if c= nil then Continue;
          if c.Value = fid then
          begin
            c.Value := f;
            List[j] := nil;
          end;
        end;
      end;

      List.Free;

      { Map local color indexes to global
        color indexes. }

      List := Content.FindAll('cf');

      for i := 0 to Doc.ColorsCount - 1 do
      begin
        try
          f := StrToInt(GetRTFFontColor(string(Doc.Color(i).Serialize + ';')));
        except
          f := 1;
        end;

        for j := 0 to List.Count - 1 do
        begin
          c := TGmlRtfControl(List[j]);
          if c = nil then Continue;
          if c.Value = i + 1 then
          begin
            c.Value := f;
            List[j] := nil;
          end;
        end;
      end;

      List.Free;

      { Serialize the content. }

      Stream := TMemoryStream.Create;

      try
        Content.Serialize(Stream);
        SetLength(Result, Stream.Size);
        Move(Stream.Memory^, Result[1], Stream.Size);
      except
        Stream.Free;
        raise;
      end;

      Stream.Free;

    except
      on e: Exception do
        Result := AnsiString(Format('{%s}', [e.Message]));
    end;

    Doc.Free;
    Content.Free;
  end;

var
  i: Integer;
  Obj: TfrxIEMObject;
  s: AnsiString;
begin
  for i := 0 to FMatrix.GetObjectsCount - 1 do
  begin
    Obj := FMatrix.GetObjectById(i);
    Obj.Counter := -1;

    GetRTFFontColor(GetRTFColor(Obj.Style.Color));
    GetRTFFontColor(GetRTFColor(Obj.Style.LeftLine.Color));
    GetRTFFontColor(GetRTFColor(Obj.Style.RightLine.Color));
    GetRTFFontColor(GetRTFColor(Obj.Style.TopLine.Color));
    GetRTFFontColor(GetRTFColor(Obj.Style.BottomLine.Color));

    if Obj.IsRichText then
    begin
      s := PrepareRtfMemo(AnsiString(Obj.Memo.Text));
      Obj.Memo.Text := string(s);
    end
    else if Obj.IsText then
    begin
      GetRTFFontColor(GetRTFColor(Obj.Style.Font.Color));
      GetRTFFontName(Obj.Style.Font.Name, Obj.Style.Charset);
    end;
  end;
end;

procedure TfrxRTFExport.ExportPage(const Stream: TStream);
var
  i, j, x, y, fx, fy, dx, dy, n, n1, pbk: Integer;
  YDiv: Extended;
  dcol, drow, xoffs: Integer;
  buff, s, s0, s1, s2: String;
  st, st1: WideString;
  CellsLine: AnsiString;
  Obj: TfrxIEMObject;
  ObjBounds: TfrxRect;
  ObjWidth, ObjHeight: Extended;
  Graphic: TGraphic;
  Str, CellsStream: TStream;
  bArr: array[0..1023] of Byte;
  FMode: Integer; // 3 - header, 2 - footer, 1 - body, 0 - stop
  FHTMLTags: TfrxHTMLTagsList;
  Tag: TfrxHTMLTag;
  SubType: TSubStyle;

  TagFColor: TColor;
  TagFStyleB, TagFStyleU, TagFStyleI: Integer;

  procedure WriteExpLn(const str: string);
{$IFDEF Delphi12}
  var
    TemsStr: AnsiString;
{$ENDIF}
  begin
{$IFDEF Delphi12}
    TemsStr := AnsiString(str);
    if Length(TemsStr) > 0 then
    begin
      Stream.Write(TemsStr[1], Length(TemsStr));
      Stream.Write(AnsiString(#13#10), 2);
    end;
{$ELSE}
    if Length(str) > 0 then
    begin
      Stream.Write(str[1], Length(str));
      Stream.Write(#13#10, 2);
    end;
{$ENDIF}
  end;

  procedure SetPageProp(Page: Integer);
  var
    s: String;
  begin
    s := '\pgwsxn' + IntToStr(Round(FMatrix.GetPageWidth(Page) * PageDivider)) +
               '\pghsxn' + IntToStr(Round(FMatrix.GetPageHeight(Page) * PageDivider)) +
               '\marglsxn' + IntToStr(Round(FMatrix.GetPageLMargin(Page) * MargDivider)) +
               '\margrsxn' + IntToStr(Round(FMatrix.GetPageRMargin(Page) * MargDivider)) +
               '\margtsxn' + IntToStr(Round(FMatrix.GetPageTMargin(Page) * MargDivider)) +
               '\margbsxn' + IntToStr(Round(FMatrix.GetPageBMargin(Page) * MargDivider));
    WriteExpLn(s);
    if FMatrix.GetPageOrientation(Page) = poLandscape then
      WriteExpLn('\lndscpsxn');
  end;

begin
  PrepareExport;
  SubType := ssNormal;
  WriteExpLn('{\rtf1\ansi');
  s := '{\fonttbl';
  for i := 0 to FFontTable.Count - 1 do
  begin
    s1 := '{\f' + IntToStr(i) + '\fcharset' + FCharsetTable[i] +  ' ' + FFontTable[i] + '}';
    if Length(s + s1) < 255 then
      s := s + s1
    else
    begin
      WriteExpLn(s);
      s := s1;
    end;
  end;
  s := s + '}';
  WriteExpLn(s);
  s := '{\colortbl;';
  for i := 0 to FColorTable.Count - 1 do
  begin
    s1 := FColorTable[i];
    if Length(s + s1) < 255 then
      s := s + s1
    else
    begin
      WriteExpLn(s);
      s := s1;
    end;
  end;
  s := s + '}';
  WriteExpLn(s);
  WriteExpLn('{\info{\title ' + StrToRTFUnicodeEx(Report.ReportOptions.Name) +
             '}{\author ' + StrToRTFUnicodeEx(FCreator) +
             '}{\creatim\yr' + FormatDateTime('yyyy', CreationTime) +
             '\mo' + FormatDateTime('mm', CreationTime) +
             '\dy' + FormatDateTime('dd', CreationTime) +
             '\hr' + FormatDateTime('hh', CreationTime) +
             '\min' + FormatDateTime('nn', CreationTime) + '}}');
  if ShowProgress then
    FProgress.Execute(FMatrix.Height - 1, frxResources.Get('ProgressWait'), True, True);
  pbk := 0;
  SetPageProp(pbk);

  if FHeaderFooterMode = hfPrint then
    FMode := 3
  else
    FMode := 1;
///
  YDiv := Ydivider;
  while FMode > 0 do
  begin
    if FMode = 3 then
      WriteExpLn('{\header ')
    else if FMode = 2 then
      WriteExpLn('{\footer ');

    if FMatrix.PagesCount = 1 then
      YDiv := Ydivider_last;

    for y := 0 to FMatrix.Height - 2 do
    begin
      if ShowProgress then
      begin
        FProgress.Tick;
        if FProgress.Terminated then
          break;
      end;
      if FExportPageBreaks and (FMode = 1) then
        if pbk < FMatrix.PagesCount then
          if FMatrix.GetPageBreak(pbk) <= FMatrix.GetYPosById(y) then
          begin
            WriteExpLn('\pard\sect');
            Inc(pbk);
            if pbk < FMatrix.PagesCount then
              SetPageProp(pbk);
            if pbk = FMatrix.PagesCount - 1 then
              YDiv := Ydivider_last;
            continue;
          end;
      drow := Round((FMatrix.GetYPosById(y + 1) - FMatrix.GetYPosById(y)) * YDiv);
      if FAutoSize then
        buff := '\trrh'
      else
        buff := '\trrh-';
      buff := buff + IntToStr(drow) + '\trgaph15';
      CellsStream := TMemoryStream.Create;
      try
        xoffs := Round(FMatrix.GetXPosById(0)) + Round(FMatrix.GetPageLMargin(pbk) * MargDivider / Xdivider);
        for x := 1 to FMatrix.Width - 2 do
        begin
          i := FMatrix.GetCell(x, y);
          if (i <> -1) then
          begin
            Obj := FMatrix.GetObjectById(i);

            ObjBounds := FMatrix.GetObjectBounds(Obj);
            ObjWidth := ObjBounds.Right - ObjBounds.Left;
            ObjHeight := ObjBounds.Bottom - ObjBounds.Top;

            if (FMode = 3) and (not Obj.Header) then
              Continue;
            if (FMode = 2) and (not Obj.Footer) then
              Continue;
            if (FMode = 1) and (Obj.Header or Obj.Footer) and
               ((FHeaderFooterMode = hfPrint) or
                (FHeaderFooterMode = hfNone)) then
              Continue;

            FMatrix.GetObjectPos(i, fx, fy, dx, dy);
            if Obj.Counter = -1 then
            begin
              if dy > 1 then
                buff := buff + '\clvmgf';
              if (obj.Style.Color mod 16777216) <> clWhite then
                buff := buff + '\clcbpat' + GetRTFFontColor(GetRTFColor(Obj.Style.Color));

              buff := buff + GetRTFVAlignment(Obj.Style.VAlign) + GetRTFBorders(Obj.Style) + '\cltxlrtb';
              dcol := Round((ObjBounds.Right - xoffs) * Xdivider);
              buff := buff + '\cellx' + IntToStr(dcol);
              if Obj.IsText then
              begin
                s := '\f' + GetRTFFontName(Obj.Style.Font.Name, Obj.Style.Charset);
                s := s + '\fs' + IntToStr(Obj.Style.Font.Size * 2);
                s := s + GetRTFFontStyle(Obj.Style.Font.Style);
                s := s + '\cf' + GetRTFFontColor(GetRTFColor(Obj.Style.Font.Color));
                if (Obj.IsRichText) then
                  s1 := Obj.Memo.Text
                else
                begin
                  // export HTML tags
                  if Obj.HTMLTags then
                  begin
                    FHTMLTags := TfrxHTMLTagsList.Create;
                    try
                      FHTMLTags.SetDefaults(Obj.Style.Font.Color, Obj.Style.Font.Size, Obj.Style.Font.Style);
                      FHTMLTags.AllowTags := True;
                      st := StrToRTFSlash(TruncReturns(Obj.Memo.Text));
                      st1 := st;
                      s1 := '';

                      TagFColor := Obj.Style.Color;
                      TagFStyleB := 0;
                      TagFStyleU := 0;
                      TagFStyleI := 0;

                      FHTMLTags.ExpandHTMLTags(st);
                      for i := 0 to FHTMLTags.Count - 1 do
                        for j := 0 to FHTMLTags[i].Count - 1 do
                        begin
                          Tag := FHTMLTags[i].Items[j];

                          // bold tags
                          if (fsBold in Tag.Style) and (TagFStyleB = 0) then
                          begin
                            Inc(TagFStyleB);
                            s1 := s1 + '\b ';
                          end;
                          if (TagFStyleB > 0) and (not (fsBold in Tag.Style)) then
                          begin
                            Dec(TagFStyleB);
                            s1 := s1 + '\b0 ';
                          end;

                          // italic tags
                          if (fsItalic in Tag.Style) and (TagFStyleI = 0) then
                          begin
                            Inc(TagFStyleI);
                            s1 := s1 + '\i ';
                          end;
                          if (TagFStyleI > 0) and (not (fsItalic in Tag.Style)) then
                          begin
                            Dec(TagFStyleI);
                            s1 := s1 + '\i0 ';
                          end;

                          // underline tags
                          if (fsUnderline in Tag.Style) and (TagFStyleU = 0) then
                          begin
                            Inc(TagFStyleU);
                            s1 := s1 + '\ul ';
                          end;
                          if (TagFStyleU > 0) and (not (fsUnderline in Tag.Style)) then
                          begin
                            Dec(TagFStyleU);
                            s1 := s1 + '\ul0 ';
                          end;

                          // color tags
                          if (Tag.Color <> Obj.Style.Font.Color) and (Tag.Color <> TagFColor) then
                          begin
                            TagFColor := Tag.Color;
                            s1 := s1 + '\cf' + GetRTFFontColor(GetRTFColor(TagFColor)) + ' ';
                          end;
                          if (Tag.Color <> TagFColor) then
                          begin
                            TagFColor := Tag.Color;
                            s1 := s1 + '\cf' + GetRTFFontColor(GetRTFColor(TagFColor)) + ' ';
                          end;

                          // subscript and subscript
                          if SubType <> Tag.Subtype then
                          begin
                             SubType := Tag.Subtype;
                             case SubType of
                              ssSubscript:
                                s1 := s1 + '\sub ';
                              ssSuperscript:
                                s1 := s1 + '\super ';
                              else
                                s1 := s1 + '\nosupersub ';
                              end;
                          end;

                          s1 := s1 + StrToRTFUnicode(st1[Tag.Position]);

                        end;
                        s1 := s1 + '\plain';
                    finally
                      FHTMLTags.Free;
                    end;
                  end
                  else
                    s1 := StrToRTFUnicodeEx(TruncReturns(Obj.Memo.Text));
                end;
                if Trim(s1) <> '' then
                begin
                  s2 := '';
                  if not Obj.IsRichText then
                  begin
                    j := Round(Obj.Style.CharSpacing * FONT_DIVIDER);
                    if (Obj.Style.GapY + Obj.Style.LineSpacing - 1) > 0 then
                      n1 := Round((Obj.Style.GapY + Obj.Style.LineSpacing - 1) * YDiv)
                    else
                      n1 := 0;
                    s2 := '\sb' + IntToStr(n1) +
                        '\li' + IntToStr(Round((Obj.Style.GapX / 2) * Xdivider)) +
                        '\fi' + IntToStr(Round((Obj.Style.ParagraphGap) * Xdivider)) +
                        '\expnd' + IntToStr(j div 5) + '\expndtw' + IntToStr(j) +
                        '\sl-' + IntToStr(Round((Obj.Style.Font.Size * 96 / 72 + Obj.Style.LineSpacing) * YDiv * 0.98)) +
                        '\slmult0';
                    if Obj.Style.WordBreak then
                      s2 := s2 + '\hyphauto1\hyphcaps1';
                  end
                end;
                CellsLine := AnsiString(GetRTFHAlignment(Obj.Style.HAlign) +
                  '{' + s + s2 + ' ' + s1 + '\cell}');
                s := '\par'#13#10'\cell';
                while Pos(AnsiString(s), CellsLine) > 0 do
                  CellsLine := AnsiString(StringReplace(String(CellsLine), s, '\cell', []));
                CellsStream.Write(CellsLine[1], Length(CellsLine));
              end
              else if FExportPictures then
                if PictureType <> gpBMP then
                begin
                  Graphic := Obj.Metafile;

                  if (Graphic <> nil) and (Graphic.Width <> 0) and (Graphic.Height <> 0) then
                    SaveGraphic(Graphic, CellsStream, ObjWidth, ObjHeight, PictureType)
                end
                else
                begin
                  Graphic := Obj.Image;
                  if not ((Graphic = nil) or Graphic.Empty) then
                  begin
                    Str := TMemoryStream.Create;
                    try
                      dx := Round(ObjWidth);
                      dy := Round(ObjHeight);
                      fx := Graphic.Width;
                      fy := Graphic.Height;
                      Graphic.SaveToStream(Str);
                      Str.Position := 0;
                      CellsLine := '{\sb0\li0\sl0\slmult0 {\pict\wmetafile8\picw' + AnsiString(FloatToStr(Round(dx * IMAGE_DIVIDER))) +
                           '\pich' + AnsiString(FloatToStr(Round(dy * IMAGE_DIVIDER))) + '\picbmp\picbpp4' + #13#10;
                      CellsStream.Write(CellsLine[1], Length(CellsLine));
                      Str.Read(n, 2);
                      Str.Read(n, 4);
                      n := n div 2 + 7;
                      s0 := IntToHex(n + $24, 8);
                      s := '010009000003' + Copy(s0, 7, 2) + Copy(s0, 5, 2) +
                           Copy(s0, 3, 2) + Copy(s0, 1, 2) + '0000';
                      s0 := IntToHex(n, 8);
                      s1 := Copy(s0, 7, 2) + Copy(s0, 5, 2) + Copy(s0, 3, 2) + Copy(s0, 1, 2);
                      s := s + s1 + '0000050000000b0200000000050000000c02';
                      s0 := IntToHex(fy, 4);
                      s := s + Copy(s0, 3, 2) + Copy(s0, 1, 2);
                      s0 := IntToHex(fx, 4);
                      s := s + Copy(s0, 3, 2) + Copy(s0, 1, 2) +
                        '05000000090200000000050000000102ffffff000400000007010300' + s1 +
                        '430f2000cc000000';
                      s0 := IntToHex(fy, 4);
                      s := s + Copy(s0, 3, 2) + Copy(s0, 1, 2);
                      s0 := IntToHex(fx, 4);
                      s := s + Copy(s0, 3, 2) + Copy(s0, 1, 2) + '00000000';
                      s0 := IntToHex(fy, 4);
                      s := s + Copy(s0, 3, 2) + Copy(s0, 1, 2);
                      s0 := IntToHex(fx, 4);
                      s := s + Copy(s0, 3, 2) + Copy(s0, 1, 2) + '00000000';
                      CellsLine := AnsiString(s + #13#10);
                      CellsStream.Write(CellsLine[1], Length(CellsLine));
                      Str.Read(bArr[0], 8);
                      n1 := 0; s := '';
                      repeat
                        n := Str.Read(bArr[0], 1024);
                        for j := 0 to n - 1 do
                        begin
                          s := s + IntToHex(bArr[j], 2);
                          Inc(n1);
                          if n1 > 63 then
                          begin
                            n1 := 0;
                            CellsLine := AnsiString(s + #13#10);
                            CellsStream.Write(CellsLine[1], Length(CellsLine));
                            s := '';
                          end;
                        end;
                      until n < 1024;
                    finally
                      Str.Free;
                    end;
                    if n1 <> 0 then
                    begin
                      CellsLine := AnsiString(s + #13#10);
                      CellsStream.Write(CellsLine[1], Length(CellsLine));
                    end;
                    s := '030000000000}';
                    CellsLine := AnsiString(s + '\cell}' + #13#10);
                    CellsStream.Write(CellsLine[1], Length(CellsLine));
                  end;
                end;
              Obj.Counter := y + 1;
            end
            else
            begin
              if (dy > 1) and (Obj.Counter <> (y + 1)) then
              begin
                buff := buff + '\clvmrg';
                buff := buff + GetRTFBorders(Obj.Style) + '\cltxlrtb';
                dcol := Round((ObjBounds.Right - xoffs) * Xdivider);
                buff := buff + '\cellx' + IntToStr(dcol);
                j := drow div FONT_DIVIDER;
                if j > 20 then
                  j := 20;
                CellsLine := '{\fs' + AnsiString(IntToStr(j)) + '\cell}';
                CellsStream.Write(CellsLine[1], Length(CellsLine));
                Obj.Counter := y + 1;
              end;
            end
          end
        end;
        if CellsStream.Size > 0 then
        begin
          s := '\trowd' + buff + '\pard\intbl';
          WriteExpLn(s);
          Stream.CopyFrom(CellsStream, 0);
          WriteExpLn('\pard\intbl{\trowd' + buff + '\row}');
        end;
      finally
        CellsStream.Free;
      end;
    end;
    if FMode in [2, 3] then
      WriteExpLn('}');
    Dec(FMode);
  end;
  WriteExpLn('}');
end;

procedure TfrxRTFExport.SaveGraphic(Graphic: TGraphic; Stream: TStream;
  Width, Height: Extended; PicType: TfrxPictureType);
var
  Blip: TStream;
  CellsLine: AnsiString;
  n1, n, j: Integer;
  s: AnsiString;
  bArr: array[0..1023] of Byte;
  BlipType: AnsiString;
begin
  Blip := TMemoryStream.Create;

  try
    case PicType of
      gpEMF:
        begin
          BlipType := 'emfblip';
          SaveGraphicAs(Graphic, Blip, gpEMF);
        end;

      gpJPG:
        begin
          BlipType := 'jpegblip';
          SaveGraphicAs(Graphic, Blip, gpJPG);
        end

      else
        begin
          BlipType := 'pngblip';
          SaveGraphicAs(Graphic, Blip, gpPNG);
        end;
    end;

    CellsLine := '{\sb0\li0\sl0\slmult0 {\pict\picw' +
      AnsiString(FloatToStr(Width * IMAGE_DIVIDER)) +
      '\pich' +
      AnsiString(FloatToStr(Height * IMAGE_DIVIDER)) +
      '\picscalex98\picscaley98\piccropl0\piccropr0\piccropt0\piccropb0\' +
      BlipType +
      #13#10;
    Stream.Write(CellsLine[1], Length(CellsLine));

    { todo: Rewrite slow code.
      This code splits the Blip stream into 64-byte chunks,
      converts each byte to 2 hex-dgits, appends each chunk with CRLF
      and writes them all to Stream. }

    Blip.Position := 0;
    n1 := 0; s := '';
    repeat
      n := Blip.Read(bArr[0], 1024);
      for j := 0 to n - 1 do
      begin
        s := s + AnsiString(IntToHex(bArr[j], 2));
        Inc(n1);
        if n1 > 63 then
        begin
          n1 := 0;
          CellsLine := s + AnsiString(#13#10);
          Stream.Write(CellsLine[1], Length(CellsLine));
          s := '';
        end;
      end;
    until n < 1024;
    if n1 <> 0 then
    begin
      CellsLine := s + AnsiString(#13#10);
      Stream.Write(CellsLine[1], Length(CellsLine));
    end;
    CellsLine := '}\cell}' + #13#10;
    Stream.Write(CellsLine[1], Length(CellsLine));
  finally
    Blip.Free
  end;
end;

function TfrxRTFExport.ShowModal: TModalResult;
begin
  if not Assigned(Stream) then
  begin
    with TfrxRTFExportDialog.Create(nil) do
    begin
      SendMessage(GetWindow(PColontitulCB.Handle,GW_CHILD), EM_SETREADONLY, 1, 0);
      OpenCB.Visible := not SlaveExport;
      if OverwritePrompt then
        SaveDialog1.Options := SaveDialog1.Options + [ofOverwritePrompt];
      if SlaveExport then
        FOpenAfterExport := False;

      if (FileName = '') and (not SlaveExport) then
        SaveDialog1.FileName := ChangeFileExt(ExtractFileName(frxUnixPath2WinPath(Report.FileName)), SaveDialog1.DefaultExt)
      else
        SaveDialog1.FileName := FileName;

      ContinuousCB.Checked := SuppressPageHeadersFooters;
      PicturesCB.Checked := FExportPictures;
      PageBreaksCB.Checked := FExportPageBreaks;
      WCB.Checked := FWysiwyg;
      OpenCB.Checked := FOpenAfterExport;

      if PageNumbers <> '' then
      begin
        PageNumbersE.Text := PageNumbers;
        PageNumbersRB.Checked := True;
      end;

      if FHeaderFooterMode = hfText then
        PColontitulCB.ItemIndex := 0
      else if FHeaderFooterMode = hfPrint then
        PColontitulCB.ItemIndex := 1
      else
        PColontitulCB.ItemIndex := 2;

      Result := ShowModal;

      if Result = mrOk then
      begin
        if PColontitulCB.ItemIndex = 0 then
          FHeaderFooterMode := hfText
        else if PColontitulCB.ItemIndex = 1 then
          FHeaderFooterMode := hfPrint
        else
          FHeaderFooterMode := hfNone;

        PageNumbers := '';
        CurPage := False;
        if CurPageRB.Checked then
          CurPage := True
        else if PageNumbersRB.Checked then
          PageNumbers := PageNumbersE.Text;

        SuppressPageHeadersFooters := ContinuousCB.Checked;

        if FHeaderFooterMode = hfPrint then
          SuppressPageHeadersFooters := True;

        FExportPictures := PicturesCB.Checked;
        FExportPageBreaks := PageBreaksCB.Checked;
        FWysiwyg := WCB.Checked;
        FOpenAfterExport := OpenCB.Checked;

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

function TfrxRTFExport.Start: Boolean;
begin
  if SlaveExport then
  begin
    if Report.FileName <> '' then
      FileName := ChangeFileExt(GetTemporaryFolder + ExtractFileName(Report.FileName), frxGet(8505))
    else
      FileName := ChangeFileExt(GetTempFile, frxGet(8505))
  end;
  if (FileName <> '') or Assigned(Stream) then
  begin
    if (ExtractFilePath(FileName) = '') and (DefaultPath <> '') then
      FileName := DefaultPath + '\' + FileName;
    FFirstPage := True;
    FCurrentPage := 0;
    FMatrix := TfrxIEMatrix.Create(UseFileCache, Report.EngineOptions.TempDir);
    FMatrix.ShowProgress := ShowProgress;
    if FWysiwyg then
      FMatrix.Inaccuracy := 0.5
    else
      FMatrix.Inaccuracy := 10;
    FMatrix.RotatedAsImage := True;
    FMatrix.RichText := True;
    FMatrix.PlainRich := False;
    FMatrix.AreaFill := True;
    FMatrix.CropAreaFill := True;
    FMatrix.DeleteHTMLTags := False;
    FMatrix.BackgroundImage := False;
    FMatrix.Background := False;
    FMatrix.Printable := ExportNotPrintable;
    FMatrix.EMFPictures := PictureType <> gpBMP;
    FFontTable := TStringList.Create;
    FCharsetTable := TStringList.Create;
    FColorTable := TStringList.Create;
    FDataList := TList.Create;
    Result := True
  end
  else
    Result := False;
end;

procedure TfrxRTFExport.StartPage(Page: TfrxReportPage; Index: Integer);
begin
  Inc(FCurrentPage);
  if FFirstPage then
    FFirstPage := False;
end;

procedure TfrxRTFExport.ExportObject(Obj: TfrxComponent);
begin
  if (Obj is TfrxPageHeader) and (ExportNotPrintable or TfrxView(Obj).Printable) then
    FMatrix.SetPageHeader(TfrxBand(Obj))
  else if (Obj is TfrxPageFooter) and (ExportNotPrintable or TfrxView(Obj).Printable) then
    FMatrix.SetPageFooter(TfrxBand(Obj))
  else if (Obj is TfrxView) and (ExportNotPrintable or TfrxView(Obj).Printable) then
  begin
    if (Obj is TfrxCustomMemoView) or
      (FExportPictures and (not (Obj is TfrxCustomMemoView))) then
        FMatrix.AddObject(TfrxView(Obj))
  end;
end;

procedure TfrxRTFExport.FinishPage(Page: TfrxReportPage; Index: Integer);
begin
  FMatrix.AddPage(Page.Orientation, Page.Width, Page.Height, Page.LeftMargin,
                  Page.TopMargin, Page.RightMargin, Page.BottomMargin, Page.MirrorMargins, Index);
end;

procedure TfrxRTFExport.Finish;
var
  Exp: TStream;
begin
  FMatrix.Prepare;
  if ShowProgress then
    FProgress := TfrxProgress.Create(nil);
  try
    if Assigned(Stream) then
      Exp := Stream
    else
      Exp := TFileStream.Create(FileName, fmCreate);
    try
      ExportPage(Exp);
    finally
      if not Assigned(Stream) then
        Exp.Free;
    end;
    if FOpenAfterExport and (not Assigned(Stream)) then
      ShellExecute(GetDesktopWindow, 'open', PChar(FileName), nil, nil, SW_SHOW);
  except
    on e: Exception do
      case Report.EngineOptions.NewSilentMode of
        simSilent:        Report.Errors.Add(e.Message);
        simMessageBoxes:  frxErrorMsg(e.Message);
        simReThrow:       raise;
      end;
  end;
  FMatrix.Clear;
  FMatrix.Free;
  FFontTable.Free;
  FCharsetTable.Free;
  FColorTable.Free;
  FDataList.Free;
  if ShowProgress then
    FProgress.Free;
end;

{ TfrxRTFExportDialog }

procedure TfrxRTFExportDialog.FormCreate(Sender: TObject);
begin
  Caption := frxGet(8500);
  OkB.Caption := frxGet(1);
  CancelB.Caption := frxGet(2);
  GroupPageRange.Caption := frxGet(7);
  AllRB.Caption := frxGet(3);
  CurPageRB.Caption := frxGet(4);
  PageNumbersRB.Caption := frxGet(5);
  DescrL.Caption := frxGet(9);
  GroupQuality.Caption := frxGet(8);
  ContinuousCB.Caption := frxGet(8950);
  PicturesCB.Caption := frxGet(8501);
  PageBreaksCB.Caption := frxGet(6);
  WCB.Caption := frxGet(8502);
  OpenCB.Caption := frxGet(8503);
  SaveDialog1.Filter := frxGet(8504);
  SaveDialog1.DefaultExt := frxGet(8505);
  HeadFootL.Caption := frxGet(8951);
  PColontitulCB.Items[0] := frxGet(8952);
  PColontitulCB.Items[1] := frxGet(8953);
  PColontitulCB.Items[2] := frxGet(8954);

  if UseRightToLeftAlignment then
    FlipChildren(True);
end;

procedure TfrxRTFExportDialog.PageNumbersEChange(Sender: TObject);
begin
  PageNumbersRB.Checked := True;
end;

procedure TfrxRTFExportDialog.PageNumbersEKeyPress(Sender: TObject;
  var Key: Char);
begin
  case key of
    '0'..'9':;
    #8, '-', ',':;
  else
    key := #0;
  end;
end;

procedure TfrxRTFExportDialog.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_F1 then
    frxResources.Help(Self);
end;

end.
