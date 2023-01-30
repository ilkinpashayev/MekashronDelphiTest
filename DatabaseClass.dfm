object DataModule2: TDataModule2
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 325
  Width = 536
  object mysqlConnection: TFDConnection
    Params.Strings = (
      'DriverID=MySQL'
      'User_Name=root')
    Left = 31
    Top = 16
  end
  object qryCallback: TFDQuery
    Connection = mysqlConnection
    SQL.Strings = (
      'select * from callback')
    Left = 31
    Top = 86
  end
  object FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink
    VendorLib = 'C:\lib\l\libmysql\libmysql.dll'
    Left = 159
    Top = 16
  end
  object qrySelect: TFDQuery
    Connection = mysqlConnection
    SQL.Strings = (
      'select * from callback')
    Left = 95
    Top = 86
  end
end
