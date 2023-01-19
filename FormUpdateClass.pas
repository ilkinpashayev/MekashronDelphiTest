unit FormUpdateClass;

interface

uses Classes,VCL.Forms;
type
  FormUpdateHelper = class
  public
    procedure insertLog(form : TForm);
  end;

implementation

procedure FormUpdateHelper.insertLog(form:TForm);

begin
  form.FindComponent('eventLogMemo')
end;
end.




