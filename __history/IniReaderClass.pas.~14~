unit IniReaderClass;

interface
uses Classes,inifiles,System.SysUtils,Forms;

type IniReaderHelper = class
  public
    class var
      Server   : string;
      Port     : string;
      Database : string;
      User_name: string;
      Password : string;
      Wsdl     : string;
    Constructor Create; overload;
  end;


implementation

constructor  IniReaderHelper.Create;
var

  ServerIni   : string;
  PortIni     : string;
  DatabaseIni : string;
  UserNameIni : string;
  PasswordIni : string;
  WsdlIni     : string;
  appINI : TIniFile;
begin

  ServerIni   := '';
  PortIni     := '';
  DatabaseIni := '';
  UserNameIni := '';
  WsdlIni     :='';
  try
     appINI      := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'settings.ini');
     ServerIni   := appINI.ReadString('Param','Server','');
     PortIni     := appINI.ReadString('Param','Port','');
     DatabaseIni := appINI.ReadString('Param','Database','');
     UserNameIni := appINI.ReadString('Param','User_Name','');
     PasswordIni := appINI.ReadString('Param','Password','');
     WsdlIni     := appINI.ReadString('Param','Wsdl','');
  finally
     appINI.Free;
  end;

  Server   := ServerIni;
  Port     := PortIni;
  Database := DatabaseIni;
  User_Name:= UserNameIni;
  Password := PasswordIni;
  Wsdl     := WsdlIni;

end;

end.
