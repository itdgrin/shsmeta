unit fEstRowFinder;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.ComCtrls,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, System.Actions, Vcl.ActnList;

type
  TFormEstRowFinder = class(TForm)
    Panel1: TPanel;
    gbFilter: TGroupBox;
    lbCodeTitle: TLabel;
    lbName: TLabel;
    edtCode: TEdit;
    rgTypeDate: TRadioGroup;
    edtName: TEdit;
    gbEntry: TGroupBox;
    lvEntry: TListView;
    Panel4: TPanel;
    btnGoToRow: TButton;
    btnCancel: TButton;
    TimerFilter: TTimer;
    ActionList: TActionList;
    actGoToRow: TAction;
    actCancel: TAction;
    pnlSelection: TPanel;
    edtSelCode: TEdit;
    Label1: TLabel;
    Label3: TLabel;
    memSelName: TMemo;
    procedure FormShow(Sender: TObject);
    procedure rgTypeDateClick(Sender: TObject);
    procedure edtChange(Sender: TObject);
    procedure TimerFilterTimer(Sender: TObject);
    procedure actGoToRowUpdate(Sender: TObject);
    procedure actGoToRowExecute(Sender: TObject);
    procedure actCancelExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure lvEntrySelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
  private
    FCurType: Integer;
    FDataID: Integer;
    FEstimateID: Integer;
    FAct: Boolean;

    FNoLock: Boolean;
    FNameList: TStringList;

    procedure FindDataInEstimate(ACode, AName: string);
    procedure SetCurType(AValue: Integer);
    procedure SetAct(AValue: Boolean);
  public
    property EstimateID: Integer read FEstimateID write FEstimateID;
    property CurType: Integer read FCurType write SetCurType;
    property DataID: Integer read FDataID;
    property Act: Boolean read FAct write SetAct;
  end;

implementation
uses DataModule;

{$R *.dfm}

procedure TFormEstRowFinder.FormCreate(Sender: TObject);
begin
  FNameList :=  TStringList.Create;
  rgTypeDateClick(nil);
end;

procedure TFormEstRowFinder.FormDestroy(Sender: TObject);
begin
  FreeAndNil(FNameList);
end;

procedure TFormEstRowFinder.FormShow(Sender: TObject);
begin
  if FEstimateID = 0 then
  begin
    PostMessage(Handle, WM_CLOSE, 0, 0);
    try
      raise Exception.Create('Не задан ID сметы.');
    except
      on e: Exception do
        Application.ShowException(e);
    end;
  end;
  FNoLock := True; //Для блокировки сробатывания FindDataInEstimate при Create
  edtCode.SetFocus;
  FindDataInEstimate(Trim(edtCode.Text), Trim(edtName.Text));
end;

procedure TFormEstRowFinder.lvEntrySelectItem(Sender: TObject; Item: TListItem;
  Selected: Boolean);
begin
  edtSelCode.Text := '';
  memSelName.Text := '';

  if Assigned(Item) and
    (Integer(Item.Data) > 0) then
  begin
    edtSelCode.Text := Item.Caption;
    memSelName.Text := FNameList[Item.Index];
  end;
end;

procedure TFormEstRowFinder.rgTypeDateClick(Sender: TObject);
begin
  FCurType := rgTypeDate.ItemIndex + 1;
  gbFilter.Caption := ' ' + rgTypeDate.Items[rgTypeDate.ItemIndex] + ': ';
  FindDataInEstimate(Trim(edtCode.Text), Trim(edtName.Text));
end;

procedure TFormEstRowFinder.actCancelExecute(Sender: TObject);
begin
  Close;
end;

procedure TFormEstRowFinder.actGoToRowExecute(Sender: TObject);
begin
  FDataID := Integer(lvEntry.Selected.Data);
  ModalResult := mrOk;
end;

procedure TFormEstRowFinder.actGoToRowUpdate(Sender: TObject);
begin
  actGoToRow.Enabled :=
    Assigned(lvEntry.Selected) and
    (Integer(lvEntry.Selected.Data) > 0);
end;

procedure TFormEstRowFinder.edtChange(Sender: TObject);
begin
  TimerFilter.Enabled := False;
  TimerFilter.Enabled := True;
end;

