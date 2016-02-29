unit fSprLoader;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  System.IOUtils,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  System.Actions,
  Vcl.ActnList,
  Vcl.Menus,
  Vcl.StdActns,
  Vcl.StdCtrls,
  Vcl.ImgList,
  Vcl.ExtCtrls,
  Vcl.ComCtrls,
  ComObj,
  ActiveX,
  Vcl.Samples.Spin,
  Data.DB;

type
  TSprLoaderForm = class(TForm)
    MainMenu: TMainMenu;
    ActionList: TActionList;
    actClose: TAction;
    pmFile: TMenuItem;
    pmExit: TMenuItem;
    pcMain: TPageControl;
    tsMaterial: TTabSheet;
    tsMechanism: TTabSheet;
    tsTransp: TTabSheet;
    pnlUpdMat: TPanel;
    pnlUpdMatPrice: TPanel;
    pnlUpdMatNoTrans: TPanel;
    btnUpdMat: TButton;
    edtUpdMat: TButtonedEdit;
    ImageList: TImageList;
    lbUpdMatTitle: TLabel;
    lbUpdMatNoTransTitle: TLabel;
    edtUpdMatNoTrans: TButtonedEdit;
    btnUpdMatNoTrans: TButton;
    lbUpdMatPriceTitle: TLabel;
    edtUpdMatPrice: TButtonedEdit;
    btnUpdMatPrice: TButton;
    pnlUpdJBI: TPanel;
    lbUpdJBITitle: TLabel;
    edtUpdJBI: TButtonedEdit;
    btnUpdJBI: TButton;
    OpenDialog: TOpenDialog;
    actUpdMat: TAction;
    actUpdJBI: TAction;
    actUpdMatNoPrice: TAction;
    actUpdMatPrice: TAction;
    cbMonthMat: TComboBox;
    edtYearMat: TSpinEdit;
    pnlUpdMatNoPrice: TPanel;
    lbUpdMatNoPriceTitle: TLabel;
    edtUpdMatNoPrice: TButtonedEdit;
    btnUpdMatNoPrice: TButton;
    actUpdMatNoTrans: TAction;
    cbMonthMatNoPrice: TComboBox;
    edtYearMatNoPrice: TSpinEdit;
    cbMonthMatPrice: TComboBox;
    edtYearMatPrice: TSpinEdit;
    cbMonthJBI: TComboBox;
    edtYearJBI: TSpinEdit;
    cboxUpdMatName: TCheckBox;
    cboxUpdJBIName: TCheckBox;
    pnlUpdMech: TPanel;
    lbUpdMechTitle: TLabel;
    edtUpdMech: TButtonedEdit;
    btnUpdMech: TButton;
    cbMonthMech: TComboBox;
    edtYearMech: TSpinEdit;
    cboxUpdMechName: TCheckBox;
    btnClearMechPrice: TButton;
    actUpdMech: TAction;
    actClearMechPrice: TAction;
    pnlUpdCargoBoard: TPanel;
    lbpnlUpdCargoBoardTitle: TLabel;
    btnUpdCargoBoard: TButton;
    edtUpdCargoBoard: TButtonedEdit;
    cbMonthCargoBoard: TComboBox;
    edtYearCargoBoard: TSpinEdit;
    actUpdCargoBoard: TAction;
    pnlUpdTransKoef: TPanel;
    lbUpdTransKoefTitle: TLabel;
    btnUpdTransKoef: TButton;
    edtUpdTransKoef: TButtonedEdit;
    cbMonthTransKoef: TComboBox;
    edtYearTransKoef: TSpinEdit;
    actUpdTransKoef: TAction;
    pnlUpdDump: TPanel;
    lbUpdDumpTitle: TLabel;
    btnUpdDump: TButton;
    edtUpdDump: TButtonedEdit;
    cbMonthDump: TComboBox;
    edtYearDump: TSpinEdit;
    actUpdDump: TAction;
    pnlUpdCargo: TPanel;
    lbUpdCargoTitle: TLabel;
    btnUpdCargo: TButton;
    edtUpdCargo: TButtonedEdit;
    cbMonthCargo: TComboBox;
    edtYearCargo: TSpinEdit;
    actUpdCargo: TAction;
    pnlUpdTarif: TPanel;
    lbUpdTarifTitle: TLabel;
    btnUpdTarif: TButton;
    edtUpdTarif: TButtonedEdit;
    cbMonthTarif: TComboBox;
    edtYearTarif: TSpinEdit;
    actUpdTarif: TAction;
    procedure actCloseExecute(Sender: TObject);
    procedure edtRightButtonClick(Sender: TObject);
    procedure actUpdMatExecute(Sender: TObject);
    procedure actUpdJBIExecute(Sender: TObject);
    procedure actUpdMatNoPriceExecute(Sender: TObject);
    procedure actUpdMatPriceExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure actUpdMatNoTransExecute(Sender: TObject);
    procedure actClearMechPriceExecute(Sender: TObject);
    procedure actUpdMechExecute(Sender: TObject);
    procedure actUpdCargoBoardExecute(Sender: TObject);
    procedure actUpdTransKoefExecute(Sender: TObject);
    procedure actUpdDumpExecute(Sender: TObject);
    procedure actUpdCargoExecute(Sender: TObject);
    procedure actUpdTarifExecute(Sender: TObject);
  private
    FUnitsName, FUnitsID: TStringList;
    procedure ChackFileExsist(const AFileName: string);
    procedure LoadUnits();
    function AddNewUnit(AUnitName: string): Integer;
    function AddNewMat(ACode, AName, AUnit: string; ADate: TDateTime;
      AJBI, ANoUpdate: Boolean): Integer;
    function AddNewMech(ACode, AName: string; ADate: TDateTime; ANoUpdate: Boolean): Integer;
    function AddNewDump(AName, AUnit: string; ACode, OblID: Integer; ANoUpdate: Boolean): Integer;
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses DataModule, GlobsAndConst;

procedure TSprLoaderForm.actClearMechPriceExecute(Sender: TObject);
begin
  if Application.MessageBox(
    PChar('Очистить цены механизмов за ' + cbMonthMech.Text + ' ' +
    edtYearMech.Value.ToString + '?'),
    'Загрузка данных', MB_OKCANCEL + MB_ICONQUESTION) = mrCancel then
    Exit;

  DM.qrDifferent.SQL.Text :=
    'Delete from mechanizmcoastg where (YEAR = :YEAR) and (MONAT = :MONAT)';
  DM.qrDifferent.ParamByName('YEAR').Value := edtYearMech.Value;
  DM.qrDifferent.ParamByName('MONAT').Value := cbMonthMech.ItemIndex + 1;
  DM.qrDifferent.ExecSQL;

  ShowMessage('Выполнено успешно.');
end;

procedure TSprLoaderForm.actCloseExecute(Sender: TObject);
begin
  Close;
end;

procedure TSprLoaderForm.edtRightButtonClick(Sender: TObject);
begin
  if OpenDialog.Execute(Self.Handle) then
    (Sender as  TButtonedEdit).Text := OpenDialog.FileName;
end;

procedure TSprLoaderForm.FormCreate(Sender: TObject);
var Y, M, D: Word;
    I: Integer;
begin
  FUnitsName := TStringList.Create;
  FUnitsID := TStringList.Create;

  cbMonthMat.Clear;
  cbMonthMatNoPrice.Clear;
  for I := Low(arraymes) to High(arraymes) do
  begin
    cbMonthMat.Items.Add(arraymes[I][1]);
    cbMonthMatNoPrice.Items.Add(arraymes[I][1]);
    cbMonthMatPrice.Items.Add(arraymes[I][1]);
    cbMonthJBI.Items.Add(arraymes[I][1]);
    cbMonthMech.Items.Add(arraymes[I][1]);
    cbMonthCargo.Items.Add(arraymes[I][1]);
    cbMonthCargoBoard.Items.Add(arraymes[I][1]);
    cbMonthTransKoef.Items.Add(arraymes[I][1]);
    cbMonthTarif.Items.Add(arraymes[I][1]);
    cbMonthDump.Items.Add(arraymes[I][1]);
  end;

  DecodeDate(Date, Y, M, D);
  cbMonthMat.ItemIndex := M - 1;
  edtYearMat.Value := Y;
  cbMonthMatNoPrice.ItemIndex := M - 1;
  edtYearMatNoPrice.Value := Y;
  cbMonthMatPrice.ItemIndex := M - 1;
  edtYearMatPrice.Value := Y;
  cbMonthJBI.ItemIndex := M - 1;
  edtYearJBI.Value := Y;
  cbMonthMech.ItemIndex := M - 1;
  edtYearMech.Value := Y;
  cbMonthCargo.ItemIndex := M - 1;
  edtYearCargo.Value := Y;
  cbMonthCargoBoard.ItemIndex := M - 1;
  edtYearCargoBoard.Value := Y;
  cbMonthTransKoef.ItemIndex := M - 1;
  edtYearTransKoef.Value := Y;
  cbMonthTarif.ItemIndex := M - 1;
  edtYearTarif.Value := Y;
  cbMonthDump.ItemIndex := M - 1;
  edtYearDump.Value := Y;
end;

procedure TSprLoaderForm.FormDestroy(Sender: TObject);
begin
  FreeAndNil(FUnitsName);
  FreeAndNil(FUnitsID);
end;

