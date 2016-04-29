unit fSprLoader;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  System.IOUtils,
  System.StrUtils,
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
  Data.DB, Bde.DBTables;

type
  TIzmRec = record
    IzmDate: TDateTime;
    Prikaz: string;
    PNom: string;
    PDate: TDateTime;
  end;

  PIzmRec = ^TIzmRec;
  TIzmArray = array of TIzmRec;

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
    tsRates: TTabSheet;
    pnlUpdRates: TPanel;
    lbUpdRatesTitle: TLabel;
    btnUpdRates: TButton;
    edtUpdRates: TButtonedEdit;
    memUpdRateRes: TMemo;
    Label1: TLabel;
    tsSverka: TTabSheet;
    q1: TQuery;
    Panel1: TPanel;
    lbDBFPath: TLabel;
    btnSverkaMat: TButton;
    edtDBFPath: TButtonedEdit;
    btnSverkaMech: TButton;
    btnSverkaDev: TButton;
    btnSverkaRate: TButton;
    memError: TMemo;
    lblError: TLabel;
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
    procedure btnUpdRatesClick(Sender: TObject);
    procedure btnSverkaMatClick(Sender: TObject);
    procedure btnSverkaMechClick(Sender: TObject);
    procedure btnSverkaDevClick(Sender: TObject);
    procedure btnSverkaRateClick(Sender: TObject);
  private
    FUnitsName, FUnitsID: TStringList;
    procedure ChackFileExsist(const AFileName: string);
    procedure LoadUnits();
    function AddNewUnit(AUnitName: string): Integer;
    function AddNewMat(ACode, AName, AUnit: string; ADate: TDateTime;
      ANoUpdate: Boolean; AMatType: Byte): Integer;
    function AddNewMech(ACode, AName, AUnit: string; ADate: TDateTime;
      ANoUpdate: Boolean; ATrud: Double; AUpdateTrud: Boolean): Integer;
    function AddNewDump(AName, AUnit: string; ACode, OblID: Integer; ANoUpdate: Boolean): Integer;
    function AddNewDev(ACode, AName, AUnit: string; ANoUpdate: Boolean): Integer;

    function ConvertStrToDate(AStr: string): TDateTime;
    function AddNewNormDir(AName, ASecName, AParent: Variant;
      AType: Integer; AAddNew: Boolean): Integer;
    function VarToFloat(AVar: Variant): Double;
    function GetUnitID(AUnitName: string): Integer;

    function GetRateID(ACode: string): Integer;
    procedure AddRateWork(ARateID: Integer; AZTRab, AZTMach, ARazrad: Double);
    procedure AddRateMat(ARateCode, AMatStr, APMatStr: string; ARateID: Integer);
    procedure AddRateMech(ARateCode, AMechStr: string; ARateID: Integer);
    procedure ParsRateIZM(AIzm: string; var AIzmArray: TIzmArray);
    function GetDirectoryID(ACode: string): Integer;

    procedure AddRateDesc(const ARateDesc: string; ARateID: Integer; AIzmRec: PIzmRec);

    function GetMatID(AMatCode: string): Integer;
    function GetMechID(AMatCode: string): Integer;
    function GetMatNormID(ARateID, AMatID: Integer): Integer;
    function GetMechNormID(ARateID, AMechID: Integer): Integer;

    function AddNewPMat(ACode, AName, AUnit: string): Integer;
  public
    { Public declarations }
  end;

implementation
{$R *.dfm}

uses DataModule, GlobsAndConst, Tools;

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

function TSprLoaderForm.ConvertStrToDate(AStr: string): TDateTime;
var D, M, Y: Word;
begin
  D := StrToIntDef(Copy(AStr, 1, 2), 1);
  M := StrToIntDef(Copy(AStr, 4, 2), 1);
  Y := StrToIntDef(Copy(AStr, 7, 4), 1900);
  Result := EncodeDate(Y, M, D);
end;

function TSprLoaderForm.VarToFloat(AVar: Variant): Double;
var TmpStr: string;
begin
  TmpStr := VarToStr(AVar);
  TmpStr := StringReplace(TmpStr, ',', FormatSettings.DecimalSeparator, []);
  TmpStr := StringReplace(TmpStr, '.', FormatSettings.DecimalSeparator, []);
  Result := StrToFloatDef(TmpStr, 0);
end;

function TSprLoaderForm.AddNewNormDir(AName, ASecName, AParent: Variant;
  AType: Integer; AAddNew: Boolean): Integer;
begin
  DM.qrDifferent.SQL.Text :=
    'Select normativ_directory_id from normativ_directory ' +
    'where (lower(first_name) = lower(:first_name)) and ' +
    '(type_directory = :type_directory) and (parent_id = :parent_id)';
  Result := -1;
  DM.qrDifferent.ParamByName('first_name').Value := AName;
  DM.qrDifferent.ParamByName('type_directory').Value := AType;
  DM.qrDifferent.ParamByName('parent_id').Value := AParent;
  DM.qrDifferent.Active := True;
  try
    if not DM.qrDifferent.IsEmpty then
      Result := DM.qrDifferent.Fields[0].AsInteger;
  finally
    DM.qrDifferent.Active := False;
  end;

  if (Result = -1) and AAddNew then
  begin
    DM.qrDifferent.SQL.Text :=
      'Insert into normativ_directory ' +
      '(first_name, second_name, type_directory, parent_id) ' +
      'values ' +
      '(:first_name, :second_name, :type_directory, :parent_id)';
    DM.qrDifferent.ParamByName('first_name').Value := AName;
    DM.qrDifferent.ParamByName('second_name').Value := ASecName;
    DM.qrDifferent.ParamByName('type_directory').Value := AType;
    DM.qrDifferent.ParamByName('parent_id').Value := AParent;
    DM.qrDifferent.ExecSQL;

    DM.qrDifferent.SQL.Text := 'Select LAST_INSERT_ID()';
    DM.qrDifferent.Active := True;
    try
      Result := DM.qrDifferent.Fields[0].AsInteger;
    finally
      DM.qrDifferent.Active := False;
    end;
  end
end;

procedure TSprLoaderForm.btnSverkaDevClick(Sender: TObject);
var I, J: Integer;
    Ca: string;
    TmpCode,
    TmpName,
    TmpUnit: string;
    AutoCommitValue: Boolean;
    MatType: Byte;
begin
  Ca := Caption;
  LoadUnits;
  AutoCommitValue := DM.Read.Options.AutoCommit;
  DM.Read.Options.AutoCommit := False;
  try
    Caption := 'Выполняется открытие справочника....';
    q1.DatabaseName := edtDBFPath.Text;
    q1.SQL.Text := 'select * from obrd';
    q1.Open;
    try
      DM.Read.StartTransaction;
      I := 0;
      J := 0;
      try
        while not q1.Eof do
        begin
          Inc(I);
          Caption := I.ToString;
          TmpCode := Trim(q1.FieldByName('OBOSN').AsString);
          TmpName := Trim(q1.FieldByName('NAIM').AsString);
          TmpUnit := 'шт';

          if ((Length(TmpCode) > 0) and CharInSet(TmpCode[1], ['1'..'6'])) then
          begin
            if Length(TmpName) > J then
              J := Length(TmpName);

            AddNewDev(TmpCode, TmpName, TmpUnit, False);
          end;

          if I mod 100 = 0 then
            Application.ProcessMessages;
          q1.Next;
        end;
        DM.Read.Commit;
        ShowMessage('Сверка оборудования завершена.');
      except
        on e: Exception do
        begin
          DM.Read.Rollback;
          raise Exception.Create('Ошибка на оборудование ' + TmpCode + ':' +
            sLineBreak + e.Message);
        end;
      end;
    finally
      q1.Close;
    end;
  finally
    Showmessage('Максимальная длиннта названия = ' + J.ToString);
    DM.Read.Options.AutoCommit := AutoCommitValue;
    Caption := Ca;
  end;
end;