procedure TFormEstRowFinder.FindDataInEstimate(ACode, AName: string);
var Item: TListItem;
begin
  lvEntry.Clear;
  FNameList.Clear;
  edtSelCode.Text := '';
  memSelName.Text := '';

  if not FNoLock then
    Exit;

  ACode := ACode.ToUpper;
  DM.qrDifferent.Active := False;
  case FCurType of
  1:
  begin
    if ACode.Length > 0 then
    begin
      if (ACode[1] = 'E') or
         (ACode[1] = 'T') or
         (ACode[1] = 'У') then
        ACode[1] := 'Е'; // E кирилическая
      if ACode[1] = 'W' then
        ACode[1] := 'Ц';
    end;
    DM.qrDifferent.SQL.Text :=
      'Select crt.DATA_ROW_ID DATAID, ' +
      'CAST(CONCAT(IF(((:SMID = ssd.PARENT_ID) or (:SMID = ssd.SM_ID)), '''', :SMID), ' +
        'ssd.PARENT_ID, ssd.SM_ID) AS CHAR(255)) SORT_ID2, drt.NUM_ROW NUM_ROW, ' +
      'crt.RATE_CODE CODE, crt.RATE_CAPTION NAME,' +
      'CONCAT(IF((:SMID = ssd.PARENT_ID) or (:SMID = ssd.SM_ID), '''', ' +
        '(Select CONCAT(SM_NUMBER, '', '') from smetasourcedata ' +
        'where SM_ID = ssd.PARENT_ID)),ssd.SM_NUMBER) SMNAME, ' +
      'Null RATECODE, Null NORMA, crt.RATE_COUNT COUNT, Null COAST, Null PRICE ' +
      'from card_rate_temp crt, data_row_temp drt, smetasourcedata ssd ' +
      'where (crt.SM_ID = ssd.SM_ID) and (crt.DATA_ROW_ID = drt.ID) and ' +
            '(ssd.`TREE_PATH` like  CONCAT(''%0'',:SMID,''%'')) and ' +
            '(crt.RATE_CODE like  CONCAT(''%'',:SCode,''%'')) and ' +
            '(crt.RATE_CAPTION like  CONCAT(''%'',:SName,''%''))' +
      'order by SORT_ID2, NUM_ROW';
  end;
  2:
  begin
    if ACode.Length > 0 then
    begin
      if ACode[1] = 'C' then
        ACode[1] := 'С';
    end;
    DM.qrDifferent.SQL.Text :=
      'Select mct.DATA_ROW_ID DATAID, ' +
      'CAST(CONCAT(IF(((:SMID = ssd.PARENT_ID) or (:SMID = ssd.SM_ID)), '''', :SMID), ' +
        'ssd.PARENT_ID, ssd.SM_ID) AS CHAR(255)) SORT_ID2, drt.NUM_ROW NUM_ROW, ' +
      'mct.MAT_CODE CODE, mct.MAT_NAME NAME,' +
      'CONCAT(IF((:SMID = ssd.PARENT_ID) or (:SMID = ssd.SM_ID), '''', ' +
        '(Select CONCAT(SM_NUMBER, '', '') from smetasourcedata ' +
        'where SM_ID = ssd.PARENT_ID)),ssd.SM_NUMBER) SMNAME, ' +
      '(Select RATE_CODE from card_rate_temp where ID = mct.ID_CARD_RATE) RATECODE, ' +
      'IF(mct.MAT_NORMA = 0, Null, mct.MAT_NORMA) NORMA, ' +
      'mct.MAT_COUNT COUNT, ' +
      'IF(ssd.NDS = 0, FCOAST_NO_NDS, FCOAST_NDS) COAST, ' +
      'IF(ssd.NDS = 0, FPRICE_NO_NDS, FPRICE_NDS) PRICE ' +
      'from materialcard_temp mct, data_row_temp drt, smetasourcedata ssd ' +
      'where (mct.SM_ID = ssd.SM_ID) and (mct.DATA_ROW_ID = drt.ID) and ' +
            '(ssd.`TREE_PATH` like  CONCAT(''%0'',:SMID,''%'')) and ' +
            '(mct.MAT_CODE like  CONCAT(''%'',:SCode,''%'')) and ' +
            '(mct.MAT_NAME like  CONCAT(''%'',:SName,''%''))' +
      'order by SORT_ID2, NUM_ROW, CODE';
  end;
  3:
  begin
    if ACode.Length > 0 then
    begin
      if (ACode[1] = 'M') or
         (ACode[1] = 'V') then
        ACode[1] := 'М';
    end;
    DM.qrDifferent.SQL.Text :=
      'Select mct.DATA_ROW_ID DATAID, ' +
      'CAST(CONCAT(IF(((:SMID = ssd.PARENT_ID) or (:SMID = ssd.SM_ID)), '''', :SMID), ' +
        'ssd.PARENT_ID, ssd.SM_ID) AS CHAR(255)) SORT_ID2, drt.NUM_ROW NUM_ROW, ' +
      'mct.MECH_CODE CODE, mct.MECH_NAME NAME,' +
      'CONCAT(IF((:SMID = ssd.PARENT_ID) or (:SMID = ssd.SM_ID), '''', ' +
        '(Select CONCAT(SM_NUMBER, '', '') from smetasourcedata ' +
        'where SM_ID = ssd.PARENT_ID)),ssd.SM_NUMBER) SMNAME, ' +
      '(Select RATE_CODE from card_rate_temp where ID = mct.ID_CARD_RATE) RATECODE, ' +
      'IF(mct.MECH_NORMA = 0, Null, mct.MECH_NORMA) NORMA, ' +
      'mct.MECH_COUNT COUNT, ' +
      'IF(ssd.NDS = 0, FCOAST_NO_NDS, FCOAST_NDS) COAST, ' +
      'IF(ssd.NDS = 0, FPRICE_NO_NDS, FPRICE_NDS) PRICE ' +
      'from mechanizmcard_temp mct, data_row_temp drt, smetasourcedata ssd ' +
      'where (mct.SM_ID = ssd.SM_ID) and (mct.DATA_ROW_ID = drt.ID) and ' +
            '(ssd.`TREE_PATH` like  CONCAT(''%0'',:SMID,''%'')) and ' +
            '(mct.MECH_CODE like  CONCAT(''%'',:SCode,''%'')) and ' +
            '(mct.MECH_NAME like  CONCAT(''%'',:SName,''%''))' +
      'order by SORT_ID2, NUM_ROW, CODE';
  end;
  4:
  begin
    DM.qrDifferent.SQL.Text :=
      'Select dct.DATA_ROW_ID DATAID, ' +
      'CAST(CONCAT(IF(((:SMID = ssd.PARENT_ID) or (:SMID = ssd.SM_ID)), '''', :SMID), ' +
        'ssd.PARENT_ID, ssd.SM_ID) AS CHAR(255)) SORT_ID2, drt.NUM_ROW NUM_ROW, ' +
      'dct.DEVICE_CODE CODE, dct.DEVICE_NAME NAME,' +
      'CONCAT(IF((:SMID = ssd.PARENT_ID) or (:SMID = ssd.SM_ID), '''', ' +
        '(Select CONCAT(SM_NUMBER, '', '') from smetasourcedata ' +
        'where SM_ID = ssd.PARENT_ID)),ssd.SM_NUMBER) SMNAME, ' +
      'Null RATECODE, Null NORMA, ' +
      'dct.DEVICE_COUNT COUNT, ' +
      'IF(ssd.NDS = 0, FCOAST_NO_NDS, FCOAST_NDS) COAST, ' +
      'IF(ssd.NDS = 0, FPRICE_NO_NDS, FPRICE_NDS) PRICE ' +
      'from devicescard_temp dct, data_row_temp drt, smetasourcedata ssd ' +
      'where (dct.SM_ID = ssd.SM_ID) and (dct.DATA_ROW_ID = drt.ID) and ' +
            '(ssd.`TREE_PATH` like  CONCAT(''%0'',:SMID,''%'')) and ' +
            '(dct.DEVICE_CODE like  CONCAT(''%'',:SCode,''%'')) and ' +
            '(dct.DEVICE_NAME like  CONCAT(''%'',:SName,''%''))' +
      'order by SORT_ID2, NUM_ROW, CODE';
  end;
  else Exit;
  end;
  DM.qrDifferent.ParamByName('SMID').Value := FEstimateID;
  DM.qrDifferent.ParamByName('SCode').Value := ACode;
  DM.qrDifferent.ParamByName('SName').Value := AName;
  DM.qrDifferent.Active := True;
  try
    while not DM.qrDifferent.Eof do
    begin
      Item := lvEntry.Items.Add;
      Item.Data := Pointer(DM.qrDifferent.FieldByName('DATAID').AsInteger);
      Item.Caption := DM.qrDifferent.FieldByName('CODE').AsString;
      FNameList.Add(DM.qrDifferent.FieldByName('NAME').AsString);
      Item.SubItems.Add(DM.qrDifferent.FieldByName('SMNAME').AsString);
      Item.SubItems.Add(DM.qrDifferent.FieldByName('RATECODE').AsString);
      Item.SubItems.Add(DM.qrDifferent.FieldByName('NORMA').AsString);
      Item.SubItems.Add(DM.qrDifferent.FieldByName('COUNT').AsString);
      Item.SubItems.Add(DM.qrDifferent.FieldByName('COAST').AsString);
      Item.SubItems.Add(DM.qrDifferent.FieldByName('PRICE').AsString);
      DM.qrDifferent.Next;
    end;
  finally
    DM.qrDifferent.Active := False;
  end;
end;

procedure TFormEstRowFinder.SetCurType(AValue: Integer);
begin
  case AValue of
  1: rgTypeDate.ItemIndex := 0;
  2: rgTypeDate.ItemIndex := 1;
  3: rgTypeDate.ItemIndex := 2;
  4: rgTypeDate.ItemIndex := 3;
  else
    raise Exception.Create('Недопустимый тип данных');
  end;
end;

procedure TFormEstRowFinder.SetAct(AValue: Boolean);
begin
  FAct := AValue;
  if FAct then
  begin
    Caption := 'Поиск по акте';
    lvEntry.Columns[1].Caption := 'Акт';
  end
  else
  begin
    Caption := 'Поиск по смете';
    lvEntry.Columns[1].Caption := 'Смета';
  end;
end;

procedure TFormEstRowFinder.TimerFilterTimer(Sender: TObject);
begin
  TimerFilter.Enabled := False;
  FindDataInEstimate(Trim(edtCode.Text), Trim(edtName.Text));
end;

end.
