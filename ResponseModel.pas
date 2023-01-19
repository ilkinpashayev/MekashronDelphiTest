unit ResponseModel;

interface
type
  TResponseModel = class(TObject)
  private
     FResultCode          : Integer;
     FResultMessage       : string;
     FEntityId            : Integer;
     FAffiliateResultCode : Integer;
     FExecuteTime         : Integer;
  public
    property  ResultCode :Integer read FResultCode write FResultCode;
    property  ResultMessage :string read FResultMessage write FResultMessage;
    property  EntityId :Integer read FEntityId write FEntityId;
    property  AffiliateResultCode :Integer read FAffiliateResultCode write FAffiliateResultCode;
    property  ExecuteTime :Integer read FExecuteTime write FExecuteTime;

  end;
implementation

//EntityAddresponse #$A'  {"ResultCode":-5674,"ResultMessage":"Customer exists","EntityId":8,"AffiliateResultCode":0,"ExecuteTime":14}'
end.