procedure TSprLoaderForm.FormShow(Sender: TObject);
var TmpStr: string;
begin
  if not DM.Connect.Connected then
  begin
    TmpStr :=
      StringReplace(G_CONNECTSTR, 'xxx', 'localhost', [rfReplaceAll, rfIgnoreCase]);
    DM.Connect.Params.Text := TmpStr;
    try
      DM.Connect.Connected := true;
    except
      on e: exception do
        Application.ShowException(e);
    end;
  end;
end;

procedure TSprLoaderForm.LoadUnits;
begin
  FUnitsName.Clear;
  FUnitsID.Clear;
  DM.qrDifferent.SQL.Text :=
    'Select UNIT_ID, UNIT_NAME from units order by UNIT_ID';
  DM.qrDifferent.Active := True;
  try
    while not DM.qrDifferent.Eof do
    begin
      FUnitsID.Add(IntToStr(DM.qrDifferent.Fields[0].AsInteger));
      FUnitsName.Add(Trim(DM.qrDifferent.Fields[1].AsString).ToLower);
      DM.qrDifferent.Next;
    end;
  finally
    DM.qrDifferent.Active := False;
  end;
end;

function TSprLoaderForm.AddNewUnit(AUnitName: string): Integer;
var NextID: Integer;
begin
  NextID := 1;
  if FUnitsID.Count > 0 then
    NextID := StrToIntDef(FUnitsID[FUnitsID.Count - 1], 0) + 1;

  DM.qrDifferent.SQL.Text :=
    'Insert into units (UNIT_ID, UNIT_NAME, BASE) values (:ID, :NAME, 0)';
  DM.qrDifferent.ParamByName('ID').Value := NextID;
  DM.qrDifferent.ParamByName('NAME').Value := AUnitName;
  DM.qrDifferent.ExecSQL;

  FUnitsID.Add(IntToStr(NextID));
  FUnitsName.Add(AUnitName.ToLower);
  Result := NextID;
end;

procedure TSprLoaderForm.actUpdCargoBoardExecute(Sender: TObject);
var ExlApp,
    WorkSheet1,
    WorkSheet2: OleVariant;
    FData,
    FDataPriceNDS,
    FDataPriceNoNDS: OleVariant;
    I, J,
    Rows1, Rows2: Integer;
    TmpDistance: string;
    AutoCommitValue: Boolean;