procedure TSprLoaderForm.btnSverkaMatClick(Sender: TObject);
var I, J: Integer;
    Ca: string;
    TmpCode,
    TmpName,
    TmpUnit: string;
    AutoCommitValue: Boolean;
    MatType: Byte;
begin
  Ca := Caption;
  LoadUnits;
  AutoCommitValue := DM.Read.Options.AutoCommit;
  DM.Read.Options.AutoCommit := False;
  try
    Caption := 'Выполняется открытие справочника....';
    q1.DatabaseName := edtDBFPath.Text;
    q1.SQL.Text := 'select * from Mat';
    q1.Open;
    try
      DM.Read.StartTransaction;
      I := 0;
      J := 0;
      try
        while not q1.Eof do
        begin
          Inc(I);
          Caption := I.ToString;
          TmpCode := Trim(q1.FieldByName('OBOSN').AsString);
          TmpName := Trim(q1.FieldByName('NAIM').AsString);
          TmpUnit := Trim(q1.FieldByName('PRM1').AsString);
          MatType := 1;
          if (Length(TmpCode) > 0) and
             (TmpCode[1] = '5') then
            MatType := 2;

          if Pos('#', TmpUnit) > 0 then
            TmpUnit := trim(Copy(TmpUnit, 1, Pos('#', TmpUnit) - 1));

          if Length(TmpName) > J then
            J := Length(TmpName);

          AddNewMat(TmpCode, TmpName, TmpUnit, 0, False, MatType);

          if I mod 100 = 0 then
            Application.ProcessMessages;
          q1.Next;
        end;
        DM.Read.Commit;
        ShowMessage('Сверка материалов завершена.');
      except
        on e: Exception do
        begin
          DM.Read.Rollback;
          raise Exception.Create('Ошибка на материале ' + TmpCode + ':' +
            sLineBreak + e.Message);
        end;
      end;
    finally
      q1.Close;
    end;
  finally
    Showmessage('Максимальная длиннта названия = ' + J.ToString);
    DM.Read.Options.AutoCommit := AutoCommitValue;
    Caption := Ca;
  end;
end;

procedure TSprLoaderForm.btnSverkaMechClick(Sender: TObject);
var I, J: Integer;
    Ca: string;
    TmpStr,
    TmpCode,
    TmpName: string;
    Tryd: Double;
    AutoCommitValue: Boolean;
    ds: Char;
begin
  Ca := Caption;
  LoadUnits;
  AutoCommitValue := DM.Read.Options.AutoCommit;
  DM.Read.Options.AutoCommit := False;
  ds := FormatSettings.DecimalSeparator;
  try
    FormatSettings.DecimalSeparator := '.';
    Caption := 'Выполняется открытие справочника....';
    q1.DatabaseName := edtDBFPath.Text;
    q1.SQL.Text := 'select * from Meh';
    q1.Open;
    try
      DM.Read.StartTransaction;
      I := 0;
      J := 0;
      try
        while not q1.Eof do
        begin
          Inc(I);
          Caption := I.ToString;
          TmpCode := Trim(q1.FieldByName('OBOSN').AsString);
          TmpName := Trim(q1.FieldByName('NAIM').AsString);
          TmpStr := Trim(q1.FieldByName('PRM1').AsString);

          TmpStr := Copy(TmpStr, 3, Length(TmpStr) - 2);
          TmpStr := Copy(TmpStr, 1, Pos('#', TmpStr) - 1);
          Tryd := StrToFloatDef(TmpStr, 0);

          if Length(TmpName) > J then
            J := Length(TmpName);

          AddNewMech(TmpCode, TmpName, 'маш.-ч', 0, False, Tryd, True);

          if I mod 100 = 0 then
            Application.ProcessMessages;
          q1.Next;
        end;
        DM.Read.Commit;
        ShowMessage('Сверка механизмов завершена.');
      except
        on e: Exception do
        begin
          DM.Read.Rollback;
          raise Exception.Create('Ошибка на механизме ' + TmpCode + ':' +
            sLineBreak + e.Message);
        end;
      end;
    finally
      q1.Close;
    end;
  finally
    Showmessage('Максимальная длиннта названия = ' + J.ToString);
    DM.Read.Options.AutoCommit := AutoCommitValue;
    Caption := Ca;
    FormatSettings.DecimalSeparator := ds;
  end;
end;

function TSprLoaderForm.GetRateID(ACode: string): Integer;
begin
  Result := -1;
  //Проверяет есть ли такой уже в базе
  DM.qrDifferent.SQL.Text :=
    'Select NORMATIV_ID from normativg where ' +
    '(NORM_NUM = :NORM_NUM) and (NORM_BASE = 0)';
  DM.qrDifferent.ParamByName('NORM_NUM').Value := ACode;
  DM.qrDifferent.Active := True;
  try
    if not DM.qrDifferent.IsEmpty then
      Result := DM.qrDifferent.Fields[0].AsInteger;
  finally
    DM.qrDifferent.Active := False;
  end;
end;

procedure TSprLoaderForm.AddRateWork(ARateID: Integer;
  AZTRab, AZTMach, ARazrad: Double);
var ZTRabID, ZTMachID, RazradID: Integer;

procedure Upsert(AID, AWork: Integer; AValue: Double);
begin
  if AID > 0 then
  begin
    DM.qrDifferent.SQL.Text :=
      'Update normativwork set NORMA = :NORMA where ID = :ID';
    DM.qrDifferent.ParamByName('NORMA').Value := AValue;
    DM.qrDifferent.ParamByName('ID').Value := AID;
    DM.qrDifferent.ExecSQL;
  end
  else
  begin
    if AValue = 0 then
      Exit;

    DM.qrDifferent.SQL.Text := 'Select GetNewSprID(:TypeID, 0)';
    DM.qrDifferent.ParamByName('TypeID').Value := C_MANID_NORM_WORK;
    DM.qrDifferent.Active := True;
    try
      AID := DM.qrDifferent.Fields[0].AsInteger;
    finally
      DM.qrDifferent.Active := False;
    end;

    DM.qrDifferent.SQL.Text :=
      'Insert into normativwork ' +
      '(ID, NORMATIV_ID, WORK_ID, NORMA, BASE) ' +
      'values ' +
      '(:ID, :NORMATIV_ID, :WORK_ID, :NORMA, 0)';
    DM.qrDifferent.ParamByName('ID').Value := AID;
    DM.qrDifferent.ParamByName('NORMATIV_ID').Value := ARateID;
    DM.qrDifferent.ParamByName('WORK_ID').Value := AWork;
    DM.qrDifferent.ParamByName('NORMA').Value := AValue;
    DM.qrDifferent.ExecSQL;
  end;
end;

begin
  ZTRabID := 0;
  ZTMachID := 0;
  RazradID := 0;

  DM.qrDifferent.SQL.Text :=
    'Select ID, WORK_ID from normativwork where ' +
    '(NORMATIV_ID = :NORMATIV_ID) and (BASE = 0)';
  DM.qrDifferent.ParamByName('NORMATIV_ID').Value := ARateID;
  DM.qrDifferent.Active := True;
  try
    while not DM.qrDifferent.Eof do
    begin
      case DM.qrDifferent.Fields[1].AsInteger of
      1: RazradID := DM.qrDifferent.Fields[0].AsInteger;
      2: ZTRabID := DM.qrDifferent.Fields[0].AsInteger;
      3: ZTMachID := DM.qrDifferent.Fields[0].AsInteger;
      end;
      DM.qrDifferent.Next;
    end;
  finally
    DM.qrDifferent.Active := False;
  end;

  Upsert(RazradID, 1, ARazrad);
  Upsert(ZTRabID, 2, AZTRab);
  Upsert(ZTMachID, 3, AZTMach);
end;

