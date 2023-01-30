object TelemarketingForm: TTelemarketingForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Add Telemarketing'
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
  object Label2: TLabel
    Left = 10
    Top = 64
    Width = 62
    Height = 17
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Caption = 'Entity ID'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -14
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object UserNameLbl: TLabel
    Left = 10
    Top = 106
    Width = 75
    Height = 17
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Caption = 'User Name'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -14
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label3: TLabel
    Left = 10
    Top = 146
    Width = 67
    Height = 17
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Caption = 'Password'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -14
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object responselabel: TLabel
    Left = 120
    Top = 20
    Width = 4
    Height = 17
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Visible = False
  end
  object CreateTelemarketingButton: TButton
    Left = 10
    Top = 10
    Width = 94
    Height = 31
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Caption = 'Create'
    TabOrder = 0
    OnClick = CreateTelemarketingButtonClick
  end
  object EntityNamesCombo: TComboBox
    Left = 99
    Top = 60
    Width = 151
    Height = 21
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    TabOrder = 1
  end
  object UserNameEdit: TEdit
    Left = 99
    Top = 100
    Width = 151
    Height = 25
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    TabOrder = 2
    Text = 'admin'
  end
  object PasswordOlEdit: TEdit
    Left = 99
    Top = 143
    Width = 151
    Height = 25
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    PasswordChar = '*'
    TabOrder = 3
    Text = 'admin'
  end
  object TelemarketingUserList: TCheckListBox
    Left = 270
    Top = 60
    Width = 290
    Height = 194
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    OnClickCheck = TelemarketingUserListClickCheck
    Items.Strings = (
      '1'
      '2'
      '3'
      '4'
      '5'
      '6'
      '7'
      '8'
      '9'
      '0')
    TabOrder = 4
  end
  object memolog: TMemo
    Left = 111
    Top = 10
    Width = 450
    Height = 35
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    BorderStyle = bsNone
    Color = clBtnFace
    ScrollBars = ssVertical
    TabOrder = 5
    Visible = False
  end
  object BusinessApi: THTTPRIO
    Converter.Options = [soSendMultiRefObj, soTryAllSchema, soRootRefNodesToBody, soCacheMimeResponse, soUTF8EncodeXML]
    Left = 68
    Top = 160
  end
end
