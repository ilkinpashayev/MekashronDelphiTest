unit Telemarketing;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.CheckLst,System.Generics.Collections,
  Soap.InvokeRegistry, System.Net.URLClient, Soap.Rio, Soap.SOAPHTTPClient,IBusinessAPI1
  ,Rest.Json,TelemarketingResponseModel;

type
  TTelemarketingForm = class(TForm)
    CreateTelemarketingButton: TButton;
    Label2: TLabel;
    EntityNamesCombo: TComboBox;
    UserNameLbl: TLabel;
    UserNameEdit: TEdit;
    Label3: TLabel;
    PasswordOlEdit: TEdit;
    TelemarketingUserList: TCheckListBox;
    BusinessApi: THTTPRIO;
    responselabel: TLabel;
    memolog: TMemo;
    procedure TelemarketingUserListClickCheck(Sender: TObject);
    procedure CreateTelemarketingButtonClick(Sender: TObject);
  public
    class var
      List : TList<Integer>;
      EntityList : TList<Integer>;
      SelectedList : TList<Integer>;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  TelemarketingForm: TTelemarketingForm;


implementation

{$R *.dfm}

procedure TTelemarketingForm.CreateTelemarketingButtonClick(Sender: TObject);
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
         users[I] := SelectedList[I];

      entityid:=List[EntityNamesCombo.ItemIndex];
      TelemarketingAddresponse :=   (BusinessApi as IBusinessAPI).Telemarketing_add(
        entityid,
        UserNameEdit.Text,
        PasswordOlEdit.Text,
        0,
        users
      );
      var responseObj := TJson.JsonToObject<TTelemarketingResponseModel>(TelemarketingAddresponse);
      if (responseObj.ResultCode = 0) then
        begin
          strValue := 'Telemarketing had been created successfully';
          responseLabel.Caption :=strValue;
          responseLabel.Visible :=true;
        end
        else
        begin
          strValue := 'Something went wrong: '+responseObj.ResultMessage;
          responseLabel.Caption :=strValue;
          responseLabel.Visible :=true;
        end;
    end;
  except
    on E : Exception do
      begin
        memolog.Lines.add(E.ClassName+' '+E.Message);
        memolog.Visible :=true;
      end;
    end;

end;

procedure TTelemarketingForm.TelemarketingUserListClickCheck(Sender: TObject);
begin
  if TelemarketingUserList.Checked[TelemarketingUserList.ItemIndex] then
  begin
    SelectedList.Add(TelemarketingUserList.ItemIndex) ;
  end
  else
      SelectedList.Remove(TelemarketingUserList.ItemIndex)  ;
end;

end.