function TSprLoaderForm.GetMatNormID(ARateID, AMatID: Integer): Integer;
begin
  Result := -1;
  //Проверяет есть ли такой уже в базе
  DM.qrDifferent.SQL.Text :=
    'Select ID from materialnorm where ' +
    '(NORMATIV_ID = :NORMATIV_ID) and ' +
    '(MATERIAL_ID = :MATERIAL_ID) and (BASE = 0)';
  DM.qrDifferent.ParamByName('NORMATIV_ID').Value := ARateID;
  DM.qrDifferent.ParamByName('MATERIAL_ID').Value := AMatID;
  DM.qrDifferent.Active := True;
  try
    if not DM.qrDifferent.IsEmpty then
      Result := DM.qrDifferent.Fields[0].AsInteger;
  finally
    DM.qrDifferent.Active := False;
  end;
end;

function TSprLoaderForm.GetMechNormID(ARateID, AMechID: Integer): Integer;
begin
  Result := -1;
  //Проверяет есть ли такой уже в базе
  DM.qrDifferent.SQL.Text :=
    'Select ID from mechanizmnorm where ' +
    '(NORMATIV_ID = :NORMATIV_ID) and ' +
    '(MECHANIZM_ID = :MECHANIZM_ID) and (BASE = 0)';
  DM.qrDifferent.ParamByName('NORMATIV_ID').Value := ARateID;
  DM.qrDifferent.ParamByName('MECHANIZM_ID').Value := AMechID;
  DM.qrDifferent.Active := True;
  try
    if not DM.qrDifferent.IsEmpty then
      Result := DM.qrDifferent.Fields[0].AsInteger;
  finally
    DM.qrDifferent.Active := False;
  end;
end;

procedure TSprLoaderForm.AddRateMat(ARateCode, AMatStr, APMatStr: string;
  ARateID: Integer);
var MatList: TStringList;
    I: Integer;
    Code,
    MatName,
    MatUnit: string;
    MatNormaStr: string;
    MatNorma: Double;
    MatID, ID, UnitID: Integer;
    MatIdStr: string;
