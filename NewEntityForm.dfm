object newEntityFrm: TnewEntityFrm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Create New Entity'
  ClientHeight = 269
  ClientWidth = 503
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
    Top = 45
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
  object UserNameLbl: TLabel
    Left = 8
    Top = 109
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
    Top = 141
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
    Top = 173
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
    Left = 280
    Top = 44
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
    Left = 280
    Top = 76
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
    Left = 280
    Top = 108
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
    Left = 280
    Top = 140
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
    Left = 280
    Top = 172
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
  object Label2: TLabel
    Left = 9
    Top = 80
    Width = 36
    Height = 13
    Caption = 'Entity:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label10: TLabel
    Left = 8
    Top = 202
    Width = 81
    Height = 13
    Caption = 'Main category'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label11: TLabel
    Left = 8
    Top = 230
    Width = 75
    Height = 13
    Caption = 'Sub category'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object CreateEntityButton: TButton
    Left = 8
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Create'
    TabOrder = 0
    OnClick = CreateEntityButtonClick
  end
  object BusinessIDEdit: TEdit
    Left = 103
    Top = 42
    Width = 121
    Height = 21
    TabOrder = 1
    Text = '1'
  end
  object UserNameEdit: TEdit
    Left = 103
    Top = 106
    Width = 121
    Height = 21
    TabOrder = 2
    Text = 'admin'
  end
  object PasswordOlEdit: TEdit
    Left = 103
    Top = 138
    Width = 121
    Height = 21
    PasswordChar = '*'
    TabOrder = 3
    Text = 'admin'
  end
  object EmailEdit: TEdit
    Left = 103
    Top = 171
    Width = 121
    Height = 21
    TabOrder = 4
    Text = 'pashayev.ilkin1@gmail.com'
  end
  object PasswordEdit: TEdit
    Left = 351
    Top = 41
    Width = 121
    Height = 21
    PasswordChar = '*'
    TabOrder = 5
    Text = 'admin'
  end
  object FirstNameEdit: TEdit
    Left = 351
    Top = 73
    Width = 121
    Height = 21
    TabOrder = 6
    Text = 'Ilkin'
  end
  object LastNameEdit: TEdit
    Left = 351
    Top = 105
    Width = 121
    Height = 21
    TabOrder = 7
    Text = 'Pashayev'
  end
  object MobileEdit: TEdit
    Left = 351
    Top = 137
    Width = 121
    Height = 21
    TabOrder = 8
    Text = '+994519001290'
  end
  object CountryISOEdit: TEdit
    Left = 351
    Top = 170
    Width = 121
    Height = 21
    TabOrder = 9
    Text = 'IL'
  end
  object EntityNamesCombo: TComboBox
    Left = 104
    Top = 77
    Width = 120
    Height = 21
    TabOrder = 10
  end
  object memolog: TMemo
    Left = 89
    Top = 8
    Width = 360
    Height = 28
    BorderStyle = bsNone
    Color = clBtnFace
    ScrollBars = ssVertical
    TabOrder = 11
    Visible = False
  end
  object maincategorycombo: TComboBox
    Left = 104
    Top = 200
    Width = 120
    Height = 21
    TabOrder = 12
    OnChange = maincategorycomboChange
  end
  object subcategorycombo: TComboBox
    Left = 104
    Top = 227
    Width = 120
    Height = 21
    TabOrder = 13
  end
  object BusinessApi: THTTPRIO
    URL = 'http://127.0.0.1:33322/soap/IBusinessAPI'
    HTTPWebNode.URL = 'http://127.0.0.1:33322/soap/IBusinessAPI'
    HTTPWebNode.WebNodeOptions = [wnoSOAP12]
    Converter.Options = [soSendMultiRefObj, soTryAllSchema, soRootRefNodesToBody, soDontSendEmptyNodes, soCacheMimeResponse, soUTF8EncodeXML, soFormElementUnqualifed, soSOAP12]
    Left = 208
  end
end
