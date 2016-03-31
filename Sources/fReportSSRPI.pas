unit fReportSSRPI;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Param,
  FireDAC.Stan.Error,
  FireDAC.DatS,
  FireDAC.Phys.Intf,
  FireDAC.DApt.Intf,
  FireDAC.Stan.Async,
  FireDAC.DApt,
  Data.DB,
  FireDAC.Comp.Client,
  FireDAC.Comp.DataSet,
  Vcl.Grids, Vcl.DBGrids,
  JvExDBGrids, JvDBGrid,
  Vcl.ExtCtrls,
  Vcl.StdCtrls,
  Vcl.Mask,
  Vcl.DBCtrls,
  Tools,
  GlobsAndConst,
  Vcl.Buttons;

type
  TFormReportSSRPI = class(TSmForm)
    pnlTop: TPanel;
    pnlCenter: TPanel;
    pnlBottom: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    edtSmDate: TDBEdit;
    edtBeginDate: TDBEdit;
    edtSrok: TDBEdit;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    edtTotalWithNal: TDBEdit;
    edtVozvrat: TDBEdit;
    edtDevWithNDS: TDBEdit;
    edtNoIndex: TDBEdit;
    edtTotalIndex: TDBEdit;
    edtPIOnBegin: TDBEdit;
    edtTotal: TDBEdit;
    Bevel1: TBevel;
    grTab: TJvDBGrid;
    Label12: TLabel;
    Label13: TLabel;
    edtIndex1: TDBEdit;
    edtIndex2: TDBEdit;
    qrTemp: TFDQuery;
    mtTab: TFDMemTable;
    dsLine: TDataSource;
    dsTab: TDataSource;
    mtTabName: TStringField;
    mtTabLineNum: TWideStringField;
    SpeedButton1: TSpeedButton;
    pnlNoIndex: TPanel;
    btnHideNoIndex: TButton;
    edtDevZakNDS: TDBEdit;
    edtMatZakNDS: TDBEdit;
    edtOtherChap1: TDBEdit;
    edtPIRExp: TDBEdit;
    edtOtherNoIndex: TDBEdit;
    Label7: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    mtLine: TFDMemTable;
    mtLineSmDate: TDateField;
    mtLineBeginDate: TDateField;
    mtLineSrok: TSmallintField;
    mtLineVozvrat: TFloatField;
    mtLineDevWithNDS: TFloatField;
    mtLineNoIndex: TFloatField;
    mtLineTotalIndex: TFloatField;
    mtLineMatZakNDS: TFloatField;
    mtLinePIOnBegin: TFloatField;
    mtLineIndex1: TFloatField;
    mtLineIndex2: TFloatField;
    mtLineDevZakNDS: TFloatField;
    mtLineOtherChap1: TFloatField;
    mtLinePIRExp: TFloatField;
    mtLineOtherNoIndex: TFloatField;
    mtLineTotalWithNal: TFloatField;
    mtLineTotal: TFloatField;
    mtTabSumm: TFloatField;
    Label18: TLabel;
    edtIndex3: TDBEdit;
    mtLineIndex3: TFloatField;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure mtTabProcChange(Sender: TField);
    procedure grTabCanEditCell(Grid: TJvDBGrid; Field: TField;
      var AllowEdit: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure SpeedButton1Click(Sender: TObject);
    procedure btnHideNoIndexClick(Sender: TObject);
    procedure mtLineDevZakNDSChange(Sender: TField);
    procedure mtLineNoIndexChange(Sender: TField);
    procedure edtKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    FObjectID: Integer;
    FLine9013,
    FLine0802: TRepSSRLine;
    FChange: Boolean;
    FCalc: Integer;
    FResult: Double;
    procedure SetObjectID(AValue: Integer);
  public
    property Line9013: TRepSSRLine write FLine9013;
    property Line0802: TRepSSRLine write FLine0802;
    property Result: Double read FResult;
    procedure CalcPIIndex();
  end;

implementation

uses DataModule;

const
  TabItems: array[0..11, 0..1] of string =
  (('Нормы задела в строительстве по месяцам, %', '1'),
   ('Нормы задела по оборудованию, %', '2'),
   ('Стоисмость без оборудования, руб', '3'),
   ('- в т.ч. возвратные материалы, руб', '4'),
   ('Оборудование, руб', '5'),
   ('Ежемесячный ПИ цен в строительстве', '6'),
   ('Стоимость с учетом ПИ, руб', '7'),
   ('- в т.ч. возвратные материалы, руб', '8'),
   ('Стоимость оборудования с учетом ПИ, руб', '9'),
   ('Средства учитывающие применение ПИ роста, руб', '10'),
   ('- в т.ч. возвратные материалы, руб', '11'),
   ('Средства учитывающие применение ПИ роста на оборудование, руб', '12'));

{$R *.dfm}

procedure TFormReportSSRPI.FormClose(Sender: TObject; var Action: TCloseAction);
var J: Integer;
    TmpDate: TDateTime;
    Y, M, D: Word;
begin
  if FChange then
  begin
    qrTemp.SQL.Text := 'Delete from ssr_line where (OBJ_ID = :OBJ_ID);';
    qrTemp.ParamByName('OBJ_ID').Value := FObjectID;
    qrTemp.ExecSQL;

    qrTemp.SQL.Text := 'Insert into ssr_line (OBJ_ID, NO_INDEX_TOTAL, ' +
      'DEV_ZAK_NDS, MAT_ZAK_NDS, OTHER_CHAP1, PIR_EXP, OTHER_NO_INDEX) values ' +
      '(:OBJ_ID, :NO_INDEX_TOTAL, :DEV_ZAK_NDS, :MAT_ZAK_NDS, :OTHER_CHAP1, ' +
      ':PIR_EXP, :OTHER_NO_INDEX);';
    qrTemp.ParamByName('OBJ_ID').Value := FObjectID;
    qrTemp.ParamByName('NO_INDEX_TOTAL').Value := mtLineNoIndex.Value;
    qrTemp.ParamByName('DEV_ZAK_NDS').Value := mtLineDevZakNDS.Value;
    qrTemp.ParamByName('MAT_ZAK_NDS').Value := mtLineMatZakNDS.Value;
    qrTemp.ParamByName('OTHER_CHAP1').Value := mtLineOtherChap1.Value;
    qrTemp.ParamByName('PIR_EXP').Value := mtLinePIRExp.Value;
    qrTemp.ParamByName('OTHER_NO_INDEX').Value := mtLineOtherNoIndex.Value;
    qrTemp.ExecSQL;

    qrTemp.SQL.Text := 'Delete from ssr_month_proc where (OBJ_ID = :OBJ_ID);';
    qrTemp.ParamByName('OBJ_ID').Value := FObjectID;
    qrTemp.ExecSQL;

    qrTemp.SQL.Text :=
        'Insert into ssr_month_proc (OBJ_ID, SYEAR, SMONTH, PROC_STROI, PROC_DEV) ' +
        'values (:OBJ_ID, :SYEAR, :SMONTH, :PROC_STROI, :PROC_DEV);';
    mtTab.First;
    for J := 1 to mtLineSrok.Value do
    begin
      TmpDate := IncMonth(mtLineBeginDate.Value, J - 1);
      DecodeDate(TmpDate, Y, M, D);
      qrTemp.ParamByName('OBJ_ID').Value := FObjectID;
      qrTemp.ParamByName('SYEAR').Value := Y;
      qrTemp.ParamByName('SMONTH').Value := M;
      qrTemp.ParamByName('PROC_STROI').Value := mtTab.FieldByName('month' + J.ToString).AsFloat;
      mtTab.Next;
      qrTemp.ParamByName('PROC_DEV').Value := mtTab.FieldByName('month' + J.ToString).AsFloat;
      mtTab.Prior;
      qrTemp.ExecSQL;
    end;

    ModalResult := mrYes;
  end;
end;

procedure TFormReportSSRPI.FormCreate(Sender: TObject);
begin
  if not VarIsNull(InitParams) then
    SetObjectID(InitParams);
end;

procedure TFormReportSSRPI.FormShow(Sender: TObject);
begin
  FChange := False;
  CalcPIIndex();
end;

procedure TFormReportSSRPI.grTabCanEditCell(Grid: TJvDBGrid; Field: TField;
  var AllowEdit: Boolean);
begin
  if not((Grid.Col > 2) and
        ((mtTabLineNum.Value = '1') or (mtTabLineNum.Value = '2'))) then
    AllowEdit := False;
end;

procedure TFormReportSSRPI.mtLineDevZakNDSChange(Sender: TField);
begin
  if not Showing or (FCalc > 0) then
    Exit;

  Inc(FCalc);
  try
    FChange := True;
    Sender.Value := SmRound(Sender.Value);
    mtLineNoIndex.Value := mtLineDevZakNDS.Value + mtLineMatZakNDS.Value +
        mtLineOtherChap1.Value + mtLineOtherNoIndex.Value + mtLinePIRExp.Value;
  finally
    Dec(FCalc);
  end;
end;

procedure TFormReportSSRPI.mtLineNoIndexChange(Sender: TField);
begin
  if not Showing or (FCalc > 0) then
    Exit;

  Inc(FCalc);
  try
    FChange := True;
    Sender.Value := SmRound(Sender.Value);
    CalcPIIndex();
  finally
    Dec(FCalc);
  end;
end;

procedure TFormReportSSRPI.mtTabProcChange(Sender: TField);
begin
  if not Showing or (FCalc > 0) then
    Exit;

  if ((mtTabLineNum.Value = '1') or (mtTabLineNum.Value = '2')) and
     not (Sender.Value > 100) then
  begin
    mtTab.Post;
    FChange := True;
    CalcPIIndex();
  end
  else
    mtTab.Cancel;
end;

procedure TFormReportSSRPI.btnHideNoIndexClick(Sender: TObject);
begin
  pnlNoIndex.Visible := False;
  grTab.Repaint;
end;

procedure TFormReportSSRPI.CalcPIIndex();
var TmpArray: array of array [0..9] of Double;
    J: Integer;
    TmpSumm: Double;
    TmpBookmark: TBookmark;
begin
  FResult := 0;
  Inc(FCalc);
  try
    mtLine.DisableControls;
    try
      mtLine.Edit;
      mtLineTotalWithNal.Value := SmRound(FLine9013.Total);
      mtLineVozvrat.Value := SmRound(FLine0802.Total);
      mtLineDevWithNDS.Value := SmRound((FLine9013.Devices + FLine9013.Transp) *
        (1 + G_NDS/100));
      mtLineTotalIndex.Value := SmRound(mtLineTotalWithNal.Value - mtLineNoIndex.Value);
      mtLineTotal.Value := SmRound(mtLineTotalIndex.Value * mtLinePIOnBegin.Value);
      mtLine.Post;
    finally
      mtLine.EnableControls;
    end;

    TmpBookmark := mtTab.GetBookmark;
    mtTab.DisableControls;

    try
      SetLength(TmpArray, mtLineSrok.Value);
      mtTab.First;
      while not mtTab.Eof do
      begin
        if mtTabLineNum.Value = '1' then
        begin
          mtTab.Edit;
          TmpSumm := 0;
          for J := 1 to mtLineSrok.Value do
          begin
            TmpArray[J - 1][0] :=
              mtTab.FieldByName('month' + J.ToString).AsFloat/100;
            TmpSumm := TmpSumm + TmpArray[J - 1][0];
          end;
          mtTabSumm.Value := 100 - TmpSumm * 100;
          mtTab.Post;
        end;

        if mtTabLineNum.Value = '2' then
        begin
          mtTab.Edit;
          TmpSumm := 0;
          for J := 1 to mtLineSrok.Value do
          begin
            TmpArray[J - 1][1] :=
              mtTab.FieldByName('month' + J.ToString).AsFloat/100;
            TmpSumm := TmpSumm + TmpArray[J - 1][1];
          end;
          mtTabSumm.Value := 100 - TmpSumm * 100;
          mtTab.Post;
        end;

        if mtTabLineNum.Value = '3' then
        begin
          mtTab.Edit;
          TmpSumm := 0;
          for J := 1 to mtLineSrok.Value do
          begin
            TmpArray[J - 1][2] :=
              SmRound((mtLineTotal.Value -
                (mtLineDevWithNDS.Value - mtLineDevZakNDS.Value) * mtLinePIOnBegin.Value) *
                TmpArray[J - 1][0]);
            TmpSumm := TmpSumm + TmpArray[J - 1][2];
            mtTab.FieldByName('month' + J.ToString).AsFloat := TmpArray[J - 1][2];
          end;
          mtTabSumm.Value := TmpSumm;
          mtTab.Post;
        end;

        if mtTabLineNum.Value = '4' then
        begin
          mtTab.Edit;
          TmpSumm := 0;
          for J := 1 to mtLineSrok.Value do
          begin
            TmpArray[J - 1][3] :=
              SmRound(mtLineVozvrat.Value * mtLinePIOnBegin.Value * TmpArray[J - 1][0]);
            TmpSumm := TmpSumm + TmpArray[J - 1][3];
            mtTab.FieldByName('month' + J.ToString).AsFloat := TmpArray[J - 1][3];
          end;
          mtTabSumm.Value := TmpSumm;
          mtTab.Post;
        end;

        if mtTabLineNum.Value = '5' then
        begin
          mtTab.Edit;
          TmpSumm := 0;
          for J := 1 to mtLineSrok.Value do
          begin
            TmpArray[J - 1][4] :=
              SmRound(mtLineDevWithNDS.Value * TmpArray[J - 1][1] * mtLinePIOnBegin.Value);
            TmpSumm := TmpSumm + TmpArray[J - 1][4];
            mtTab.FieldByName('month' + J.ToString).AsFloat := TmpArray[J - 1][4];
          end;
          TmpSumm := TmpSumm - mtLineDevZakNDS.Value * mtLinePIOnBegin.Value;
          mtTabSumm.Value := TmpSumm;
          mtTab.Post;

          mtLine.Edit;
          mtLineIndex2.Value := TmpSumm;
          mtLine.Post;
        end;

        if mtTabLineNum.Value = '6' then
          for J := 1 to mtLineSrok.Value do
            TmpArray[J - 1][5] :=
              mtTab.FieldByName('month' + J.ToString).AsFloat;

        if mtTabLineNum.Value = '7' then
        begin
          mtTab.Edit;
          TmpSumm := 0;
          for J := 1 to mtLineSrok.Value do
          begin
            TmpArray[J - 1][6] := SmRound(TmpArray[J - 1][5] * TmpArray[J - 1][2]);
            TmpSumm := TmpSumm + TmpArray[J - 1][6];
            mtTab.FieldByName('month' + J.ToString).AsFloat := TmpArray[J - 1][6];
          end;
          mtTabSumm.Value := TmpSumm;
          mtTab.Post;

          mtLine.Edit;
          mtLineIndex2.Value := TmpSumm - mtLineTotalIndex.Value + mtLineIndex2.Value;
          mtLine.Post;
        end;

        if mtTabLineNum.Value = '8' then
        begin
          mtTab.Edit;
          TmpSumm := 0;
          for J := 1 to mtLineSrok.Value do
          begin
            TmpArray[J - 1][7] := SmRound(TmpArray[J - 1][5] * TmpArray[J - 1][3]);
            TmpSumm := TmpSumm + TmpArray[J - 1][7];
            mtTab.FieldByName('month' + J.ToString).AsFloat := TmpArray[J - 1][7];
          end;
          mtTabSumm.Value := TmpSumm;
          mtTab.Post;

          mtLine.Edit;
          mtLineIndex3.Value := TmpSumm - mtLineVozvrat.Value;
          mtLine.Post;
        end;

        if mtTabLineNum.Value = '9' then
        begin
          mtTab.Edit;
          TmpSumm := 0;
          for J := 1 to mtLineSrok.Value do
          begin
            TmpArray[J - 1][8] := SmRound(TmpArray[J - 1][5] * TmpArray[J - 1][4]);
            TmpSumm := TmpSumm + TmpArray[J - 1][8];
            mtTab.FieldByName('month' + J.ToString).AsFloat := TmpArray[J - 1][8];
          end;
          mtTabSumm.Value := TmpSumm;
          mtTab.Post;
        end;

        if mtTabLineNum.Value = '10' then
        begin
          mtTab.Edit;
          TmpSumm := 0;
          for J := 1 to mtLineSrok.Value do
          begin
            mtTab.FieldByName('month' + J.ToString).AsFloat :=
              TmpArray[J - 1][6] - TmpArray[J - 1][2];
            TmpSumm := TmpSumm + mtTab.FieldByName('month' + J.ToString).AsFloat;
          end;
          mtTabSumm.Value := TmpSumm;
          mtTab.Post;

          mtLine.Edit;
          mtLineIndex1.Value := TmpSumm;
          mtLine.Post;
        end;

        if mtTabLineNum.Value = '11' then
        begin
          mtTab.Edit;
          TmpSumm := 0;
          for J := 1 to mtLineSrok.Value do
          begin
            mtTab.FieldByName('month' + J.ToString).AsFloat :=
              TmpArray[J - 1][7] - TmpArray[J - 1][3];
            TmpSumm := TmpSumm + mtTab.FieldByName('month' + J.ToString).AsFloat;
          end;
          mtTabSumm.Value := TmpSumm;
          mtTab.Post;
        end;

        if mtTabLineNum.Value = '12' then
        begin
          mtTab.Edit;
          TmpSumm := 0;
          for J := 1 to mtLineSrok.Value do
          begin
            mtTab.FieldByName('month' + J.ToString).AsFloat :=
              TmpArray[J - 1][8] - TmpArray[J - 1][4];
            TmpSumm := TmpSumm + mtTab.FieldByName('month' + J.ToString).AsFloat;
          end;
          mtTabSumm.Value := TmpSumm;
          mtTab.Post;
        end;
        mtTab.Next;
      end;
    finally
      FResult := mtLineIndex2.Value;
      mtTab.GotoBookmark(TmpBookmark);
      mtTab.FreeBookmark(TmpBookmark);
      mtTab.EnableControls;
    end;
  finally
    Dec(FCalc);
  end;
end;

procedure TFormReportSSRPI.edtKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = 13) and (mtLine.State = dsEdit) then
  begin
    mtLine.Post;
    (Sender as TDBEdit).SelectAll;
  end;
