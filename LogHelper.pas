unit LogHelper;

interface

uses Classes;

type
  MekashronLogHelper = class
  public
    function generateLogMessage(logType:string; logMessage:string): string;

  end;

implementation

uses DateUtils,SysUtils;
function MekashronLogHelper.generateLogMessage(logType:string; logMessage:string):String;
var
  today :TDateTime;
begin
  today :=Now;
  result :=DateToStr(today)+' '+TimeToStr(today)+' : '+logType+' || '+logMessage;
end;

end.
