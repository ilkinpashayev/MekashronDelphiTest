unit TDBThreadClass;

interface

uses System.Classes,FormUpdateClass;

type
  TDBThread = class(TThread)
  protected
    procedure Execute; override;
  end;



implementation

procedure TDBThread.Execute;

begin

end;

end.

