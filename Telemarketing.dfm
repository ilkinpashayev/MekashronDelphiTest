object TelemarketingForm: TTelemarketingForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Add Telemarketing'
  ClientHeight = 211
  ClientWidth = 456
  Color = clBtnFace
  CustomTitleBar.CaptionAlignment = taCenter
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label2: TLabel
    Left = 8
    Top = 51
    Width = 49
    Height = 13
    Caption = 'Entity ID'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object UserNameLbl: TLabel
    Left = 8
    Top = 85
    Width = 61
    Height = 13
    Caption = 'User Name'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label3: TLabel
    Left = 8
    Top = 117
    Width = 54
    Height = 13
    Caption = 'Password'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object responselabel: TLabel
    Left = 96
    Top = 16
    Width = 3
    Height = 13
    Visible = False
  end
  object CreateTelemarketingButton: TButton
    Left = 8
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Create'
    TabOrder = 0
    OnClick = CreateTelemarketingButtonClick
  end
  object EntityNamesCombo: TComboBox
    Left = 79
    Top = 48
    Width = 121
    Height = 21
    TabOrder = 1
  end
  object UserNameEdit: TEdit
    Left = 79
    Top = 80
    Width = 121
    Height = 21
    TabOrder = 2
    Text = 'admin'
  end
  object PasswordOlEdit: TEdit
    Left = 79
    Top = 114
    Width = 121
    Height = 21
    PasswordChar = '*'
    TabOrder = 3
    Text = 'admin'
  end
  object TelemarketingUserList: TCheckListBox
    Left = 216
    Top = 48
    Width = 232
    Height = 155
    OnClickCheck = TelemarketingUserListClickCheck
    ItemHeight = 13
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
  object BusinessApi: THTTPRIO
    WSDLLocation = 
      'C:\Ilkin\Projects\Delphi\MekashronCRM\Win32\Debug\IBusinessAPI.x' +
      'ml'
    Service = 'IBusinessAPIservice'
    Port = 'IBusinessAPIPort'
    Converter.Options = [soSendMultiRefObj, soTryAllSchema, soRootRefNodesToBody, soCacheMimeResponse, soUTF8EncodeXML]
    Left = 68
    Top = 160
  end
end
