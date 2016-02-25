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
    Label1: TLabel;
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
  private
    FUnitsName, FUnitsID: TStringList;
    procedure ChackFileExsist(const AFileName: string);
    procedure LoadUnits();
    function AddNewUnit(AUnitName: string): Integer;
    function AddNewMat(ACode, AName, AUnit: string; ADate: TDateTime;
      AJBI, ANoUpdate: Boolean): Integer;
    function AddNewMech(ACode, AName: string; ADate: TDateTime; ANoUpdate: Boolean): Integer;
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
          DM.qrDifferent1.ParamByName('YEAR').Value := edtYearMatPrice.Value;
          DM.qrDifferent1.ParamByName('MONAT').Value := cbMonthMatPrice.ItemIndex + 1;
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

procedure TSprLoaderForm.ChackFileExsist(const AFileName: string);
begin
  if not TFile.Exists(AFileName) then
    raise Exception.Create('Файл ''' + AFileName + ''' не найден.');
end;

end.
