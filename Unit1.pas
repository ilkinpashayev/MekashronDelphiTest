unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, LogHelper,Math,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client,
  FireDAC.Phys.MySQLDef, FireDAC.Phys.MySQL,IniReaderClass, FireDAC.Stan.Param,
  FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.DataSet,DateUtils,TDBThreadClass,
  Datasnap.DBClient, NewEntityForm,IBusinessAPI1,System.Generics.Collections,Telemarketing,
  Vcl.Menus,Settings,DatabaseClass,DBConnectResult,Unit2, Soap.InvokeRegistry,
  System.Net.URLClient, Soap.Rio, Soap.SOAPHTTPClient,Rest.Json,ResponseModel,
  ActiveX,TelemarketingResponseModel, Vcl.CheckLst;

type
  TForm1 = class(TForm)
    Label2: TLabel;
    eventLogMemo: TMemo;
    QryDataSendRequestBtn: TButton;
    TelemarketingAddButton: TButton;
    MainMenu1: TMainMenu;
    SettingsMenu: TMenuItem;
    Label1: TLabel;
    Serviceconnection1: TMenuItem;
    HTTPRIO1: THTTPRIO;
    CheckListBox1: TCheckListBox;
    procedure FormCreate(Sender: TObject);
    function  connectDB: Integer;
    function  checkServiceSettings: Integer;
    function  checktable: Integer;
    function  createtable:Integer;
    procedure selectCallbackData;
    procedure QryDataSendRequestBtnClick(Sender: TObject);
    procedure SettingsMenuClick(Sender: TObject);
    procedure Serviceconnection1Click(Sender: TObject);
    procedure TelemarketingAddButtonClick(Sender: TObject);
    procedure CheckListBox1ClickCheck(Sender: TObject);
  private
    { Private declarations }
  public
         { Public declarations }
  end;

  TDBThreadSelect = class(TThread)
  private
    FNewStr: String;
  protected
    procedure Execute; override;
  public
    constructor Create(const ANewStr: String);

  end;

var
  Form1: TForm1;
  IniReader   : IniReaderHelper;
  logMessage  : string;
  logHelper   : MekashronLogHelper;
  dbModule    : TDataModule2;
  dbconnectmodel: TDbConnectResult;
  CIDList : TList<String>;
  entityList : TList<Integer>;
  SelectedList : TList<Integer>;


implementation

function TForm1.checkServiceSettings:Integer;
var
   errorMessage     : string;
begin
    IniReader := IniReaderHelper.Create;
    if (IniReader.ServiceEntityID = null) or (IniReader.ServiceEntityID = '') then
      begin
        result:=-1;
       logMessage := logHelper.generateLogMessage('ServiceSettings','EntityID is missing');
       eventLogMemo.Lines.Add(logMessage);
      end
    else if  (IniReader.ServiceUsername=null) or  (IniReader.ServiceUsername='') then
      begin
        result:=-1;
       logMessage := logHelper.generateLogMessage('ServiceSettings','ServiceUsername is missing');
       eventLogMemo.Lines.Add(logMessage);
      end
     else if  (IniReader.ServicePassword=null) or  (IniReader.Password='') then
      begin
        result:=-1;
       logMessage := logHelper.generateLogMessage('ServiceSettings','Password is missing');
       eventLogMemo.Lines.Add(logMessage);
      end
     else if  (IniReader.ServiceBusinessID=null) or  (IniReader.ServiceBusinessID='') then
      begin
        result:=-1;
       logMessage := logHelper.generateLogMessage('ServiceSettings','ServiceBusinessID is missing');
       eventLogMemo.Lines.Add(logMessage);
      end
     else if  (IniReader.ServiceCountryISO=null) or  (IniReader.ServiceCountryISO='') then
      begin
        result:=-1;
       logMessage := logHelper.generateLogMessage('ServiceSettings','ServiceCountryISO is missing');
       eventLogMemo.Lines.Add(logMessage);
      end
     else if  (IniReader.ServiceCategoryID=null) or  (IniReader.ServiceCategoryID='') then
      begin
        result:=-1;
       logMessage := logHelper.generateLogMessage('ServiceSettings','ServiceCategoryID is missing');
       eventLogMemo.Lines.Add(logMessage);
      end
     else if  (IniReader.Wsdl=null) or  (IniReader.Wsdl='') then
      begin
        result:=-1;
       logMessage := logHelper.generateLogMessage('ServiceSettings','Wsdl is missing');
       eventLogMemo.Lines.Add(logMessage);
      end
      else
      begin
        HTTPRIO1.URL :=IniReader.Wsdl;
        result :=1;
      end;



