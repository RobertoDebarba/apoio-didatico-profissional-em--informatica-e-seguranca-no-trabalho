unit UPrincipal;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  Menus, ExtCtrls, Buttons;

type

  { TfrmPrincipal }

  TfrmPrincipal = class(TForm)
    bttCobas: TBitBtn;
    bttNortem: TBitBtn;
    bttArnu: TBitBtn;
    bttCarot: TBitBtn;
    Image2: TImage;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    MainMenu1: TMainMenu;
    Gerenciar: TMenuItem;
    GerenciarCadastrar: TMenuItem;
    gerenciarCadastrarAluno: TMenuItem;
    GerenciarCadastrarprofessor: TMenuItem;
    Gerenciaspesquisar: TMenuItem;
    GerenciarProcurarAluno: TMenuItem;
    GerenciarProcurarProfessor: TMenuItem;
    GerenciarPersonalizar: TMenuItem;
    SairLogoff: TMenuItem;
    SairSair: TMenuItem;
    Sair: TMenuItem;
    SobreProjeto: TMenuItem;
    SobreSoftware: TMenuItem;
    Sobre: TMenuItem;
    panelCorpo: TPanel;
    panelMenu: TPanel;
    Panel2: TPanel;
    procedure bttArnuClick(Sender: TObject);
    procedure bttCobasClick(Sender: TObject);
    procedure FormClose(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure gerenciarCadastrarAlunoClick(Sender: TObject);
    procedure GerenciarCadastrarprofessorClick(Sender: TObject);
    procedure GerenciarPersonalizarClick(Sender: TObject);
    procedure GerenciarProcurarAlunoClick(Sender: TObject);
    procedure GerenciarProcurarProfessorClick(Sender: TObject);
    procedure SairLogoffClick(Sender: TObject);
    procedure SairSairClick(Sender: TObject);
    procedure SobreProjetoClick(Sender: TObject);
    procedure SobreSoftwareClick(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

uses
  UCadastroAlunos, UPesquisaAlunos, UCadastroProfessores, UPesquisaProfessores,
  UArnuPreview, UPesquisaProfessores_EditarCursos, UCobasPrewiew, Ulogin,
  UPersonalizar, UUtilidades, USobreProjeto, USobreSoftware, DMPrincipal;

{$R *.lfm}

{ TfrmPrincipal }

// INICIO -------------------------------------------------------------------------------------------

procedure TfrmPrincipal.FormShow(Sender: TObject);                              // Carrega nome da escola
var
  cabecalho : TStringList;
begin
  cabecalho := TStringList.Create;
  cabecalho.LoadFromFile('bin/cabecalho');

  Label9.Caption := cabecalho[0];

  cabecalho.Free;
end;

// MENU PRINCIPAL -----------------------------------------------------------------------------------

procedure TfrmPrincipal.bttArnuClick(Sender: TObject);                          // Arnu
begin
  Utilidades.FecharForms;

  if (frmArnuPreview = nil) then
    Application.CreateForm(TfrmArnuPreview, frmArnuPreview);

  frmArnuPreview.Show;
  frmArnuPreview.Parent := panelCorpo;
end;

procedure TfrmPrincipal.bttCobasClick(Sender: TObject);                         // Cobas
begin
  Utilidades.FecharForms;

  if (frmArnuPreview <> nil) then
  begin
    frmArnuPreview.Close;
    frmArnuPreview := nil;
  end;

  if (frmCobasPreview = nil) then
    Application.CreateForm(TfrmCobasPreview, frmCobasPreview);

  frmCobasPreview.Show;
  frmCobasPreview.Parent := panelCorpo;
end;

// MENU SUPERIOR ------------------------------------------------------------------------------------

procedure TfrmPrincipal.gerenciarCadastrarAlunoClick(Sender: TObject);          // Cadastrar - Alunos
begin
  DM1.tbTipo_Usuarios.Filter:='codigo_tipo_usuario = 3'; // Restrição de privilegio de usuario
  Utilidades.FecharForms;

  if (frmCadastroAlunos = nil) then
    Application.CreateForm(TfrmCadastroAlunos, frmCadastroAlunos);

  frmCadastroAlunos.Show;
  frmCadastroAlunos.Parent := panelCorpo;
end;

procedure TfrmPrincipal.GerenciarCadastrarprofessorClick(Sender: TObject);      // Cadastrar - Professores
begin
  DM1.tbTipo_Usuarios.Filter:='codigo_tipo_usuario <> 3';  // Restrição de privilegio de usuario
  Utilidades.FecharForms;

  if (frmCadastroProfessores = nil) then
    Application.CreateForm(TfrmCadastroProfessores, frmCadastroProfessores);

  frmCadastroProfessores.Show;
  frmCadastroProfessores.Parent := panelCorpo;
end;

procedure TfrmPrincipal.GerenciarProcurarAlunoClick(Sender: TObject);           // Pesquisar - Alunos
begin
  DM1.tbTipo_Usuarios.Filter:='codigo_tipo_usuario = 3';  // Restrição de privilegio de usuario
  Utilidades.FecharForms;

  if (frmPesquisaAlunos = nil) then
    Application.CreateForm(TfrmPesquisaAlunos, frmPesquisaAlunos);

  frmPesquisaAlunos.Show;
  frmPesquisaAlunos.Parent := panelCorpo;;
end;

procedure TfrmPrincipal.GerenciarProcurarProfessorClick(Sender: TObject);       // Pesquisar - Professores
begin
  DM1.tbTipo_Usuarios.Filter:='codigo_tipo_usuario <> 3';  // Restrição de privilegio de usuario
  Utilidades.FecharForms;

  if (frmPesquisaProfessores_EditarCursos = nil) then    // Cria form a ser utilizada depois
    Application.CreateForm(TfrmPesquisaProfessores_EditarCursos, frmPesquisaProfessores_EditarCursos);

  if (frmPesquisaProfessores = nil) then
    Application.CreateForm(TfrmPesquisaProfessores, frmPesquisaProfessores);

  frmPesquisaProfessores.Show;
  frmPesquisaProfessores.Parent := panelCorpo;;
end;

procedure TfrmPrincipal.GerenciarPersonalizarClick(Sender: TObject);            // Gerenciar - Personalizar
begin
  Application.CreateForm(TfrmPersonalizar, frmPersonalizar);

  frmPersonalizar.ShowModal;
  frmPersonalizar.Free;
end;

procedure TfrmPrincipal.SairLogoffClick(Sender: TObject);                       // Sair - Logoff
begin
  frmLogin.Show;
  self.free;
end;

procedure TfrmPrincipal.SairSairClick(Sender: TObject);                         // Sair - Sair
begin
  Application.Terminate;
end;

procedure TfrmPrincipal.SobreProjetoClick(Sender: TObject);                     // Sobre - Projeto
begin
  Application.CreateForm(TfrmSobreProjeto, frmSobreProjeto);
  frmSobreProjeto.ShowModal;
  frmSobreProjeto.Free;
end;

procedure TfrmPrincipal.SobreSoftwareClick(Sender: TObject);                    // Sobre - Software
begin
  Application.CreateForm(TfrmSobreSoftware, frmSobreSoftware);
  frmSobreSoftware.ShowModal;
  frmSobreSoftware.Free;
end;

// FIM ----------------------------------------------------------------------------------------------

procedure TfrmPrincipal.FormClose(Sender: TObject);
begin
  Application.Terminate;
end;

end.