begin
  if Application.MessageBox(
    PChar('Загрузить данные из ''' + edtUpdCargoBoard.Text + ''' в справочник ' +
      'тарифов на перевозку бортовыми автомобилями?' +
    sLineBreak + 'Старые тарифы за ' + cbMonthCargoBoard.Text + ' ' +
    edtYearCargoBoard.Value.ToString + ' будут удалены.'),
    'Загрузка данных', MB_OKCANCEL + MB_ICONQUESTION) = mrCancel then
    Exit;
  ChackFileExsist(edtUpdCargoBoard.Text);

  CoInitialize(nil);
  AutoCommitValue := DM.Read.Options.AutoCommit;
  DM.Read.Options.AutoCommit := False;
  J := 0;
  try
    Screen.Cursor := crHourGlass;
    ExlApp := Unassigned;
    try
      ExlApp := CreateOleObject('Excel.Application');
      ExlApp.Visible:=false;
      ExlApp.DisplayAlerts := False;
    except
      on e: exception do
        raise Exception.Create('Ошибка инициализации Excel:' + e.Message);
    end;

    try
      ExlApp.WorkBooks.Open(edtUpdCargoBoard.Text);
      WorkSheet1 := ExlApp.ActiveWorkbook.Sheets.Item[1];
      WorkSheet2 := ExlApp.ActiveWorkbook.Sheets.Item[2];
    except
      on e: exception do
        raise Exception.Create('Ошибка открытия Excel документа:' + e.Message);
    end;

    Rows1 := WorkSheet1.UsedRange.Rows.Count;
    Rows2 := WorkSheet2.UsedRange.Rows.Count;

    if Rows2 <> Rows1 then
      raise Exception.Create('Таблицы с НДС и без НДС разной длинны.');

    FData :=
      WorkSheet1.Range[WorkSheet1.Cells[8, 1].Address,
      WorkSheet1.Cells[Rows1, 1].Address].Value;

    FDataPriceNoNDS :=
      WorkSheet1.Range[WorkSheet1.Cells[8, 2].Address,
      WorkSheet1.Cells[Rows1, 5].Address].Value;

    FDataPriceNDS :=
      WorkSheet2.Range[WorkSheet2.Cells[8, 2].Address,
      WorkSheet2.Cells[Rows1, 5].Address].Value;

    DM.Read.StartTransaction;
    try
      DM.qrDifferent.SQL.Text :=
        'Delete from transfercargoboard where (YEAR = :YEAR) and (MONAT = :MONAT)';
      DM.qrDifferent.ParamByName('YEAR').Value := edtYearCargoBoard.Value;
      DM.qrDifferent.ParamByName('MONAT').Value := cbMonthCargoBoard.ItemIndex + 1;
      DM.qrDifferent.ExecSQL;

      DM.qrDifferent1.SQL.Text :=
        'Insert into transfercargoboard ' +
        '(`YEAR`, `MONAT`, `DISTANCE`, CLASS1_1, CLASS1_2, CLASS2_1, ' +
        'CLASS2_2, CLASS3_1, CLASS3_2, CLASS4_1, CLASS4_2, SORT) ' +
        'values ' +
        '(:YEAR, :MONAT, :DISTANCE, :CLASS1_1, :CLASS1_2, :CLASS2_1, ' +
        ':CLASS2_2, :CLASS3_1, :CLASS3_2, :CLASS4_1, :CLASS4_2, :SORT)';

      for I := 1 to Rows1 - 7 do
      begin
        J := I;
        TmpDistance := trim(VarToStr(FData[I,1]));

        if (TmpDistance <> '') then
        begin
          DM.qrDifferent1.ParamByName('YEAR').Value := edtYearCargoBoard.Value;
          DM.qrDifferent1.ParamByName('MONAT').Value := cbMonthCargoBoard.ItemIndex + 1;
          DM.qrDifferent1.ParamByName('DISTANCE').Value := TmpDistance;
          DM.qrDifferent1.ParamByName('CLASS1_1').Value := FDataPriceNoNDS[I,1];
          DM.qrDifferent1.ParamByName('CLASS1_2').Value := FDataPriceNDS[I,1];
          DM.qrDifferent1.ParamByName('CLASS2_1').Value := FDataPriceNoNDS[I,2];
          DM.qrDifferent1.ParamByName('CLASS2_2').Value := FDataPriceNDS[I,2];
          DM.qrDifferent1.ParamByName('CLASS3_1').Value := FDataPriceNoNDS[I,3];
          DM.qrDifferent1.ParamByName('CLASS3_2').Value := FDataPriceNDS[I,3];
          DM.qrDifferent1.ParamByName('CLASS4_1').Value := FDataPriceNoNDS[I,4];
          DM.qrDifferent1.ParamByName('CLASS4_2').Value := FDataPriceNDS[I,4];
          DM.qrDifferent1.ParamByName('SORT').Value := J;
          DM.qrDifferent1.ExecSQL;
        end;
      end;
      DM.Read.Commit;
      ShowMessage('Загрузка успешно завершена.');
    except
      on e: Exception do
      begin
        DM.Read.Rollback;
        raise Exception.Create('Ошибка на строке ' + (J + 7).ToString + ':' +
          sLineBreak + e.Message);
      end;
    end;
  finally
    DM.Read.Options.AutoCommit := AutoCommitValue;
    if not VarIsEmpty(ExlApp) then
    begin
      ExlApp.ActiveWorkbook.Close;
      ExlApp.Quit;
    end;
    Screen.Cursor := crDefault;
    WorkSheet1 := Unassigned;
    WorkSheet2 := Unassigned;
    ExlApp := Unassigned;
    CoUninitialize;
  end;
end;

procedure TSprLoaderForm.actUpdCargoExecute(Sender: TObject);
var ExlApp,
    WorkSheet1,
    WorkSheet2: OleVariant;
    FData,
    FDataPriceNDS,
    FDataPriceNoNDS: OleVariant;
    I, J,
    Rows1, Rows2: Integer;
    TmpDistance: string;
    AutoCommitValue: Boolean;
begin
  if Application.MessageBox(
    PChar('Загрузить данные из ''' + edtUpdCargo.Text + ''' в справочник ' +
      'тарифов на перевозку грузов автомобилями-самосвалами?' +
    sLineBreak + 'Старые тарифы за ' + cbMonthCargo.Text + ' ' +
    edtYearCargo.Value.ToString + ' будут удалены.'),
    'Загрузка данных', MB_OKCANCEL + MB_ICONQUESTION) = mrCancel then
    Exit;
  ChackFileExsist(edtUpdCargo.Text);

  CoInitialize(nil);
  AutoCommitValue := DM.Read.Options.AutoCommit;
  DM.Read.Options.AutoCommit := False;
  J := 0;
  try
    Screen.Cursor := crHourGlass;
    ExlApp := Unassigned;
    try
      ExlApp := CreateOleObject('Excel.Application');
      ExlApp.Visible:=false;
      ExlApp.DisplayAlerts := False;
    except
      on e: exception do
        raise Exception.Create('Ошибка инициализации Excel:' + e.Message);
    end;

    try
      ExlApp.WorkBooks.Open(edtUpdCargo.Text);
      WorkSheet1 := ExlApp.ActiveWorkbook.Sheets.Item[1];
      WorkSheet2 := ExlApp.ActiveWorkbook.Sheets.Item[2];
    except
      on e: exception do
        raise Exception.Create('Ошибка открытия Excel документа:' + e.Message);
    end;

    Rows1 := WorkSheet1.UsedRange.Rows.Count;
    Rows2 := WorkSheet2.UsedRange.Rows.Count;

    if Rows2 <> Rows1 then
      raise Exception.Create('Таблицы с НДС и без НДС разной длинны.');

    FData :=
      WorkSheet1.Range[WorkSheet1.Cells[8, 1].Address,
      WorkSheet1.Cells[Rows1, 1].Address].Value;

    FDataPriceNoNDS :=
      WorkSheet1.Range[WorkSheet1.Cells[8, 2].Address,
      WorkSheet1.Cells[Rows1, 5].Address].Value;

    FDataPriceNDS :=
      WorkSheet2.Range[WorkSheet2.Cells[8, 2].Address,
      WorkSheet2.Cells[Rows1, 5].Address].Value;

    DM.Read.StartTransaction;
    try
      DM.qrDifferent.SQL.Text :=
        'Delete from transfercargo where (YEAR = :YEAR) and (MONAT = :MONAT)';
      DM.qrDifferent.ParamByName('YEAR').Value := edtYearCargo.Value;
      DM.qrDifferent.ParamByName('MONAT').Value := cbMonthCargo.ItemIndex + 1;
      DM.qrDifferent.ExecSQL;

      DM.qrDifferent1.SQL.Text :=
        'Insert into transfercargo ' +
        '(`YEAR`, `MONAT`, `DISTANCE`, CLASS1_1, CLASS1_2, CLASS2_1, ' +
        'CLASS2_2, CLASS3_1, CLASS3_2, CLASS4_1, CLASS4_2, SORT) ' +
        'values ' +
        '(:YEAR, :MONAT, :DISTANCE, :CLASS1_1, :CLASS1_2, :CLASS2_1, ' +
        ':CLASS2_2, :CLASS3_1, :CLASS3_2, :CLASS4_1, :CLASS4_2, :SORT)';

      for I := 1 to Rows1 - 7 do
      begin
        J := I;
        TmpDistance := trim(VarToStr(FData[I,1]));

        if (TmpDistance <> '') then
        begin
          DM.qrDifferent1.ParamByName('YEAR').Value := edtYearCargo.Value;
          DM.qrDifferent1.ParamByName('MONAT').Value := cbMonthCargo.ItemIndex + 1;
          DM.qrDifferent1.ParamByName('DISTANCE').Value := TmpDistance;
          DM.qrDifferent1.ParamByName('CLASS1_1').Value := FDataPriceNoNDS[I,1];
          DM.qrDifferent1.ParamByName('CLASS1_2').Value := FDataPriceNDS[I,1];
          DM.qrDifferent1.ParamByName('CLASS2_1').Value := FDataPriceNoNDS[I,2];
          DM.qrDifferent1.ParamByName('CLASS2_2').Value := FDataPriceNDS[I,2];
          DM.qrDifferent1.ParamByName('CLASS3_1').Value := FDataPriceNoNDS[I,3];
          DM.qrDifferent1.ParamByName('CLASS3_2').Value := FDataPriceNDS[I,3];
          DM.qrDifferent1.ParamByName('CLASS4_1').Value := FDataPriceNoNDS[I,4];
          DM.qrDifferent1.ParamByName('CLASS4_2').Value := FDataPriceNDS[I,4];
          DM.qrDifferent1.ParamByName('SORT').Value := J;
          DM.qrDifferent1.ExecSQL;
        end;
      end;
      DM.Read.Commit;
      ShowMessage('Загрузка успешно завершена.');
    except
      on e: Exception do
      begin
        DM.Read.Rollback;
        raise Exception.Create('Ошибка на строке ' + (J + 7).ToString + ':' +
          sLineBreak + e.Message);
      end;
    end;
  finally
    DM.Read.Options.AutoCommit := AutoCommitValue;
    if not VarIsEmpty(ExlApp) then
    begin
      ExlApp.ActiveWorkbook.Close;
      ExlApp.Quit;
    end;
    Screen.Cursor := crDefault;
    WorkSheet1 := Unassigned;
    WorkSheet2 := Unassigned;
    ExlApp := Unassigned;
    CoUninitialize;
  end;
end;

procedure TSprLoaderForm.actUpdDumpExecute(Sender: TObject);
var ExlApp,
    WorkSheet: OleVariant;
    FData: OleVariant;
    I, Rows: Integer;
    OblName,
    DumpName,
    UnitName: string;
    OblID,
    DumpID,
    TmpCode: Integer;
    TmpDate: TDateTime;

    AutoCommitValue: Boolean;
begin
  if Application.MessageBox(
    PChar('Загрузить данные из ''' + edtUpdDump.Text + ''' в справочник ' +
      'тарифов на прием и захоранение отходов?' +
    sLineBreak + 'Старые тарифы за ' + cbMonthDump.Text + ' ' +
    edtYearDump.Value.ToString + ' будут удалены.'),
    'Загрузка данных', MB_OKCANCEL + MB_ICONQUESTION) = mrCancel then
    Exit;
  ChackFileExsist(edtUpdDump.Text);

  TmpDate := EncodeDate(edtYearDump.Value, cbMonthDump.ItemIndex + 1, 1);
  LoadUnits;

  CoInitialize(nil);
  AutoCommitValue := DM.Read.Options.AutoCommit;
  DM.Read.Options.AutoCommit := False;
  try
    Screen.Cursor := crHourGlass;
    ExlApp := Unassigned;
    try
      ExlApp := CreateOleObject('Excel.Application');
      ExlApp.Visible:=false;
      ExlApp.DisplayAlerts := False;
    except
      on e: exception do
        raise Exception.Create('Ошибка инициализации Excel:' + e.Message);
    end;

    try
      ExlApp.WorkBooks.Open(edtUpdDump.Text);
      WorkSheet := ExlApp.ActiveWorkbook.ActiveSheet;
    except
      on e: exception do
        raise Exception.Create('Ошибка открытия Excel документа:' + e.Message);
    end;

    Rows := WorkSheet.UsedRange.Rows.Count;

    FData :=
      WorkSheet.Range[WorkSheet.Cells[9, 1].Address,
      WorkSheet.Cells[Rows, 5].Address].Value;

    DM.Read.StartTransaction;
    try
      DM.qrDifferent1.SQL.Text :=
        'Delete from dumpcoast where (DATE_BEG = :DATE_BEG)';
      DM.qrDifferent1.ParamByName('DATE_BEG').Value := TmpDate;
      DM.qrDifferent1.ExecSQL;

      DM.qrDifferent1.SQL.Text :=
        'Insert into dumpcoast (`DUMP_ID`, `DATE_BEG`, `COAST1`, `COAST2`) ' +
        'values (:DUMP_ID, :DATE_BEG, :COAST1, :COAST2)';

      OblName := '';
      OblID := 0;
      for I := 1 to Rows - 8 do
      begin
        if trim(VarToStr(FData[I,3])) = '' then  //Если нет цены то ожидается что это строчка облости
        begin
          OblName := trim(VarToStr(FData[I,2])).ToLower;
          if OblName = 'брестская область' then
            OblID := 1
          else if OblName = 'витебская область' then
            OblID := 2
          else if OblName = 'гомельская область' then
            OblID := 3
          else if OblName = 'гродненская область' then
            OblID := 4
          else if OblName = 'минская область' then
            OblID := 5
          else if OblName = 'могилевская область' then
            OblID := 6
          else if OblName = 'город минск' then
            OblID := 7
          else
            raise Exception.Create('Неизвестная область');
          Continue;
        end;

        TmpCode := StrToIntDef(VarToStr(FData[I,1]), 0);
        DumpName := trim(VarToStr(FData[I,2]));
        UnitName := trim(VarToStr(FData[I,3]));

        DumpID := AddNewDump(DumpName, UnitName, TmpCode, OblID, False);
        DM.qrDifferent1.ParamByName('DUMP_ID').Value := DumpID;
        DM.qrDifferent1.ParamByName('DATE_BEG').Value := TmpDate;
        DM.qrDifferent1.ParamByName('COAST1').Value := FData[I,4];
        DM.qrDifferent1.ParamByName('COAST2').Value := FData[I,5];
        DM.qrDifferent1.ExecSQL;
      end;
      DM.Read.Commit;
      ShowMessage('Загрузка успешно завершена.');
    except
      DM.Read.Rollback;
      raise;
    end;
  finally
    DM.Read.Options.AutoCommit := AutoCommitValue;
    if not VarIsEmpty(ExlApp) then
    begin
      ExlApp.ActiveWorkbook.Close;
      ExlApp.Quit;
    end;
    Screen.Cursor := crDefault;
    WorkSheet := Unassigned;
    ExlApp := Unassigned;
    CoUninitialize;
  end;
end;

procedure TSprLoaderForm.actUpdJBIExecute(Sender: TObject);
var ExlApp,
    WorkSheet1,
    WorkSheet2: OleVariant;
    FData,
    FDataPriceNDS,
    FDataPriceNoNDS: OleVariant;
    I, J,
    Rows1, Rows2: Integer;
    TmpCode,
    TmpName,
    TmpUnit: string;
    TmpMatID: Integer;

    TmpDate: TDateTime;
    AutoCommitValue: Boolean;
    GroupStr: string;
begin
  if Application.MessageBox(
    PChar('Загрузить данные из ''' + edtUpdJBI.Text + ''' в справочник цен ЖБИ?' +
    sLineBreak + 'Старые цены за ' + cbMonthJBI.Text + ' ' +
    edtYearJBI.Value.ToString + ' будут удалены.'),
    'Загрузка данных', MB_OKCANCEL + MB_ICONQUESTION) = mrCancel then
    Exit;
  ChackFileExsist(edtUpdJBI.Text);

  TmpDate := EncodeDate(edtYearJBI.Value, cbMonthJBI.ItemIndex + 1, 1);
  LoadUnits;
  CoInitialize(nil);
  AutoCommitValue := DM.Read.Options.AutoCommit;
  DM.Read.Options.AutoCommit := False;
  J := 0;
  try
    Screen.Cursor := crHourGlass;
    ExlApp := Unassigned;
    try
      ExlApp := CreateOleObject('Excel.Application');
      ExlApp.Visible:=false;
      ExlApp.DisplayAlerts := False;
    except
      on e: exception do
        raise Exception.Create('Ошибка инициализации Excel:' + e.Message);
    end;

    try
      ExlApp.WorkBooks.Open(edtUpdJBI.Text);
      WorkSheet1 := ExlApp.ActiveWorkbook.Sheets.Item[1];
      WorkSheet2 := ExlApp.ActiveWorkbook.Sheets.Item[2];
    except
      on e: exception do
        raise Exception.Create('Ошибка открытия Excel документа:' + e.Message);
    end;

    Rows1 := WorkSheet1.UsedRange.Rows.Count;
    Rows2 := WorkSheet2.UsedRange.Rows.Count;

    if Rows2 <> Rows1 then
      raise Exception.Create('Таблицы с НДС и без НДС разной длинны.');

    FData :=
      WorkSheet1.Range[WorkSheet1.Cells[9, 1].Address,
      WorkSheet1.Cells[Rows1, 3].Address].Value;

    FDataPriceNoNDS :=
      WorkSheet1.Range[WorkSheet1.Cells[9, 4].Address,
      WorkSheet1.Cells[Rows1, 10].Address].Value;

    FDataPriceNDS :=
      WorkSheet2.Range[WorkSheet2.Cells[9, 4].Address,
      WorkSheet2.Cells[Rows1, 10].Address].Value;

    DM.Read.StartTransaction;
    try
      DM.qrDifferent.SQL.Text :=
        'Delete from materialcoastg where (YEAR = :YEAR) and (MONAT = :MONAT) and ' +
        '(MATERIAL_ID in (Select MATERIAL_ID from material where MAT_TYPE = 2))';
      DM.qrDifferent.ParamByName('YEAR').Value := edtYearJBI.Value;
      DM.qrDifferent.ParamByName('MONAT').Value := cbMonthJBI.ItemIndex + 1;
      DM.qrDifferent.ExecSQL;

      DM.qrDifferent1.SQL.Text :=
        'Insert into materialcoastg ' +
        '(MATERIAL_ID, `YEAR`, `MONAT`, COAST1_1, COAST1_2, COAST2_1, COAST2_2, ' +
        'COAST3_1, COAST3_2, COAST4_1, COAST4_2, COAST5_1, COAST5_2, ' +
        'COAST6_1, COAST6_2, COAST7_1, COAST7_2) ' +
        'values ' +
        '(:MATERIAL_ID, :YEAR, :MONAT, :COAST1_1, :COAST1_2, :COAST2_1, :COAST2_2, ' +
        ':COAST3_1, :COAST3_2, :COAST4_1, :COAST4_2, :COAST5_1, :COAST5_2, ' +
        ':COAST6_1, :COAST6_2, :COAST7_1, :COAST7_2)';

      GroupStr := '';
      for I := 1 to Rows1 - 8 do
      begin
        J := I;
        TmpCode := trim(VarToStr(FData[I,1]));
        TmpName := trim(VarToStr(FData[I,2]));
        TmpUnit := trim(VarToStr(FData[I,3]));

        if (TmpCode <> '') then
        begin
          TmpMatID :=
            AddNewMat(TmpCode, Trim(GroupStr + ' ' + TmpName), TmpUnit, TmpDate,
              True, not cboxUpdJBIName.Checked);

          DM.qrDifferent1.ParamByName('MATERIAL_ID').Value := TmpMatID;
          DM.qrDifferent1.ParamByName('YEAR').Value := edtYearJBI.Value;
          DM.qrDifferent1.ParamByName('MONAT').Value := cbMonthJBI.ItemIndex + 1;
          DM.qrDifferent1.ParamByName('COAST1_1').Value := FDataPriceNoNDS[I,1];
          DM.qrDifferent1.ParamByName('COAST1_2').Value := FDataPriceNDS[I,1];
          DM.qrDifferent1.ParamByName('COAST2_1').Value := FDataPriceNoNDS[I,2];
          DM.qrDifferent1.ParamByName('COAST2_2').Value := FDataPriceNDS[I,2];
          DM.qrDifferent1.ParamByName('COAST3_1').Value := FDataPriceNoNDS[I,3];
          DM.qrDifferent1.ParamByName('COAST3_2').Value := FDataPriceNDS[I,3];
          DM.qrDifferent1.ParamByName('COAST4_1').Value := FDataPriceNoNDS[I,4];
          DM.qrDifferent1.ParamByName('COAST4_2').Value := FDataPriceNDS[I,4];
          DM.qrDifferent1.ParamByName('COAST5_1').Value := FDataPriceNoNDS[I,5];
          DM.qrDifferent1.ParamByName('COAST5_2').Value := FDataPriceNDS[I,5];
          DM.qrDifferent1.ParamByName('COAST6_1').Value := FDataPriceNoNDS[I,6];
          DM.qrDifferent1.ParamByName('COAST6_2').Value := FDataPriceNDS[I,6];
          DM.qrDifferent1.ParamByName('COAST7_1').Value := FDataPriceNoNDS[I,7];
          DM.qrDifferent1.ParamByName('COAST7_2').Value := FDataPriceNDS[I,7];
          DM.qrDifferent1.ExecSQL;
        end
        else
          if TmpName <> '' then
            GroupStr := TmpName;
      end;
      DM.Read.Commit;
      ShowMessage('Загрузка успешно завершена.');
    except
      on e: Exception do
      begin
        DM.Read.Rollback;
        raise Exception.Create('Ошибка на строке ' + (J + 8).ToString + ':' +
          sLineBreak + e.Message);
      end;
    end;
  finally
    DM.Read.Options.AutoCommit := AutoCommitValue;
    if not VarIsEmpty(ExlApp) then
    begin
      ExlApp.ActiveWorkbook.Close;
      ExlApp.Quit;
    end;
    Screen.Cursor := crDefault;
    WorkSheet1 := Unassigned;
    WorkSheet2 := Unassigned;
    ExlApp := Unassigned;
    CoUninitialize;
  end;
end;

function TSprLoaderForm.AddNewMech(ACode, AName: string; ADate: TDateTime;
  ANoUpdate: Boolean): Integer;
begin
  //Проверяет есть ли такой уже в базе
  DM.qrDifferent.SQL.Text :=
    'Select MECHANIZM_ID from mechanizm where (MECH_CODE = :MECH_CODE) and (BASE = 0)';
  Result := -1;
  DM.qrDifferent.ParamByName('MECH_CODE').Value := ACode;
  DM.qrDifferent.Active := True;
  try
    if not DM.qrDifferent.IsEmpty then
      Result := DM.qrDifferent.Fields[0].AsInteger;
  finally
    DM.qrDifferent.Active := False;
  end;

  if Result = -1 then
  begin
    DM.qrDifferent.SQL.Text := 'Select GetNewSprID(:TypeID, 0)';
    DM.qrDifferent.ParamByName('TypeID').Value := C_MANID_MECH;
    DM.qrDifferent.Active := True;
    try
      Result := DM.qrDifferent.Fields[0].AsInteger;
    finally
      DM.qrDifferent.Active := False;
    end;

    DM.qrDifferent.SQL.Text :=
      'Insert into mechanizm ' +
      '(MECHANIZM_ID, MECH_CODE, MECH_NAME, UNIT_ID) ' +
      'values ' +
      '(:MECHANIZM_ID, :MECH_CODE, :MECH_NAME, :UNIT_ID)';
    DM.qrDifferent.ParamByName('MECH_CODE').Value := ACode;
    DM.qrDifferent.ParamByName('MECH_NAME').Value := AName;
    DM.qrDifferent.ParamByName('MECHANIZM_ID').Value := Result;
    DM.qrDifferent.ParamByName('UNIT_ID').Value := 0;
    DM.qrDifferent.ExecSQL;
  end
  else
  begin
    if not ANoUpdate then
    begin
      DM.qrDifferent.SQL.Text :=
        'Update mechanizm set MECH_NAME = :MECH_NAME where MECHANIZM_ID = :MECHANIZM_ID';
      DM.qrDifferent.ParamByName('MECH_NAME').Value := AName;
      DM.qrDifferent.ParamByName('MECHANIZM_ID').Value := Result;
      DM.qrDifferent.ExecSQL;
    end;
  end;
end;

function TSprLoaderForm.AddNewMat(ACode, AName, AUnit: string; ADate: TDateTime;
    AJBI, ANoUpdate: Boolean): Integer;
var J,
    TmpUnitID,
    MType: Integer;
begin
  //Получает код ед. изм.
  J := FUnitsName.IndexOf(AUnit.ToLower);
  if J > -1 then
    TmpUnitID := StrToInt(FUnitsID[J])
  else
    TmpUnitID := AddNewUnit(AUnit);

  //Проверяет есть ли такой уже в базе
  DM.qrDifferent.SQL.Text :=
    'Select MATERIAL_ID from material where (MAT_CODE = :MAT_CODE) and (BASE = 0)';
  Result := -1;
  DM.qrDifferent.ParamByName('MAT_CODE').Value := ACode;
  DM.qrDifferent.Active := True;
  try
    if not DM.qrDifferent.IsEmpty then
      Result := DM.qrDifferent.Fields[0].AsInteger;
  finally
    DM.qrDifferent.Active := False;
  end;

  if Result = -1 then
  begin
    DM.qrDifferent.SQL.Text := 'Select GetNewSprID(:TypeID, 0)';
    DM.qrDifferent.ParamByName('TypeID').Value := C_MANID_MAT;
    DM.qrDifferent.Active := True;
    try
      Result := DM.qrDifferent.Fields[0].AsInteger;
    finally
      DM.qrDifferent.Active := False;
    end;

    MType := 1;
    if AJBI then
      MType := 2;

    DM.qrDifferent.SQL.Text :=
      'Insert into material ' +
      '(MATERIAL_ID, MAT_CODE, MAT_NAME, MAT_TYPE, UNIT_ID, BASE, date_beginer) ' +
      'values ' +
      '(:MATERIAL_ID, :MAT_CODE, :MAT_NAME, :TYPE, :UNIT_ID, 0, :date_beginer)';
    DM.qrDifferent.ParamByName('MAT_CODE').Value := ACode;
    DM.qrDifferent.ParamByName('MAT_NAME').Value := AName;
    DM.qrDifferent.ParamByName('MATERIAL_ID').Value := Result;
    DM.qrDifferent.ParamByName('TYPE').Value := MType;
    DM.qrDifferent.ParamByName('UNIT_ID').Value := TmpUnitID.ToString;
    DM.qrDifferent.ParamByName('date_beginer').Value := ADate;
    DM.qrDifferent.ExecSQL;
  end
  else
  begin
    if not ANoUpdate then
    begin
      DM.qrDifferent.SQL.Text :=
        'Update material set MAT_NAME = :MAT_NAME, UNIT_ID = :UNIT_ID, ' +
        'date_beginer = :date_beginer where MATERIAL_ID = :MATERIAL_ID';
      DM.qrDifferent.ParamByName('MAT_NAME').Value := AName;
      DM.qrDifferent.ParamByName('UNIT_ID').Value := TmpUnitID.ToString;
      DM.qrDifferent.ParamByName('date_beginer').Value := ADate;
      DM.qrDifferent.ParamByName('MATERIAL_ID').Value := Result;
      DM.qrDifferent.ExecSQL;
    end;
  end;
end;

function TSprLoaderForm.AddNewDump(AName, AUnit: string; ACode, OblID: Integer;
  ANoUpdate: Boolean): Integer;
var J,
    TmpUnitID: Integer;
begin
  //Получает код ед. изм.
  J := FUnitsName.IndexOf(AUnit.ToLower);
  if J > -1 then
    TmpUnitID := StrToInt(FUnitsID[J])
  else
    TmpUnitID := AddNewUnit(AUnit);

  //Проверяет есть ли такой уже в базе
  DM.qrDifferent.SQL.Text :=
    'Select DUMP_ID from dump where (Lower(DUMP_NAME) = Lower(:DUMP_NAME)) and ' +
    '(REGION_ID = :REGION_ID)';
  Result := -1;
  DM.qrDifferent.ParamByName('DUMP_NAME').Value := AName;
  DM.qrDifferent.ParamByName('REGION_ID').Value := OblID;
  DM.qrDifferent.Active := True;
  try
    if not DM.qrDifferent.IsEmpty then
      Result := DM.qrDifferent.Fields[0].AsInteger;
  finally
    DM.qrDifferent.Active := False;
  end;

  if Result = -1 then
  begin
    DM.qrDifferent.SQL.Text :=
      'Insert into dump ' +
      '(`REGION_ID`, `DUMP_NAME`, `UNIT_ID`, `DUMP_CODE`) ' +
      'values ' +
      '(:REGION_ID, :DUMP_NAME, :UNIT_ID, :DUMP_CODE)';

    DM.qrDifferent.ParamByName('REGION_ID').Value := OblID;
    DM.qrDifferent.ParamByName('DUMP_NAME').Value := AName;
    DM.qrDifferent.ParamByName('UNIT_ID').Value := TmpUnitID;
    DM.qrDifferent.ParamByName('DUMP_CODE').Value := ACode;
    DM.qrDifferent.ExecSQL;

    DM.qrDifferent.SQL.Text := 'Select last_insert_id()';
    DM.qrDifferent.Active := True;
    try
      Result := DM.qrDifferent.Fields[0].AsInteger;
    finally
      DM.qrDifferent.Active := False;
    end;
  end
  else
  begin
    if not ANoUpdate then
    begin
      DM.qrDifferent.SQL.Text :=
        'Update dump set UNIT_ID = :UNIT_ID, DUMP_CODE = :DUMP_CODE ' +
        'where (Lower(DUMP_NAME) = Lower(:DUMP_NAME)) and (REGION_ID = :REGION_ID)';
      DM.qrDifferent.ParamByName('UNIT_ID').Value := TmpUnitID;
      DM.qrDifferent.ParamByName('DUMP_CODE').Value := ACode;
      DM.qrDifferent.ParamByName('DUMP_NAME').Value := AName;
      DM.qrDifferent.ParamByName('REGION_ID').Value := OblID;
      DM.qrDifferent.ExecSQL;
    end;
  end;
end;

procedure TSprLoaderForm.actUpdMatExecute(Sender: TObject);
var ExlApp, WorkSheet: OleVariant;
    FData: OleVariant;
    I, Rows: Integer;
    TmpCode,
    TmpName,
    TmpUnit: string;

    TmpDate: TDateTime;
    AutoCommitValue: Boolean;
begin
  if Application.MessageBox(
    PChar('Загрузить данные из ''' + edtUpdMat.Text + ''' в справочник материалов?'),
    'Загрузка данных', MB_OKCANCEL + MB_ICONQUESTION) = mrCancel then
    Exit;
  ChackFileExsist(edtUpdMat.Text);

  TmpDate := EncodeDate(edtYearMat.Value, cbMonthMat.ItemIndex + 1, 1);
  LoadUnits;
  CoInitialize(nil);
  AutoCommitValue := DM.Read.Options.AutoCommit;
  DM.Read.Options.AutoCommit := False;
  try
    Screen.Cursor := crHourGlass;
    ExlApp := Unassigned;
    try
      ExlApp := CreateOleObject('Excel.Application');
      ExlApp.Visible:=false;
      ExlApp.DisplayAlerts := False;
    except
      on e: exception do
        raise Exception.Create('Ошибка инициализации Excel:' + e.Message);
    end;

    try
      ExlApp.WorkBooks.Open(edtUpdMat.Text);
      WorkSheet := ExlApp.ActiveWorkbook.ActiveSheet;
    except
      on e: exception do
        raise Exception.Create('Ошибка открытия Excel документа:' + e.Message);
    end;

    Rows := WorkSheet.UsedRange.Rows.Count;
    FData :=
      WorkSheet.Range[WorkSheet.Cells[4, 1].Address,
      WorkSheet.Cells[Rows, 3].Address].Value;

    DM.Read.StartTransaction;
    try
      for I := 1 to Rows - 3 do
      begin
        TmpCode := trim(VarToStr(FData[I,1]));
        TmpName := trim(VarToStr(FData[I,2]));
        TmpUnit := trim(VarToStr(FData[I,3]));
        if (TmpCode <> '') and (TmpName <> '') then
          AddNewMat(TmpCode, TmpName, TmpUnit, TmpDate, False, False);
      end;
      DM.Read.Commit;
      ShowMessage('Загрузка успешно завершена.');
    except
      DM.Read.Rollback;
      raise;
    end;
  finally
    DM.Read.Options.AutoCommit := AutoCommitValue;
    if not VarIsEmpty(ExlApp) then
    begin
      ExlApp.ActiveWorkbook.Close;
      ExlApp.Quit;
    end;
    Screen.Cursor := crDefault;
    WorkSheet := Unassigned;
    ExlApp := Unassigned;
    CoUninitialize;
  end;
end;

procedure TSprLoaderForm.actUpdMatNoPriceExecute(Sender: TObject);
var ExlApp, WorkSheet: OleVariant;
    FData: OleVariant;
    I, J, Rows: Integer;
    TmpCode,
    TmpName,
    TmpUnit: string;
    TmpMatID: Integer;
    SBORNIK_E, SBORNIK_C: string;
    RCN: Integer;
    TmpDate: TDateTime;
    AutoCommitValue: Boolean;
begin
  if Application.MessageBox(
    PChar('Загрузить данные из ''' + edtUpdMatNoPrice.Text + ''' в справочник материалов?'),
    'Загрузка данных', MB_OKCANCEL + MB_ICONQUESTION) = mrCancel then
    Exit;
  ChackFileExsist(edtUpdMatNoPrice.Text);

  TmpDate := EncodeDate(edtYearMatNoPrice.Value, cbMonthMatNoPrice.ItemIndex + 1, 1);
  LoadUnits;
  CoInitialize(nil);
  AutoCommitValue := DM.Read.Options.AutoCommit;
  DM.Read.Options.AutoCommit := False;
  try
    Screen.Cursor := crHourGlass;
    ExlApp := Unassigned;
    try
      ExlApp := CreateOleObject('Excel.Application');
      ExlApp.Visible:=false;
      ExlApp.DisplayAlerts := False;
    except
      on e: exception do
        raise Exception.Create('Ошибка инициализации Excel:' + e.Message);
    end;

    try
      ExlApp.WorkBooks.Open(edtUpdMatNoPrice.Text);
      WorkSheet := ExlApp.ActiveWorkbook.ActiveSheet;
    except
      on e: exception do
        raise Exception.Create('Ошибка открытия Excel документа:' + e.Message);
    end;

    Rows := WorkSheet.UsedRange.Rows.Count;
    FData :=
      WorkSheet.Range[WorkSheet.Cells[2, 1].Address,
      WorkSheet.Cells[Rows, 6].Address].Value;

    DM.Read.StartTransaction;
    try
      for I := 1 to Rows - 1 do
      begin
        TmpCode := trim(VarToStr(FData[I,1]));
        TmpName := trim(VarToStr(FData[I,2]));
        TmpUnit := trim(VarToStr(FData[I,3]));
        SBORNIK_C := trim(VarToStr(FData[I,4]));
        SBORNIK_E := trim(VarToStr(FData[I,5]));
        RCN := StrToIntDef(VarToStr(FData[I,6]), 0);

        if (TmpCode <> '') then
        begin
          TmpMatID := AddNewMat(TmpCode, TmpName, TmpUnit, TmpDate, False, False);
          J := -1;
          DM.qrDifferent.SQL.Text :=
            'Select ID from materialnocoast where ' +
              '(MATERIAL_ID = :MATERIAL_ID)';
          DM.qrDifferent.ParamByName('MATERIAL_ID').Value := TmpMatID;
          DM.qrDifferent.Active := True;
          try
            if not DM.qrDifferent.IsEmpty then
              J := DM.qrDifferent.Fields[0].AsInteger;
          finally
            DM.qrDifferent.Active := False;
          end;

          if J = -1 then
          begin
            DM.qrDifferent.SQL.Text :=
              'Insert into materialnocoast ' +
              '(MATERIAL_ID, SBORNIK_E, SBORNIK_C, RCN, DATE_BEG) ' +
              'values ' +
              '(:MATERIAL_ID, :SBORNIK_E, :SBORNIK_C, :RCN, :DATE_BEG)';
            DM.qrDifferent.ParamByName('MATERIAL_ID').Value := TmpMatID;
            DM.qrDifferent.ParamByName('SBORNIK_E').Value := SBORNIK_E;
            DM.qrDifferent.ParamByName('SBORNIK_C').Value := SBORNIK_C;
            DM.qrDifferent.ParamByName('RCN').Value := RCN;
            DM.qrDifferent.ParamByName('DATE_BEG').Value := TmpDate;
            DM.qrDifferent.ExecSQL;
          end
          else
          begin
            DM.qrDifferent.SQL.Text :=
              'Update materialnocoast set SBORNIK_E = :SBORNIK_E, SBORNIK_C = :SBORNIK_C, ' +
              'RCN = :RCN, DATE_BEG = :DATE_BEG where ID = :ID';
            DM.qrDifferent.ParamByName('SBORNIK_E').Value := SBORNIK_E;
            DM.qrDifferent.ParamByName('SBORNIK_C').Value := SBORNIK_C;
            DM.qrDifferent.ParamByName('RCN').Value := RCN;
            DM.qrDifferent.ParamByName('DATE_BEG').Value := TmpDate;
            DM.qrDifferent.ParamByName('ID').Value := J;
            DM.qrDifferent.ExecSQL;
          end;
        end;
      end;
      DM.Read.Commit;
      ShowMessage('Загрузка успешно завершена.');
    except
      DM.Read.Rollback;
      raise;
    end;
  finally
    DM.Read.Options.AutoCommit := AutoCommitValue;
    if not VarIsEmpty(ExlApp) then
    begin
      ExlApp.ActiveWorkbook.Close;
      ExlApp.Quit;
    end;
    Screen.Cursor := crDefault;
    WorkSheet := Unassigned;
    ExlApp := Unassigned;
    CoUninitialize;
  end;
end;

procedure TSprLoaderForm.actUpdMatNoTransExecute(Sender: TObject);
var ExlApp, WorkSheet: OleVariant;
    FData: OleVariant;
    I,
    Rows: Integer;
    AutoCommitValue: Boolean;
    TmpCode: string;
begin
  if Application.MessageBox(
    PChar('Загрузить данные из ''' + edtUpdMatNoTrans.Text + ''' ' +
    'в справочник материалов без транспорта?' + sLineBreak +
    'Справочник материалов без транспорта перед загрузкой будет очищен. '),
    'Загрузка данных', MB_OKCANCEL + MB_ICONQUESTION) = mrCancel then
    Exit;
  ChackFileExsist(edtUpdMatNoTrans.Text);
  CoInitialize(nil);
  AutoCommitValue := DM.Read.Options.AutoCommit;
  DM.Read.Options.AutoCommit := False;
  try
    Screen.Cursor := crHourGlass;
    ExlApp := Unassigned;
    try
      ExlApp := CreateOleObject('Excel.Application');
      ExlApp.Visible:=false;
      ExlApp.DisplayAlerts := False;
    except
      on e: exception do
        raise Exception.Create('Ошибка инициализации Excel:' + e.Message);
    end;

    try
      ExlApp.WorkBooks.Open(edtUpdMatNoTrans.Text);
      WorkSheet := ExlApp.ActiveWorkbook.ActiveSheet;
    except
      on e: exception do
        raise Exception.Create('Ошибка открытия Excel документа:' + e.Message);
    end;

    Rows := WorkSheet.UsedRange.Rows.Count;

    FData :=
      WorkSheet.Range[WorkSheet.Cells[2, 1].Address,
      WorkSheet.Cells[Rows, 1].Address].Value;

    DM.Read.StartTransaction;
    try
      DM.qrDifferent.SQL.Text :=
        'Delete from materialwithouttransp';
      DM.qrDifferent.ExecSQL;

      DM.qrDifferent.SQL.Text :=
        'Insert into materialwithouttransp (MAT_CODE) values (:MAT_CODE)';

      for I := 1 to Rows - 1 do
      begin
        TmpCode := trim(VarToStr(FData[I,1]));
        if (TmpCode <> '') then
        begin
          DM.qrDifferent.ParamByName('MAT_CODE').Value := TmpCode;
          DM.qrDifferent.ExecSQL;
        end;
      end;
      DM.Read.Commit;
      ShowMessage('Загрузка успешно завершена.');
    except
      DM.Read.Rollback;
      raise;
    end;
  finally
    DM.Read.Options.AutoCommit := AutoCommitValue;
    if not VarIsEmpty(ExlApp) then
    begin
      ExlApp.ActiveWorkbook.Close;
      ExlApp.Quit;
    end;
    Screen.Cursor := crDefault;
    WorkSheet := Unassigned;
    ExlApp := Unassigned;
    CoUninitialize;
  end;
end;

procedure TSprLoaderForm.actUpdMatPriceExecute(Sender: TObject);
var ExlApp,
    WorkSheet1,
    WorkSheet2: OleVariant;
    FData,
    FDataPriceNDS,
    FDataPriceNoNDS: OleVariant;
    I, J,
    Rows1, Rows2: Integer;
    TmpCode,
    TmpName,
    TmpUnit: string;
    TmpMatID: Integer;

    TmpDate: TDateTime;
    AutoCommitValue: Boolean;
begin
  if Application.MessageBox(
    PChar('Загрузить данные из ''' + edtUpdMatPrice.Text + ''' в справочник цен материалов?' +
    sLineBreak + 'Старые цены за ' + cbMonthMatPrice.Text + ' ' +
    edtYearMatPrice.Value.ToString + ' будут удалены.'),
    'Загрузка данных', MB_OKCANCEL + MB_ICONQUESTION) = mrCancel then
    Exit;
  ChackFileExsist(edtUpdMatPrice.Text);

  TmpDate := EncodeDate(edtYearMatPrice.Value, cbMonthMatPrice.ItemIndex + 1, 1);
  LoadUnits;
  CoInitialize(nil);
  AutoCommitValue := DM.Read.Options.AutoCommit;
  DM.Read.Options.AutoCommit := False;
  J := 0;
  try
    Screen.Cursor := crHourGlass;
    ExlApp := Unassigned;
    try
      ExlApp := CreateOleObject('Excel.Application');
      ExlApp.Visible:=false;
      ExlApp.DisplayAlerts := False;
    except
      on e: exception do
        raise Exception.Create('Ошибка инициализации Excel:' + e.Message);
    end;

    try
      ExlApp.WorkBooks.Open(edtUpdMatPrice.Text);
      WorkSheet1 := ExlApp.ActiveWorkbook.Sheets.Item[1];
      WorkSheet2 := ExlApp.ActiveWorkbook.Sheets.Item[2];
    except
      on e: exception do
        raise Exception.Create('Ошибка открытия Excel документа:' + e.Message);
    end;

    Rows1 := WorkSheet1.UsedRange.Rows.Count;
    Rows2 := WorkSheet2.UsedRange.Rows.Count;

    if Rows2 <> Rows1 then
      raise Exception.Create('Таблицы с НДС и без НДС разной длинны.');

    FData :=
      WorkSheet1.Range[WorkSheet1.Cells[9, 1].Address,
      WorkSheet1.Cells[Rows1, 3].Address].Value;

    FDataPriceNoNDS :=
      WorkSheet1.Range[WorkSheet1.Cells[9, 4].Address,
      WorkSheet1.Cells[Rows1, 10].Address].Value;

    FDataPriceNDS :=
      WorkSheet2.Range[WorkSheet2.Cells[9, 4].Address,
      WorkSheet2.Cells[Rows1, 10].Address].Value;

    DM.Read.StartTransaction;
    try
      DM.qrDifferent.SQL.Text :=
        'Delete from materialcoastg where (YEAR = :YEAR) and (MONAT = :MONAT) and ' +
        '(MATERIAL_ID in (Select MATERIAL_ID from material where MAT_TYPE = 1))';
      DM.qrDifferent.ParamByName('YEAR').Value := edtYearMatPrice.Value;
      DM.qrDifferent.ParamByName('MONAT').Value := cbMonthMatPrice.ItemIndex + 1;
      DM.qrDifferent.ExecSQL;

      DM.qrDifferent1.SQL.Text :=
        'Insert into materialcoastg ' +
        '(MATERIAL_ID, `YEAR`, `MONAT`, COAST1_1, COAST1_2, COAST2_1, COAST2_2, ' +
        'COAST3_1, COAST3_2, COAST4_1, COAST4_2, COAST5_1, COAST5_2, ' +
        'COAST6_1, COAST6_2, COAST7_1, COAST7_2) ' +
        'values ' +
        '(:MATERIAL_ID, :YEAR, :MONAT, :COAST1_1, :COAST1_2, :COAST2_1, :COAST2_2, ' +
        ':COAST3_1, :COAST3_2, :COAST4_1, :COAST4_2, :COAST5_1, :COAST5_2, ' +
        ':COAST6_1, :COAST6_2, :COAST7_1, :COAST7_2)';

      for I := 1 to Rows1 - 8 do
      begin
        J := I;
        TmpCode := trim(VarToStr(FData[I,1]));
        TmpName := trim(VarToStr(FData[I,2]));
        TmpUnit := trim(VarToStr(FData[I,3]));

        if (TmpCode <> '') then
        begin
          TmpMatID :=
            AddNewMat(TmpCode, TmpName, TmpUnit, TmpDate,
              False, not cboxUpdMatName.Checked);

          DM.qrDifferent1.ParamByName('MATERIAL_ID').Value := TmpMatID;
          DM.qrDifferent1.ParamByName('YEAR').Value := edtYearMatPrice.Value;
          DM.qrDifferent1.ParamByName('MONAT').Value := cbMonthMatPrice.ItemIndex + 1;
          DM.qrDifferent1.ParamByName('COAST1_1').Value := FDataPriceNoNDS[I,1];
          DM.qrDifferent1.ParamByName('COAST1_2').Value := FDataPriceNDS[I,1];
          DM.qrDifferent1.ParamByName('COAST2_1').Value := FDataPriceNoNDS[I,2];
          DM.qrDifferent1.ParamByName('COAST2_2').Value := FDataPriceNDS[I,2];
          DM.qrDifferent1.ParamByName('COAST3_1').Value := FDataPriceNoNDS[I,3];
          DM.qrDifferent1.ParamByName('COAST3_2').Value := FDataPriceNDS[I,3];
          DM.qrDifferent1.ParamByName('COAST4_1').Value := FDataPriceNoNDS[I,4];
          DM.qrDifferent1.ParamByName('COAST4_2').Value := FDataPriceNDS[I,4];
          DM.qrDifferent1.ParamByName('COAST5_1').Value := FDataPriceNoNDS[I,5];
          DM.qrDifferent1.ParamByName('COAST5_2').Value := FDataPriceNDS[I,5];
          DM.qrDifferent1.ParamByName('COAST6_1').Value := FDataPriceNoNDS[I,6];
          DM.qrDifferent1.ParamByName('COAST6_2').Value := FDataPriceNDS[I,6];
          DM.qrDifferent1.ParamByName('COAST7_1').Value := FDataPriceNoNDS[I,7];
          DM.qrDifferent1.ParamByName('COAST7_2').Value := FDataPriceNDS[I,7];
          DM.qrDifferent1.ExecSQL;
        end;

      end;
      DM.Read.Commit;
      ShowMessage('Загрузка успешно завершена.');
    except
      on e: Exception do
      begin
        DM.Read.Rollback;
        raise Exception.Create('Ошибка на строке ' + (J + 8).ToString + ':' +
          sLineBreak + e.Message);
      end;
    end;
  finally
    DM.Read.Options.AutoCommit := AutoCommitValue;
    if not VarIsEmpty(ExlApp) then
    begin
      ExlApp.ActiveWorkbook.Close;
      ExlApp.Quit;
    end;
    Screen.Cursor := crDefault;
    WorkSheet1 := Unassigned;
    WorkSheet2 := Unassigned;
    ExlApp := Unassigned;
    CoUninitialize;
  end;
end;

procedure TSprLoaderForm.actUpdMechExecute(Sender: TObject);
var ExlApp,
    WorkSheet: OleVariant;
    FData: OleVariant;
    I, J,
    Rows: Integer;
    TmpCode,
    TmpName: string;
    TmpMechID: Integer;

    TmpDate: TDateTime;
    AutoCommitValue: Boolean;
begin
  if Application.MessageBox(
    PChar('Загрузить данные из ''' + edtUpdMech.Text + ''' в справочник цен механизмов?'),
    'Загрузка данных', MB_OKCANCEL + MB_ICONQUESTION) = mrCancel then
    Exit;
  ChackFileExsist(edtUpdMech.Text);

  TmpDate := EncodeDate(edtYearMech.Value, cbMonthMech.ItemIndex + 1, 1);

  CoInitialize(nil);
  AutoCommitValue := DM.Read.Options.AutoCommit;
  DM.Read.Options.AutoCommit := False;
  J := 0;
  try
    Screen.Cursor := crHourGlass;
    ExlApp := Unassigned;
    try
      ExlApp := CreateOleObject('Excel.Application');
      ExlApp.Visible:=false;
      ExlApp.DisplayAlerts := False;
    except
      on e: exception do
        raise Exception.Create('Ошибка инициализации Excel:' + e.Message);
    end;

    try
      ExlApp.WorkBooks.Open(edtUpdMech.Text);
      WorkSheet := ExlApp.ActiveWorkbook.ActiveSheet;
    except
      on e: exception do
        raise Exception.Create('Ошибка открытия Excel документа:' + e.Message);
    end;

    Rows := WorkSheet.UsedRange.Rows.Count;

    FData :=
      WorkSheet.Range[WorkSheet.Cells[9, 1].Address,
      WorkSheet.Cells[Rows, 6].Address].Value;

    DM.Read.StartTransaction;
    try
      DM.qrDifferent1.SQL.Text :=
        'Insert into mechanizmcoastg ' +
        '(MECHANIZM_ID, `YEAR`, `MONAT`, COAST1, ZP1, COAST2, ZP2) ' +
        'values ' +
        '(:MECHANIZM_ID, :YEAR, :MONAT, :COAST1, :ZP1, :COAST2, :ZP2)';

      for I := 1 to Rows - 8 do
      begin
        J := I;
        TmpCode :=  trim(StringReplace(VarToStr(FData[I,1]), '*', '', [rfReplaceAll]));
        TmpName := trim(VarToStr(FData[I,2]));

        if (TmpCode <> '') then
        begin
          TmpMechID :=
            AddNewMech(TmpCode, TmpName, TmpDate, not cboxUpdMechName.Checked);

          DM.qrDifferent1.ParamByName('MECHANIZM_ID').Value := TmpMechID;
          DM.qrDifferent1.ParamByName('YEAR').Value := edtYearMech.Value;
          DM.qrDifferent1.ParamByName('MONAT').Value := cbMonthMech.ItemIndex + 1;
          DM.qrDifferent1.ParamByName('COAST1').Value := FData[I,3];
          DM.qrDifferent1.ParamByName('ZP1').Value := FData[I,4];
          DM.qrDifferent1.ParamByName('COAST2').Value := FData[I,5];
          DM.qrDifferent1.ParamByName('ZP2').Value := FData[I,6];
          DM.qrDifferent1.ExecSQL;
        end;

      end;
      DM.Read.Commit;
      ShowMessage('Загрузка успешно завершена.');
    except
      on e: Exception do
      begin
        DM.Read.Rollback;
        raise Exception.Create('Ошибка на строке ' + (J + 8).ToString + ':' +
          sLineBreak + e.Message);
      end;
    end;
  finally
    DM.Read.Options.AutoCommit := AutoCommitValue;
    if not VarIsEmpty(ExlApp) then
    begin
      ExlApp.ActiveWorkbook.Close;
      ExlApp.Quit;
    end;
    Screen.Cursor := crDefault;
    WorkSheet := Unassigned;
    ExlApp := Unassigned;
    CoUninitialize;
  end;
end;

procedure TSprLoaderForm.actUpdTarifExecute(Sender: TObject);
var ExlApp,
    WorkSheet: OleVariant;
    FData: OleVariant;
    I, J, Rows: Integer;
    AutoCommitValue: Boolean;
begin
  if Application.MessageBox(
    PChar('Загрузить данные из ''' + edtUpdTarif.Text +
      ''' в справочник тарифов на погрузочные и разгрузочные работы?' +
      sLineBreak + 'Старые тарифы за ' + cbMonthTarif.Text + ' ' +
      edtYearTarif.Value.ToString + ' будут удалены.'),
    'Загрузка данных', MB_OKCANCEL + MB_ICONQUESTION) = mrCancel then
    Exit;
  ChackFileExsist(edtUpdTarif.Text);

  CoInitialize(nil);
  AutoCommitValue := DM.Read.Options.AutoCommit;
  DM.Read.Options.AutoCommit := False;
  try
    Screen.Cursor := crHourGlass;
    ExlApp := Unassigned;
    try
      ExlApp := CreateOleObject('Excel.Application');
      ExlApp.Visible:=false;
      ExlApp.DisplayAlerts := False;
    except
      on e: exception do
        raise Exception.Create('Ошибка инициализации Excel:' + e.Message);
    end;

    try
      ExlApp.WorkBooks.Open(edtUpdTarif.Text);
      WorkSheet := ExlApp.ActiveWorkbook.ActiveSheet;
    except
      on e: exception do
        raise Exception.Create('Ошибка открытия Excel документа:' + e.Message);
    end;

   { Rows := WorkSheet.UsedRange.Rows.Count;

    if Rows <> 53 then
      raise Exception.Create('Неожиданное кол-во строк в справочнике.');
    }

    Rows := 53;
    FData :=
      WorkSheet.Range[WorkSheet.Cells[9, 1].Address,
      WorkSheet.Cells[Rows, 14].Address].Value;

    DM.Read.StartTransaction;
    try
      DM.qrDifferent.SQL.Text :=
        'Delete from tariffworks where (YEAR = :YEAR) and (MONAT = :MONAT)';
      DM.qrDifferent.ParamByName('YEAR').Value := edtYearTarif.Value;
      DM.qrDifferent.ParamByName('MONAT').Value := cbMonthTarif.ItemIndex + 1;
      DM.qrDifferent.ExecSQL;

      DM.qrDifferent1.SQL.Text :=
        'Insert into tariffworks ' +
        '(`WORK_ID`, `YEAR`, `MONAT`, `TARIFF_1`, `TARIFF_2`, `TARIFF_3`, ' +
        '`TARIFF_4`, `TARIFF_5`, `TARIFF_6`, `TARIFF_7`, `TARIFF_8`, ' +
        '`TARIFF_9`, `TARIFF_10`, `TARIFF_11`, `TARIFF_12`) ' +
        'values ' +
        '(:WORK_ID, :YEAR, :MONAT, :TARIFF_1, :TARIFF_2, :TARIFF_3, ' +
        ':TARIFF_4, :TARIFF_5, :TARIFF_6, :TARIFF_7, :TARIFF_8, ' +
        ':TARIFF_9, :TARIFF_10, :TARIFF_11, :TARIFF_12)';
      J := 0;
      for I := 1 to Rows - 8 do
      begin
        //Получение кода просто подогнано под строчки в файле
        if (VarToStr(FData[I,1]) = '12') or
           (VarToStr(FData[I,1]) = '31') then
          Continue;
        Inc(J);

        DM.qrDifferent1.ParamByName('WORK_ID').Value := J;
        DM.qrDifferent1.ParamByName('YEAR').Value := edtYearTarif.Value;
        DM.qrDifferent1.ParamByName('MONAT').Value := cbMonthTarif.ItemIndex + 1;
        DM.qrDifferent1.ParamByName('TARIFF_1').Value := FData[I,3];
        DM.qrDifferent1.ParamByName('TARIFF_2').Value := FData[I,4];
        DM.qrDifferent1.ParamByName('TARIFF_3').Value := FData[I,5];
        DM.qrDifferent1.ParamByName('TARIFF_4').Value := FData[I,6];
        DM.qrDifferent1.ParamByName('TARIFF_5').Value := FData[I,7];
        DM.qrDifferent1.ParamByName('TARIFF_6').Value := FData[I,8];
        DM.qrDifferent1.ParamByName('TARIFF_7').Value := FData[I,9];
        DM.qrDifferent1.ParamByName('TARIFF_8').Value := FData[I,10];
        DM.qrDifferent1.ParamByName('TARIFF_9').Value := FData[I,11];
        DM.qrDifferent1.ParamByName('TARIFF_10').Value := FData[I,12];
        DM.qrDifferent1.ParamByName('TARIFF_11').Value := FData[I,13];
        DM.qrDifferent1.ParamByName('TARIFF_12').Value := FData[I,14];
        DM.qrDifferent1.ExecSQL;
      end;
      DM.Read.Commit;
      ShowMessage('Загрузка успешно завершена.');
    except
      DM.Read.Rollback;
      raise;
    end;
  finally
    DM.Read.Options.AutoCommit := AutoCommitValue;
    if not VarIsEmpty(ExlApp) then
    begin
      ExlApp.ActiveWorkbook.Close;
      ExlApp.Quit;
    end;
    Screen.Cursor := crDefault;
    WorkSheet := Unassigned;
    ExlApp := Unassigned;
    CoUninitialize;
  end;
end;

procedure TSprLoaderForm.actUpdTransKoefExecute(Sender: TObject);
var ExlApp,
    WorkSheet: OleVariant;
    FData: OleVariant;
    I, Rows: Integer;
    TmpStr, TmpStr1: string;
    AutoCommitValue: Boolean;
begin
  if Application.MessageBox(
    PChar('Загрузить данные из ''' + edtUpdTransKoef.Text + ''' в справочник ' +
      'надбавок к тарифам на перевозку бортовыми автомобилями?' +
    sLineBreak + 'Старые надбавки за ' + cbMonthTransKoef.Text + ' ' +
    edtYearTransKoef.Value.ToString + ' будут удалены.'),
    'Загрузка данных', MB_OKCANCEL + MB_ICONQUESTION) = mrCancel then
    Exit;
  ChackFileExsist(edtUpdTransKoef.Text);

  CoInitialize(nil);
  AutoCommitValue := DM.Read.Options.AutoCommit;
  DM.Read.Options.AutoCommit := False;
  try
    Screen.Cursor := crHourGlass;
    ExlApp := Unassigned;
    try
      ExlApp := CreateOleObject('Excel.Application');
      ExlApp.Visible:=false;
      ExlApp.DisplayAlerts := False;
    except
      on e: exception do
        raise Exception.Create('Ошибка инициализации Excel:' + e.Message);
    end;

    try
      ExlApp.WorkBooks.Open(edtUpdTransKoef.Text);
      WorkSheet := ExlApp.ActiveWorkbook.ActiveSheet;
    except
      on e: exception do
        raise Exception.Create('Ошибка открытия Excel документа:' + e.Message);
    end;

    Rows := WorkSheet.UsedRange.Rows.Count;

    FData :=
      WorkSheet.Range[WorkSheet.Cells[5, 1].Address,
      WorkSheet.Cells[Rows, 2].Address].Value;

    DM.Read.StartTransaction;
    try
      DM.qrDifferent.SQL.Text :=
        'Delete from transferkoef where (YEAR = :YEAR) and (MONAT = :MONAT)';
      DM.qrDifferent.ParamByName('YEAR').Value := edtYearTransKoef.Value;
      DM.qrDifferent.ParamByName('MONAT').Value := cbMonthTransKoef.ItemIndex + 1;
      DM.qrDifferent.ExecSQL;

      DM.qrDifferent1.SQL.Text :=
        'Insert into transferkoef (`koef`, `description`, `YEAR`, `MONAT`) ' +
        'values (:koef, :description, :YEAR, :MONAT)';

      for I := 1 to Rows - 4 do
      begin
        if trim(VarToStr(FData[I,2])) = '' then
        begin
          TmpStr1 := trim(VarToStr(FData[I,1]));
          Continue;
        end;

        TmpStr := VarToStr(FData[I,1]);
        if Pos('   ', TmpStr) = 1 then
          TmpStr := TmpStr1 + ' ' + Trim(TmpStr);
        TmpStr := Trim(TmpStr);

        DM.qrDifferent1.ParamByName('YEAR').Value := edtYearTransKoef.Value;
        DM.qrDifferent1.ParamByName('MONAT').Value := cbMonthTransKoef.ItemIndex + 1;
        DM.qrDifferent1.ParamByName('koef').Value :=
          1 + StrToIntDef(VarToStr(FData[I,2]), 0)/100;
        DM.qrDifferent1.ParamByName('description').Value := TmpStr;
        DM.qrDifferent1.ExecSQL;
      end;
      DM.Read.Commit;
      ShowMessage('Загрузка успешно завершена.');
    except
      DM.Read.Rollback;
      raise;
    end;
  finally
    DM.Read.Options.AutoCommit := AutoCommitValue;
    if not VarIsEmpty(ExlApp) then
    begin
      ExlApp.ActiveWorkbook.Close;
      ExlApp.Quit;
    end;
    Screen.Cursor := crDefault;
    WorkSheet := Unassigned;
    ExlApp := Unassigned;
    CoUninitialize;
  end;
end;

procedure TSprLoaderForm.ChackFileExsist(const AFileName: string);
begin
  if not TFile.Exists(AFileName) then
    raise Exception.Create('Файл ''' + AFileName + ''' не найден.');
end;

end.
