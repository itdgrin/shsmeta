unit NormativDirectory;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Vcl.ComCtrls, JvExComCtrls, JvDBTreeView, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.Grids,
  Vcl.DBGrids, JvExDBGrids, JvDBGrid, Vcl.ExtCtrls{, ShellAPI};

type
  TfNormativDirectory = class(TForm)
    qrMain: TFDQuery;
    dsMain: TDataSource;
    tvMain: TJvDBTreeView;
    grSostav: TJvDBGrid;
    spl1: TSplitter;
    qrDetail: TFDQuery;
    dsDetail: TDataSource;
    procedure FormCreate(Sender: TObject);
    procedure tvMainDblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fNormativDirectory: TfNormativDirectory;

implementation

uses DataModule, Tools;
{$R *.dfm}

procedure TfNormativDirectory.FormCreate(Sender: TObject);
begin
  if dm.Connect.Connected then
  begin
    if not qrMain.Active then
      qrMain.Active := True;
    if not qrDetail.Active then
      qrDetail.Active := True;
  end;
  LoadDBGridSettings(grSostav);
end;

procedure TfNormativDirectory.tvMainDblClick(Sender: TObject);
{var
  NumberNormativ: String;
  FirstChar: Char;
  Path: String; }
begin
  {
  //? NumberNormativ := RateNum;

  // В условии - русские символы, в переменной NumberNormativ - английские
  if (NumberNormativ > 'Е121-1-1') and (NumberNormativ < 'Е121-137-1') then
    NumberNormativ := 'E121_p1'
  else if (NumberNormativ > 'Е121-141-1') and (NumberNormativ < 'Е121-222-2') then
    NumberNormativ := 'E121_p2'
  else if (NumberNormativ > 'Е121-241-1') and (NumberNormativ < 'Е121-439-8') then
    NumberNormativ := 'E121_p3'
  else if (NumberNormativ > 'Е121-451-1') and (NumberNormativ < 'Е121-639-1') then
    NumberNormativ := 'E121_p4'
  else if (NumberNormativ > 'Е29-6-1') and (NumberNormativ < 'Е29-92-12') then
    NumberNormativ := 'E29_p1'
  else if (NumberNormativ > 'Е29-93-1') and (NumberNormativ < 'Е29-277-1') then
    NumberNormativ := 'E29_p2'
  else if (NumberNormativ > 'Е35-9-1') and (NumberNormativ < 'Е35-233-2') then
    NumberNormativ := 'E35_p1'
  else if (NumberNormativ > 'Е35-234-1') and (NumberNormativ < 'Е35-465-1') then
    NumberNormativ := 'E35_p2'
  else if (NumberNormativ > 'Ц12-1-1') and (NumberNormativ < 'Ц12-331-3') then
    NumberNormativ := 'C12_p1'
  else if (NumberNormativ > 'Ц12-362-1') and (NumberNormativ < 'Ц12-1314-10') then
    NumberNormativ := 'C12_p2'
  else if (NumberNormativ > 'Ц13-1-1') and (NumberNormativ < 'Ц13-230-7') then
    NumberNormativ := 'C13_p1'
  else if (NumberNormativ > 'Ц13-250-1') and (NumberNormativ < 'Ц13-383-3') then
    NumberNormativ := 'C13_p2'
  else if (NumberNormativ > 'Ц8-1-1') and (NumberNormativ < 'Ц8-477-1') then
    NumberNormativ := 'C8_p1'
  else if (NumberNormativ > 'Ц8-481-1') and (NumberNormativ < 'Ц8-914-3') then
    NumberNormativ := 'C8_p2'
  else
  begin
    FirstChar := NumberNormativ[1];

    Delete(NumberNormativ, 1, 1);

    // В условии - русские символы, в переменной NumberNormativ - английские
    if FirstChar = 'Е' then
      NumberNormativ := 'E' + NumberNormativ
    else if FirstChar = 'С' then
      NumberNormativ := 'C' + NumberNormativ;

    // Удаляем символы начиная с первого символа '-' и до конца строки
    Delete(NumberNormativ, Pos('-', NumberNormativ), Length(NumberNormativ) - Pos('-', NumberNormativ) + 1);
  end;

  Path := ExtractFilePath(Application.ExeName) + 'Normative documents\' + NumberNormativ + '\data.doc';

  if not FileExists(Path) then
  begin
    MessageBox(0, PChar('Вы пытаетесь открыть файл:' + sLineBreak + sLineBreak + Path + sLineBreak +
      sLineBreak + 'которого не существует!'), '', MB_ICONWARNING + MB_OK + mb_TaskModal);
    Exit;
  end;

  ShellExecute(fNormativDirectory.Handle, nil, PChar(Path), nil, nil, SW_SHOWMAXIMIZED);
  }
end;

end.
