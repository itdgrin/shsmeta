unit ArhivModule;

interface
uses
  System.Classes, System.SysUtils, System.IOUtils, System.Types, SyncObjs,
  Winapi.Windows, Winapi.Messages, ZipForge, GlobsAndConst;

type
  TBaseAppArhiv = class(TObject)
  private
    FAppPath,
    FArhivPath: string;
    FArhFiles: TStringDynArray;
    procedure CopyAppTo(const ASourceDir, ADestDir: string);
  public
    constructor Create(const AAppPath, AArhivPath: string);
    procedure Update();
    function GetArhivTime(const AArhivName: string): TDateTime;
    procedure DeleteArhiv(const AArhivName: string);
    procedure RestoreArhiv(const AArhivName: string);
    procedure CreateNewArhiv();
    property ArhivPath: string read FArhivPath;
    property ArhFiles: TStringDynArray read FArhFiles;
  end;

implementation

uses  Tools, fUpdate;

{ TBaseAppArhiv }

constructor TBaseAppArhiv.Create(const AAppPath, AArhivPath: string);
begin
  if not TDirectory.Exists(AArhivPath) then
    TDirectory.CreateDirectory(AArhivPath);

  inherited Create;
  FAppPath := IncludeTrailingPathDelimiter(AAppPath);
  FArhivPath := IncludeTrailingPathDelimiter(AArhivPath);
  try
    if not TDirectory.Exists(FAppPath) then
      raise Exception.Create('Директорий ''' + AAppPath + ''' не найден.');
    Update();
  except
    on e: Exception do
    begin
      Destroy;
      raise e;
    end;
  end;
end;

function TBaseAppArhiv.GetArhivTime(const AArhivName: string): TDateTime;
var TmpStr: string;
    TmpList: TStringList;
    y,m,d: Word;
begin
  TmpList := TStringList.Create;
  try
    TmpStr := ExtractFileName(AArhivName);
    TmpStr := StringReplace(TmpStr, '_arh.zip', '', [rfIgnoreCase]);
    TmpStr := StringReplace(TmpStr, '_', #13#10, [rfReplaceAll]);
    TmpList.Text := TmpStr;
    y := StrToInt(TmpList[0]);
    m := StrToInt(TmpList[1]);
    d := StrToInt(TmpList[2]);
    Result := EncodeDate(y, m, d);
    Result := Result + (StrToInt(TmpList[3]))/10000;
  finally
    FreeAndNil(TmpList);
  end;
end;

procedure TBaseAppArhiv.RestoreArhiv(const AArhivName: string);
var ZF: TZipForge;
    TmpCurPath: string;
    TmpWaitResult: DWord;
begin
  if not SameText(ExtractFilePath(AArhivName), FArhivPath) then
    raise Exception.Create('Расположения файла ''' + AArhivName +
      ''' не совпадает с расположением архива');

  //Подготавливаем временну папку
  if TDirectory.Exists(FArhivPath + C_TMPDIR) then
    KillDir(FArhivPath + C_TMPDIR);
  TDirectory.CreateDirectory(FArhivPath + C_TMPDIR);

  TmpCurPath := TDirectory.GetCurrentDirectory;
  ZF := TZipForge.Create(nil);
  try
    //Если есть мусорок подчищием
    if TFile.Exists(FArhivPath + C_DUMPNAME) then
      TFile.Delete(FArhivPath + C_DUMPNAME);

    //Задаем текущий директорый
    TDirectory.SetCurrentDirectory(FArhivPath);

    try
      ZF.BaseDir := FArhivPath + C_TMPDIR;
      ZF.Options.CreateDirs := true;
      ZF.Options.OverwriteMode := omAlways;

      ZF.FileName := AArhivName;
      ZF.OpenArchive;
      ZF.ExtractFiles('*');
      ZF.CloseArchive;

    except
      on e: Exception do
        raise Exception.Create('Ошибка распаковки: ' + e.Message);
    end;

    try
      //Перетягиваем дамп в текущую директорию
      if TFile.Exists(FArhivPath + C_TMPDIR + C_ARHBASEDIR + C_DUMPNAME) then
        TFile.Move(FArhivPath + C_TMPDIR + C_ARHBASEDIR + C_DUMPNAME,
          FArhivPath + C_DUMPNAME);
    except
      on e: Exception do
        raise Exception.Create('Ошибка копирования: ' + e.Message);
    end;

    //Запуск восстановления из дампа
    //НЕ ЗНАЕТ ОБ ВОЗНИКШИХ ИСКЛЮЧЕНИЯХ!!!!!!!!!!!
    WinExecAndWait(C_DUMPTOBASE, nil, 0, TmpWaitResult);
    if (TmpWaitResult <> WAIT_OBJECT_0) then
      raise Exception.Create('Не удалось восстановить базу из дампа!');

    G_STARTUPDATER := 2;
    G_UPDPATH := FArhivPath + C_TMPDIR + C_ARHAPPDIR;
    G_STARTAPP := True;

    //Переносим из архива апдейтер (вообще сомнительная операция)
    if TFile.Exists(G_UPDPATH + C_UPDATERNAME) then
    begin
      TFile.Copy(G_UPDPATH + C_UPDATERNAME,
        FAppPath + C_UPDATERNAME, True);
      TFile.Delete(G_UPDPATH + C_UPDATERNAME);
    end;
  finally
    FreeAndNil(ZF);

    TDirectory.SetCurrentDirectory(TmpCurPath);

    if TFile.Exists(FArhivPath + C_DUMPNAME) then
      TFile.Delete(FArhivPath + C_DUMPNAME);
  end;
end;

procedure TBaseAppArhiv.DeleteArhiv(const AArhivName: string);
begin
  if not SameText(ExtractFilePath(AArhivName), FArhivPath) then
    raise Exception.Create('Расположения файла ''' + AArhivName +
      ''' не совпадает с расположением архива');
  TFile.Delete(AArhivName);
  Update();
end;

procedure TBaseAppArhiv.CreateNewArhiv;
var ZF: TZipForge;
    TmpCurPath: string;
    TmpWaitResult: DWord;
    y,m,d,t: Word;

    function FileSize(const aFilename: String): Int64;
    var
      info: TWin32FileAttributeData;
    begin
      result := -1;

      if NOT GetFileAttributesEx(PWideChar(aFileName), GetFileExInfoStandard, @info) then
        EXIT;

      result := Int64(info.nFileSizeLow) or Int64(info.nFileSizeHigh shl 32);
    end;
begin
  //Подготавливаем временну папку для сбора файлов дампа
  if TDirectory.Exists(FArhivPath + C_TMPDIR) then
    KillDir(FArhivPath + C_TMPDIR);

  TmpCurPath := TDirectory.GetCurrentDirectory;
  ZF := TZipForge.Create(nil);
  try
    //Если есть мусорок подчищием
    if TFile.Exists(FArhivPath + C_DUMPNAME) then
      TFile.Delete(FArhivPath + C_DUMPNAME);

    //Задаем текущий директорый, чтобы не создавало дамп абы где
    TDirectory.SetCurrentDirectory(FArhivPath);

    //Запуск создания архива
    //К сожалению процесс создания архива не как не контролируется
    WinExecAndWait(C_BASETODUMP, nil, 0, TmpWaitResult);
    if (TmpWaitResult <> WAIT_OBJECT_0) or
      not TFile.Exists(FArhivPath + C_DUMPNAME) or
      (FileSize(FArhivPath + C_DUMPNAME) < 1024*1024*2) then //2мб чисто условно
      raise Exception.Create('Не удалось создать дамп базы данных!');

    //Создаем папку базы и папку приложения в архиве
    TDirectory.CreateDirectory(FArhivPath + C_TMPDIR + C_ARHBASEDIR);
    TDirectory.CreateDirectory(FArhivPath + C_TMPDIR + C_ARHAPPDIR);

    try
      //Перемещаем полученый дамп в архив
      TFile.Move(FArhivPath + C_DUMPNAME,
        FArhivPath + C_TMPDIR + C_ARHBASEDIR + C_DUMPNAME);
      //копирует в архив приложение
      CopyAppTo(FAppPath, FArhivPath + C_TMPDIR + C_ARHAPPDIR);
    except
      on e: Exception do
        raise Exception.Create('Ошибка копирования: ' + e.Message);
    end;

    try
      //Упаковывает в архив с уникальним именем
      DecodeDate(Date, y, m, d);
      t := Trunc(Time * 10000);
      ZF.FileName := FArhivPath + IntToStr(y) + '_' +
        copy(IntToStr(100 + m), 2, 2) +  '_' +
        copy(IntToStr(100 + d), 2, 2) + '_' +
        copy(IntToStr(10000 + t), 2, 4) + '_arh.zip';
      ZF.Options.CreateDirs := true;
      ZF.Options.OverwriteMode := omAlways;
      ZF.OpenArchive(fmCreate);
      ZF.BaseDir := FArhivPath + C_TMPDIR;
      ZF.AddFiles('*');
      ZF.CloseArchive;
    except
      on e: Exception do
        raise Exception.Create('Ошибка упаковки: ' + e.Message);
    end;
  finally
    FreeAndNil(ZF);
    TDirectory.SetCurrentDirectory(TmpCurPath);

    if TFile.Exists(FArhivPath + C_DUMPNAME) then
      TFile.Delete(FArhivPath + C_DUMPNAME);

    if TDirectory.Exists(FArhivPath + C_TMPDIR) then
      KillDir(FArhivPath + C_TMPDIR);

    Update();
  end;
end;

procedure TBaseAppArhiv.CopyAppTo(const ASourceDir, ADestDir: string);
var i: Integer;
begin
  for i:= Low(С_APPSTRUCT) to High(С_APPSTRUCT) do
  begin
    if С_APPSTRUCT[i].EType = 0 then //Файлы просто копируются
    begin
      if TFile.Exists(ASourceDir + С_APPSTRUCT[i].EName) then
      begin
        //Позволяет использовать имена файлов типа Dirname\Filename.ext
        ForceDirectories(ExtractFileDir(ADestDir + С_APPSTRUCT[i].EName));
        TFile.Copy(ASourceDir + С_APPSTRUCT[i].EName,
          ADestDir + С_APPSTRUCT[i].EName, True);
      end;
    end;

    if С_APPSTRUCT[i].EType = 1 then //Файлы просто копируются
    begin
      if TDirectory.Exists(ASourceDir + С_APPSTRUCT[i].EName) then
      begin
        TDirectory.Copy(ASourceDir + С_APPSTRUCT[i].EName,
          ADestDir + С_APPSTRUCT[i].EName);
      end;
    end;
  end;
end;

procedure TBaseAppArhiv.Update();
var i, j, k: Integer;
    TmpStr: string;
begin
  FArhFiles := TDirectory.GetFiles(FArhivPath, '*_arh.zip',
    TSearchOption.soTopDirectoryOnly);
  //Сортирует архивы по убыванию
  for i := Low(FArhFiles) to High(FArhFiles) do
  begin
    k := i;
    TmpStr := FArhFiles[i];
    for j := i + 1 to High(FArhFiles) do
      if (FArhFiles[j] > TmpStr) then
      begin
        k := j;
        TmpStr := FArhFiles[j];
      end;
    if k <> i then
    begin
      FArhFiles[k] := FArhFiles[i];
      FArhFiles[i] := TmpStr;
    end;
  end;
end;

end.
