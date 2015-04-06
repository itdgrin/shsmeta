unit UniDict;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, Vcl.Grids, Vcl.DBGrids,
  JvExDBGrids, JvDBGrid, Tools, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Vcl.DBCtrls, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.Samples.Spin, System.DateUtils,
  Vcl.Mask;

type
  TfUniDict = class(TForm)
    pnl1: TPanel;
    qrUniDict: TFDQuery;
    dsUniDict: TDataSource;
    dbmmoparam_description: TDBMemo;
    seYear: TSpinEdit;
    lbl1: TLabel;
    lbl2: TLabel;
    dbedtcode: TDBEdit;
    lbl3: TLabel;
    qrUniDictid_unidictparam: TFDAutoIncField;
    strngfldUniDictcode: TStringField;
    strngfldUniDictparam_name: TStringField;
    strngfldUniDictparam_description: TStringField;
    qrUniDictMONTH_1: TFloatField;
    qrUniDictMONTH_2: TFloatField;
    qrUniDictMONTH_3: TFloatField;
    qrUniDictMONTH_4: TFloatField;
    qrUniDictMONTH_5: TFloatField;
    qrUniDictMONTH_6: TFloatField;
    qrUniDictMONTH_7: TFloatField;
    qrUniDictMONTH_8: TFloatField;
    qrUniDictMONTH_9: TFloatField;
    qrUniDictMONTH_10: TFloatField;
    qrUniDictMONTH_11: TFloatField;
    qrUniDictMONTH_12: TFloatField;
    qrSetParamValue: TFDQuery;
    qrUniDictType: TFDQuery;
    dsUniDictType: TDataSource;
    dbnvgr1: TDBNavigator;
    qrUniDictTypeLook: TFDQuery;
    dsUniDictTypeLook: TDataSource;
    qrUniDictid_unidicttype: TIntegerField;
    strngfldUniDictLookIDUniDictType: TStringField;
    pnlClient: TPanel;
    pnlLeft: TPanel;
    spl1: TSplitter;
    pnlClientCh: TPanel;
    gtUniDictType: TJvDBGrid;
    grUniDictParam: TJvDBGrid;
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure seYearChange(Sender: TObject);
    procedure qrUniDictMONTHChange(Sender: TField);
    procedure gtUniDictTypeEnter(Sender: TObject);
    procedure grUniDictParamEnter(Sender: TObject);
    procedure qrUniDictTypeAfterPost(DataSet: TDataSet);
    procedure qrUniDictTypeAfterScroll(DataSet: TDataSet);
    procedure qrUniDictTypeUpdateError(ASender: TDataSet; AException: EFDException; ARow: TFDDatSRow;
      ARequest: TFDUpdateRequest; var AAction: TFDErrorAction);
    procedure qrUniDictAfterPost(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fUniDict: TfUniDict;

implementation

{$R *.dfm}

uses Main;

procedure TfUniDict.FormActivate(Sender: TObject);
begin
  // Если нажата клавиша Ctrl и выбираем форму, то делаем
  // каскадирование с переносом этой формы на передний план
  FormMain.CascadeForActiveWindow;
  // Делаем нажатой кнопку активной формы (на главной форме внизу)
  FormMain.SelectButtonActiveWindow(Caption);
end;

procedure TfUniDict.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfUniDict.FormCreate(Sender: TObject);
begin
  // Создаём кнопку от этого окна (на главной форме внизу)
  // FormMain.CreateButtonOpenWindow(Caption, Caption, FormMain.N8Click);
  // !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  LoadDBGridSettings(grUniDictParam);
  LoadDBGridSettings(gtUniDictType);
  CloseOpen(qrUniDictType);
  CloseOpen(qrUniDictTypeLook);
  seYear.Value := YearOf(Now);
  seYearChange(Sender);
end;

procedure TfUniDict.FormDestroy(Sender: TObject);
begin
  fUniDict := nil;
  // Удаляем кнопку от этого окна (на главной форме внизу)
  FormMain.DeleteButtonCloseWindow(Caption);
end;

procedure TfUniDict.grUniDictParamEnter(Sender: TObject);
begin
  dbnvgr1.DataSource := dsUniDict;
end;

procedure TfUniDict.gtUniDictTypeEnter(Sender: TObject);
begin
  dbnvgr1.DataSource := dsUniDictType;
end;

procedure TfUniDict.qrUniDictAfterPost(DataSet: TDataSet);
begin
  CloseOpen(qrUniDict);
end;

procedure TfUniDict.qrUniDictMONTHChange(Sender: TField);
begin
  qrSetParamValue.ParamByName('inPARAM_CODE').AsString := dbedtcode.Text;
  qrSetParamValue.ParamByName('inMONTH').AsInteger := Sender.Tag;
  qrSetParamValue.ParamByName('inYEAR').AsInteger := seYear.Value;
  qrSetParamValue.ParamByName('inValue').Value := Sender.Value;
  qrSetParamValue.ExecSQL;
end;

procedure TfUniDict.qrUniDictTypeAfterPost(DataSet: TDataSet);
begin
  CloseOpen(qrUniDictTypeLook);
end;

procedure TfUniDict.qrUniDictTypeAfterScroll(DataSet: TDataSet);
begin
  seYearChange(Self);
end;

procedure TfUniDict.qrUniDictTypeUpdateError(ASender: TDataSet; AException: EFDException; ARow: TFDDatSRow;
  ARequest: TFDUpdateRequest; var AAction: TFDErrorAction);
begin
  ASender.Cancel;
  AAction := eaDefault;
  Application.MessageBox('Данный тип записи не может быть изменен', 'Предупреждение',
    MB_OK + MB_ICONWARNING + MB_TOPMOST);
end;

procedure TfUniDict.seYearChange(Sender: TObject);
begin
  qrUniDict.ParamByName('year').AsInteger := seYear.Value;
  qrUniDict.ParamByName('id_unidicttype').AsInteger := qrUniDictType.FieldByName('unidicttype_id').AsInteger;
  CloseOpen(qrUniDict);
end;

end.
