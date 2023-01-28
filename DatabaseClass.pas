unit DatabaseClass;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MySQL,
  FireDAC.Phys.MySQLDef, FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet,IniReaderClass,DBConnectResult;

type
  TDataModule2 = class(TDataModule)
    mysqlConnection: TFDConnection;
    qryCallback: TFDQuery;
    FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink;
    function  connectDB( server:string; port:string; database:string;username:string; password:string):TDbConnectResult;
    procedure DataModuleCreate(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DataModule2: TDataModule2;
  IniReader   : IniReaderHelper;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}
function TDataModule2.connectDB( server:string; port:string; database:string;username:string; password:string):TDbConnectResult;
var
   errorMessage     : string;
   connectedresult : integer;
   dbmodel         : TDbConnectResult;

begin

   try
     IniReader := IniReaderHelper.Create;

     mysqlConnection.Close;
     mysqlConnection.Params.Clear;
     mysqlConnection.Params.Add('DriverID=MySQL');
     mysqlConnection.Params.Add('Server='+server);
     mysqlConnection.Params.Add('Port='+port);
     mysqlConnection.Params.Add('Database='+database);
     mysqlConnection.Params.Add('User_Name='+username);
     mysqlConnection.Params.Add('Password='+password);
     mysqlConnection.Open;
     connectedresult :=1;
     result :=  TDbConnectResult.Create;
     result.isConnected :=1;
     result.ExceptonMessage := '';
     result.ExceptionClass :='';
  except
   on E : Exception do
     begin
       connectedresult :=-1;
       result :=  TDbConnectResult.Create;
       result.isConnected :=-1;
       result.ExceptionClass :='Exception class name = '+E.ClassName;
       result.ExceptonMessage := 'Exception message = '+E.Message;
       //logMessage := logHelper.generateLogMessage('DatabaseConnection','Exception class name = '+E.ClassName);
       //eventLogMemo.Lines.Add(logMessage);
       //logMessage := logHelper.generateLogMessage('DatabaseConnection','Exception message = '+E.Message);
       //eventLogMemo.Lines.Add(logMessage);
       errorMessage :='Error';

     end;
   end;

 { if (connectedresult =-1) then
  begin
     logMessage := logHelper.generateLogMessage('DatabseConnection','Couldn''t connect to database check setting then  try again');
     eventLogMemo.Lines.Add(logMessage);
     Exit;
  end
  else
  begin
     logMessage := logHelper.generateLogMessage('DatabseConnection','Connected successfully');
     eventLogMemo.Lines.Add(logMessage);
  end;
  }
end;

procedure TDataModule2.DataModuleCreate(Sender: TObject);
begin
  FDPhysMySQLDriverLink1.VendorLib:='libmysql.dll';
end;

end.