begin
  MatList := TStringList.Create;
  try
    MatIdStr := '';

    AMatStr := StringReplace(Copy(AMatStr, 1, Length(AMatStr) - 1),
      '#', #13#10, [rfReplaceAll]);
    MatList.Text := AMatStr;

    for I := 0 to MatList.Count - 1 do
    begin
      Code := Copy(MatList[I], 1, Pos('~', MatList[I]) - 1);
      MatNorma := StrToFloatDef(Copy(MatList[I], Pos('~', MatList[I]) + 1, 10), 0);
      MatID := GetMatID(Code);

      if MatIdStr <> '' then
        MatIdStr := MatIdStr + ',';
      MatIdStr := MatIdStr + MatID.ToString;

      if MatID > 0 then
      begin
        ID := GetMatNormID(ARateID, MatID);
        if ID > 0 then
        begin
          DM.qrDifferent.SQL.Text :=
            'Update materialnorm set NORM_RAS = :NORM_RAS where ID = :ID';
          DM.qrDifferent.ParamByName('NORM_RAS').Value := FloatToStr(MatNorma);
          DM.qrDifferent.ParamByName('ID').Value := ID;
          DM.qrDifferent.ExecSQL;
        end
        else
        begin
          DM.qrDifferent.SQL.Text := 'Select GetNewSprID(:TypeID, 0)';
          DM.qrDifferent.ParamByName('TypeID').Value := C_MANID_NORM_MAT;
          DM.qrDifferent.Active := True;
          try
            ID := DM.qrDifferent.Fields[0].AsInteger;
          finally
            DM.qrDifferent.Active := False;
          end;

          DM.qrDifferent.SQL.Text :=
            'Insert into materialnorm ' +
            '(ID, NORMATIV_ID, MATERIAL_ID, NORM_RAS, BASE) ' +
            'values ' +
            '(:ID, :NORMATIV_ID, :MATERIAL_ID, :NORM_RAS, 0)';
          DM.qrDifferent.ParamByName('ID').Value := ID;
          DM.qrDifferent.ParamByName('NORMATIV_ID').Value := ARateID;
          DM.qrDifferent.ParamByName('MATERIAL_ID').Value := MatID;
          DM.qrDifferent.ParamByName('NORM_RAS').Value := FloatToStr(MatNorma);
          DM.qrDifferent.ExecSQL;
        end;
      end
      else
        memError.Lines.Add('Не найден материал ' + Code + ' в расценке ' + ARateCode);
    end;

    MatList.Clear;
    AMatStr := StringReplace(Copy(APMatStr, 1, Length(APMatStr) - 1),
      '#', #13#10, [rfReplaceAll]);
    MatList.Text := AMatStr;

    for I := 0 to MatList.Count - 1 do
    begin

      Code := Copy(MatList[I], 1, Pos('''', MatList[I]) - 1);
      MatList[I] := Copy(MatList[I], Pos('''', MatList[I]) + 1,  250);
      MatName := Copy(MatList[I], 1, Pos('''', MatList[I]) - 1);
      MatList[I] := Copy(MatList[I], Pos('''', MatList[I]) + 1,  250);
      MatUnit := Copy(MatList[I], 1, Pos('''', MatList[I]) - 1);
      MatNormaStr := Copy(MatList[I], Pos('''', MatList[I]) + 1,  250);
      MatNorma := StrToFloatDef(MatNormaStr, 0);

      MatID := AddNewPMat(Code, MatName, MatUnit);

      if MatIdStr <> '' then
        MatIdStr := MatIdStr + ',';
      MatIdStr := MatIdStr + MatID.ToString;

      ID := GetMatNormID(ARateID, MatID);
      if ID > 0 then
      begin
        DM.qrDifferent.SQL.Text :=
          'Update materialnorm set NORM_RAS = :NORM_RAS where ID = :ID';
        if MatNormaStr = 'П' then
          DM.qrDifferent.ParamByName('NORM_RAS').Value := MatNormaStr
        else
          DM.qrDifferent.ParamByName('NORM_RAS').Value := FloatToStr(MatNorma);
        DM.qrDifferent.ParamByName('ID').Value := ID;
        DM.qrDifferent.ExecSQL;
      end
      else
      begin
        DM.qrDifferent.SQL.Text := 'Select GetNewSprID(:TypeID, 0)';
        DM.qrDifferent.ParamByName('TypeID').Value := C_MANID_NORM_MAT;
        DM.qrDifferent.Active := True;
        try
          ID := DM.qrDifferent.Fields[0].AsInteger;
        finally
          DM.qrDifferent.Active := False;
        end;

        DM.qrDifferent.SQL.Text :=
          'Insert into materialnorm ' +
          '(ID, NORMATIV_ID, MATERIAL_ID, NORM_RAS, BASE) ' +
          'values ' +
          '(:ID, :NORMATIV_ID, :MATERIAL_ID, :NORM_RAS, 0)';
        DM.qrDifferent.ParamByName('ID').Value := ID;
        DM.qrDifferent.ParamByName('NORMATIV_ID').Value := ARateID;
        DM.qrDifferent.ParamByName('MATERIAL_ID').Value := MatID;
        if MatNormaStr = 'П' then
          DM.qrDifferent.ParamByName('NORM_RAS').Value := MatNormaStr
        else
          DM.qrDifferent.ParamByName('NORM_RAS').Value := FloatToStr(MatNorma);
        DM.qrDifferent.ExecSQL;
      end;
    end;

    if MatIdStr = '' then
      DM.qrDifferent.SQL.Text :=
        'Delete from materialnorm where (NORMATIV_ID = :NORMATIV_ID)'
    else
      DM.qrDifferent.SQL.Text :=
        'Delete from materialnorm where (NORMATIV_ID = :NORMATIV_ID) and ' +
        'not(MATERIAL_ID in (' + MatIdStr + '))';
    DM.qrDifferent.ParamByName('NORMATIV_ID').Value := ARateID;
    DM.qrDifferent.ExecSQL;

  finally
    FreeAndNil(MatList);
  end;
end;

procedure TSprLoaderForm.AddRateMech(ARateCode, AMechStr: string; ARateID: Integer);
var MechList: TStringList;
    I: Integer;
    Code: String;
    MechNorma: Double;
    MechID, ID: Integer;
    MechIdStr: string;
begin
  MechList := TStringList.Create;
  try
    AMechStr := StringReplace(Copy(AMechStr, 1, Length(AMechStr) - 1),
      '#', #13#10, [rfReplaceAll]);
    MechList.Text := AMechStr;
    MechIdStr := '';
    for I := 0 to MechList.Count - 1 do
    begin
      Code := Copy(MechList[I], 1, Pos('~', MechList[I]) - 1);

      MechNorma := StrToFloatDef(Copy(MechList[I], Pos('~', MechList[I]) + 1, 10), 0);
      MechID := GetMechID(Code);

      if MechIdStr <> '' then
        MechIdStr := MechIdStr + ',';
      MechIdStr := MechIdStr + MechID.ToString;

      if MechID > 0 then
      begin
        ID := GetMechNormID(ARateID, MechID);
        if ID > 0 then
        begin
          DM.qrDifferent.SQL.Text :=
            'Update mechanizmnorm set NORM_RAS = :NORM_RAS where ID = :ID';
          DM.qrDifferent.ParamByName('NORM_RAS').Value := FloatToStr(MechNorma);
          DM.qrDifferent.ParamByName('ID').Value := ID;
          DM.qrDifferent.ExecSQL;
        end
        else
        begin
          DM.qrDifferent.SQL.Text := 'Select GetNewSprID(:TypeID, 0)';
          DM.qrDifferent.ParamByName('TypeID').Value := C_MANID_NORM_MECH;
          DM.qrDifferent.Active := True;
          try
            ID := DM.qrDifferent.Fields[0].AsInteger;
          finally
            DM.qrDifferent.Active := False;
          end;

          DM.qrDifferent.SQL.Text :=
            'Insert into mechanizmnorm ' +
            '(ID, NORMATIV_ID, MECHANIZM_ID, NORM_RAS, BASE) ' +
            'values ' +
            '(:ID, :NORMATIV_ID, :MECHANIZM_ID, :NORM_RAS, 0)';
          DM.qrDifferent.ParamByName('ID').Value := ID;
          DM.qrDifferent.ParamByName('NORMATIV_ID').Value := ARateID;
          DM.qrDifferent.ParamByName('MECHANIZM_ID').Value := MechID;
          DM.qrDifferent.ParamByName('NORM_RAS').Value := FloatToStr(MechNorma);
          DM.qrDifferent.ExecSQL;
        end;
      end
      else
        memError.Lines.Add('Не найден механизм ' + Code + ' в расценке ' + ARateCode);
    end;

    if MechIdStr = '' then
      DM.qrDifferent.SQL.Text :=
        'Delete from mechanizmnorm where (NORMATIV_ID = :NORMATIV_ID)'
    else
      DM.qrDifferent.SQL.Text :=
        'Delete from mechanizmnorm where (NORMATIV_ID = :NORMATIV_ID) and ' +
        'not(MECHANIZM_ID in (' + MechIdStr + '))';
    DM.qrDifferent.ParamByName('NORMATIV_ID').Value := ARateID;
    DM.qrDifferent.ExecSQL;
  finally
    FreeAndNil(MechList);
  end;
end;

procedure TSprLoaderForm.AddRateDesc(const ARateDesc: string; ARateID: Integer;
  AIzmRec: PIzmRec);
var ID: Integer;
begin
  ID := -1;
  DM.qrDifferent.SQL.Text :=
    'insert into normdesc ' +
    '(NORMATIV_ID, WorkDesc, BASE, PBEGIN_NAME, PBEGIN_NOM, PBEGIN_DATE) values ' +
    '(:NORMATIV_ID, :WorkDesc, 0, :PBEGIN_NAME, :PBEGIN_NOM, :PBEGIN_DATE) ' +
    'ON DUPLICATE KEY UPDATE WorkDesc = :WorkDesc, PBEGIN_NAME = :PBEGIN_NAME, ' +
    'PBEGIN_NOM = :PBEGIN_NOM, PBEGIN_DATE = :PBEGIN_DATE';
  DM.qrDifferent.ParamByName('NORMATIV_ID').Value := ARateID;
  DM.qrDifferent.ParamByName('WorkDesc').Value := ARateDesc;

  if Assigned(AIzmRec) then
  begin
    DM.qrDifferent.ParamByName('PBEGIN_NAME').Value := AIzmRec.Prikaz;
    DM.qrDifferent.ParamByName('PBEGIN_NOM').Value := AIzmRec.PNom;
    if AIzmRec.PDate > 0 then
      DM.qrDifferent.ParamByName('PBEGIN_DATE').Value := AIzmRec.PDate;
  end
  else
  begin
    DM.qrDifferent.ParamByName('PBEGIN_NAME').Value := Null;
    DM.qrDifferent.ParamByName('PBEGIN_NOM').Value := Null;
    DM.qrDifferent.ParamByName('PBEGIN_DATE').Value := Null;
  end;
  DM.qrDifferent.ExecSQL;
end;

procedure TSprLoaderForm.ParsRateIZM(AIzm: string; var AIzmArray: TIzmArray);
var TmpList1, TmpList2: TStringList;
    I, J: Integer;
    DF: string;
begin
  TmpList1 := TStringList.Create;
  TmpList2 := TStringList.Create;
  DF := FormatSettings.ShortDateFormat;
  try
    FormatSettings.ShortDateFormat := 'dd.mm.yyyy';
    AIzm := StringReplace(Copy(AIzm, 1, Length(AIzm)), '#', sLineBreak, [rfReplaceAll]);
    TmpList1.Text := AIzm;
    SetLength(AIzmArray, TmpList1.Count);
    for I := 0 to TmpList1.Count - 1 do
    begin
      TmpList2.Text :=
        StringReplace(Copy(TmpList1[I], 1, Length(TmpList1[I])), '''',
         sLineBreak, [rfReplaceAll]);
      for J := 0 to TmpList2.Count - 1 do
        case J of
        0: AIzmArray[I].IzmDate := StrToDateDef(TmpList2[J], 0);
        1: AIzmArray[I].Prikaz := TmpList2[J];
        2: AIzmArray[I].PNom := TmpList2[J];
        3: AIzmArray[I].PDate := StrToDateDef(TmpList2[J], 0);
        end;
    end;
  finally
    FormatSettings.ShortDateFormat := DF;
    FreeAndNil(TmpList1);
    FreeAndNil(TmpList2);
  end;
end;

function TSprLoaderForm.GetDirectoryID(ACode: string): Integer;
var Str1,
    Str2: string;
    I: Integer;
    MaimNode: string;
begin
  Result := -1;
  I := Pos('-', ACode);
  Str1 := Copy(ACode, 1, I - 1);
  if Length(Str1) = 0 then
    Exit;

  if (Str1[1] = 'Е') then
  begin
    DM.qrDifferent.SQL.Text :=
      'Select tree_data from normativ_directory where (first_name = :first_name)';
    DM.qrDifferent.ParamByName('first_name').Value := Str1;
    DM.qrDifferent.Active := True;
    try
      if not DM.qrDifferent.IsEmpty then
        MaimNode := DM.qrDifferent.Fields[0].AsString
      else
        Exit;
    finally
      DM.qrDifferent.Active := False;
    end;

    Str2 := 'Таблица ' + Copy(ACode, 2, PosEx('-', ACode, I + 1) - 2);

    DM.qrDifferent.SQL.Text :=
      'Select normativ_directory_id from normativ_directory ' +
      'where (first_name = :first_name) and (tree_data like ''' + MaimNode + '%'')';
    DM.qrDifferent.ParamByName('first_name').Value := Str1;
    DM.qrDifferent.Active := True;
    try
      if not DM.qrDifferent.IsEmpty then
        Result := DM.qrDifferent.Fields[0].AsInteger;
    finally
      DM.qrDifferent.Active := False;
    end;
  end;

  if (Str1[1] = 'Ц') then
  begin
    DM.qrDifferent.SQL.Text :=
      'Select tree_data from normativ_directory where (first_name = :first_name)';
    DM.qrDifferent.ParamByName('first_name').Value := Str1;
    DM.qrDifferent.Active := True;
    try
      if not DM.qrDifferent.IsEmpty then
        MaimNode := DM.qrDifferent.Fields[0].AsString
      else
        Exit;
    finally
      DM.qrDifferent.Active := False;
    end;

    Str2 := 'Группа ' + Copy(ACode, I + 1, PosEx('-', ACode, I + 1) - (I + 1));

    DM.qrDifferent.SQL.Text :=
      'Select normativ_directory_id from normativ_directory ' +
      'where (first_name = :first_name) and (tree_data like ''' + MaimNode + '%'')';
    DM.qrDifferent.ParamByName('first_name').Value := Str1;
    DM.qrDifferent.Active := True;
    try
      if not DM.qrDifferent.IsEmpty then
        Result := DM.qrDifferent.Fields[0].AsInteger;
    finally
      DM.qrDifferent.Active := False;
    end;
  end;
end;

procedure TSprLoaderForm.btnSverkaRateClick(Sender: TObject);
var I, J, RateID: Integer;
    Ca: string;
    TmpCode,
    TmpName,
    TmpUnit,
    TmpStr,
    Izm,
    SW: string;
    AutoCommitValue: Boolean;
    MatType: Byte;
    ZTRab,
    ZTMach,
    Razrad: Double;
    ds: Char;
    TmpUnitID: Integer;
    IzmArray: TIzmArray;
    IzmRec: PIzmRec;
    DateBegin: TDateTime;
    Active: Byte;
    DirID: Integer;
    NormType: Integer;
begin
  Ca := Caption;
  memError.Clear;
  LoadUnits;
  AutoCommitValue := DM.Read.Options.AutoCommit;
  DM.Read.Options.AutoCommit := False;
  ds := FormatSettings.DecimalSeparator;
  try
    FormatSettings.DecimalSeparator := '.';
    Caption := 'Выполняется открытие справочника....';
    q1.DatabaseName := edtDBFPath.Text;
    q1.SQL.Text := 'select * from RSCER';
    q1.Open;
    try
      DM.Read.StartTransaction;
      I := 0;
      J := 0;
      try
        while not q1.Eof do
        begin
          Inc(I);
          Caption := I.ToString;
          TmpCode := Trim(q1.FieldByName('OBOSN').AsString).ToUpper;
          RateID := GetRateID(TmpCode);
          TmpName := Trim(q1.FieldByName('NAIM').AsString).ToUpper;
          ParsRateIZM(Trim(q1.FieldByName('IZM').AsString), IzmArray);
          SW := Trim(q1.FieldByName('TXT').AsString);

          TmpStr := Trim(q1.FieldByName('PRM').AsString);
          TmpUnit := Trim(Copy(TmpStr, 1, Pos('#', TmpStr) - 1));
          TmpStr := Copy(TmpStr, Pos('#', TmpStr) + 2,  250);
          ZTRab := StrToFloatDef(Copy(TmpStr, 1, Pos('#', TmpStr) - 1), 0);
          TmpStr := Copy(TmpStr, Pos('#', TmpStr) + 1,  250);
          Razrad := StrToFloatDef(Copy(TmpStr, 1, Pos('#', TmpStr) - 1), 0);
          TmpStr := Copy(TmpStr, Pos('#', TmpStr) + 3,  250);
          ZTMach := StrToFloatDef(Copy(TmpStr, 1, Pos('#', TmpStr) - 1), 0);

          if Length(TmpName) > J then
            J := Length(TmpName);

          TmpUnitID := GetUnitID(TmpUnit);

          DateBegin := EncodeDate(2012, 1, 1);
          IzmRec := nil;
          if Length(IzmArray) > 0 then
          begin
            IzmRec := @IzmArray[0];
            DateBegin := IzmArray[0].IzmDate;
          end;

          Active := 1; //Активна
          if (Length(TmpCode) > 0) and
             (TmpCode[Length(TmpCode)] = '*') then
            Active := 2;

          if RateID > -1 then
          begin
            DM.qrDifferent.SQL.Text :=
              'Update normativg set NORM_CAPTION = :NORM_CAPTION, ' +
              'UNIT_ID = :UNIT_ID, date_beginer = :date_beginer, ' +
              'NORM_ACTIVE = :NORM_ACTIVE ' +
              'where NORMATIV_ID = :NORMATIV_ID';
            DM.qrDifferent.ParamByName('NORM_CAPTION').Value := TmpName;
            DM.qrDifferent.ParamByName('UNIT_ID').Value := TmpUnitID;
            DM.qrDifferent.ParamByName('date_beginer').Value := DateBegin;
            DM.qrDifferent.ParamByName('NORM_ACTIVE').Value := Active;
            DM.qrDifferent.ParamByName('NORMATIV_ID').Value := RateID;
            DM.qrDifferent.ExecSQL;
          end
          else
          begin
            DirID := GetDirectoryID(TmpCode);
            RateID := GetNewID(C_MANID_NORM, 0);
            NormType := 0;

            if (Length(TmpCode) > 0) and
               (TmpCode[1] =  '0') then
              NormType := 1;

            if (Length(TmpCode) > 3) and
               (Copy(TmpCode, 1, 3) =  'УНР') then
              NormType := 2;

            DM.qrDifferent.SQL.Text :=
              'INSERT INTO normativg(NORMATIV_ID, NORM_NUM, NORM_CAPTION, ' +
              'UNIT_ID, NORM_ACTIVE, normativ_directory_id, NORM_BASE, NORM_TYPE, ' +
              'date_beginer) values (:NORMATIV_ID, :NORM_NUM, :NORM_CAPTION, ' +
              ':UNIT_ID, :NORM_ACTIVE, :normativ_directory_id, 0, :NORM_TYPE, ' +
              ':date_beginer)';
            DM.qrDifferent.ParamByName('NORMATIV_ID').Value := RateID;
            DM.qrDifferent.ParamByName('NORM_NUM').Value := TmpCode;
            DM.qrDifferent.ParamByName('NORM_CAPTION').Value := TmpName;
            DM.qrDifferent.ParamByName('UNIT_ID').Value := TmpUnitID;
            DM.qrDifferent.ParamByName('NORM_ACTIVE').Value := Active;
            if DirID > 0 then
              DM.qrDifferent.ParamByName('normativ_directory_id').Value := DirID
            else
              DM.qrDifferent.ParamByName('normativ_directory_id').Value := Null;
            DM.qrDifferent.ParamByName('NORM_TYPE').Value := NormType;
            DM.qrDifferent.ParamByName('date_beginer').Value := DateBegin;
            DM.qrDifferent.ExecSQL;
          end;

          AddRateWork(RateID, ZTRab, ZTMach, Razrad);
          AddRateMat(TmpCode, Trim(q1.FieldByName('MAT').AsString).ToUpper,
            Trim(q1.FieldByName('RNMAT').AsString).ToUpper, RateID);
          AddRateMech(TmpCode, Trim(q1.FieldByName('MEH').AsString).ToUpper, RateID);
          AddRateDesc(SW, RateID, IzmRec);

          if I mod 100 = 0 then
            Application.ProcessMessages;
          q1.Next;
        end;

     //   DM.qrDifferent.SQL.Text := 'CALL `UpdateNormSortField`()';
     //   DM.qrDifferent.ExecSQL;

        DM.Read.Commit;
        ShowMessage('Сверка расценок завершена.');
      except
        on e: Exception do
        begin
          DM.Read.Rollback;
          raise Exception.Create('Ошибка на расценке ' + TmpCode + ':' +
            sLineBreak + e.Message);
        end;
      end;
    finally
      q1.Close;
    end;
  finally
    Showmessage('Максимальная длинна названия = ' + J.ToString);
    DM.Read.Options.AutoCommit := AutoCommitValue;
    Caption := Ca;
    FormatSettings.DecimalSeparator := ds;
  end;
end;

procedure TSprLoaderForm.btnUpdRatesClick(Sender: TObject);
var ExlApp,
    WorkSheet1,
    WorkSheet2,
    WorkSheet3: OleVariant;
    FRateData,
    FMatData,
    FMechData: OleVariant;
    I, J, N,
    Rows1, Rows2, Rows3: Integer;
    Cols1, Cols2, Cols3: Integer;
    AutoCommitValue: Boolean;
    TmpStr: string;
    SborChar: Char;
    Act, MatType: Byte;
    RateCode: string;
    RateDate: TDateTime;
    newID, newID1: Variant;
    TmpUnitID: Integer;
    MatID, MechID: Integer;
    SborID1, SborID2: Integer;

procedure DeactivateRate(ARateNum: string; AEndDate: TDateTime);
begin
  DM.qrDifferent.SQL.Text :=
    'Update normativg set NORM_ACTIVE = 2, date_end = :date_end ' +
    'where NORM_NUM = :NORM_NUM and  NORM_BASE = 0';
  DM.qrDifferent.ParamByName('date_end').Value := AEndDate;
  DM.qrDifferent.ParamByName('NORM_NUM').Value := ARateNum;
  DM.qrDifferent.ExecSQL;
end;

function ChackRateExist(ARateNum: string; ABeginDate: TDateTime): Boolean;
begin
  DM.qrDifferent.SQL.Text := 'select NORM_NUM from normativg where ' +
    'NORM_NUM = :NORM_NUM and NORM_ACTIVE = 1 and date_beginer = :date_beginer';
  DM.qrDifferent.ParamByName('NORM_NUM').Value := ARateNum;
  DM.qrDifferent.ParamByName('date_beginer').Value := ABeginDate;
  DM.qrDifferent.Active := True;
  Result := not DM.qrDifferent.IsEmpty;
  DM.qrDifferent.Active := False;
end;

begin
  if Application.MessageBox(
    PChar('Обновить справочник расценок из ''' + edtUpdRates.Text + '''?'),
    'Загрузка данных', MB_OKCANCEL + MB_ICONQUESTION) = mrCancel then
    Exit;
  ChackFileExsist(edtUpdRates.Text);

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
      ExlApp.WorkBooks.Open(edtUpdRates.Text);
      WorkSheet1 := ExlApp.ActiveWorkbook.Sheets.Item[1];
      WorkSheet2 := ExlApp.ActiveWorkbook.Sheets.Item[2];
      WorkSheet3 := ExlApp.ActiveWorkbook.Sheets.Item[3];
    except
      on e: exception do
        raise Exception.Create('Ошибка открытия Excel документа:' + e.Message);
    end;

    Rows1 := WorkSheet1.UsedRange.Rows.Count;
    Rows2 := WorkSheet2.UsedRange.Rows.Count;
    Rows3 := WorkSheet2.UsedRange.Rows.Count;

    Cols1 := WorkSheet1.UsedRange.Rows.Count;
    Cols2 := WorkSheet2.UsedRange.Rows.Count;
    Cols3 := WorkSheet3.UsedRange.Rows.Count;

    FRateData :=
      WorkSheet1.Range[WorkSheet1.Cells[2, 1].Address,
      WorkSheet1.Cells[Rows1, Cols1].Address].Value;

    FMechData :=
      WorkSheet2.Range[WorkSheet2.Cells[2, 1].Address,
      WorkSheet2.Cells[Rows2, Cols2].Address].Value;

    FMatData :=
      WorkSheet3.Range[WorkSheet3.Cells[2, 1].Address,
      WorkSheet3.Cells[Rows3, Cols3].Address].Value;

    DM.Read.StartTransaction;
    try
      for I := 1 to Rows1 - 1 do
      begin
        TmpStr := VarToStr(FRateData[I, 4]).ToLower;
        Act := 0;
        if TmpStr = 'new' then Act := 1
        else if TmpStr = 'zam' then Act := 2
        else if TmpStr = 'null' then Act := 3
        else
        begin
          memUpdRateRes.Lines.Add('Строка ' + I.ToString +
            ': Неизвестный тип действия по строке');
          Continue;
        end;

        RateCode := VarToStr(FRateData[I, 1]);
        RateDate :=  ConvertStrToDate(VarToStr(FRateData[I, 5]));

        case Act of
        1, 2:
        begin
          if ChackRateExist(RateCode, RateDate) then
          begin
            memUpdRateRes.Lines.Add('Строка ' + I.ToString +
              ': Акстивная расценка ' + RateCode + ' от ' + DateToStr(RateDate) +
              ' уже существует');
            Continue;
          end;
          DeactivateRate(RateCode, RateDate - 1);

          SborChar := #0;
          TmpStr := VarToStr(FRateData[I, 12]);
          if Length(TmpStr) > 0 then
            SborChar := TmpStr[1];

          SborID1 := -1;
          DM.qrDifferent.SQL.Text :=
            'Select normativ_directory_id from normativ_directory ' +
            'where (first_name = :first_name) and (type_directory = :type_directory)';
          DM.qrDifferent.ParamByName('first_name').Value := VarToStr(FRateData[I, 12]);
          DM.qrDifferent.ParamByName('type_directory').Value := 2;
          DM.qrDifferent.Active := True;
          try
            if not DM.qrDifferent.IsEmpty then
              SborID1 := DM.qrDifferent.Fields[0].AsInteger;
          finally
            DM.qrDifferent.Active := False;
          end;

          if SborID1 = -1 then
          begin
            memUpdRateRes.Lines.Add('Строка ' + I.ToString + ': Неизветсный сборник');
            Continue;
          end;

          if SborChar = 'Е' then
          begin
            SborID1 := AddNewNormDir(VarToStr(FRateData[I, 12]),
              VarToStr(FRateData[I, 18]), SborID1, 3, True);

            SborID1 := AddNewNormDir(VarToStr(FRateData[I, 19]),
              VarToStr(FRateData[I, 21]), SborID1, 4, True);

          end
          else if SborChar = 'Ц' then
          begin
            SborID1 := AddNewNormDir(VarToStr(FRateData[I, 13]),
              VarToStr(FRateData[I, 15]), SborID1, 3, True);

            SborID1 := AddNewNormDir(VarToStr(FRateData[I, 16]),
              VarToStr(FRateData[I, 18]), SborID1, 4, True);

            SborID1 := AddNewNormDir(VarToStr(FRateData[I, 19]),
              VarToStr(FRateData[I, 21]), SborID1, 5, True);

            if VarToStr(FRateData[I, 22]) <> '' then
              AddNewNormDir(VarToStr(FRateData[I, 22]), Null, SborID1, 6, True);
            if VarToStr(FRateData[I, 23]) <> '' then
              AddNewNormDir(VarToStr(FRateData[I, 23]), Null, SborID1, 6, True);
            if VarToStr(FRateData[I, 24]) <> '' then
              AddNewNormDir(VarToStr(FRateData[I, 24]), Null, SborID1, 6, True);
            if VarToStr(FRateData[I, 25]) <> '' then
              AddNewNormDir(VarToStr(FRateData[I, 25]), Null, SborID1, 6, True);
            if VarToStr(FRateData[I, 26]) <> '' then
              AddNewNormDir(VarToStr(FRateData[I, 26]), Null, SborID1, 6, True);
            if VarToStr(FRateData[I, 27]) <> '' then
              AddNewNormDir(VarToStr(FRateData[I, 27]), Null, SborID1, 6, True);
            if VarToStr(FRateData[I, 28]) <> '' then
              AddNewNormDir(VarToStr(FRateData[I, 28]), Null, SborID1, 6, True);
            if VarToStr(FRateData[I, 29]) <> '' then
              AddNewNormDir(VarToStr(FRateData[I, 29]), Null, SborID1, 6, True);
            if VarToStr(FRateData[I, 30]) <> '' then
              AddNewNormDir(VarToStr(FRateData[I, 30]), Null, SborID1, 6, True);
          end
          else
          begin
            memUpdRateRes.Lines.Add('Строка ' + I.ToString + ': Неизветсный тип сборника');
            Continue;
          end;

          N := FUnitsName.IndexOf(VarToStr(FRateData[I, 3]).ToLower);
          if N > -1 then
            TmpUnitID := StrToInt(FUnitsID[N])
          else
            TmpUnitID := AddNewUnit(VarToStr(FRateData[I, 3]));

          newID := GetNewID(C_MANID_NORM, 0);

          DM.qrDifferent.SQL.Text :=
            'INSERT INTO normativg(NORMATIV_ID, NORM_NUM, NORM_CAPTION, ' +
            'UNIT_ID, NORM_ACTIVE, normativ_directory_id, NORM_BASE, NORM_TYPE, ' +
            'date_beginer) values (:NORMATIV_ID, :NORM_NUM, :NORM_CAPTION, ' +
            ':UNIT_ID, 1, :normativ_directory_id, 0, 0, :date_beginer)';
          DM.qrDifferent.ParamByName('NORMATIV_ID').Value := newID;
          DM.qrDifferent.ParamByName('NORM_NUM').Value := RateCode;
          DM.qrDifferent.ParamByName('NORM_CAPTION').Value := VarToStr(FRateData[I, 2]);
          DM.qrDifferent.ParamByName('UNIT_ID').Value := TmpUnitID;
          DM.qrDifferent.ParamByName('normativ_directory_id').Value := SborID1;
          DM.qrDifferent.ParamByName('date_beginer').Value := RateDate;
          DM.qrDifferent.ExecSQL;

          DM.qrDifferent.SQL.Text :=
            'INSERT INTO normativwork (ID, NORMATIV_ID, WORK_ID, NORMA, BASE) values ' +
            '(:ID, :NORMATIV_ID, :WORK_ID, :NORMA, 0)';

          newID1 := GetNewID(C_MANID_NORM_WORK, 0);
          DM.qrDifferent.ParamByName('ID').Value := newID1;
          DM.qrDifferent.ParamByName('NORMATIV_ID').Value := newID;
          DM.qrDifferent.ParamByName('WORK_ID').Value := 1;
          DM.qrDifferent.ParamByName('NORMA').Value := VarToFloat(FRateData[I, 8]);
          DM.qrDifferent.ExecSQL;

          newID1 := GetNewID(C_MANID_NORM_WORK, 0);
          DM.qrDifferent.ParamByName('ID').Value := newID1;
          DM.qrDifferent.ParamByName('NORMATIV_ID').Value := newID;
          DM.qrDifferent.ParamByName('WORK_ID').Value := 2;
          DM.qrDifferent.ParamByName('NORMA').Value := VarToFloat(FRateData[I, 9]);
          DM.qrDifferent.ExecSQL;

          newID1 := GetNewID(C_MANID_NORM_WORK, 0);
          DM.qrDifferent.ParamByName('ID').Value := newID1;
          DM.qrDifferent.ParamByName('NORMATIV_ID').Value := newID;
          DM.qrDifferent.ParamByName('WORK_ID').Value := 3;
          DM.qrDifferent.ParamByName('NORMA').Value := VarToFloat(FRateData[I, 10]);
          DM.qrDifferent.ExecSQL;

          for J := 1 to Rows2 - 1 do
          begin
            if VarToStr(FMechData[J, 1]) = RateCode then
            begin
              newID1 := GetNewID(C_MANID_NORM_MECH, 0);
              MechID := AddNewMech(VarToStr(FMechData[J, 2]),
                VarToStr(FMechData[J, 3]), VarToStr(FMechData[J, 4]),
                RateDate, False, 0, False);

              DM.qrDifferent.SQL.Text :=
                'INSERT INTO mechanizmnorm (ID, NORMATIV_ID, MECHANIZM_ID, NORM_RAS, BASE) values ' +
                '(:ID, :NORMATIV_ID, :MECHANIZM_ID, :NORM_RAS, 0)';
              DM.qrDifferent.ParamByName('ID').Value := newID1;
              DM.qrDifferent.ParamByName('NORMATIV_ID').Value := newID;
              DM.qrDifferent.ParamByName('MECHANIZM_ID').Value := MechID;
              DM.qrDifferent.ParamByName('NORM_RAS').Value :=
                StringReplace(FMechData[J, 5], ',', '.', []);
              DM.qrDifferent.ExecSQL;
            end;
          end;

          for J := 1 to Rows3 - 1 do
          begin
            if VarToStr(FMechData[J, 1]) = RateCode then
            begin
              newID1 := GetNewID(C_MANID_NORM_MAT, 0);
              MatType := 1;
              if VarToStr(FMatData[J, 5]) = 'П' then
                MatType := 0;

              MatID := AddNewMat(VarToStr(FMatData[J, 2]),
                VarToStr(FMatData[J, 3]), VarToStr(FMatData[J, 4]),
                RateDate, False, MatType);

              DM.qrDifferent.SQL.Text :=
                'INSERT INTO materialnorm (ID, NORMATIV_ID, MATERIAL_ID, NORM_RAS, BASE) values ' +
                '(:ID, :NORMATIV_ID, :MATERIAL_ID, :NORM_RAS, 0)';
              DM.qrDifferent.ParamByName('ID').Value := newID1;
              DM.qrDifferent.ParamByName('NORMATIV_ID').Value := newID;
              DM.qrDifferent.ParamByName('MATERIAL_ID').Value := MatID;
              DM.qrDifferent.ParamByName('NORM_RAS').Value :=
                StringReplace(FMatData[J, 5], ',', '.', []);
              DM.qrDifferent.ExecSQL;
            end;
          end;
        end;
        3:
          DeactivateRate(RateCode, RateDate);
        end;
      end;

     // DM.qrDifferent.SQL.Text := 'CALL `UpdateNormSortField`()';
     // DM.qrDifferent.ExecSQL;

      DM.qrDifferent.SQL.Text := 'CALL `tmp_update_tree`(Null)';
      DM.qrDifferent.ExecSQL;

      DM.Read.Rollback;
      ShowMessage('Загрузка успешно завершена.');
    except
      on e: Exception do
      begin
        DM.Read.Rollback;
        raise Exception.Create('Ошибка на строке ' + (I + 1).ToString + ':' +
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
    WorkSheet3 := Unassigned;
    ExlApp := Unassigned;
    CoUninitialize;
  end;
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
              not cboxUpdJBIName.Checked, 2);

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

function TSprLoaderForm.GetMechID(AMatCode: string): Integer;
begin
  //Проверяет есть ли такой уже в базе
  DM.qrDifferent.SQL.Text :=
    'Select MECHANIZM_ID from mechanizm where ' +
    '(MECH_CODE = :MECH_CODE) and (BASE = 0)';
  Result := -1;
  DM.qrDifferent.ParamByName('MECH_CODE').Value := AMatCode;
  DM.qrDifferent.Active := True;
  try
    if not DM.qrDifferent.IsEmpty then
      Result := DM.qrDifferent.Fields[0].AsInteger;
  finally
    DM.qrDifferent.Active := False;
  end;
end;

function TSprLoaderForm.AddNewMech(ACode, AName, AUnit: string; ADate: TDateTime;
  ANoUpdate: Boolean; ATrud: Double; AUpdateTrud: Boolean): Integer;
var TmpUnitID: Integer;
    TmpStr: string;
begin
  //Получает код ед. изм.
  TmpUnitID := GetUnitID(AUnit);

  ACode := Trim(ACode).ToUpper;
  AName := Trim(AName).ToUpper;

  Result := GetMechID(ACode);

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
      '(MECHANIZM_ID, MECH_CODE, MECH_NAME, UNIT_ID, MECH_PH, BASE) ' +
      'values ' +
      '(:MECHANIZM_ID, :MECH_CODE, :MECH_NAME, :UNIT_ID, :MECH_PH, 0)';
    DM.qrDifferent.ParamByName('MECH_CODE').Value := ACode;
    DM.qrDifferent.ParamByName('MECH_NAME').Value := AName;
    DM.qrDifferent.ParamByName('MECHANIZM_ID').Value := Result;
    DM.qrDifferent.ParamByName('UNIT_ID').Value := TmpUnitID;
    DM.qrDifferent.ParamByName('MECH_PH').Value := ATrud;
    DM.qrDifferent.ExecSQL;
  end
  else
  begin
    if not ANoUpdate then
    begin
      TmpStr := '';
      if AUpdateTrud then
        TmpStr := ', MECH_PH = :MECH_PH';

      DM.qrDifferent.SQL.Text :=
        'Update mechanizm set MECH_NAME = :MECH_NAME, UNIT_ID = :UNIT_ID' +
        TmpStr + ' where MECHANIZM_ID = :MECHANIZM_ID';
      DM.qrDifferent.ParamByName('MECH_NAME').Value := AName;
      DM.qrDifferent.ParamByName('UNIT_ID').Value := TmpUnitID;
      DM.qrDifferent.ParamByName('MECHANIZM_ID').Value := Result;
      if AUpdateTrud then
        DM.qrDifferent.ParamByName('MECH_PH').Value := ATrud;
      DM.qrDifferent.ExecSQL;
    end;
  end;
end;

function TSprLoaderForm.AddNewDev(ACode, AName, AUnit: string;
  ANoUpdate: Boolean): Integer;
var TmpUnitID: Integer;
begin
  //Получает код ед. изм.
  TmpUnitID := GetUnitID(AUnit);
  ACode := Trim(ACode).ToUpper;
  AName := Trim(AName).ToUpper;

  //Проверяет есть ли такой уже в базе
  DM.qrDifferent.SQL.Text :=
    'Select DEVICE_ID from devices where (DEVICE_CODE1 = :DEVICE_CODE1) and (BASE = 0)';
  Result := -1;
  DM.qrDifferent.ParamByName('DEVICE_CODE1').Value := ACode;
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
    DM.qrDifferent.ParamByName('TypeID').Value := C_MANID_DEV;
    DM.qrDifferent.Active := True;
    try
      Result := DM.qrDifferent.Fields[0].AsInteger;
    finally
      DM.qrDifferent.Active := False;
    end;

    DM.qrDifferent.SQL.Text :=
      'Insert into devices ' +
      '(DEVICE_ID, DEVICE_CODE1, NAME, UNIT, BASE) ' +
      'values ' +
      '(:DEVICE_ID, :DEVICE_CODE1, :NAME, :UNIT, 0)';
    DM.qrDifferent.ParamByName('DEVICE_CODE1').Value := ACode;
    DM.qrDifferent.ParamByName('NAME').Value := AName;
    DM.qrDifferent.ParamByName('DEVICE_ID').Value := Result;
    DM.qrDifferent.ParamByName('UNIT').Value := TmpUnitID;
    DM.qrDifferent.ExecSQL;
  end
  else
  begin
    if not ANoUpdate then
    begin
      DM.qrDifferent.SQL.Text :=
        'Update devices set NAME = :NAME, UNIT = :UNIT where DEVICE_ID = :DEVICE_ID';
      DM.qrDifferent.ParamByName('NAME').Value := AName;
      DM.qrDifferent.ParamByName('UNIT').Value := TmpUnitID;
      DM.qrDifferent.ParamByName('DEVICE_ID').Value := Result;
      DM.qrDifferent.ExecSQL;
    end;
  end;
end;

function TSprLoaderForm.GetUnitID(AUnitName: string): Integer;
var J: Integer;
begin
  AUnitName := Trim(AUnitName);
  J := FUnitsName.IndexOf(AUnitName.ToLower);
  if J > -1 then
    Result := StrToInt(FUnitsID[J])
  else
    Result := AddNewUnit(AUnitName);
end;

function TSprLoaderForm.GetMatID(AMatCode: string): Integer;
begin
  //Проверяет есть ли такой уже в базе
  DM.qrDifferent.SQL.Text :=
    'Select MATERIAL_ID from material where ' +
    '(MAT_CODE = :MAT_CODE) and (BASE = 0)';
  Result := -1;
  DM.qrDifferent.ParamByName('MAT_CODE').Value := AMatCode;
  DM.qrDifferent.Active := True;
  try
    if not DM.qrDifferent.IsEmpty then
      Result := DM.qrDifferent.Fields[0].AsInteger;
  finally
    DM.qrDifferent.Active := False;
  end;
end;

function TSprLoaderForm.AddNewPMat(ACode, AName, AUnit: string): Integer;
var TmpUnitID: Integer;
begin
  TmpUnitID := GetUnitID(AUnit);
  ACode := Trim(ACode).ToUpper;
  AName := Trim(AName).ToUpper;

  DM.qrDifferent.SQL.Text :=
    'Select MATERIAL_ID from material where ' +
    '(MAT_CODE = :MAT_CODE) and (MAT_NAME = :MAT_NAME) and (BASE = 0)';
  Result := -1;
  DM.qrDifferent.ParamByName('MAT_CODE').Value := ACode;
  DM.qrDifferent.ParamByName('MAT_NAME').Value := AName;
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

    DM.qrDifferent.SQL.Text :=
      'Insert into material ' +
      '(MATERIAL_ID, MAT_CODE, MAT_NAME, MAT_TYPE, UNIT_ID, BASE) ' +
      'values ' +
      '(:MATERIAL_ID, :MAT_CODE, :MAT_NAME, :TYPE, :UNIT_ID, 0)';
    DM.qrDifferent.ParamByName('MAT_CODE').Value := ACode;
    DM.qrDifferent.ParamByName('MAT_NAME').Value := AName;
    DM.qrDifferent.ParamByName('MATERIAL_ID').Value := Result;
    DM.qrDifferent.ParamByName('TYPE').Value := 0;
    DM.qrDifferent.ParamByName('UNIT_ID').Value := TmpUnitID;
    DM.qrDifferent.ExecSQL;
  end
end;

function TSprLoaderForm.AddNewMat(ACode, AName, AUnit: string; ADate: TDateTime;
    ANoUpdate: Boolean; AMatType: Byte): Integer;
var TmpUnitID: Integer;
begin
  //Получает код ед. изм.
  TmpUnitID := GetUnitID(AUnit);
  ACode := Trim(ACode).ToUpper;
  AName := Trim(AName).ToUpper;

  Result := GetMatID(ACode);

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

    DM.qrDifferent.SQL.Text :=
      'Insert into material ' +
      '(MATERIAL_ID, MAT_CODE, MAT_NAME, MAT_TYPE, UNIT_ID, BASE, date_beginer) ' +
      'values ' +
      '(:MATERIAL_ID, :MAT_CODE, :MAT_NAME, :TYPE, :UNIT_ID, 0, :date_beginer)';
    DM.qrDifferent.ParamByName('MAT_CODE').Value := ACode;
    DM.qrDifferent.ParamByName('MAT_NAME').Value := AName;
    DM.qrDifferent.ParamByName('MATERIAL_ID').Value := Result;
    DM.qrDifferent.ParamByName('TYPE').Value := AMatType;
    DM.qrDifferent.ParamByName('UNIT_ID').Value := TmpUnitID;
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
      DM.qrDifferent.ParamByName('UNIT_ID').Value := TmpUnitID;
      DM.qrDifferent.ParamByName('date_beginer').Value := ADate;
      DM.qrDifferent.ParamByName('MATERIAL_ID').Value := Result;
      DM.qrDifferent.ExecSQL;
    end;
  end;
end;

function TSprLoaderForm.AddNewDump(AName, AUnit: string; ACode, OblID: Integer;
  ANoUpdate: Boolean): Integer;
var TmpUnitID: Integer;
begin
  //Получает код ед. изм.
  TmpUnitID := GetUnitID(AUnit);

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
          AddNewMat(TmpCode, TmpName, TmpUnit, TmpDate, False, 1);
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
          TmpMatID := AddNewMat(TmpCode, TmpName, TmpUnit, TmpDate, False, 1);
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
              not cboxUpdMatName.Checked, 1);

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
            AddNewMech(TmpCode, TmpName, 'маш.-ч', TmpDate,
              not cboxUpdMechName.Checked, 0, False);

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
