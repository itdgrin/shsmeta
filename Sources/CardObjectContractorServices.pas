unit CardObjectContractorServices;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Vcl.Grids, Vcl.DBGrids, JvExDBGrids, JvDBGrid, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.DBCtrls, Vcl.DBCGrids;

type
  TfCardObjectContractorServices = class(TForm)
    pnlBott: TPanel;
    btnCancel: TBitBtn;
    btnSave: TBitBtn;
    qrMain: TFDQuery;
    dsMain: TDataSource;
    grMain: TJvDBGrid;
    DBCtrlGrid1: TDBCtrlGrid;
    dbmmoparam_name: TDBMemo;
    dbchkchecked: TDBCheckBox;
    qrMainid_unidictparam: TFDAutoIncField;
    strngfldMaincode: TStringField;
    strngfldMainparam_name: TStringField;
    strngfldMainparam_description: TStringField;
    qrMainVALUE: TFloatField;
    dbtxtVALUE: TDBText;
    qrMainChecked: TBooleanField;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure qrMainCalcFields(DataSet: TDataSet);
    procedure btnCancelClick(Sender: TObject);
  private
    { Private declarations }
  public
    CheckMask: Integer;
  end;

var
  fCardObjectContractorServices: TfCardObjectContractorServices;

implementation

{$R *.dfm}

uses Tools;

procedure TfCardObjectContractorServices.btnCancelClick(Sender: TObject);
begin
  CheckMask := CheckMask and 2;
  ShowMessage(IntToStr(CheckMask));
end;

procedure TfCardObjectContractorServices.btnSaveClick(Sender: TObject);
begin
  CheckMask := 0;
  qrMain.First;
  while not qrMain.Eof do
  begin
    CheckMask := CheckMask or (1 shl qrMain.RecNo);
    qrMain.Next;
  end;
  ModalResult := mrOk;
end;

procedure TfCardObjectContractorServices.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfCardObjectContractorServices.FormCreate(Sender: TObject);
begin
  LoadDBGridSettings(grMain);
  qrMain.ParamByName('MONTH').AsInteger := 1;   // !!!
  qrMain.ParamByName('YEAR').AsInteger := 2015; // !!!
  CheckMask := 1;
  CloseOpen(qrMain);
end;

procedure TfCardObjectContractorServices.FormDestroy(Sender: TObject);
begin
  fCardObjectContractorServices := nil;
end;

procedure TfCardObjectContractorServices.qrMainCalcFields(DataSet: TDataSet);
begin
  qrMainChecked.Value := (CheckMask and (1 shl qrMain.RecNo)) = 0;
end;

end.
