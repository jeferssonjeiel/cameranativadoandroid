program prjCamera;

uses
  System.StartUpCopy,
  FMX.Forms,
  untApp in 'untApp.pas' {frmApplication};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmApplication, frmApplication);
  Application.Run;
end.
