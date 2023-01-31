object Form1: TForm1
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Mekashron CRM'
  ClientHeight = 703
  ClientWidth = 1391
  Color = clBtnFace
  CustomTitleBar.CaptionAlignment = taCenter
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -14
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 17
  object Label2: TLabel
    Left = 10
    Top = 49
    Width = 88
    Height = 24
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Caption = 'Event Log'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label1: TLabel
    Left = 1090
    Top = 49
    Width = 94
    Height = 24
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Caption = 'Customers'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object eventLogMemo: TMemo
    Left = 9
    Top = 81
    Width = 1051
    Height = 619
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    ScrollBars = ssVertical
    TabOrder = 0
  end
  object QryDataSendRequestBtn: TButton
    Left = 10
    Top = 10
    Width = 133
    Height = 31
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Caption = 'Run'
    TabOrder = 1
    OnClick = QryDataSendRequestBtnClick
  end
  object TelemarketingAddButton: TButton
    Left = 170
    Top = 9
    Width = 131
    Height = 31
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Caption = 'Add Telemarkeing'
    TabOrder = 2
    OnClick = TelemarketingAddButtonClick
  end
  object CheckListBox1: TCheckListBox
    Left = 1067
    Top = 80
    Width = 316
    Height = 620
    OnClickCheck = CheckListBox1ClickCheck
    ItemHeight = 17
    TabOrder = 3
  end
  object MainMenu1: TMainMenu
    Left = 344
    Top = 152
    object SettingsMenu: TMenuItem
      Caption = 'Database Connection setting'
      OnClick = SettingsMenuClick
    end
    object Serviceconnection1: TMenuItem
      Caption = 'Service settings'
      OnClick = Serviceconnection1Click
    end
  end
  object HTTPRIO1: THTTPRIO
    Converter.Options = [soSendMultiRefObj, soTryAllSchema, soRootRefNodesToBody, soCacheMimeResponse, soUTF8EncodeXML]
    Left = 336
    Top = 16
  end
end
