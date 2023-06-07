unit UPesquisaProfessores_EditarCursos;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  Buttons, ZDataset, DbCtrls;

type

  { TfrmPesquisaProfessores_EditarCursos }

  TfrmPesquisaProfessores_EditarCursos = class(TForm)
    bttOK: TBitBtn;
    ckAdministracao: TCheckBox;
    ckInformatica: TCheckBox;
    ckEletronica: TCheckBox;
    ckSeguranca: TCheckBox;
    procedure bttOKClick(Sender: TObject);
    procedure LimparDados;
  private
    { private declarations }
  public
    { public declarations }
    vAdministracao, vEletronica, vInformatica, vSeguranca : boolean;
  end;

var
  frmPesquisaProfessores_EditarCursos: TfrmPesquisaProfessores_EditarCursos;

implementation

uses
  UPesquisaProfessores, DMPrincipal;

{$R *.lfm}

{ TfrmPesquisaProfessores_EditarCursos }

procedure TfrmPesquisaProfessores_EditarCursos.LimparDados;                     // Limpar dados
begin
  // ---------------------------------
  vAdministracao:=false;                        // limpar variaveis
  vEletronica:=false;
  vInformatica:=false;
  vSeguranca:=false;
  // ---------------------------------
  ckAdministracao.Checked:=false;               // limpar campos
  ckEletronica.Checked:=false;
  ckInformatica.Checked:=false;
  ckSeguranca.Checked:=false;
  // ---------------------------------
end;

procedure TfrmPesquisaProfessores_EditarCursos.bttOKClick(Sender: TObject);     // OK
var
  QueryInsert : TZQuery;
begin
  QueryInsert := TZQuery.Create(nil);
  QueryInsert.Connection := DM1.ZConnection1;

  try
    if (ckAdministracao.Checked = true) and (vAdministracao = false) then   // Escreve --> executa --> limpa
    begin
      QueryInsert.SQL.Add('INSERT INTO tb_cursos_professores VALUES ('+frmPesquisaProfessores.DBEdit1.Text+', 1);');
      QueryInsert.ExecSQL;
      QueryInsert.SQL.Clear;
    end;
    if (ckEletronica.Checked = true) and (vEletronica = false) then
    begin
      QueryInsert.SQL.Add('INSERT INTO tb_cursos_professores VALUES ('+frmPesquisaProfessores.DBEdit1.Text+', 2);');
      QueryInsert.ExecSQL;
      QueryInsert.SQL.Clear;
    end;
    if (ckInformatica.Checked = true) and (vinformatica = false) then
    begin
      QueryInsert.SQL.Add('INSERT INTO tb_cursos_professores VALUES ('+frmPesquisaProfessores.DBEdit1.Text+', 3);');
      QueryInsert.ExecSQL;
      QueryInsert.SQL.Clear;
    end;
    if (ckSeguranca.Checked = true) and (vSeguranca = false) then
    begin
      QueryInsert.SQL.Add('INSERT INTO tb_cursos_professores VALUES ('+frmPesquisaProfessores.DBEdit1.Text+', 4);');
      QueryInsert.ExecSQL;
      QueryInsert.SQL.Clear;
    end;

    if (ckAdministracao.Checked = false) and (vAdministracao = true) then   // Escreve --> executa --> limpa
    begin
      QueryInsert.SQL.Add('DELETE FROM tb_cursos_professores WHERE codigo_professor = '+frmPesquisaProfessores.DBEdit1.Text+' AND codigo_curso = 1;');
      QueryInsert.ExecSQL;
      QueryInsert.SQL.Clear;
    end;
    if (ckEletronica.Checked = false) and (vEletronica = true) then
    begin
      QueryInsert.SQL.Add('DELETE FROM tb_cursos_professores WHERE codigo_professor = '+frmPesquisaProfessores.DBEdit1.Text+' AND codigo_curso = 2;');
      QueryInsert.ExecSQL;
      QueryInsert.SQL.Clear;
    end;
    if (ckInformatica.Checked = false) and (vinformatica = true) then
    begin
      QueryInsert.SQL.Add('DELETE FROM tb_cursos_professores WHERE codigo_professor = '+frmPesquisaProfessores.DBEdit1.Text+' AND codigo_curso = 3;');
      QueryInsert.ExecSQL;
      QueryInsert.SQL.Clear;
    end;
    if (ckSeguranca.Checked = false) and (vSeguranca = true) then
    begin
      QueryInsert.SQL.Add('DELETE FROM tb_cursos_professores WHERE codigo_professor = '+frmPesquisaProfessores.DBEdit1.Text+' AND codigo_curso = 4;');
      QueryInsert.ExecSQL;
      QueryInsert.SQL.Clear;
    end;

  finally
    QueryInsert.Free;
  end;

  frmPesquisaProfessores.dsPesquisaCursoProfessores.DataSet.Refresh;  // Atualiza pesquisa

  LimparDados;    // Limpa componentes e variaveis do form para nova utilização
  self.Close;     // Fecha
end;

end.

