unit NewEntityForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,IBusinessAPI1,
  System.Net.URLClient, System.Net.HttpClient, Soap.SOAPHTTPTrans, Data.DB,
  Datasnap.DBClient, Soap.SOAPConn, Soap.InvokeRegistry, Soap.Rio,
  Soap.SOAPHTTPClient,ResponseModel,Rest.Json,System.Generics.Collections;

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
    procedure CreateEntityButtonClick(Sender: TObject);
  public
    class var
      List : TList<Integer>;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  newEntityFrm: TnewEntityFrm;

implementation

{$R *.dfm}

procedure TnewEntityFrm.CreateEntityButtonClick(Sender: TObject);
var
    soapClient2 : IBusinessAPI;
    EntityIDInt : Integer ;
    I           : Integer;
    strValue    : string;
    EntityAddresponse : string;
    entityid     : Integer;
begin


      try
        memolog.Lines.Clear;
           entityid := List[EntityNamesCombo.ItemIndex];
        EntityAddresponse :=   (BusinessApi as IBusinessAPI).Entity_Add(
            entityid,
            UserNameEdit.Text,
            PasswordOlEdit.Text,
            strtoint(BusinessIDEdit.Text),
            0,
            0,
            EmailEdit.Text,
            PasswordEdit.Text,
            FirstNameEdit.Text,
            LastNameEdit.Text,
            MobileEdit.Text,
            CountryISOEdit.Text,
            0 ) ;
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
end;

end.
