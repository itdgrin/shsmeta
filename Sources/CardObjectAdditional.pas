unit CardObjectAdditional;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Tools, DataModule, CardObject, Vcl.ExtCtrls, Vcl.DBCtrls,
  Vcl.StdCtrls, Vcl.Buttons;

type
  TfCardObjectAdditional = class(TSmForm)
    grp1: TGroupBox;
    dbchkFL_CALC_TRAVEL: TDBCheckBox;
    dbchkFL_CALC_WORKER_DEPARTMENT: TDBCheckBox;
    dbchkFL_CALC_TRAVEL_WORK: TDBCheckBox;
    dbchkFL_CALC_ZEM_NAL: TDBCheckBox;
    dbchkFL_CALC_VEDOMS_NAL: TDBCheckBox;
    btn1: TBitBtn;
    dbchkAPPLY_WINTERPRISE_FLAG: TDBCheckBox;
    dbrgrpCOEF_ORDERS: TDBRadioGroup;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure btn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fCardObjectAdditional: TfCardObjectAdditional;

implementation

{$R *.dfm}

procedure TfCardObjectAdditional.btn1Click(Sender: TObject);
begin
  Close;
end;

procedure TfCardObjectAdditional.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfCardObjectAdditional.FormDestroy(Sender: TObject);
begin
  fCardObjectAdditional := nil;
end;

end.