end;

{$R *.dfm}
function TForm1.connectDB:Integer;
var
   errorMessage     : string;
begin
  result := 0;
   try
     logMessage := logHelper.generateLogMessage('DatabaseConnection','Setting up connection');
     eventLogMemo.Lines.Add(logMessage);
     logMessage := logHelper.generateLogMessage('DatabaseConnection','Connecting to Server:'+IniReader.Server+' ; Database: '+IniReader.Database);
     eventLogMemo.Lines.Add(logMessage);
     dbconnectmodel :=dbModule.connectDB(IniReader.Server,IniReader.Port,IniReader.Database,IniReader.User_Name,IniReader.Password);

  except
   on E : Exception do
     begin
       logMessage := logHelper.generateLogMessage('DatabaseConnection','Exception class name = '+E.ClassName);
       eventLogMemo.Lines.Add(logMessage);
       logMessage := logHelper.generateLogMessage('DatabaseConnection','Exception message = '+E.Message);
       eventLogMemo.Lines.Add(logMessage);
       errorMessage :='Error';
       result := -1;
     end;
   end;

   if (dbconnectmodel.isConnected=-1) then
   begin
     logMessage := logHelper.generateLogMessage('DatabseConnection',dbconnectmodel.ExceptionClass);
     eventLogMemo.Lines.Add(logMessage);
     logMessage := logHelper.generateLogMessage('DatabseConnection',dbconnectmodel.ExceptonMessage);
     eventLogMemo.Lines.Add(logMessage);
     result :=  -1;
   end;

  if (result =-1) then
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
end;

procedure TForm1.QryDataSendRequestBtnClick(Sender: TObject);
var
   connectresult    : Integer;
   tableexists      : Integer;

  //connectresult : Integer;
  newEntity     : TnewEntityFrm;
  soapClient    : IBusinessAPI;
begin
  if (checkServiceSettings=1)  then
  begin
   connectresult :=  connectDB;

   if (connectresult = 0) then
    begin
      tableexists := checktable;
    end;

   if (connectresult = 0) and (tableexists=0) then
    begin
      try
        selectCallbackData;
      except
        on E : Exception do
      begin
       logMessage := logHelper.generateLogMessage('Run','Exception class name = '+E.ClassName);
       eventLogMemo.Lines.Add(logMessage);
       logMessage := logHelper.generateLogMessage('Run','Exception message = '+E.Message);
       eventLogMemo.Lines.Add(logMessage);
      end;
      end;
    end;
  end
  else
  begin
     logMessage := logHelper.generateLogMessage('Run','Service settings missing');
     eventLogMemo.Lines.Add(logMessage);
  end;
 {
  eventLogMemo.Lines.Add('newentrybutton click begin');

   try
    connectresult :=  connectDB;

    if (connectresult = 0)  then
    begin
      newEntity := TnewEntityFrm.Create(nil);
      IniReader := IniReaderHelper.Create;
      newEntity.BusinessApi.URL:= IniReader.Wsdl;
      newEntity.maincategorycombo.Style := csOwnerDrawFixed;
      newEntity.ShowModal;
    end;
   except
     on E : Exception do
     begin
       logMessage := logHelper.generateLogMessage('NewEntity','Exception class name = '+E.ClassName);
       eventLogMemo.Lines.Add(logMessage);
       logMessage := logHelper.generateLogMessage('NewEntity','Exception message = '+E.Message);
       eventLogMemo.Lines.Add(logMessage);
     end;
   end;
   }
end;

procedure TForm1.selectCallbackData;
var
  I                : Integer;
  threadArray      : Array[1..10] of TDBThreadSelect;
begin
  try
    CIDList :=TList<String>.Create;
    entityList :=    TList<Integer>.Create;
    SelectedList :=TList<Integer>.Create;
    CIDList.Clear;
    entityList.Clear;
    Form1.CheckListBox1.Items.Clear;
    dbModule.qrySelect.SQL.Text := 'select * from callback where isextracted=0';
    dbModule.qrySelect.Open;
    dbModule.qrySelect.First;
    while not dbModule.qrySelect.eof do
    begin
          logMessage := logHelper.generateLogMessage('SelectCallback','Select data: :'+dbModule.qrySelect.FieldByName('CID').AsString);
          Form1.eventLogMemo.Lines.Add(logMessage);
          CIDList.Add(dbModule.qrySelect.FieldByName('CID').AsString);
          //threadArray[1] := TDBThreadSelect.Create(dbModule.qrySelect.FieldByName('CID').AsString);
          dbModule.qrySelect.Next;
    end;
    dbModule.qrySelect.Close;

    for I := 0 to CIDList.Count-1 do
      begin
        threadArray[1] := TDBThreadSelect.Create(CIDList[I]);
      end;


  except
  on E : Exception do
     begin
       logMessage := logHelper.generateLogMessage('SelectCallback','Exception class name = '+E.ClassName);
       eventLogMemo.Lines.Add(logMessage);
       logMessage := logHelper.generateLogMessage('SelectCallback','Exception message = '+E.Message);
       eventLogMemo.Lines.Add(logMessage);
     end;
  end;

