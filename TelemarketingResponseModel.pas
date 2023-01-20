unit TelemarketingResponseModel;

interface
type
  TTelemarketingResponseModel = class(TObject)
  private
     FResultCode          : Integer;
     FResultMessage       : string;
     FExecuteTime         : Integer;
  public
    property  ResultCode :Integer read FResultCode write FResultCode;
    property  ResultMessage :string read FResultMessage write FResultMessage;
    property  ExecuteTime :Integer read FExecuteTime write FExecuteTime;
  end;


implementation

end.
