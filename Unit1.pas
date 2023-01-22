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
  Vcl.Menus,Settings;

type
  TForm1 = class(TForm)
    createCustomersBtn: TButton;
    Label1: TLabel;
    Label2: TLabel;
    eventLogMemo: TMemo;
    mysqlConnection: TFDConnection;
    FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink;
    qryCallback: TFDQuery;
    QryDataSendRequestBtn: TButton;
    newentrybtn: TButton;
    TelemarketingAddButton: TButton;
    MainMenu1: TMainMenu;
    SettingsMenu: TMenuItem;
    procedure createCustomersBtnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    function  connectDB: Integer;
    function  checktable: Integer;
    function  createtable:Integer;
    procedure insertCallback;
    procedure createCustomerThreads(newCustomerCount : Integer);
    procedure selectCallbackData;
    procedure QryDataSendRequestBtnClick(Sender: TObject);
    procedure newentrybtnClick(Sender: TObject);
    procedure getUsernameList(newentityform:TnewEntityFrm);
    procedure TelemarketingAddButtonClick(Sender: TObject);
    procedure getTelemarketingUsernameList(newTelemarketingform:TTelemarketingForm);
    procedure SettingsMenuClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  TDBThreadInsert = class(TThread)
  protected
    procedure Execute; override;
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


implementation

{$R *.dfm}
procedure TForm1.newentrybtnClick(Sender: TObject);
var
  connectresult : Integer;
  newEntity     : TnewEntityFrm;
  soapClient    : IBusinessAPI;
begin
   eventLogMemo.Lines.Add('newentrybutton click begin');

   try
    connectresult :=  connectDB;

    if (connectresult = 0)  then
    begin
      newEntity := TnewEntityFrm.Create(nil);
      getUsernameList(newentity);
      IniReader := IniReaderHelper.Create;
      newEntity.BusinessApi.WSDLLocation:= IniReader.Wsdl;
      newEntity.BusinessApi.Port := 'IBusinessAPIPort';
      newEntity.BusinessApi.Service := 'IBusinessAPIservice';
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

end;

function TForm1.connectDB:Integer;
var
   errorMessage     : string;
begin
  result := 0;
   try
     IniReader := IniReaderHelper.Create;
     logMessage := logHelper.generateLogMessage('DatabaseConnection','Setting up connection');
     eventLogMemo.Lines.Add(logMessage);
     logMessage := logHelper.generateLogMessage('DatabaseConnection','Connecting to Server:'+IniReader.Server+' ; Database: '+IniReader.Database);
     eventLogMemo.Lines.Add(logMessage);
     mysqlConnection.Close;
     mysqlConnection.Params.Clear;
     mysqlConnection.Params.Add('DriverID='+IniReader.DriverId);
     mysqlConnection.Params.Add('Server='+IniReader.Server);
     mysqlConnection.Params.Add('Port='+IniReader.Port);
     mysqlConnection.Params.Add('Database='+IniReader.Database);
     mysqlConnection.Params.Add('User_Name='+IniReader.User_Name);
     mysqlConnection.Params.Add('Password='+IniReader.Password);
     mysqlConnection.Open;
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

procedure TForm1.insertCallback;
begin
  if not mysqlConnection.Connected then
  begin
     logMessage := logHelper.generateLogMessage('DatabseConnection','Couldn''t connect to database, try again');
     eventLogMemo.Lines.Add(logMessage);
     Exit;
  end;

  mysqlConnection.ExecSQL('insert into callback(Date,DID,CID, Number,Language,  Prefix) ' +
                 'values(:1,:2,:3,:4,:5,:6)', [Now,'ttt','kk','99','En','pref']);


  qryCallback.refresh;

end;
procedure TForm1.QryDataSendRequestBtnClick(Sender: TObject);
var
   connectresult    : Integer;
   tableexists      : Integer;
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
       logMessage := logHelper.generateLogMessage('SelecttCallback','Exception class name = '+E.ClassName);
       eventLogMemo.Lines.Add(logMessage);
       logMessage := logHelper.generateLogMessage('SelectCallback','Exception message = '+E.Message);
       eventLogMemo.Lines.Add(logMessage);
     end;
    end;

  end;
end;

procedure TForm1.createCustomerThreads(newCustomerCount : Integer);
var
  I                : Integer;
  threadArray      : Array[1..10] of TDBThreadInsert;
