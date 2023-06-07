unit UCadastroAlunos;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, sqldb, FileUtil, Forms, Controls, Graphics, Dialogs,
  StdCtrls, DbCtrls, ExtCtrls, Buttons, ZDataset;

type

  { TfrmCadastroAlunos }

  TfrmCadastroAlunos = class(TForm)
    bttSalvar: TBitBtn;
    bttCancelar: TBitBtn;
    DBEdit1: TDBEdit;
    DBEdit6: TDBEdit;
    DBEdit7: TDBEdit;
    dsTipo_Usuarios: TDatasource;
    DBEdit4: TDBEdit;
    DBEdit5: TDBEdit;
    DBLookupComboBox2: TDBLookupComboBox;
    dsUsuarios: TDatasource;
    dsCursos: TDatasource;
    DBLookupComboBox1: TDBLookupComboBox;
    dsAlunos: TDatasource;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    procedure bttNovoClick(Sender: TObject);
    procedure bttSalvarClick(Sender: TObject);
    procedure bttCancelarClick(Sender: TObject);
    procedure DBEdit3Exit(Sender: TObject);
    procedure DBEdit3KeyPress(Sender: TObject; var Key: char);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure NovoCadastro;
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmCadastroAlunos: TfrmCadastroAlunos;

implementation

uses
  UUtilidades, DMPrincipal;

{$R *.lfm}

{ TfrmCadastroAlunos }

// INICIO -----------------------------------------------------------------------------------------------

procedure TfrmCadastroAlunos.FormCreate(Sender: TObject);
begin
  NovoCadastro;
end;

// PROCEDURES AND FUNCTIONS -----------------------------------------------------------------------------

procedure TfrmCadastroAlunos.DBEdit3Exit(Sender: TObject);                      // Testar CPF - evento
begin
  if Utilidades.VerifCPF(DBEdit3.Text) then
  begin
    DBEdit3.Color := clWindow;
  end
  else
  begin
    ShowMessage('CPF incorreto!');
    DBEdit3.Color := clRed;
    DBEdit3.SetFocus;
    DBEdit3.SelStart := 15;
  end;
end;

procedure TfrmCadastroAlunos.DBEdit3KeyPress(Sender: TObject; var Key: char);   // Mascara CPF - evento
begin
  Utilidades.MascCPF(DBEdit3, Key);
end;

procedure TfrmCadastroAlunos.NovoCadastro;                                      // Novo Cadatro
var
  QueryAI : TZQuery;
begin
  dsAlunos.DataSet.Insert;
  dsUsuarios.DataSet.Insert;

  QueryAI := TZQuery.Create(nil); // Cria Query
  QueryAI.Connection := DM1.ZConnection1;

  try
    // AI tabela de alunos
    QueryAI.SQL.Add('Select MAX(codigo_aluno) as "MAIOR" from tb_alunos;');
    QueryAI.Open;
    DBEdit1.Text := IntToStr(Succ(QueryAI.FieldByName('MAIOR').AsInteger));

    // AI tabela de usuarios
    QueryAI.Close;
    QueryAI.SQL.Clear;
    QueryAI.SQL.Add('Select MAX(codigo_usuario) as "MAIOR" from tb_usuarios;');
    QueryAI.Open;
    DBEdit6.Text := IntToStr(Succ(QueryAI.FieldByName('MAIOR').AsInteger));
  finally
    QueryAI.Free;
  end;

  DBEdit7.Text := DBEdit6.Text;   // Passa codigo do usuario ao campo invisivel tb_alunos.codigo_usuario
end;

// BOTOES -----------------------------------------------------------------------------------------------

procedure TfrmCadastroAlunos.bttNovoClick(Sender: TObject);                     // Novo
begin
  NovoCadastro;
end;

procedure TfrmCadastroAlunos.bttSalvarClick(Sender: TObject);                   // Salvar
var
  componente : Tcomponent;
  i : integer;
begin
  for i := 1 to 7 do                                 // Verifica se todos campos foram preenchidos
  begin
    componente := FindComponent('DBEdit' + IntToStr(i));
    if ((componente as TDBEdit).Text = '') or (DBLookupComboBox1.Text = '') or (DBLookupComboBox2.Text = '') then
    begin
      ShowMessage('Todos os campos devem ser preenchidos!');
      abort;
    end;
  end;

  dsUsuarios.DataSet.post;                           // Realiza cadastro
  dsAlunos.DataSet.Post;
  ShowMessage('Cadastro realizado com sucesso!');

  DM1.tbUsuariosAlunos.Refresh;
  NovoCadastro;
end;

procedure TfrmCadastroAlunos.bttCancelarClick(Sender: TObject);                 // Cancelar
begin
  dsAlunos.DataSet.Cancel;
  dsUsuarios.DataSet.Cancel;
  ShowMessage('Cadastro Cancelado!');
  self.Close;
end;

// FIM --------------------------------------------------------------------------------------------------

procedure TfrmCadastroAlunos.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
  dsAlunos.DataSet.Cancel;
  dsUsuarios.DataSet.Cancel;

  frmCadastroAlunos := nil;
  CloseAction:=caFree;
end;

end.

