object Form1: TForm1
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Mekashron CRM'
  ClientHeight = 567
  ClientWidth = 857
  Color = clBtnFace
  CustomTitleBar.CaptionAlignment = taCenter
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 432
    Height = 76
    Caption = 
      'Click button to create new customers. Number of customers will b' +
      'e in range 4-10 on random.  Created customers will be saved to l' +
      'ocal databse, with different threads.  Later new customers would' +
      ' be sent to CRM API'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    WordWrap = True
  end
  object Label2: TLabel
    Left = 8
    Top = 160
    Width = 70
    Height = 19
    Caption = 'Event Log'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object createCustomersBtn: TButton
    Left = 8
    Top = 90
    Width = 105
    Height = 25
    Caption = 'Insert into Callback'
    TabOrder = 0
    OnClick = createCustomersBtnClick
  end
  object eventLogMemo: TMemo
    Left = 8
    Top = 192
    Width = 825
    Height = 357
    ScrollBars = ssVertical
    TabOrder = 1
  end
  object QryDataSendRequestBtn: TButton
    Left = 135
    Top = 90
    Width = 137
    Height = 25
    Caption = 'Query table'
    TabOrder = 2
    OnClick = QryDataSendRequestBtnClick
  end
  object newentrybtn: TButton
    Left = 288
    Top = 90
    Width = 75
    Height = 25
    Caption = 'New Entry'
    TabOrder = 3
    OnClick = newentrybtnClick
  end
  object TelemarketingAddButton: TButton
    Left = 384
    Top = 90
    Width = 105
    Height = 25
    Caption = 'Add Telemarkeing'
    TabOrder = 4
    OnClick = TelemarketingAddButtonClick
  end
  object mysqlConnection: TFDConnection
    Params.Strings = (
      'DriverID=MySQL'
      'User_Name=root')
    Left = 520
    Top = 64
  end
  object FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink
    VendorLib = 'C:\lib\l\libmysql\libmysql.dll'
    Left = 632
    Top = 64
  end
  object qryCallback: TFDQuery
    Connection = mysqlConnection
    SQL.Strings = (
      'select * from callback')
    Left = 504
    Top = 128
  end
  object MainMenu1: TMainMenu
    Left = 344
    Top = 152
    object SettingsMenu: TMenuItem
      Caption = 'Settings'
      OnClick = SettingsMenuClick
    end
  end
end
