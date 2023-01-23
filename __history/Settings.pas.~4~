unit Settings;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TSettingsForm = class(TForm)
    Button1: TButton;
    SettingsMemo: TMemo;
    Button2: TButton;
    Button3: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  SettingsForm: TSettingsForm;

implementation

{$R *.dfm}

procedure TSettingsForm.Button1Click(Sender: TObject);
begin
 try
  SettingsMemo.Lines.Clear;
  if FileExists('settings.ini') then
    SettingsMemo.Lines.LoadFromFile('settings.ini')
  else
    begin
       SettingsMemo.Lines.Add('[Param]');
       SettingsMemo.Lines.Add('DriverId=MySQL');
       SettingsMemo.Lines.Add('Server=127.0.0.1');
       SettingsMemo.Lines.Add('Port=3306');
       SettingsMemo.Lines.Add('Database=mekashron');
       SettingsMemo.Lines.Add('User_Name=root');
       SettingsMemo.Lines.Add('Password=');
       SettingsMemo.Lines.Add('VendorLib = libmysql.dll');
       SettingsMemo.Lines.Add('Wsdl=IBusinessAPI.xml');

    end;
  ShowMessage('Settings file loaded');
 finally

 end;
end;

procedure TSettingsForm.Button2Click(Sender: TObject);
begin
  try
    SettingsMemo.Lines.Clear;
    SettingsMemo.Lines.Add('[Param]');
    SettingsMemo.Lines.Add('DriverId=MySQL');
    SettingsMemo.Lines.Add('Server=127.0.0.1');
    SettingsMemo.Lines.Add('Port=3306');
    SettingsMemo.Lines.Add('Database=mekashron');
    SettingsMemo.Lines.Add('User_Name=root');
    SettingsMemo.Lines.Add('Password=');
    SettingsMemo.Lines.Add('VendorLib = libmysql.dll');
    SettingsMemo.Lines.Add('Wsdl=IBusinessAPI.xml');
    SettingsMemo.Lines.SaveToFile('settings.ini');
    ShowMessage('Default ini file created');
  finally

  end;
end;

procedure TSettingsForm.Button3Click(Sender: TObject);
begin
  try
    SettingsMemo.Lines.SaveToFile('settings.ini');
    ShowMessage('Ini file saved');
  finally

  end;

end;

end.
