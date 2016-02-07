unit fReportSSRPI;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.Client, FireDAC.Comp.DataSet, Vcl.Grids, Vcl.DBGrids,
  JvExDBGrids, JvDBGrid, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Mask, Vcl.DBCtrls,
  Tools;

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
    mtLine: TFDMemTable;
    mtTab: TFDMemTable;
    dsLine: TDataSource;
    dsTab: TDataSource;
    mtLineSmDate: TDateField;
    mtLineBeginDate: TDateField;
    mtLineSrok: TSmallintField;
    mtLineTotalWithNal: TCurrencyField;
    mtLineVozvrat: TCurrencyField;
    mtLineDevWithNDS: TCurrencyField;
    mtLineNoIndex: TCurrencyField;
    mtLineTotalIndex: TCurrencyField;
    mtLinePIOnBegin: TFloatField;
    mtLineTotal: TCurrencyField;
    mtLineIndex1: TCurrencyField;
    mtLineIndex2: TCurrencyField;
    mtTabName: TStringField;
    mtTabSumm: TExtendedField;
    procedure FormCreate(Sender: TObject);
  private
    FObjectID: Integer;
    procedure SetObjectID(AValue: Integer);
  public
  end;

implementation

uses DataModule, GlobsAndConst;

const
  TabItems: array[0..11] of string =
  (('Нормы задела в строительстве по месяцам, %'),
   ('Нормы задела по оборудованию, %'),
   ('Стоисмость без оборудования, руб'),
   ('- в т.ч. возвратные материалы, руб'),
   ('Оборудование, руб'),
   ('Ежемесячный ПИ цен в строительстве'),
   ('Стоимость с учетом ПИ, руб'),
   ('- в т.ч. возвратные материалы, руб'),
   ('Стоимость оборудования с учетом ПИ, руб'),
   ('Средства учитывающие применение ПИ роста, руб'),
   ('- в т.ч. возвратные материалы, руб'),
   ('Средства учитывающие применение ПИ роста на оборудование, руб'));

{$R *.dfm}

{ TFormReportSSRPI }

procedure TFormReportSSRPI.FormCreate(Sender: TObject);
begin
  FObjectID := 0;
  if not VarIsNull(InitParams) then
    SetObjectID(InitParams);
end;

procedure TFormReportSSRPI.SetObjectID(AValue: Integer);
var I: Integer;
    TmpDate: TDateTime;
    Field: TField;
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
      mtLine.Post;;
    end;
  finally
    mtLine.EnableControls;
  end;

  mtTab.DisableControls;
  try
    mtTab.Active := False;

    for I := 1 to mtLineSrok.Value do
    begin
      Field := TExtendedField.Create(mtTab);
      Field.FieldName := 'month' + I.ToString;
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
      mtTabName.AsString := TabItems[I];
      mtTab.Post;
    end;
  finally
    mtTab.EnableControls;
  end;

end;

end.
