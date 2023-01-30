unit Unit2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  Tservicesettings = class(TForm)
    Button1: TButton;
    SettingsMemo: TMemo;
    Button2: TButton;
    Button3: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  servicesettings: Tservicesettings;

implementation

{$R *.dfm}

procedure Tservicesettings.Button1Click(Sender: TObject);
begin
 try
  SettingsMemo.Lines.Clear;
  if FileExists('servicesettings.ini') then
    SettingsMemo.Lines.LoadFromFile('servicesettings.ini')
  else
    begin
       SettingsMemo.Lines.Add('[Param]');
       SettingsMemo.Lines.Add('EntityID=1');
       SettingsMemo.Lines.Add('Username=admin');
       SettingsMemo.Lines.Add('Password=admin');
       SettingsMemo.Lines.Add('BusinessID=1');
       SettingsMemo.Lines.Add('CountryISO=IL');
       SettingsMemo.Lines.Add('CategoryID=2');
       SettingsMemo.Lines.Add('Wsdl=http://127.0.0.1:33322/soap/IBusinessAPI');

    end;
  ShowMessage('Settings file loaded');
 finally

 end;
end;

procedure Tservicesettings.Button2Click(Sender: TObject);
begin
  try
    SettingsMemo.Lines.Clear;
    SettingsMemo.Lines.Add('[Param]');
       SettingsMemo.Lines.Add('EntityID=1');
       SettingsMemo.Lines.Add('Username=admin');
       SettingsMemo.Lines.Add('Password=admin');
       SettingsMemo.Lines.Add('BusinessID=1');
       SettingsMemo.Lines.Add('CountryISO=IL');
       SettingsMemo.Lines.Add('CategoryID=2');
       SettingsMemo.Lines.Add('Wsdl=http://127.0.0.1:33322/soap/IBusinessAPI');
    SettingsMemo.Lines.SaveToFile('servicesettings.ini');
    ShowMessage('Default ini file created');
  finally

  end;
end;

procedure Tservicesettings.Button3Click(Sender: TObject);
begin
  try
    SettingsMemo.Lines.SaveToFile('servicesettings.ini');
    ShowMessage('Ini file saved');
  finally

  end;
end;

end.
