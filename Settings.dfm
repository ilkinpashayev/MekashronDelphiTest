object SettingsForm: TSettingsForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Settings'
  ClientHeight = 344
  ClientWidth = 719
  Color = clBtnFace
  CustomTitleBar.CaptionAlignment = taCenter
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -14
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  PixelsPerInch = 96
  TextHeight = 17
  object Button1: TButton
    Left = 10
    Top = 10
    Width = 151
    Height = 31
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Caption = 'Load  settings file'
    TabOrder = 0
    OnClick = Button1Click
  end
  object SettingsMemo: TMemo
    Left = 0
    Top = 50
    Width = 560
    Height = 204
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    TabOrder = 1
  end
  object Button2: TButton
    Left = 169
    Top = 10
    Width = 212
    Height = 31
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Caption = 'Generate default settings file'
    TabOrder = 2
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 389
    Top = 11
    Width = 162
    Height = 32
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Caption = 'Save settings file'
    TabOrder = 3
    OnClick = Button3Click
  end
end
