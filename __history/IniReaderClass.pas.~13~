unit IniReaderClass;

interface
uses Classes,inifiles,System.SysUtils,Forms;

type IniReaderHelper = class
  public
    class var
      DriverId : string;
      Server   : string;
      Port     : string;
      Database : string;
      User_name: string;
      Password : string;
      VendorLib: string;
      Wsdl     : string;
    Constructor Create; overload;
  end;


implementation

constructor  IniReaderHelper.Create;
var
  DriverIdIni : string;
  ServerIni   : string;
  PortIni     : string;
  DatabaseIni : string;
  UserNameIni : string;
  PasswordIni : string;
  VendorLibIni: string;
  WsdlIni     : string;
  appINI : TIniFile;
begin
  DriverIdIni := '';
  ServerIni   := '';
  PortIni     := '';
  DatabaseIni := '';
  UserNameIni := '';
  WsdlIni     :='';
  try
     appINI      := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'settings.ini');
     DriverIdIni := appINI.ReadString('Param','DriverId','');
     ServerIni   := appINI.ReadString('Param','Server','');
     PortIni     := appINI.ReadString('Param','Port','');
     DatabaseIni := appINI.ReadString('Param','Database','');
     UserNameIni := appINI.ReadString('Param','User_Name','');
     PasswordIni := appINI.ReadString('Param','Password','');
     VendorLibIni:= appINI.ReadString('Param','VendorLib','');
     WsdlIni     := appINI.ReadString('Param','Wsdl','');
  finally
     appINI.Free;
  end;

  DriverId := DriverIdIni;
  Server   := ServerIni;
  Port     := PortIni;
  Database := DatabaseIni;
  User_Name:= UserNameIni;
  Password := PasswordIni;
  VendorLib:= VendorLibIni;
  Wsdl     := WsdlIni;

end;

end.
