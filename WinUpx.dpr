program WinUpx;

uses
  Forms, Interfaces,
  MainFrm in 'MainFrm.pas' {MainForm},
  Lan in 'Lan.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'Upx Shell For Windows';
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.