end;
procedure TForm1.Serviceconnection1Click(Sender: TObject);
var
  settingsForm : Tservicesettings;
begin
  settingsForm := Tservicesettings.Create(nil);
  settingsForm.ShowModal;
end;

procedure TForm1.SettingsMenuClick(Sender: TObject);
var
  settingsForm : TSettingsForm;
begin
  settingsForm := TSettingsForm.Create(nil);
  settingsForm.ShowModal;

end;

procedure TForm1.TelemarketingAddButtonClick(Sender: TObject);
var
    EntityIDInt : Integer ;
    I           : Integer;
    TelemarketingAddresponse : string;
    users : IBusinessAPI1.ArrayOfInt;
    strValue : string;
    entityid : Integer;
begin
  try
    if (SelectedList.Count >0) then
    begin
      SetLength(users,SelectedList.Count);
      for I := 0 to SelectedList.Count-1 do
      begin
         users[I] := SelectedList[I];
         eventLogMemo.Lines.Add(inttostr(SelectedList[I]));
      end;

      entityid:=strtoint(IniReader.ServiceEntityID);
      TelemarketingAddresponse :=   (HTTPRIO1 as IBusinessAPI).Telemarketing_add(
        entityid,
        IniReader.ServiceUsername,
        IniReader.ServicePassword,
        0,
        users
      );
      var responseObj := TJson.JsonToObject<TTelemarketingResponseModel>(TelemarketingAddresponse);
      if (responseObj.ResultCode = 0) then
        begin
          strValue := 'Telemarketing had been created successfully';
          logMessage := logHelper.generateLogMessage('Telemarketing',strValue);
          eventLogMemo.Lines.Add(logMessage);

        end
        else
        begin
          strValue := 'Something went wrong: '+responseObj.ResultMessage;
          logMessage := logHelper.generateLogMessage('Telemarketing',strValue);
          eventLogMemo.Lines.Add(logMessage);

        end;
    end;
  except
    on E : Exception do
      begin
          logMessage := logHelper.generateLogMessage('Telemarketing',E.ClassName+' '+E.Message);
          eventLogMemo.Lines.Add(logMessage);
      end;
    end;
end;

function TForm1.createtable:Integer;
begin
    try
       dbModule.mysqlConnection.ExecSQL('CREATE TABLE `callback` ('
  	    +'`CallBackID` INT(11) NOT NULL AUTO_INCREMENT,'
        +	'`Date` DATETIME NOT NULL,'
	      + '`DID` VARCHAR(20) NOT NULL COLLATE ''latin1_swedish_ci'','
	      +'`CID` VARCHAR(20) NOT NULL COLLATE ''latin1_swedish_ci'','
	      +'`Number` VARCHAR(20) NOT NULL COLLATE ''latin1_swedish_ci'','
	      +'`Confirmed` INT(1) NULL DEFAULT ''0'','
	      +'`Language` TEXT NOT NULL COLLATE ''latin1_swedish_ci'','
	      +'`Prefix` TEXT NOT NULL COLLATE ''latin1_swedish_ci'','
	      +'`isExtracted` INT(1) NULL DEFAULT ''0'','
	      +'PRIMARY KEY (`CallBackID`) USING BTREE) '
        +'COLLATE=''latin1_swedish_ci'''
        +' ENGINE=MyISAM'
        +' AUTO_INCREMENT=16018');
      result :=0;
    except
       on E : Exception do
     begin
       logMessage := logHelper.generateLogMessage('Createtable','Exception class name = '+E.ClassName);
       eventLogMemo.Lines.Add(logMessage);
       logMessage := logHelper.generateLogMessage('Createtable','Exception message = '+E.Message);
       eventLogMemo.Lines.Add(logMessage);
       result := -1;
     end;


    end;
end;

