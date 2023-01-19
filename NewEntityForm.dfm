object newEntityFrm: TnewEntityFrm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Create New Entity'
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
  object Label1: TLabel
    Left = 8
    Top = 56
    Width = 65
    Height = 13
    Caption = 'Business ID'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 8
    Top = 88
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
    Top = 120
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
    Top = 152
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
  object Label4: TLabel
    Left = 8
    Top = 184
    Width = 30
    Height = 13
    Caption = 'Email'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label5: TLabel
    Left = 240
    Top = 56
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
  object Label6: TLabel
    Left = 240
    Top = 88
    Width = 60
    Height = 13
    Caption = 'First Name'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label7: TLabel
    Left = 240
    Top = 120
    Width = 59
    Height = 13
    Caption = 'Last Name'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label8: TLabel
    Left = 240
    Top = 152
    Width = 37
    Height = 13
    Caption = 'Mobile'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label9: TLabel
    Left = 240
    Top = 184
    Width = 65
    Height = 13
    Caption = 'CountryISO'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object responseResultLabel: TLabel
    Left = 96
    Top = 13
    Width = 3
    Height = 13
    Color = clSilver
    ParentColor = False
    Visible = False
  end
  object CreateEntityButton: TButton
    Left = 0
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Create'
    TabOrder = 0
    OnClick = CreateEntityButtonClick
  end
  object BusinessIDEdit: TEdit
    Left = 79
    Top = 53
    Width = 121
    Height = 21
    TabOrder = 1
    Text = '1'
  end
  object EntityIDEdit: TEdit
    Left = 79
    Top = 85
    Width = 121
    Height = 21
    TabOrder = 2
    Text = '1'
  end
  object UserNameEdit: TEdit
    Left = 79
    Top = 117
    Width = 121
    Height = 21
    TabOrder = 3
    Text = 'admin'
  end
  object PasswordOlEdit: TEdit
    Left = 79
    Top = 149
    Width = 121
    Height = 21
    PasswordChar = '*'
    TabOrder = 4
    Text = 'admin'
  end
  object EmailEdit: TEdit
    Left = 79
    Top = 182
    Width = 121
    Height = 21
    TabOrder = 5
    Text = 'pashayev.ilkin1@gmail.com'
  end
  object PasswordEdit: TEdit
    Left = 311
    Top = 53
    Width = 121
    Height = 21
    PasswordChar = '*'
    TabOrder = 6
    Text = 'admin'
  end
  object FirstNameEdit: TEdit
    Left = 311
    Top = 85
    Width = 121
    Height = 21
    TabOrder = 7
    Text = 'Ilkin'
  end
  object LastNameEdit: TEdit
    Left = 311
    Top = 117
    Width = 121
    Height = 21
    TabOrder = 8
    Text = 'Pashayev'
  end
  object MobileEdit: TEdit
    Left = 311
    Top = 149
    Width = 121
    Height = 21
    TabOrder = 9
    Text = '+994519001290'
  end
  object CountryISOEdit: TEdit
    Left = 311
    Top = 182
    Width = 121
    Height = 21
    TabOrder = 10
    Text = 'IL'
  end
  object BusinessApi: THTTPRIO
    WSDLLocation = 
      'C:\Ilkin\Projects\Delphi\MekashronCRM\Win32\Debug\IBusinessAPI.x' +
      'ml'
    Service = 'IBusinessAPIservice'
    Port = 'IBusinessAPIPort'
    Converter.Options = [soSendMultiRefObj, soTryAllSchema, soRootRefNodesToBody, soCacheMimeResponse, soUTF8EncodeXML]
    Left = 440
    Top = 168
  end
end
