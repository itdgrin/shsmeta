unit uTestForRoma;

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
  Vcl.StdCtrls,
  fFrameSpr,
  fFrameMaterial,
  SprController;

type
  TTest_Form1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    FMatSpr: TSprMaterial;
    FSprRect: TSprRecord;
    procedure AddMaterial(AMatId, AManPriceID: Integer;
      APriceDate: TDateTime;
      ASprRecord: TSprRecord);
  public
    property SprRect: TSprRecord read FSprRect;
  end;

implementation

{$R *.dfm}

procedure TTest_Form1.AddMaterial(AMatId, AManPriceID: Integer;
      APriceDate: TDateTime;
      ASprRecord: TSprRecord);
begin
  FSprRect.CopyFrom(ASprRecord);
  ModalResult := mrOk;
end;

procedure TTest_Form1.Button1Click(Sender: TObject);
begin
  FMatSpr.ListSprDblClick(FMatSpr.ListSpr);
end;

procedure TTest_Form1.Button2Click(Sender: TObject);
begin
  Close;
end;

procedure TTest_Form1.FormCreate(Sender: TObject);
begin
  FMatSpr := TSprMaterial.Create(Self, True, Date, 7, True, False, 0);
  FMatSpr.Parent := Self;
  FMatSpr.LoadSpr;
  FMatSpr.Align := alTop;
  FMatSpr.OnSelect := AddMaterial;

end;

end.
