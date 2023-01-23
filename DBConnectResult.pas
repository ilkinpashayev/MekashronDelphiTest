unit DBConnectResult;

interface
type
  TDbConnectResult = class(TObject)
  private
     FisConnected          : Integer;
     FExceptionClass       : string;
     FExceptonMessage      : string;
  public
    property  isConnected :Integer read FisConnected write FisConnected;
    property  ExceptionClass :string read FExceptionClass write FExceptionClass;
    property  ExceptonMessage :string read FExceptonMessage write FExceptonMessage;
  end;
implementation

end.
