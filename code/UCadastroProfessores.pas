unit UCadastroProfessores;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, sqldb, FileUtil, Forms, Controls, Graphics, Dialogs,
  DbCtrls, StdCtrls, Buttons, ZDataset;

type

  { TfrmCadastroProfessores }

  TfrmCadastroProfessores = class(TForm)
    bttCancelar: TBitBtn;
    bttSalvar: TBitBtn;
    ckAdministracao: TCheckBox;
    ckEletronica: TCheckBox;
    ckInformatica: TCheckBox;
    ckSeguranca: TCheckBox;
    DBEdit7: TDBEdit;
    dsProfessores: TDatasource;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    DBEdit4: TDBEdit;
    DBEdit5: TDBEdit;
    DBEdit6: TDBEdit;
    DBLookupComboBox2: TDBLookupComboBox;
    dsTipo_Usuario: TDatasource;
    dsUsuarios: TDatasource;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    procedure bttCancelarClick(Sender: TObject);
    procedure bttSalvarClick(Sender: TObject);
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
  frmCadastroProfessores: TfrmCadastroProfessores;

implementation

uses
  DMPrincipal, UUtilidades;

{$R *.lfm}

{ TfrmCadastroProfessores }

// INICIO ------------------------------------------------------------------------------------------------

procedure TfrmCadastroProfessores.FormCreate(Sender: TObject);
begin
  NovoCadastro;
end;

// PROCEDURES AND FUNCTIONS ------------------------------------------------------------------------------

procedure TfrmCadastroProfessores.DBEdit3Exit(Sender: TObject);                 // Testar CPF - evento
begin
  if Utilidades.VerifCPF(DBEdit3.Text) = true then
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

procedure TfrmCadastroProfessores.DBEdit3KeyPress(Sender: TObject; var Key: char); // Mascara CPF - evento
begin
  Utilidades.MascCPF(DBEdit3, Key);
end;

procedure TfrmCadastroProfessores.NovoCadastro;                                 // NOVO
var
  QueryAI : TZQuery;
begin
  dsProfessores.DataSet.Insert;
  dsUsuarios.DataSet.Insert;

  QueryAI := TZQuery.Create(nil); // Cria Query
  QueryAI.Connection := DM1.ZConnection1;

  try
    // AI tabela de professores
    QueryAI.SQL.Add('Select MAX(codigo_professor) as "MAIOR" from tb_professores;');
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

  DBEdit7.Text := DBEdit6.Text;      // Passa codigo do usuario ao campo invisivel tb_professores.codigo_usuario
end;

// BOTOES ------------------------------------------------------------------------------------------------

procedure TfrmCadastroProfessores.bttSalvarClick(Sender: TObject);              // Salvar
var
  QueryInsert : TZQuery;
  componente : Tcomponent;
  i : integer;
begin
  for i := 1 to 7 do                                 // Verifica se todos campos foram preenchidos
  begin
    componente := FindComponent('DBEdit' + IntToStr(i));
    if ((componente as TDBEdit).Text = '') or (DBLookupComboBox2.Text = '') then
    begin
      ShowMessage('Todos os campos devem ser preenchidos!');
      abort;
    end;
  end;

  dsUsuarios.DataSet.Insert;
  // Cadastro de Professor e Usuario ----------------
  dsUsuarios.DataSet.Post;
  dsProfessores.DataSet.Post;

  // Cadastro do Professor no curso -----------------
  QueryInsert := TZQuery.Create(nil);
  QueryInsert.Connection := DM1.ZConnection1;


  try
    if ckAdministracao.Checked then
    begin
      QueryInsert.SQL.Clear;
      QueryInsert.SQL.Add('INSERT INTO tb_cursos_professores VALUES ('+DBEdit1.Text+', 1)');
      QueryInsert.ExecSQL;
    end;
    if ckEletronica.Checked then
    begin
      QueryInsert.SQL.Clear;
      QueryInsert.SQL.Add('INSERT INTO tb_cursos_professores VALUES ('+DBEdit1.Text+', 2)');
      QueryInsert.ExecSQL;
    end;
    if ckInformatica.Checked then
    begin
      QueryInsert.SQL.Clear;
      QueryInsert.SQL.Add('INSERT INTO tb_cursos_professores VALUES ('+DBEdit1.Text+', 3)');
      QueryInsert.ExecSQL;
    end;
    if ckSeguranca.Checked then
    begin
      QueryInsert.SQL.Clear;
      QueryInsert.SQL.Add('INSERT INTO tb_cursos_professores VALUES ('+DBEdit1.Text+', 4)');
      QueryInsert.ExecSQL;
    end;

    ShowMessage('Cadastro realizado com sucesso!');
    NovoCadastro;
  finally
    QueryInsert.Free;
  end;

  DM1.tbUsuariosProfessores.Refresh;
end;

procedure TfrmCadastroProfessores.bttCancelarClick(Sender: TObject);            // Cancelar
begin
  dsUsuarios.DataSet.Cancel;
  dsProfessores.DataSet.Cancel;
  ShowMessage('Cadastro Cancelado!');
  self.Close;
end;

// FIM ---------------------------------------------------------------------------------------------------

procedure TfrmCadastroProfessores.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
  dsUsuarios.DataSet.Cancel;
  dsProfessores.DataSet.Cancel;

  frmCadastroProfessores := nil;
  CloseAction:=caFree;
end;

end.