procedure TForm1.CheckListBox1ClickCheck(Sender: TObject);
begin
  if CheckListBox1.Checked[CheckListBox1.ItemIndex] then
  begin
    SelectedList.Add(CheckListBox1.ItemIndex) ;
  end
  else
      SelectedList.Remove(CheckListBox1.ItemIndex)  ;
end;

function TForm1.checktable:Integer;
begin
  try
    dbModule.qryCallback.Open('select * from callback where 0 = 1');
    Result := 0;
  except
    on E: EFDDBEngineException do
      if E.Kind = ekObjNotExists then
      begin
        logMessage := logHelper.generateLogMessage('CallbackTable','Callback table doesn''t exists.');
        eventLogMemo.Lines.Add(logMessage);
        Result := createtable;
        if (Result=0) then
        begin
          logMessage := logHelper.generateLogMessage('CallbackTable','Callback table had been created.');
          eventLogMemo.Lines.Add(logMessage);
        end;
      end
      else
      begin
        logMessage := logHelper.generateLogMessage('CallbackTable','Couldn''t check if callback table exists');
        eventLogMemo.Lines.Add(logMessage);
        Result := -2;
      end;

  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
   dbModule := TDataModule2.Create(nil);
end;


procedure TDBThreadSelect.Execute;
var
    soapClient2 : IBusinessAPI;
    EntityIDInt : Integer ;
    I           : Integer;
    strValue    : string;
    EntityAddresponse : string;
    entityid     : Integer;
    req : string;
    resp: TMemoryStream;
begin
 CoInitialize(nil);
 if (StrtoInt(IniReader.ServiceEntityID)>-1) then
  begin
    try

      entityid := StrtoInt(IniReader.ServiceEntityID);

             {<ol_EntityId xsi:type="xsd:int">1</ol_EntityId>
         <ol_UserName xsi:type="xsd:string">admin</ol_UserName>
         <ol_Password xsi:type="xsd:string">admin</ol_Password>
         <BusinessId xsi:type="xsd:int">1</BusinessId>
         <Employee_EntityId xsi:type="xsd:int">2</Employee_EntityId>
         <CategoryID xsi:type="xsd:int">12</CategoryID>
         <Password xsi:type="xsd:string">admin</Password>
         <Mobile xsi:type="xsd:string">3</Mobile>
         <CountryISO xsi:type="xsd:string">IL</CountryISO>
         <affiliate_entityID xsi:type="xsd:int">0</affiliate_entityID>
      const ol_EntityId: Integer;
      const ol_UserName: string; c
      onst ol_Password: string;
       const BusinessId: Integer;
        const Employee_EntityId: Integer;
         const CategoryID: Integer;
                         const Email: string;
                         const Password: string;
                         const FirstName: string;
                         const LastName: string;
                         const Mobile: string;
                         const CountryISO: string;
                         const affiliate_entityID: Integer }
        EntityAddresponse := (Form1.HTTPRIO1 as  IBusinessAPI).Entity_Add(
            entityid,
            IniReader.ServiceUsername,
            IniReader.ServicePassword,
            strtoint(IniReader.ServiceBusinessID),
            0,
            strtoint(IniReader.ServiceCategoryID),
            '',
            'admin',
            '',
            '',
            FNewStr,
            IniReader.ServiceCountryISO,
            0 ) ;

        var responseObj := TJson.JsonToObject<TResponseModel>(EntityAddresponse);
        if (responseObj.ResultCode = 0) then
        begin
          strValue := 'Entity had been created sucessfully. New Entity ID: '+inttostr(responseObj.EntityId);
          logMessage := logHelper.generateLogMessage('ThreadEntityAdd',strValue);
          Form1.eventLogMemo.Lines.Add(logMessage);
          entityList.Add(responseObj.EntityId);
          Form1.CheckListBox1.Items.Add(FNewStr)
        end
        else
        begin
          strValue := 'Something went wrong: '+responseObj.ResultMessage;
          logMessage := logHelper.generateLogMessage('ThreadEntityAdd',strValue);
          Form1.eventLogMemo.Lines.Add(logMessage);
        end;

      except
         on E : Exception do
        begin
          logMessage := logHelper.generateLogMessage('ThreadEntityAdd11',E.ClassName+' '+E.Message);
          Form1.eventLogMemo.Lines.Add(logMessage);

        end;

      end;
  end
  else
  begin
    logMessage := logHelper.generateLogMessage('ThreadEntityAdd','Entity ID is wrong');
    Form1.eventLogMemo.Lines.Add(logMessage);
  end;

end;

constructor TDBThreadSelect.Create(const ANewStr: String);
begin
  FNewStr := ANewStr;
  inherited Create(False);
end;
end.
