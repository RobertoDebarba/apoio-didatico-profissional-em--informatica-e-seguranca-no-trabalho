program SistemaApoioDidaticoProfissional;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, zcomponent, UPrincipal, Unormas, UArnu, DMprincipal, Ulogin,
  UCadastroAlunos, UCadastroProfessores, UPesquisaAlunos, UPesquisaProfessores,
  UPesquisaProfessores_EditarCursos, UArnuPreview, UUtilidades, UCobasPrewiew,
  UPersonalizar, uTabela, UCobas, USobreProjeto, usobresoftware;

{$R *.res}

begin
  RequireDerivedFormResource := True;
  Application.Initialize;
  Application.CreateForm(TDM1, DM1);
  Application.CreateForm(TfrmLogin, frmLogin);
  Application.Run;
end.

