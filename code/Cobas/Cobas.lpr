program Cobas;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, UCalculo, uTabela, uSobre
  { you can add units after this };

{$R *.res}

begin
  RequireDerivedFormResource := True;
  Application.Initialize;
  Application.CreateForm(TfrmCalculo, frmCalculo);
  Application.CreateForm(TfrmTabela, frmTabela);
  Application.CreateForm(TfrmSobre, frmSobre);
  Application.Run;
end.

