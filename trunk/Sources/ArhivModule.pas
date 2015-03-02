unit ArhivModule;

interface
uses
  System.Classes, System.SysUtils, System.IOUtils, System.Types, SyncObjs,
  Winapi.Windows, Winapi.Messages, ZipForge;

const
  ArhivLocalDir = 'Arhiv\';
  TmpArhDir = 'Tmp\';
  //������� ������ ������ � ����� � �������
  BaseToDumpBat = '"../sql/mysqldump" -h localhost -u root -pserg --routines ' +
    '--comments --add-drop-database --databases smet�a > all_database';
  DumpToBaseBat = 'From_Dump_all_database.bat';

type
  TBaseAppArhiv = class(TObject)
  private
    FArhivPath: string;
    FArhFiles: TStringDynArray;
  public
    constructor Create(const AArhivPath: string);
    destructor Destroy; override;
    procedure Update();

    procedure RestoreArhiv(const AArhivPath: string);
    procedure CreateNewArhiv();
    property ArhivPath: string read FArhivPath;
    property ArhFiles: TStringDynArray read FArhFiles;
  end;


implementation

uses  Tools;

{ TBaseAppArhiv }

constructor TBaseAppArhiv.Create(const AArhivPath: string);
begin
  if not TDirectory.Exists(AArhivPath) then
    raise Exception.Create('����� ������ ''' +  AArhivPath + ''' �� ����������');

  inherited Create;

  FArhivPath := IncludeTrailingPathDelimiter(AArhivPath);
  SetLength(FArhFiles, 0);
  Update();
end;

destructor TBaseAppArhiv.Destroy;
begin
  SetLength(FArhFiles, 0);
  inherited;
end;

procedure TBaseAppArhiv.RestoreArhiv(const AArhivPath: string);
begin

end;

procedure TBaseAppArhiv.CreateNewArhiv;
var ZF: TZipForge;
    TmpCurPath: string;
    TmpWaitResult: DWord;
    ExitCode: Cardinal;
begin
  if TDirectory.Exists(FArhivPath + TmpArhDir) then
    KillDir(FArhivPath + TmpArhDir);
  TDirectory.CreateDirectory(FArhivPath + TmpArhDir);

  TmpCurPath := TDirectory.GetCurrentDirectory;
  try
    TDirectory.SetCurrentDirectory(FArhivPath);
    WinExecAndWait(BaseToDumpBat, SW_HIDE, 0, TmpWaitResult, ExitCode);
    if TmpWaitResult <> WAIT_OBJECT_0 then
      raise Exception.Create('�� ������� ������� ���� ���� ������!');
  finally
    TDirectory.SetCurrentDirectory(TmpCurPath);
  end;
end;

procedure TBaseAppArhiv.Update();
begin
  FArhFiles := TDirectory.GetFiles(FArhivPath, '*_arh.zip',
    TSearchOption.soTopDirectoryOnly);
end;

end.
