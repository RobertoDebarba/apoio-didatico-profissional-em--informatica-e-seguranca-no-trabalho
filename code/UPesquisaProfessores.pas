unit UPesquisaProfessores;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls, DbCtrls, Buttons, DBGrids, LCLType, ZDataset;

type

  { TfrmPesquisaProfessores }

  TfrmPesquisaProfessores = class(TForm)
    bttEditarCursos: TBitBtn;
    bttApagar: TBitBtn;
    bttCancelar: TBitBtn;
    bttEditar: TBitBtn;
    bttSalvar: TBitBtn;
    comboCampo: TComboBox;
    dsPesquisaCursoProfessores: TDatasource;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    DBEdit4: TDBEdit;
    DBEdit5: TDBEdit;
    DBGrid1: TDBGrid;
    DBGrid2: TDBGrid;
    DBLookupComboBox2: TDBLookupComboBox;
    dsProfessores: TDatasource;
    dsUsuarios: TDatasource;
    dsTipo_Usuarios: TDatasource;
    Edit1: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    panelCorpo: TPanel;
    panelLado: TPanel;
    panelTop: TPanel;
    procedure AtualizarPesquisa;
    procedure bttApagarClick(Sender: TObject);
    procedure bttCancelarClick(Sender: TObject);
    procedure bttEditarClick(Sender: TObject);
    procedure bttEditarCursosClick(Sender: TObject);
    procedure bttSalvarClick(Sender: TObject);
    procedure comboCampoChange(Sender: TObject);
    procedure DBEdit1Change(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
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
  frmPesquisaProfessores: TfrmPesquisaProfessores;

implementation

uses
  DMPrincipal, UPesquisaProfessores_EditarCursos, UUtilidades;

{$R *.lfm}

// INICIO ------------------------------------------------------------------------------------------

procedure TfrmPesquisaProfessores.FormShow(Sender: TObject);
begin
  Atualizarpesquisa;
  EditOFF;
end;

// PROCEDURES AND FUNCTIONS -------------------------------------------------------------------------

procedure TfrmPesquisaProfessores.AtualizarPesquisa;                            // Atualizar pesquisa
begin
   if Edit1.Text <> '' then
  begin
    DM1.tbprofessores.FilterOptions:=[foCaseInsensitive];  // Desativa Key Sensitive
    if comboCampo.Text = 'Código' then
      DM1.tbProfessores.Filter := 'codigo_professor = ' + QuotedStr(edit1.Text)
    else if comboCampo.Text = 'Nome' then
      DM1.tbProfessores.Filter := 'nome_professor LIKE ' + QuotedStr('*' + edit1.Text + '*')
    else if comboCampo.Text = 'CPF' then
      DM1.tbProfessores.Filter := 'CPF_professor LIKE ' + QuotedStr('*' + edit1.Text + '*');

    DM1.tbProfessores.Filtered := true;  // Ativa Filtro
  end
  else
    DM1.tbProfessores.Filtered := false; // Desativa Filtro
end;

procedure TfrmPesquisaProfessores.EditON;                                       // Habilita edição
var
  componente : Tcomponent;
  i : integer;
begin
  for i := 1 to 5 do
  begin
    componente := FindComponent('DBEdit' + IntToStr(i));
    (componente as TDBEdit).ReadOnly := false;
  end;
  DBLookupComboBox2.Enabled := true;
  bttSalvar.Enabled := true;
  bttCancelar.Enabled := true;
  bttEditarCursos.Enabled := true;
end;

procedure TfrmPesquisaProfessores.EditOFF;                                      // Desabilita edição
var
  componente : Tcomponent;
  i : integer;
begin
  for i := 1 to 5 do
  begin
    componente := FindComponent('DBEdit' + IntToStr(i));
    (componente as TDBEdit).ReadOnly := true;
  end;
  DBLookupComboBox2.Enabled := false;
  bttSalvar.Enabled := false;
  bttCancelar.Enabled := false;
  bttEditarCursos.Enabled := false;
end;

// PREVISAO DE ERROS --------------------------------------------------------------------------------

procedure TfrmPesquisaProfessores.Edit1KeyPress(Sender: TObject; var Key: char);// Edit de pesquisa
begin
  if comboCampo.Text = 'Código' then
  begin
    if not (Key in ['0'..'9', #8{backspace}]) then
      Key := #0;
  end
  else if comboCampo.Text = 'CPF' then          // Mascara de CPF
    Utilidades.VerifCPF(Edit1.Text);
end;

// PESQUISA -----------------------------------------------------------------------------------------

procedure TfrmPesquisaProfessores.Edit1Change(Sender: TObject);                 // Atualizar ao digitar
begin
  AtualizarPesquisa;
end;

procedure TfrmPesquisaProfessores.comboCampoChange(Sender: TObject);            // Atualiza ao selecionar combo
begin
  AtualizarPesquisa;
end;

procedure TfrmPesquisaProfessores.DBEdit1Change(Sender: TObject);               // Sincroniza tb_usuarios com tb_alunos
begin
  DM1.tbusuariosProfessores.Locate('codigo_usuario', DM1.tbProfessores.FieldByName('codigo_usuario').AsString, []);

  DM1.queryPesquisaCursosProfessores.Close;
  DM1.queryPesquisaCursosProfessores.Params.ParamByName('Pcodigo').Value := DBEdit1.Text;
  DM1.queryPesquisaCursosProfessores.Open;

  //---
  frmPesquisaProfessores_EditarCursos.LimparDados;
  EditOff;                                                // Sai do modo edição
end;

// BOTOES -------------------------------------------------------------------------------------------

procedure TfrmPesquisaProfessores.bttApagarClick(Sender: TObject);              // Apagar
var
  Query : TZQuery;
  codigoApagar : integer;
begin
  if Application.MessageBox('Deseja apagar este cadastro?','Apagar cadastro', MB_YESNO) = idYES then
  begin
    codigoApagar := DM1.tbProfessorescodigo_usuario.Value;

    try
      Query := TZQuery.Create(nil);
      Query.Connection := DM1.ZConnection1;

      Query.SQL.Clear;         // Apaga tb_cursos_professores
      Query.SQL.Add('DELETE FROM tb_cursos_professores WHERE codigo_professor = "'+DBEdit1.Text+'"');
      Query.ExecSQL;

      dsProfessores.DataSet.Delete;  // Apaga professor

      Query.SQL.Clear;         // Apaga tb_usuarios
      Query.SQL.Add('DELETE from tb_usuarios WHERE codigo_usuario = "'+IntToStr(codigoApagar)+'"');
      Query.ExecSQL;
    finally
      Query.Free;
    end;

    dsProfessores.DataSet.Refresh;
    editOFF;
  end
  else
    abort;
end;

procedure TfrmPesquisaProfessores.bttCancelarClick(Sender: TObject);            // Cancelar
begin
  dsProfessores.DataSet.Cancel;
  dsUsuarios.DataSet.Cancel;
  EditOFF;
end;

procedure TfrmPesquisaProfessores.bttEditarClick(Sender: TObject);              // Editar
begin
  dsProfessores.DataSet.Edit;
  dsUsuarios.DataSet.Edit;
  EditON;
end;

procedure TfrmPesquisaProfessores.bttSalvarClick(Sender: TObject);              // Salvar
begin
  dsProfessores.DataSet.Post;
  dsUsuarios.DataSet.Post;
  EditOFF;
end;

procedure TfrmPesquisaProfessores.bttEditarCursosClick(Sender: TObject);        // Editar Cursos
begin
  frmPesquisaProfessores_EditarCursos.ShowModal;
end;

// FIM ----------------------------------------------------------------------------------------------

procedure TfrmPesquisaProfessores.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
  dsProfessores.DataSet.Cancel;
  dsUsuarios.DataSet.Cancel;

  CloseAction:=caFree;
end;

end.

