unit NewEntityForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,IBusinessAPI1,
  System.Net.URLClient, System.Net.HttpClient, Soap.SOAPHTTPTrans, Data.DB,
  Datasnap.DBClient, Soap.SOAPConn, Soap.InvokeRegistry, Soap.Rio,
  Soap.SOAPHTTPClient,ResponseModel,Rest.Json,System.Generics.Collections,IniReaderClass,DBConnectResult,DatabaseClass;

type
  TnewEntityFrm = class(TForm)
    CreateEntityButton: TButton;
    Label1: TLabel;
    BusinessIDEdit: TEdit;
    UserNameEdit: TEdit;
    UserNameLbl: TLabel;
    PasswordOlEdit: TEdit;
    Label3: TLabel;
    Label4: TLabel;
    EmailEdit: TEdit;
    PasswordEdit: TEdit;
    Label5: TLabel;
    Label6: TLabel;
    FirstNameEdit: TEdit;
    LastNameEdit: TEdit;
    Label7: TLabel;
    Label8: TLabel;
    MobileEdit: TEdit;
    CountryISOEdit: TEdit;
    Label9: TLabel;
    BusinessApi: THTTPRIO;
    EntityNamesCombo: TComboBox;
    Label2: TLabel;
    memolog: TMemo;
    Label10: TLabel;
    maincategorycombo: TComboBox;
    subcategorycombo: TComboBox;
    Label11: TLabel;
    procedure CreateEntityButtonClick(Sender: TObject);
    procedure maincategorycomboChange(Sender: TObject);
    constructor newEntityConstructor(mainform: TForm);
  public
    class var
      List : TList<Integer>;
      MainCategoryList : TList<Integer>;
      SubCategoryList : TList<Integer>;
      mainFormProp : TForm;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  newEntityFrm: TnewEntityFrm;
  dbconnectmodel: TDbConnectResult;
  dbModule    : TDataModule2;

implementation

{$R *.dfm}

constructor TnewEntityFrm.newEntityConstructor(mainform: TForm);
begin
  inherited Create(nil);
  mainFormProp :=  mainform;
end;

procedure TnewEntityFrm.CreateEntityButtonClick(Sender: TObject);
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
  if (subcategorycombo.ItemIndex>-1) then
  begin
    try
      memolog.Lines.Clear;
      entityid := List[EntityNamesCombo.ItemIndex];
      dbModule := TDataModule2.Create(nil);
      IniReader := IniReaderHelper.Create;
      dbconnectmodel :=dbModule.connectDB(IniReader.Server,IniReader.Port,IniReader.Database,IniReader.User_Name,IniReader.Password);

      dbModule.mysqlConnection.ExecSQL('update system_parameters set parmvalue='+inttostr(SubCategoryList[subcategorycombo.ItemIndex])+' where parmname=''entity_default_categoryID''');
        EntityAddresponse :=   (BusinessApi as IBusinessAPI).Entity_Add(
            entityid,
            UserNameEdit.Text,
            PasswordOlEdit.Text,
            strtoint(BusinessIDEdit.Text),
            0,
            SubCategoryList[subcategorycombo.ItemIndex],
            EmailEdit.Text,
            PasswordEdit.Text,
            FirstNameEdit.Text,
            LastNameEdit.Text,
            MobileEdit.Text,
            CountryISOEdit.Text,
            0 ) ;
      dbModule.mysqlConnection.ExecSQL('update system_parameters set parmvalue=0 where parmname=''entity_default_categoryID''');
        var responseObj := TJson.JsonToObject<TResponseModel>(EntityAddresponse);
        if (responseObj.ResultCode = 0) then
        begin
          strValue := 'Entity had been created sucessfully. New Entity ID: '+inttostr(responseObj.EntityId);
          memolog.Lines.add(strValue);
          memolog.Visible :=true;
        end
        else
        begin
          strValue := 'Something went wrong: '+responseObj.ResultMessage;
          memolog.Lines.add(strValue);
          memolog.Visible :=true;
        end;
      except
         on E : Exception do
        begin

          memolog.Lines.add(E.ClassName+' '+E.Message);
          memolog.Visible :=true;
        end;
      end;
  end
  else
  begin
     memolog.Lines.Add('Category is not selected');
      memolog.Visible :=true;
  end;

 {
 soapClient := THTTPReqResp.Create(nil);
 resp := TMemoryStream.Create;



    SoapClient.URL := 'http://127.0.0.1:33322/wsdl/IBusinessAPI';


    req:='<soapenv:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:urn="urn:BusinessApiIntf-IBusinessAPI">'
   +'<soapenv:Header/>'
   +'<soapenv:Body>'
      +'<urn:Entity_Add soapenv:encodingStyle="http://schemas.xmlsoap.org/soap/encoding/">'
         +'<ol_EntityId xsi:type="xsd:int">1</ol_EntityId>'
         +'<ol_UserName xsi:type="xsd:string">admin</ol_UserName>'
         +'<ol_Password xsi:type="xsd:string">admin</ol_Password>'
         +'<BusinessId xsi:type="xsd:int">1</BusinessId>'
         +'<Employee_EntityId xsi:type="xsd:int">0</Employee_EntityId>'
         +'<CategoryID xsi:type="xsd:int">0</CategoryID>'
         +'<Email xsi:type="xsd:string">p@gmail.com</Email>'
         +'<Password xsi:type="xsd:string">admin</Password>'
         +'<FirstName xsi:type="xsd:string">kk</FirstName>'
         +'<LastName xsi:type="xsd:string">jjk</LastName>'
         +'<Mobile xsi:type="xsd:string">+9945565</Mobile>'
         +'<CountryISO xsi:type="xsd:string">IL</CountryISO>'
         +'<affiliate_entityID xsi:type="xsd:int">0</affiliate_entityID>'
      +'</urn:Entity_Add>'
   +'</soapenv:Body> '
+'</soapenv:Envelope>';
    SoapClient.Execute(req,resp);
    SetString(EntityAddresponse, PChar(resp.memory), resp.Size);

       var responseObj := TJson.JsonToObject<TResponseModel>(EntityAddresponse);
    }




end;

procedure TnewEntityFrm.maincategorycomboChange(Sender: TObject);
var
  newEntity     : TnewEntityFrm;
  categoryname  : string;
  categoryid    : integer;
begin
  try
    dbModule := TDataModule2.Create(nil);
    IniReader := IniReaderHelper.Create;
    dbconnectmodel :=dbModule.connectDB(IniReader.Server,IniReader.Port,IniReader.Database,IniReader.User_Name,IniReader.Password);

    subcategorycombo.Items.Clear;
    SubCategoryList :=TList<Integer>.Create;
    SubCategoryList.Clear;
    dbModule.qryCallback.SQL.Text := 'SELECT CONVERT(name USING utf8) categoryname,categoryid FROM categories where parentid='+inttostr(MainCategoryList[maincategorycombo.ItemIndex]);
    dbModule.qryCallback.Open;
    dbModule.qryCallback.First;
    while not dbModule.qryCallback.eof do
    begin
      categoryname := dbModule.qryCallback.FieldByName('categoryname').AsString;
      subcategorycombo.Items.Add(categoryname);
      categoryid := dbModule.qryCallback.FieldByName('categoryid').AsInteger;
      SubCategoryList.Add(categoryid) ;
      dbModule.qryCallback.Next;
    end;
  except
    on E : Exception do
      begin
        ShowMessage(E.ClassName+' '+E.Message);
      end;
  end;

end;

end.
