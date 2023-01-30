program MekashronCRM;

uses
  Vcl.Forms,
  Unit1 in 'Unit1.pas' {Form1},
  LogHelper in 'LogHelper.pas',
  IniReaderClass in 'IniReaderClass.pas',
  NewEntityForm in 'NewEntityForm.pas' {newEntityFrm},
  ResponseModel in 'ResponseModel.pas',
  Telemarketing in 'Telemarketing.pas' {TelemarketingForm},
  TelemarketingResponseModel in 'TelemarketingResponseModel.pas',
  Settings in 'Settings.pas' {SettingsForm},
  IWSDLPublish1 in 'IWSDLPublish1.pas',
  IBusinessAPI1 in 'IBusinessAPI1.pas',
  DatabaseClass in 'DatabaseClass.pas' {DataModule2: TDataModule},
  DBConnectResult in 'DBConnectResult.pas',
  Unit2 in 'Unit2.pas' {servicesettings};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TnewEntityFrm, newEntityFrm);
  Application.CreateForm(TTelemarketingForm, TelemarketingForm);
  Application.CreateForm(TSettingsForm, SettingsForm);
  Application.CreateForm(TDataModule2, DataModule2);
  Application.CreateForm(Tservicesettings, servicesettings);
  Application.Run;
end.
