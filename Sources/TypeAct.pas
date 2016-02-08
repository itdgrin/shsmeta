unit TypeAct;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Tools, Main, DataModule, JvComponentBase, JvFormPlacement,
  Vcl.ExtCtrls, Vcl.Grids, Vcl.DBGrids, JvExDBGrids, JvDBGrid, Vcl.StdCtrls, Vcl.Buttons, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  Vcl.DBCtrls;

type
  TfTypeAct = class(TSmForm)
    FormStorage: TJvFormStorage;
    grMain: TJvDBGrid;
    pnlBot: TPanel;
    btnCancel: TBitBtn;
    btnSelect: TBitBtn;
    qrMain: TFDQuery;
    dsMain: TDataSource;
    dbnvgr1: TDBNavigator;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure qrMainNewRecord(DataSet: TDataSet);
    procedure qrMainBeforePost(DataSet: TDataSet);
    procedure qrMainBeforeDelete(DataSet: TDataSet);
    procedure grMainCanEditCell(Grid: TJvDBGrid; Field: TField; var AllowEdit: Boolean);
    procedure FormActivate(Sender: TObject);
    procedure grMainDblClick(Sender: TObject);
  private
  public
  end;

var
  fTypeAct: TfTypeAct;

implementation

{$R *.dfm}

procedure TfTypeAct.FormActivate(Sender: TObject);
begin
  // Если нажата клавиша Ctrl и выбираем форму, то делаем
  // каскадирование с переносом этой формы на передний план
  FormMain.CascadeForActiveWindow;
  // Делаем нажатой кнопку активной формы (на главной форме внизу)
  FormMain.SelectButtonActiveWindow(Caption);
end;

procedure TfTypeAct.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  qrMain.CheckBrowseMode;
  Action := caFree;
end;

procedure TfTypeAct.FormCreate(Sender: TObject);
begin
  // Создаём кнопку от этого окна (на главной форме внизу)
  FormMain.CreateButtonOpenWindow(Caption, Caption, Self, 1);
  qrMain.Active := True;
end;

procedure TfTypeAct.FormDestroy(Sender: TObject);
begin
  // Удаляем кнопку от этого окна (на главной форме внизу)
  FormMain.DeleteButtonCloseWindow(Caption);
  fTypeAct := nil;
end;

procedure TfTypeAct.FormShow(Sender: TObject);
begin
  pnlBot.Visible := FormKind in [kdSelect];
end;

procedure TfTypeAct.grMainCanEditCell(Grid: TJvDBGrid; Field: TField; var AllowEdit: Boolean);
begin
  AllowEdit := (qrMain.FieldByName('CONSTANT').AsInteger <> 1);
end;

procedure TfTypeAct.grMainDblClick(Sender: TObject);
begin
  if FormKind in [kdSelect] then
    ModalResult := mrOk;
end;

procedure TfTypeAct.qrMainBeforeDelete(DataSet: TDataSet);
begin
  if qrMain.FieldByName('CONSTANT').AsInteger = 1 then
  begin
    ShowMessage('Удаленние данного типа акта запрещено!');
    Abort;
  end;
end;

procedure TfTypeAct.qrMainBeforePost(DataSet: TDataSet);
begin
  if qrMain.FieldByName('CONSTANT').AsInteger = 1 then
  begin
    ShowMessage('Редактирование данного типа акта запрещено!');
    Abort;
  end;
end;

procedure TfTypeAct.qrMainNewRecord(DataSet: TDataSet);
begin
  qrMain.FieldByName('POS').AsInteger := FastSelectSQLOne('SELECT MAX(POS)+1 FROM TYPE_ACT', VarArrayOf([]));
end;

end.
