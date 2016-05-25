// Resource converter to utf-8 by Alexander Fediachov (Samuray)
// 29.11.2007

program res2utf8;

{$APPTYPE CONSOLE}
{$WARN SYMBOL_PLATFORM OFF}

uses
  Windows, SysUtils, Classes, frxXML;

var
  Codepages: TStringList;
  StartDir: String;

procedure Help;
begin
  WriteLn('Usage: res2utf8.exe codepages.txt');
end;

procedure DoConvertFile(const FileName: String; const Lang: String);
var
  FoutXML: TfrxXMLDocument;
  VName, Val, outname: String;
  us: WideString;
  j, idx: Integer;
  cp: Integer;
  List: TStringList;
  Root: TfrxXMLItem;

begin
  List := TStringList.Create;
  List.LoadFromFile(FileName);
  FoutXML := TfrxXMLDocument.Create;
  FoutXML.Root.Name := 'Resources';
  FoutXML.AutoIndent := True;
  Root := FoutXML.Root;
  outname := ChangeFileExt(FileName, '.xml');
  if FileExists(outname) then
    DeleteFile(outname);
  try
    if Codepages.Values[UpperCase(Lang)] <> '' then
      cp := StrToInt(Codepages.Values[UpperCase(Lang)])
    else
      cp := 0;
    FoutXML.Root.Prop['CodePage'] := IntToStr(cp);
    try
      for idx := 0 to List.Count - 1 do
      begin
        VName := List[idx];
        Val := Copy(VName, Pos('=', VName) + 1, MaxInt);
        VName := Copy(VName, 1, Pos('=', VName) - 1);
        if (Length(VName) = 0) or (Length(Val) = 0) then continue;
        j := MultiByteToWideChar(cp, 0, PAnsiChar(Val), Length(Val), nil, 0);
        SetLength(us, j);
        MultiByteToWideChar(cp, 0, PAnsiChar(Val), Length(Val), PWideChar(us), j);
        SetLength(Val, Length(us) * 6);
        j := UnicodeToUtf8(PChar(Val), Length(us) * 6, PWideChar(us), Length(us));
        SetLength(Val, j - 1);
        with Root.Add do
        begin
          Name := 'StrRes';
          Prop['Name'] := VName;
          Prop['Text'] := frxStrToXML(Val);
        end;
      end;
    except
      on e: Exception do
        WriteLn(e.Message);
    end;
    WriteLn(ExtractFileName(FileName) + ' -> ' + outname);
    FoutXML.SaveToFile(outname);
  finally
    FoutXML.Free;
    List.Free;
  end;
end;

procedure DoConvert(const Dir: String; const Lang: String);
var
  SRec: TSearchRec;
  i: Integer;
begin
  i := FindFirst(Dir + '\*.*', faDirectory + faArchive, SRec);
  try
    while i = 0 do
    begin
      if (SRec.Name <> '.') and (SRec.Name <> '..') then
      begin
        if (LowerCase(ExtractFileExt(SRec.Name)) = '.frc') then
          DoConvertFile(Dir + '\' + SRec.Name, Lang)
        else
          if (SRec.Attr and faDirectory) = faDirectory then
          begin
            WriteLn(SRec.Name + ':');
            DoConvert(Dir + '\' + SRec.Name, SRec.Name);
          end;
      end;
      i := FindNext(SRec);
    end;
    WriteLn;
  finally
    FindClose(SRec);
  end;
end;

begin
  if (ParamCount > 0) and FileExists(ParamStr(1)) then
  begin
    Codepages := TStringList.Create;
    try
      Codepages.LoadFromFile(ParamStr(1));
      Codepages.Text := UpperCase(Codepages.Text);
      StartDir := GetCurrentDir;
      DoConvert(StartDir, '');
    finally
      Codepages.Free;
    end;
  end
  else
    Help;
end.