begin
  for I := 1 to newCustomerCount do
  begin
    logMessage := logHelper.generateLogMessage('ThreadInsert','Thread create '+Inttostr(I));
    eventLogMemo.Lines.Add(logMessage);

    threadArray[I] := TDBThreadInsert.Create(False);
  end;

  for I := 1 to newCustomerCount do
  begin
    threadArray[I].WaitFor;
    threadArray[I].Free
  end;
end;

procedure TForm1.getUsernameList(newentityform:TnewEntityFrm);
var
  entityname : string;
  entityid   : integer;
begin
    try
      newentityform.EntityNamesCombo.Items.Clear;
      newentityform.List :=TList<Integer>.Create;
      newentityform.List.Clear;
      mysqlConnection.ExecSQL('update system_parameters set parmvalue=1 where parmname=''entity_default_categoryID''');

      qryCallback.SQL.Text := 'SELECT ol_username,entityid FROM entities';
      qryCallback.Open;
      qryCallback.First;
      while not qryCallback.eof do
      begin
        entityname := qryCallback.FieldByName('ol_username').AsString;
        if (entityname='') then
          begin
            entityname := 'Default';
          end;
        newentityform.EntityNamesCombo.Items.Add(entityname);
        entityid := qryCallback.FieldByName('entityid').AsInteger;
        newentityform.List.Add(entityid) ;
        qryCallback.Next;
      end;

    except
      on E : Exception do
     begin
       logMessage := logHelper.generateLogMessage('GetUsernameList','Exception class name = '+E.ClassName);
       eventLogMemo.Lines.Add(logMessage);
       logMessage := logHelper.generateLogMessage('GetUsernameList','Exception message = '+E.Message);
       eventLogMemo.Lines.Add(logMessage);
     end;
    end;
end;

procedure TForm1.getTelemarketingUsernameList(newTelemarketingform:TTelemarketingForm);
var
  entityname : string;
begin
    newTelemarketingform.TelemarketingUserList.Items.Clear;
    newTelemarketingform.List :=TList<Integer>.Create;
    newTelemarketingform.EntityList :=TList<Integer>.Create;
    newTelemarketingform.SelectedList :=TList<Integer>.Create;
    newTelemarketingform.List.Clear;
    qryCallback.SQL.Text :='SELECT ol_username,entityid FROM entities';
    qryCallback.Open;
    qryCallback.First;

    while not qryCallback.eof do
    begin
      entityname := qryCallback.FieldByName('ol_username').AsString;
      if entityname='' then
        entityname:='Default';
      newTelemarketingform.TelemarketingUserList.Items.Add(entityname);

      newTelemarketingform.List.Add(qryCallback.FieldByName('entityid').AsInteger) ;
      qryCallback.Next;
    end;
    qryCallback.Close;


    qryCallback.SQL.Text :=  'select e.entityid, e.ol_username ' +
                            'from entities e ' +
                            'left join employees emp on (emp.Status<>0 or (DATE_ADD(emp.sync_modified_date, INTERVAL 24 HOUR)<utc_timestamp())) and emp.EntityId=e.EntityId ';
    qryCallback.Open;
    qryCallback.First;
    while not qryCallback.eof do
    begin
      entityname := qryCallback.FieldByName('ol_username').AsString;
      if entityname='' then
        entityname:='Default1';
      newTelemarketingform.EntityNamesCombo.Items.Add(entityname);
      newTelemarketingform.EntityList.Add(qryCallback.FieldByName('entityid').AsInteger) ;
      qryCallback.Next;
    end;
    qryCallback.Close;
end;
procedure TForm1.selectCallbackData;
var
  I                : Integer;
  threadArray      : Array[1..10] of TDBThreadSelect;
begin
  try
    Form1.qryCallback.SQL.Text := 'select * from callback where isextracted=0';
    Form1.qryCallback.Open;
    Form1.qryCallback.First;
    while not Form1.qryCallback.eof do
    begin
          logMessage := logHelper.generateLogMessage('SelectCallback','Select data: :'+Form1.qryCallback.FieldByName('DID').AsString);
          Form1.eventLogMemo.Lines.Add(logMessage);
          threadArray[1] := TDBThreadSelect.Create(Form1.qryCallback.FieldByName('DID').AsString);
          Form1.qryCallback.Next;
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
procedure TForm1.SettingsMenuClick(Sender: TObject);
var
  settingsForm : TSettingsForm;
