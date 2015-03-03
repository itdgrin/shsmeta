unit ArhivModule;

interface
uses
  System.Classes, System.SysUtils, System.IOUtils, System.Types, SyncObjs,
  Winapi.Windows, Winapi.Messages, ZipForge;

type
  TAppElement = record
    EName: string;
    EType: Byte;  //0 - файл, 1 - папка (содержимое не описывается)
  end;

const
  //Архив содержит состав приложения который будет использоваться для резервного копирования
  //Любый добавления в приложении которые необходимо резервировать должны быть в него внесены
  AppStructure: array [0..7] of TAppElement =
    ((EName: 'smeta.exe'; EType: 0),
     (EName: 'Smeta.ini'; EType: 0),
     (EName: 'libmySQL.dll'; EType: 0),
     (EName: 'SmUpd.exe'; EType: 0),
     (EName: 'SQL'; EType: 1),
     (EName: 'Logs'; EType: 1),
     (EName: 'Settings'; EType: 1),
     (EName: 'Reports'; EType: 1));

  ArhivLocalDir = 'Arhiv\';
  TmpArhDir = 'Tmp\';

  //Имена папок внутри архива
  ArhivBaseDir = 'Base\';
  ArhivAppDir = 'App\';

  //Батники должны лежать в папке с архивом
  BaseToDumpBat = 'To_Dump_all_database.bat';
  DumpToBaseBat = 'From_Dump_all_database.bat';
  DumpName = 'all_database.sql';

type
  TBaseAppArhiv = class(TObject)
  private
    FAppPath,
    FArhivPath: string;
    FArhFiles: TStringDynArray;
    procedure CopyAppTo(const ASourceDir, ADestDir: string);
  public
    constructor Create(const AAppPath, AArhivPath: string);
    destructor Destroy; override;
    procedure Update();
    procedure DeleteArhiv(const AArhivName: string);
    procedure RestoreArhiv(const AArhivPath: string);
    procedure CreateNewArhiv();
    property ArhivPath: string read FArhivPath;
    property ArhFiles: TStringDynArray read FArhFiles;
  end;


implementation

uses  Tools;

{ TBaseAppArhiv }

constructor TBaseAppArhiv.Create(const AAppPath, AArhivPath: string);
begin
  if not TDirectory.Exists(AArhivPath) then
    raise Exception.Create('Папки архива ''' +  AArhivPath + ''' не существует');

  inherited Create;
  FAppPath := IncludeTrailingPathDelimiter(AAppPath);
  FArhivPath := IncludeTrailingPathDelimiter(AArhivPath);
  SetLength(FArhFiles, 0);
  try
    if not TDirectory.Exists(FAppPath) then
      raise Exception.Create('Директорий ''' + AAppPath + ''' не найден.');
    Update();
  except
    on e: Exception do
    begin
      Free;
      raise e;
    end;
  end;
end;

destructor TBaseAppArhiv.Destroy;
begin
  SetLength(FArhFiles, 0);
  inherited;
end;

procedure TBaseAppArhiv.RestoreArhiv(const AArhivPath: string);
begin

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
    ExitCode: Cardinal;
    NewArhName: string;
    y,m,d,t: Word;
begin
  //Подготавливаем временну папку для сбора файлов дампа
  if TDirectory.Exists(FArhivPath + TmpArhDir) then
    KillDir(FArhivPath + TmpArhDir);

  TmpCurPath := TDirectory.GetCurrentDirectory;
  ZF := TZipForge.Create(nil);
  try
    //Если есть мусорок подчищием
    if TFile.Exists(FArhivPath + DumpName) then
      TFile.Delete(FArhivPath + DumpName);

    //Задаем текущий директорый, чтобы не создавало дамп абы где
    TDirectory.SetCurrentDirectory(FArhivPath);

    //Запуск создания архива
    WinExecAndWait(BaseToDumpBat, nil, SW_HIDE, 0, TmpWaitResult);
    if (TmpWaitResult <> WAIT_OBJECT_0) or
      not TFile.Exists(FArhivPath + DumpName) then
      //Так-же следовало бы проверить размер получившегося дампа
      raise Exception.Create('Не удалось создать дамп базы данных!');

    //Создаем папку базы и папку приложения в архиве
    TDirectory.CreateDirectory(FArhivPath + TmpArhDir + ArhivBaseDir);
    TDirectory.CreateDirectory(FArhivPath + TmpArhDir + ArhivAppDir);

    try
      //Перемещаем полученый дамп в архив
      TFile.Move(FArhivPath + DumpName,
        FArhivPath + TmpArhDir + ArhivBaseDir + DumpName);
      //копирует в архив приложение
      CopyAppTo(FAppPath, FArhivPath + TmpArhDir + ArhivAppDir);
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
      ZF.BaseDir := FArhivPath + TmpArhDir;
      ZF.AddFiles('*');
      ZF.CloseArchive;
    except
      on e: Exception do
        raise Exception.Create('Ошибка упаковки: ' + e.Message);
    end;
  finally
    FreeAndNil(ZF);
    TDirectory.SetCurrentDirectory(TmpCurPath);

    if TFile.Exists(FArhivPath + DumpName) then
      TFile.Delete(FArhivPath + DumpName);

    if TDirectory.Exists(FArhivPath + TmpArhDir) then
      KillDir(FArhivPath + TmpArhDir);

    Update();
  end;
end;

procedure TBaseAppArhiv.CopyAppTo(const ASourceDir, ADestDir: string);
var i: Integer;
begin
  for i:= Low(AppStructure) to High(AppStructure) do
  begin
    if AppStructure[i].EType = 0 then //Файлы просто копируются
    begin
      if TFile.Exists(ASourceDir + AppStructure[i].EName) then
      begin
        //Позволяет использовать имена файлов типа Dirname\Filename.ext
        ForceDirectories(ExtractFileDir(ASourceDir + AppStructure[i].EName));
        TFile.Copy(ASourceDir + AppStructure[i].EName, ADestDir + AppStructure[i].EName);
      end;
    end;

    if AppStructure[i].EType = 1 then //Файлы просто копируются
    begin
      if TDirectory.Exists(ASourceDir + AppStructure[i].EName) then
      begin
        TDirectory.Copy(ASourceDir + AppStructure[i].EName,
          ADestDir + AppStructure[i].EName);
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
