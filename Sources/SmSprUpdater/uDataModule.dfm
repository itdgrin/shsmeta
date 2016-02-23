object DM: TDM
  OldCreateOrder = False
  Height = 236
  Width = 387
  object FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink
    VendorLib = 'libmySQL.dll'
    Left = 240
    Top = 80
  end
  object Connect: TFDConnection
    Params.Strings = (
      'DriverID=MySQL')
    Transaction = Read
    Left = 144
    Top = 24
  end
  object Read: TFDTransaction
    Connection = Connect
    Left = 144
    Top = 80
  end
  object qrDifferent: TFDQuery
    Connection = Connect
    Left = 40
    Top = 24
  end
  object qrDifferent1: TFDQuery
    Connection = Connect
    Left = 40
    Top = 80
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Forms'
    ScreenCursor = gcrDefault
    Left = 240
    Top = 24
  end
end