begin
  settingsForm := TSettingsForm.Create(nil);
  settingsForm.ShowModal;

end;

procedure TForm1.TelemarketingAddButtonClick(Sender: TObject);
var
  newTelemarketing  : TTelemarketingForm;
  I : integer;
  connectresult : Integer;
begin
    try
    connectresult :=  connectDB;
    if (connectresult = 0)  then
    begin
      IniReader := IniReaderHelper.Create;
      newTelemarketing := TTelemarketingForm.Create(nil);
      newTelemarketing.TelemarketingUserList.Items.Clear;
      getTelemarketingUsernameList(newTelemarketing);

      newTelemarketing.BusinessApi.WSDLLocation:= IniReader.Wsdl;
      newTelemarketing.BusinessApi.Port := 'IBusinessAPIPort';
      newTelemarketing.BusinessApi.Service := 'IBusinessAPIservice';
      newTelemarketing.ShowModal;
    end;
   except
     on E : Exception do
     begin
       logMessage := logHelper.generateLogMessage('NewTelemarketing','Exception class name = '+E.ClassName);
       eventLogMemo.Lines.Add(logMessage);
       logMessage := logHelper.generateLogMessage('NewTelemarketing','Exception message = '+E.Message);
       eventLogMemo.Lines.Add(logMessage);
     end;
   end;

end;

function TForm1.createtable:Integer;
begin
    try
       mysqlConnection.ExecSQL('CREATE TABLE `callback` ('
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

function TForm1.checktable:Integer;
begin
  try
    qryCallback.Open('select * from callback where 0 = 1');
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
  {


    qryCallback.SQL.Text := 'SELECT ol_username,entityid FROM mekashronbusiness.entities';
    qryCallback.Open;
    qryCallback.First;
    newentityform.List :=TList<Integer>.Create;
    while not qryCallback.eof do
    begin
      newentityform.EntityNamesCombo.Items.Add(
      qryCallback.FieldByName('ol_username').AsString);
      newentityform.List.Add(qryCallback.FieldByName('entityid').AsInteger) ;
      qryCallback.Next;
    end;
    }
end;

procedure TForm1.createCustomersBtnClick(Sender: TObject);
var
   logHelper        : MekashronLogHelper;
   errorMessage     : string;
   newCustomerCount : Integer;
   callBackData     : Variant;
   connectresult    : Integer;
   tableexists      : Integer;
begin
  connectresult :=  connectDB;

  if (connectresult = 0) then
  begin
    tableexists := checktable;
  end;

  if (connectresult = 0) and (tableexists=0) then
  begin
    try
      qryCallback.Open;
      newCustomerCount := RandomRange(4,10);
      logMessage := logHelper.generateLogMessage('btnClick','Random number of customers:'+IntToStr(newCustomerCount));
      eventLogMemo.Lines.Add(logMessage);
      createCustomerThreads(newCustomerCount);
      mysqlConnection.Close;
    except
      on E : Exception do
     begin
       logMessage := logHelper.generateLogMessage('CallbackInsert','Exception class name = '+E.ClassName);
       eventLogMemo.Lines.Add(logMessage);
       logMessage := logHelper.generateLogMessage('CallbackInsert','Exception message = '+E.Message);
       eventLogMemo.Lines.Add(logMessage);
     end;
    end;
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  IniReader := IniReaderHelper.Create;
  FDPhysMySQLDriverLink1.VendorLib :=IniReader.VendorLib;
  eventLogMemo.Lines.Clear();
end;

procedure TDBThreadInsert.Execute;
begin
  Form1.insertCallback;
  logMessage := logHelper.generateLogMessage('ThreadInsert','New Customer Inserted');
  Form1.eventLogMemo.Lines.Add(logMessage);
end;

procedure TDBThreadSelect.Execute;
begin
  logMessage := logHelper.generateLogMessage('ThreadSelect','New Customer Selected '+FNewStr);
  Form1.eventLogMemo.Lines.Add(logMessage);
end;

constructor TDBThreadSelect.Create(const ANewStr: String);
begin
  FNewStr := ANewStr;
  inherited Create(False);
end;
end.