end;

procedure TFormReportSSRPI.SetObjectID(AValue: Integer);
var I, J: Integer;
    TmpDate: TDateTime;
    Field: TFloatField;
    TmpCol: TColumn;
    Y, M, D: Word;
begin
  if not mtLine.Active then
    mtLine.Active := True;

  mtLine.DisableControls;
  try
    mtLine.EmptyDataSet;
    mtLine.Append;
    mtLine.Post;

    FObjectID := AValue;
    qrTemp.SQL.Text :=
      'SELECT beg_stroj, beg_stroj2, srok_stroj, ' +
      'FN_getIndex(beg_stroj, DATE_ADD(beg_stroj2, INTERVAL -1 MONTH), 1) as pibeg ' +
      'FROM objcards WHERE obj_id = :obj_id';
    qrTemp.ParamByName('obj_id').Value := FObjectID;
    qrTemp.Active := True;
    if not qrTemp.IsEmpty then
    begin
      mtLine.Edit;
      mtLineSmDate.Value := qrTemp.Fields[0].AsDateTime;
      mtLineBeginDate.Value := qrTemp.Fields[1].AsDateTime;
      mtLineSrok.Value := qrTemp.Fields[2].AsInteger;
      mtLinePIOnBegin.Value := qrTemp.Fields[3].AsFloat;
      mtLine.Post;
    end;
    qrTemp.Active := False;

    qrTemp.SQL.Text := 'Select NO_INDEX_TOTAL, DEV_ZAK_NDS, MAT_ZAK_NDS, ' +
      'OTHER_CHAP1, PIR_EXP, OTHER_NO_INDEX from ssr_line where (OBJ_ID = :OBJ_ID);';
    qrTemp.ParamByName('OBJ_ID').Value := FObjectID;
    qrTemp.Active := True;

    mtLine.Edit;
    mtLineNoIndex.Value := qrTemp.Fields[0].AsFloat;
    mtLineDevZakNDS.Value := qrTemp.Fields[1].AsFloat;
    mtLineMatZakNDS.Value := qrTemp.Fields[2].AsFloat;
    mtLineOtherChap1.Value := qrTemp.Fields[3].AsFloat;
    mtLinePIRExp.Value := qrTemp.Fields[4].AsFloat;
    mtLineOtherNoIndex.Value := qrTemp.Fields[5].AsFloat;
    mtLine.Post;

    qrTemp.Active := False;
  finally
    mtLine.EnableControls;
  end;

  mtTab.DisableControls;
  try
    mtTab.Active := False;

    for I := 1 to mtLineSrok.Value do
    begin
      Field := TFloatField.Create(mtTab);
      Field.FieldName := 'month' + I.ToString;
      Field.Tag := I;
      Field.OnChange := mtTabProcChange;
      Field.DisplayFormat := C_DISPFORMAT;
      Field.EditFormat := C_EDITFORMAT;

      Field.DataSet := mtTab;

      TmpDate := IncMonth(mtLineBeginDate.Value, I - 1);
      DecodeDate(TmpDate, Y, M, D);

      TmpCol := grTab.Columns.Add;
      TmpCol.FieldName := Field.FieldName;
      TmpCol.Title.Alignment := taCenter;
      TmpCol.Title.Caption := arraymes[M, 1] + ' ' + Y.ToString;
      TmpCol.Width := 120;
    end;

    mtTab.Active := True;

    for I := Low(TabItems) to High(TabItems) do
    begin
      mtTab.Append;
      mtTabName.AsString := TabItems[I][0];
      mtTabLineNum.AsString := TabItems[I][1];

      if TabItems[I][1] = '1' then
      begin
        for J := 1 to mtLineSrok.Value do
        begin
          TmpDate := IncMonth(mtLineBeginDate.Value, J - 1);
          DecodeDate(TmpDate, Y, M, D);
          qrTemp.SQL.Text :=
            'SELECT PROC_STROI from ssr_month_proc where ' +
            '(OBJ_ID = :OBJ_ID) and (SYEAR = :SYEAR) and (SMONTH = :SMONTH);';
          qrTemp.ParamByName('OBJ_ID').Value := FObjectID;
          qrTemp.ParamByName('SYEAR').Value := Y;
          qrTemp.ParamByName('SMONTH').Value := M;
          qrTemp.Active := True;
          mtTab.FieldByName('month' + J.ToString).Value := qrTemp.Fields[0].Value;
          qrTemp.Active := False;
        end;
      end;

      if TabItems[I][1] = '2' then
      begin
        for J := 1 to mtLineSrok.Value do
        begin
          TmpDate := IncMonth(mtLineBeginDate.Value, J - 1);
          DecodeDate(TmpDate, Y, M, D);
          qrTemp.SQL.Text :=
            'SELECT PROC_DEV from ssr_month_proc where ' +
            '(OBJ_ID = :OBJ_ID) and (SYEAR = :SYEAR) and (SMONTH = :SMONTH);';
          qrTemp.ParamByName('OBJ_ID').Value := FObjectID;
          qrTemp.ParamByName('SYEAR').Value := Y;
          qrTemp.ParamByName('SMONTH').Value := M;
          qrTemp.Active := True;
          mtTab.FieldByName('month' + J.ToString).Value := qrTemp.Fields[0].Value;
          qrTemp.Active := False;
        end;
      end;

      if TabItems[I][1] = '6' then
      begin
        for J := 1 to mtLineSrok.Value do
        begin
          qrTemp.SQL.Text :=
            'SELECT FN_getIndex(:Date1, :Date2, 1);';
          qrTemp.ParamByName('Date1').Value := mtLineBeginDate.Value;
          qrTemp.ParamByName('Date2').Value := IncMonth(mtLineBeginDate.Value, J - 1);
          qrTemp.Active := True;
          mtTab.FieldByName('month' + J.ToString).Value := qrTemp.Fields[0].Value;
          qrTemp.Active := False;
        end;
      end;
      mtTab.Post;
    end;
  finally
    mtTab.EnableControls;
  end;
end;

procedure TFormReportSSRPI.SpeedButton1Click(Sender: TObject);
begin
  pnlNoIndex.Visible := not pnlNoIndex.Visible;
  grTab.Repaint;
end;

end.
