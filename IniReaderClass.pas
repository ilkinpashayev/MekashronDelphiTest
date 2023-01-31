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
      ServiceEntityID : string;
      ServiceUsername : string;
      ServicePassword  : string;
      ServiceBusinessID : string;
      ServiceCountryISO : string;
      ServiceCategoryID : string;
      ServiceCompaignID        : string;
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
  ServiceEntityIDIni : string;
  ServiceUsernameIni : string;
  ServicePasswordIni  : string;
  ServiceBusinessIDIni : string;
  ServiceCountryISOIni : string;
  ServiceCategoryIDIni : string;
  ServiceCompaignIDIni        : string;
  WsdlIni     : string;
  appINI : TIniFile;
  serviceINI : TIniFile;
begin

  ServerIni   := '';
  PortIni     := '';
  DatabaseIni := '';
  UserNameIni := '';
  ServiceEntityIDIni :='';
  ServiceUsernameIni :='';
  ServicePasswordIni  :='';
  ServiceBusinessIDIni :='';
  ServiceCountryISOIni := '';
  ServiceCategoryIDIni :='';
  ServiceCompaignIDIni :='';


  WsdlIni     :='';
  try
     appINI      := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'settings.ini');
     ServerIni   := appINI.ReadString('Param','Server','');
     PortIni     := appINI.ReadString('Param','Port','');
     DatabaseIni := appINI.ReadString('Param','Database','');
     UserNameIni := appINI.ReadString('Param','User_Name','');
     PasswordIni := appINI.ReadString('Param','Password','');


     serviceINI      := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'servicesettings.ini');
     ServiceEntityIDIni :=serviceINI.ReadString('Param','EntityID','');
     ServiceUsernameIni :=serviceINI.ReadString('Param','Username','');
     ServicePasswordIni  :=serviceINI.ReadString('Param','Password','');
     ServiceBusinessIDIni :=serviceINI.ReadString('Param','BusinessID','');
     ServiceCountryISOIni := serviceINI.ReadString('Param','CountryISO','');
     ServiceCategoryIDIni :=serviceINI.ReadString('Param','CategoryID','');
     ServiceCompaignIDIni :=serviceINI.ReadString('Param','CompaignID','');
     WsdlIni     := serviceINI.ReadString('Param','Wsdl','');

  finally
     appINI.Free;
  end;

  Server   := ServerIni;
  Port     := PortIni;
  Database := DatabaseIni;
  User_Name:= UserNameIni;
  Password := PasswordIni;


  ServiceEntityID := ServiceEntityIDIni;
  ServiceUsername :=ServiceUsernameIni;
  ServicePassword  :=ServicePasswordIni;
  ServiceBusinessID :=ServiceBusinessIDIni;
  ServiceCountryISO :=ServiceCountryISOIni;
  ServiceCategoryID :=ServiceCategoryIDIni;
  ServiceCompaignID := ServiceCompaignIDIni;
  Wsdl     := WsdlIni;

end;

end.
