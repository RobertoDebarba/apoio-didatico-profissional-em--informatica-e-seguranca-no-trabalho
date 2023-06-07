unit UPesquisaAlunos;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, sqldb, FileUtil, Forms, Controls, Graphics, Dialogs,
  ExtCtrls, DBGrids, DbCtrls, StdCtrls, Buttons, LCLType, ZDataset;

type

  { TfrmPesquisaAlunos }

  TfrmPesquisaAlunos = class(TForm)
    bttApagar: TBitBtn;
    bttEditar: TBitBtn;
    bttSalvar: TBitBtn;
    bttCancelar: TBitBtn;
    comboCampo: TComboBox;
    DBLookupComboBox1: TDBLookupComboBox;
    DBLookupComboBox2: TDBLookupComboBox;
    dsCursos: TDatasource;
    dsTipo_Usuarios: TDatasource;
    dsUsuarios: TDatasource;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    DBEdit4: TDBEdit;
    DBEdit5: TDBEdit;
    dsAlunos: TDatasource;
    DBGrid1: TDBGrid;
    Edit1: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    panelTop: TPanel;
    panelCorpo: TPanel;
    panelLado: TPanel;
    procedure bttApagarClick(Sender: TObject);
    procedure bttCancelarClick(Sender: TObject);
    procedure bttEditarClick(Sender: TObject);
    procedure bttSalvarClick(Sender: TObject);
    procedure comboCampoChange(Sender: TObject);
    procedure DBEdit1Change(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure AtualizarPesquisa;
    procedure Edit1KeyPress(Sender: TObject; var Key: char);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure EditON;
    procedure EditOFF;
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmPesquisaAlunos: TfrmPesquisaAlunos;

implementation

uses
  DMprincipal, UUtilidades;

{$R *.lfm}

{ TfrmPesquisaAlunos }

// INICIO --------------------------------------------------------------------------------------------------

procedure TfrmPesquisaAlunos.FormShow(Sender: TObject);
begin
  Atualizarpesquisa;
  EditOFF;
end;

// PROCEDURES E FUNCTIONS ----------------------------------------------------------------------------------

procedure TfrmPesquisaAlunos.AtualizarPesquisa;                                 // Atualizar Pesquisa
begin
  if Edit1.Text <> '' then
  begin
    DM1.tbAlunos.FilterOptions:=[foCaseInsensitive];  // Desativa Key Sensitive
    if comboCampo.Text = 'Código' then
      DM1.tbAlunos.Filter := 'codigo_aluno = ' + QuotedStr(edit1.Text)
    else if comboCampo.Text = 'Nome' then
      DM1.tbAlunos.Filter := 'nome_aluno LIKE ' + QuotedStr('*' + edit1.Text + '*')
    else if comboCampo.Text = 'CPF' then
      DM1.tbAlunos.Filter := 'CPF_aluno LIKE ' + QuotedStr('*' + edit1.Text + '*');

    DM1.tbAlunos.Filtered := true;  // Ativa Filtro
  end
  else
    DM1.tbAlunos.Filtered := false; // Desativa Filtro
end;

procedure TfrmPesquisaAlunos.EditON;                                            // Habilita edição
var
  componente : Tcomponent;
  i : integer;
begin
  for i := 1 to 5 do
  begin
    componente := FindComponent('DBEdit' + IntToStr(i));
    (componente as TDBEdit).ReadOnly := false;
  end;
  DBLookupComboBox1.Enabled := true;
  DBLookupComboBox2.Enabled := true;
  bttSalvar.Enabled := true;
  bttCancelar.Enabled := true;
end;

procedure TfrmPesquisaAlunos.EditOFF;                                           // Desabilita edição
var
  componente : Tcomponent;
  i : integer;
begin
  for i := 1 to 5 do
  begin
    componente := FindComponent('DBEdit' + IntToStr(i));
    (componente as TDBEdit).ReadOnly := true;
  end;
  DBLookupComboBox1.Enabled := false;
  DBLookupComboBox2.Enabled := false;
  bttSalvar.Enabled := false;
  bttCancelar.Enabled := false;
end;

// PREVISAO DE ERROS ---------------------------------------------------------------------------------------

procedure TfrmPesquisaAlunos.Edit1KeyPress(Sender: TObject; var Key: char);     // Edit de pesquisa
begin
  if comboCampo.Text = 'Código' then
  begin
    if not (Key in ['0'..'9', #8{backspace}]) then
      Key := #0;
  end
  else if comboCampo.Text = 'CPF' then          // Mascara de CPF
    Utilidades.MascCPF(Edit1, Key);

end;

// PESQUISA ------------------------------------------------------------------------------------------------

procedure TfrmPesquisaAlunos.Edit1Change(Sender: TObject);                      // Atualiza ao digitar
begin
  AtualizarPesquisa;
end;

procedure TfrmPesquisaAlunos.comboCampoChange(Sender: TObject);                 // Atualiza ao selecionar combo
begin
  AtualizarPesquisa;
end;

procedure TfrmPesquisaAlunos.DBEdit1Change(Sender: TObject);                    // Quando codigo_usu mudar, desabilita edição
begin
  DM1.tbUsuariosAlunos.Locate('codigo_usuario', DM1.tbAlunos.FieldByName('codigo_usuario').AsString, []); // Atualiza usuario
  EditOFF;                     // Sai do modo edição
end;

// BOTOES --------------------------------------------------------------------------------------------------

procedure TfrmPesquisaAlunos.bttApagarClick(Sender: TObject);                   // Apagar
var
  Query : TZQuery;
  codigoApagar : integer;
begin
  if Application.MessageBox('Deseja apagar este cadastro?','Apagar cadastro', MB_YESNO) = idYES then
  begin
    codigoApagar := DM1.tbAlunoscodigo_usuario.Value;        // Salva codigo usuario

    try
      Query := TZQuery.Create(nil);
      Query.Connection := DM1.ZConnection1;

      Query.SQL.Clear;
      Query.SQL.Add('DELETE from tb_alunos WHERE codigo_aluno = "'+DBEdit1.Text+'"');   // Apaga aluno
      Query.ExecSQL;

      Query.SQL.Clear;
      Query.SQL.Add('DELETE from tb_usuarios WHERE codigo_usuario = "'+IntToStr(codigoApagar)+'"'); // Apaga usuario
      Query.ExecSQL;
    finally
      Query.Free;
    end;

    dsAlunos.DataSet.Refresh;
    EditOFF;
  end
  else
    abort;
end;

procedure TfrmPesquisaAlunos.bttCancelarClick(Sender: TObject);                 // Cancelar
begin
  dsUsuarios.DataSet.Cancel;
  dsAlunos.DataSet.Cancel;
  EditOFF;
end;

procedure TfrmPesquisaAlunos.bttEditarClick(Sender: TObject);                   // Editar
begin
  dsUsuarios.DataSet.Edit;
  dsAlunos.DataSet.Edit;
  EditON;
end;

procedure TfrmPesquisaAlunos.bttSalvarClick(Sender: TObject);                   // Salvar
begin
  dsUsuarios.DataSet.Post;
  dsAlunos.DataSet.Post;
  EditOFF;
end;

// FIM -----------------------------------------------------------------------------------------------------

procedure TfrmPesquisaAlunos.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
  dsUsuarios.DataSet.Cancel;
  dsAlunos.DataSet.Cancel;

  CloseAction:=caFree;
end;

end.

