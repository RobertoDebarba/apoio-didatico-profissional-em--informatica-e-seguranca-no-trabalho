unit Ulogin;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  Buttons, StdCtrls;

type

  { TfrmLogin }

  TfrmLogin = class(TForm)
    bttSair: TBitBtn;
    bttEntrar: TBitBtn;
    Edit1: TEdit;
    Edit2: TEdit;
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    procedure bttEntrarClick(Sender: TObject);
    procedure bttSairClick(Sender: TObject);
    procedure Edit1KeyPress(Sender: TObject; var Key: char);
    procedure Edit2KeyPress(Sender: TObject; var Key: char);
    procedure entrar;
    procedure FormHide(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmLogin: TfrmLogin;

implementation

uses
  DMprincipal, UPrincipal;

{$R *.lfm}

{ TfrmLogin }

procedure TfrmLogin.entrar;                                                     // Login
begin
  if DM1.tbUsuarios.Locate('login_usuario', Edit1.Text, []) then     // Verifica usuario
  begin
    if (Edit2.Text = DM1.tbUsuarios.FieldByName('senha_usuario').AsString) then  // Verifica senha
    begin
      Application.CreateForm(TfrmPrincipal, frmPrincipal);                                  // OK

      // Diretivas de privilegio de usuário ----------------------------------------------------
      if (DM1.tbUsuarios.FieldByName('codigo_tipo_usuario').AsInteger = 1) then
      begin
        frmPrincipal.Label7.Caption := '"Professor Administrador"';
        frmPrincipal.bttArnu.Enabled := true;
        frmPrincipal.bttCarot.Enabled := true;
        frmPrincipal.bttCobas.Enabled := true;
        frmPrincipal.bttNortem.Enabled := true;
        frmPrincipal.MainMenu1.Items.Items[0].Visible := true;
        frmPrincipal.MainMenu1.Items.Items[0].Items[0].Items[1].Visible:=true;
        frmPrincipal.MainMenu1.Items.Items[0].Items[1].Items[1].Visible:=true;
        frmPrincipal.MainMenu1.Items.Items[0].Items[2].Visible:=true;
      end
      else if (DM1.tbUsuarios.FieldByName('codigo_tipo_usuario').AsInteger = 2) then
      begin
        frmPrincipal.Label7.Caption := '"Professor"';
        frmPrincipal.bttArnu.Enabled := true;
        frmPrincipal.bttCarot.Enabled := true;
        frmPrincipal.bttCobas.Enabled := true;
        frmPrincipal.bttNortem.Enabled := true;
        frmPrincipal.MainMenu1.Items.Items[0].Visible := true;
        frmPrincipal.MainMenu1.Items.Items[0].Items[0].Items[1].Visible:=false;
        frmPrincipal.MainMenu1.Items.Items[0].Items[1].Items[1].Visible:=false;
        frmPrincipal.MainMenu1.Items.Items[0].Items[2].Visible:=false;
      end
      else if (DM1.tbUsuarios.FieldByName('codigo_tipo_usuario').AsInteger = 3) then // Aluno --------------
      begin
        frmPrincipal.MainMenu1.Items.Items[0].Visible := false;

        DM1.tbAlunos.Locate('codigo_usuario', DM1.tbUsuarios.FieldByName('codigo_usuario').Value, []);

        if (DM1.tbAlunos.FieldByName('codigo_curso').AsInteger = 1) then
        begin
          frmPrincipal.Label7.Caption := '"Curso Técnico em Administração"';
          frmPrincipal.bttNortem.Enabled := true;
        end
        else if (DM1.tbAlunos.FieldByName('codigo_curso').AsInteger = 2) then
        begin
          frmPrincipal.Label7.Caption := '"Curso Técnico em Eletrônica"';
          frmPrincipal.bttCarot.Enabled := true;
        end
        else if (DM1.tbAlunos.FieldByName('codigo_curso').AsInteger = 3) then
        begin
          frmPrincipal.Label7.Caption := '"Curso Técnico em Informática"';
          frmPrincipal.bttCobas.Enabled := true;
        end
        else if (DM1.tbAlunos.FieldByName('codigo_curso').AsInteger = 4) then
        begin
          frmPrincipal.Label7.Caption := '"Curso Técnico em Segurança do Trabalho"';
          frmPrincipal.bttArnu.Enabled := true;
        end;
      end;

      // ---------------------------------------------------------------------------------------------

      frmPrincipal.Show;     // Abre frmPrincipal
      self.Hide;
    end
    else
      ShowMessage('Nome de usuário ou senha incorretos!');  // Erro
  end
  else
    ShowMessage('Nome de usuário ou senha incorretos!');    // Erro
end;

procedure TfrmLogin.FormHide(Sender: TObject);                                  // Limpar campos
begin
  Edit1.Text:='';
  Edit2.Text:='';
end;

procedure TfrmLogin.FormShow(Sender: TObject);                                  // Set Focus
begin
  Edit1.SetFocus;
end;

procedure TfrmLogin.bttEntrarClick(Sender: TObject);                            // Botão Entrar
begin
  entrar;
end;

procedure TfrmLogin.bttSairClick(Sender: TObject);                              // Botão Sair
begin
  Application.Terminate;
end;

// ENTER no campo --------------------------------------------------------------

procedure TfrmLogin.Edit1KeyPress(Sender: TObject; var Key: char);
begin
  if Key = #13{enter} then
    entrar;
end;

procedure TfrmLogin.Edit2KeyPress(Sender: TObject; var Key: char);
begin
  if Key = #13{enter} then
    entrar;
end;

end.

