unit DataModule;

interface

uses
  Classes, DB, ImgList, Controls, Menus, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Comp.Client, FireDAC.Phys.MySQL, FireDAC.VCLUI.Wait, FireDAC.Comp.UI,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet;

type
  TDM = class(TDataModule)
    ImageListArrowsTop: TImageList;
    ImageListArrowsBottom: TImageList;
    ImageListHorozontalDots: TImageList;
    ImageListVerticalDots: TImageList;
    ImageListArrowsLeft: TImageList;
    ImageListArrowsRight: TImageList;
    ImageListModeTables: TImageList;
    ImageList1: TImageList;
    Connect: TFDConnection;
    Read: TFDTransaction;
    Write: TFDTransaction;
    FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    ADOQueryDifferentQuery: TFDQuery;
    procedure ADOConnectionAfterConnect(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DM: TDM;

implementation

uses ConnectDatabase, CalculationEstimate;

{$R *.dfm}
// ---------------------------------------------------------------------------------------------------------------------

// ---------------------------------------------------------------------------------------------------------------------

procedure TDM.ADOConnectionAfterConnect(Sender: TObject);
begin
  // MessageBox(0, PChar('Соединение с сервером успешно установлено.'), 'Подключение к MySQL Server',
  // MB_ICONINFORMATION + mb_OK + mb_TaskModal);

  // FormConnectDatabase.Close;
end;

// ---------------------------------------------------------------------------------------------------------------------

end.
