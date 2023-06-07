unit DMprincipal;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, sqldb, db, FileUtil, ZConnection, ZDataset, Forms;

type

  { TDM1 }

  TDM1 = class(TDataModule)
    queryCodigoCadastroMAIOR: TLongintField;
    queryPesquisaCursosProfessores: TZQuery;
    queryPesquisaCursosProfessoresCursos: TLongintField;
    queryPesquisaAlunoscodigo_aluno: TAutoIncField;
    queryPesquisaAlunoscodigo_curso: TLongintField;
    queryPesquisaAlunoscodigo_usuario: TLongintField;
    queryPesquisaAlunoscpf_aluno: TStringField;
    queryPesquisaAlunosnome_aluno: TStringField;
    queryPesquisaUsuarioscodigo_tipo_usuario: TLongintField;
    queryPesquisaUsuarioscodigo_usuario: TAutoIncField;
    queryPesquisaUsuarioslogin_usuario: TStringField;
    queryPesquisaUsuariossenha_usuario: TStringField;
    tbProfessorescodigo_professor: TAutoIncField;
    tbProfessorescodigo_usuario: TLongintField;
    tbProfessorescpf_professor: TStringField;
    tbProfessoresnome_professor: TStringField;
    tbAlunoscodigo_aluno: TAutoIncField;
    tbAlunoscodigo_curso: TLongintField;
    tbAlunoscodigo_usuario: TLongintField;
    tbAlunoscpf_aluno: TStringField;
    tbAlunosnome_aluno: TStringField;
    tbTipo_Usuarioscodigo_tipo_usuario: TAutoIncField;
    tbTipo_Usuariosdescricao_usuario: TStringField;
    tbUsuarioscodigo_tipo_usuario: TLongintField;
    tbUsuarioscodigo_usuario: TAutoIncField;
    tbUsuarioslogin_usuario: TStringField;
    tbUsuariossenha_usuario: TStringField;
    ZConnection1: TZConnection;
    tbUsuarios: TZTable;
    tbAlunos: TZTable;
    tbCursos: TZTable;
    tbTipo_Usuarios: TZTable;
    tbProfessores: TZTable;
    DM1: TZQuery;
    tbUsuariosProfessores: TZQuery;
    tbUsuariosAlunos: TZQuery;
    procedure queryPesquisaCursosProfessoresCursosGetText(Sender: TField;
      var aText: string);
    procedure tbAlunoscodigo_cursoGetText(Sender: TField; var aText: string;
      DisplayText: Boolean);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  DM1: TDM1;

implementation

uses
  UPesquisaProfessores_EditarCursos;

{$R *.lfm}

{ TDM1 }

procedure TDM1.queryPesquisaCursosProfessoresCursosGetText(Sender: TField;
  var aText: string);
begin
  if (frmPesquisaProfessores_EditarCursos = nil) then
    Application.CreateForm(TfrmPesquisaProfessores_EditarCursos, frmPesquisaProfessores_EditarCursos);

  if Sender.Value = 1 then                         // Converte codigo em descrição
  begin                                            // Marca variaveis que são validas
    aText := 'Administração';
    frmPesquisaProfessores_EditarCursos.vAdministracao := true;
  end;
  if Sender.Value = 2 then
  begin
    aText := 'Eletrônica';
    frmPesquisaProfessores_EditarCursos.vEletronica := true;
  end;
  if Sender.Value = 3 then
  begin
    aText := 'Informática';
    frmPesquisaProfessores_EditarCursos.vInformatica := true;
  end;
  if Sender.Value = 4 then
  begin
    aText := 'Segurança no Trabalho';
    frmPesquisaProfessores_EditarCursos.vSeguranca := true;
  end;

  with frmPesquisaProfessores_EditarCursos do      // Marca os campos comforme variaveis
  begin                                            // utiliza variaveis para comparação quando o frm é fechado
    if vAdministracao then                         // verificando assim as alterações
      ckAdministracao.Checked := true;
    if vEletronica then
      ckEletronica.Checked := true;
    if vInformatica then
      ckInformatica.Checked := true;
    if vSeguranca then
      ckSeguranca.Checked := true;
  end;
end;

procedure TDM1.tbAlunoscodigo_cursoGetText(Sender: TField; var aText: string;
  DisplayText: Boolean);
begin
  if Sender.Value = 1 then                         // Converte codigo em descrição
    aText := 'ADM';
  if Sender.Value = 2 then
    aText := 'ELE';
  if Sender.Value = 3 then
    aText := 'INF';
  if Sender.Value = 4 then
    aText := 'SEG';
end;

end.

