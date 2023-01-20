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
  Datasnap.DBClient, NewEntityForm,IBusinessAPI1,System.Generics.Collections,Telemarketing;

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
    procedure createCustomersBtnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure connectDB;
    procedure insertCallback;
    procedure createCustomerThreads(newCustomerCount : Integer);
    procedure selectCallbackData;
    procedure QryDataSendRequestBtnClick(Sender: TObject);
    procedure newentrybtnClick(Sender: TObject);
    procedure getUsernameList(newentityform:TnewEntityFrm);
    procedure TelemarketingAddButtonClick(Sender: TObject);
    procedure getTelemarketingUsernameList(newTelemarketingform:TTelemarketingForm);
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
  newEntity  : TnewEntityFrm;
  soapClient : IBusinessAPI;
begin
   if (mysqlConnection.State <>csConnected) then
    begin
      connectDB;
    end;

  newEntity := TnewEntityFrm.Create(nil);
  getUsernameList(newEntity);
  newEntity.ShowModal;

end;

procedure TForm1.connectDB;
var
   errorMessage     : string;
begin
  IniReader := IniReaderHelper.Create;
  logMessage := logHelper.generateLogMessage('DatabaseConnection','Setting up connection');
  eventLogMemo.Lines.Add(logMessage);
  createCustomersBtn.Enabled:=false;
  logMessage := logHelper.generateLogMessage('DatabaseConnection','Connecting to Server:'+IniReader.Server+' ; Database: '+IniReader.Database);
  eventLogMemo.Lines.Add(logMessage);

   try
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
    errorMessage :='Error';

   end;

  if (mysqlConnection.State <> csConnected) then
  begin
     createCustomersBtn.Enabled:=true;
     logMessage := logHelper.generateLogMessage('DatabseConnection','Couldn''t connect to database, try again');
     eventLogMemo.Lines.Add(logMessage);
     Exit;
  end
  else
  begin
     createCustomersBtn.Enabled:=false;
     logMessage := logHelper.generateLogMessage('DatabseConnection','Connected successfully');
     eventLogMemo.Lines.Add(logMessage);
     qryCallback.Open;
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
begin
  if (mysqlConnection.State <> csConnected) then
  begin
    connectDB;
  end;
  selectCallbackData;
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
begin
    newentityform.EntityNamesCombo.Items.Clear;
    newentityform.List.Clear;
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
end;
procedure TForm1.getTelemarketingUsernameList(newTelemarketingform:TTelemarketingForm);
begin
    newTelemarketingform.TelemarketingUserList.Items.Clear;
    newTelemarketingform.List :=TList<Integer>.Create;
    newTelemarketingform.EntityList :=TList<Integer>.Create;
    newTelemarketingform.SelectedList :=TList<Integer>.Create;
    newTelemarketingform.List.Clear;
    qryCallback.SQL.Text := 'select e.entityid, e.ol_username ' +
                            'from entities e ' +
                            'left join employees emp on (emp.Status<>0 or (DATE_ADD(emp.sync_modified_date, INTERVAL 24 HOUR)<utc_timestamp())) and emp.EntityId=e.EntityId ';
    qryCallback.Open;
    qryCallback.First;

    while not qryCallback.eof do
    begin
      newTelemarketingform.TelemarketingUserList.Items.Add(qryCallback.FieldByName('ol_username').AsString);

      newTelemarketingform.List.Add(qryCallback.FieldByName('entityid').AsInteger) ;
      qryCallback.Next;
    end;
    qryCallback.Close;


    qryCallback.SQL.Text := 'SELECT ol_username,entityid FROM mekashronbusiness.entities';
    qryCallback.Open;
    qryCallback.First;
    while not qryCallback.eof do
    begin
      newTelemarketingform.EntityNamesCombo.Items.Add(
      qryCallback.FieldByName('ol_username').AsString);
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
    Form1.qryCallback.SQL.Text := 'select * from callback where isextracted=0';
    Form1.qryCallback.Open;
    Form1.qryCallback.First;
    while not Form1.qryCallback.eof do
    begin
          logMessage := logHelper.generateLogMessage('btnqryDataSendRequest','Select data: :'+Form1.qryCallback.FieldByName('DID').AsString);
          Form1.eventLogMemo.Lines.Add(logMessage);
          threadArray[1] := TDBThreadSelect.Create(Form1.qryCallback.FieldByName('DID').AsString);

      Form1.qryCallback.Next;
    end;
end;
procedure TForm1.TelemarketingAddButtonClick(Sender: TObject);
var
  newTelemarketing  : TTelemarketingForm;
  I : integer;
begin
   if (mysqlConnection.State <>csConnected) then
    begin
      connectDB;
    end;
  newTelemarketing := TTelemarketingForm.Create(nil);
  newTelemarketing.TelemarketingUserList.Items.Clear;
  getTelemarketingUsernameList(newTelemarketing);
  newTelemarketing.ShowModal;
end;

procedure TForm1.createCustomersBtnClick(Sender: TObject);
var
   logHelper        : MekashronLogHelper;
   errorMessage     : string;
   newCustomerCount : Integer;
   callBackData     : Variant;
begin
  connectDB;
  if (mysqlConnection.State=csConnected) then
  begin
    newCustomerCount := RandomRange(4,10);
    logMessage := logHelper.generateLogMessage('btnClick','Random number of customers:'+IntToStr(newCustomerCount));
    eventLogMemo.Lines.Add(logMessage);
    createCustomerThreads(newCustomerCount);
    mysqlConnection.Close;
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
