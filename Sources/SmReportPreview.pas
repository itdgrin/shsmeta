unit SmReportPreview;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Tools, Main, DataModule, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Vcl.Grids, Vcl.DBGrids, JvExDBGrids, JvDBGrid, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, SmReportParams, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls;

type
  TfSmReportPreview = class(TSmForm)
    dsMain: TDataSource;
    qrMain: TFDQuery;
    grMain: TJvDBGrid;
    pnlBott: TPanel;
    btnClose: TBitBtn;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
  private
    REPORT_ID: Variant;
  public
  end;

  /// <summary>
  /// Процедура генерации вьюшки отчета
  /// </summary>
  /// <param name="AREPORT_ID">
  /// ID отчета
  /// </param>
  /// <param name="AReportParams">
  /// Форма выбора параметров отчета
  /// </param>
  /// <param name="AOwner">
  /// Контрол для автоматического размешения вьюшки на нем
  /// </param>
  /// <param name="AMDIMode">
  /// Вызов в MDI режиме
  /// </param>
function ShowReport(const AREPORT_ID: Variant; const AReportParams: TfSmReportParams;
  const AOwner: TWinControl = nil; const AMDIMode: Boolean = True): TfSmReportPreview; overload;

/// <summary>
/// Процедура генерации вьюшки отчета
/// </summary>
/// <param name="AREPORT_ID">
/// ID отчета
/// </param>
/// <param name="AReportParams">
/// Вариантный массив Arr[N][0..1]: 0 - название параметра; 1 - значение
/// </param>
/// <param name="AOwner">
/// Контрол для автоматического размешения вьюшки на нем
/// </param>
/// <param name="AMDIMode">
/// Вызов в MDI режиме
/// </param>
function ShowReport(const AREPORT_ID: Variant; const AReportParams: Variant; const AOwner: TWinControl = nil;
  const AMDIMode: Boolean = True): TfSmReportPreview; overload;

implementation

uses SmReportEdit;

{$R *.dfm}

function ShowReport(const AREPORT_ID: Variant; const AReportParams: TfSmReportParams;
  const AOwner: TWinControl = nil; const AMDIMode: Boolean = True): TfSmReportPreview;
var
  f: TfSmReportPreview;
  res: Variant;
  i, j, colId: Integer;
begin
  Result := nil;
  f := TfSmReportPreview.Create(AOwner, AREPORT_ID);
  try
    AReportParams.WriteReportParams(f.qrMain);
    res := BuildReport(f.REPORT_ID);
    if VarIsNull(res) then
    begin
      FreeAndNil(f);
      Exit;
    end;
    f.qrMain.SQL.Text := res[0];
    f.qrMain.Active := True;
    // for i := 0 to f.grMain.Columns.Count - 1 do
    colId := 0;
    for i := 0 to VarArrayHighBound(res[1], 1) do
    begin
      for j := 0 to VarArrayHighBound(res[1][i], 1) do
      begin
        f.grMain.Columns[colId].Title.Caption := (res[1][i])[j][1];
        f.grMain.Columns[colId].Width := res[2][i];
        f.grMain.Columns[colId].Title.Alignment := taCenter;
        f.grMain.Columns[colId].Visible := True;
        Inc(colId);
      end;
    end;

    f.pnlBott.Visible := AOwner = nil;

    if AOwner <> nil then
    begin
      f.Parent := AOwner;
      f.Align := alClient;
      f.BorderStyle := bsNone;
    end
    else
    begin
      if AMDIMode then
        f.FormStyle := fsMDIChild;
      FormMain.CreateButtonOpenWindow(f.Caption, f.Caption, f, 1);
    end;
    f.Show;
    Result := f;
  except
    on e: Exception do
    begin
      MessageBox(0, PChar('При формировании отчета возникла ошибка:' + sLineBreak + sLineBreak + e.Message),
        'Отчеты', MB_ICONERROR + MB_OK + mb_TaskModal);
      FreeAndNil(f);
    end;
  end;
end;

function ShowReport(const AREPORT_ID: Variant; const AReportParams: Variant; const AOwner: TWinControl = nil;
  const AMDIMode: Boolean = True): TfSmReportPreview;
var
  f: TfSmReportPreview;
  res: Variant;
  i, j, colId: Integer;
  ParamName: string;
begin
  Result := nil;
  f := TfSmReportPreview.Create(AOwner, AREPORT_ID);
  try
    for i := VarArrayLowBound(AReportParams, 1) to VarArrayHighBound(AReportParams, 1) do
    begin
      ParamName := VarToStr(AReportParams[i][0]);
      {
        if AQuery.FindParam(ParamName) <> nil then
        AQuery.ParamByName(ParamName).Value := AReportParams[i][1];
      }
      FastExecSQL('SET @' + ParamName + ' = :0;', VarArrayOf([AReportParams[i][1]]));
    end;

    res := BuildReport(f.REPORT_ID);
    if VarIsNull(res) then
    begin
      FreeAndNil(f);
      Exit;
    end;
    f.qrMain.SQL.Text := res[0];
    f.qrMain.Active := True;
    // for i := 0 to f.grMain.Columns.Count - 1 do
    colId := 0;
    for i := 0 to VarArrayHighBound(res[1], 1) do
    begin
      for j := 0 to VarArrayHighBound(res[1][i], 1) do
      begin
        f.grMain.Columns[colId].Title.Caption := (res[1][i])[j][1];
        f.grMain.Columns[colId].Width := res[2][i];
        f.grMain.Columns[colId].Title.Alignment := taCenter;
        f.grMain.Columns[colId].Visible := True;
        Inc(colId);
      end;
    end;

    f.pnlBott.Visible := AOwner = nil;

    if AOwner <> nil then
    begin
      f.Parent := AOwner;
      f.Align := alClient;
      f.BorderStyle := bsNone;
    end
    else
    begin
      if AMDIMode then
        f.FormStyle := fsMDIChild;
      FormMain.CreateButtonOpenWindow(f.Caption, f.Caption, f, 1);
    end;
    f.Show;
    Result := f;
  except
    on e: Exception do
    begin
      MessageBox(0, PChar('При формировании отчета возникла ошибка:' + sLineBreak + sLineBreak + e.Message),
        'Отчеты', MB_ICONERROR + MB_OK + mb_TaskModal);
      FreeAndNil(f);
    end;
  end;
end;

procedure TfSmReportPreview.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TfSmReportPreview.FormActivate(Sender: TObject);
begin
  // Если нажата клавиша Ctrl и выбираем форму, то делаем
  // каскадирование с переносом этой формы на передний план
  FormMain.CascadeForActiveWindow;
  // Делаем нажатой кнопку активной формы (на главной форме внизу)
  FormMain.SelectButtonActiveWindow(Self);
end;

procedure TfSmReportPreview.FormDestroy(Sender: TObject);
begin
  // Удаляем кнопку от этого окна (на главной форме внизу)
  FormMain.DeleteButtonCloseWindow(Self);
end;

procedure TfSmReportPreview.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  qrMain.Active := False;
  Action := caFree;
end;

procedure TfSmReportPreview.FormCreate(Sender: TObject);
var
  cnt: Integer;
begin
  cnt := 0;
  REPORT_ID := InitParams;
  Caption := FastSelectSQLOne('SELECT REPORT_NAME FROM REPORT WHERE REPORT_ID=:0', VarArrayOf([REPORT_ID])) +
    IIF(cnt > 1, '(' + IntToStr(cnt) + ')', '');
end;

end.
