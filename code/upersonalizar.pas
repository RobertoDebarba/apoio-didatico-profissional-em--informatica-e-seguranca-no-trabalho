unit UPersonalizar;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TfrmPersonalizar }

  TfrmPersonalizar = class(TForm)
    bttSalvar: TButton;
    bttCancelar: TButton;
    Edit1: TEdit;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    procedure bttCancelarClick(Sender: TObject);
    procedure bttSalvarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormShow(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmPersonalizar: TfrmPersonalizar;

implementation

uses
  UPrincipal;

{$R *.lfm}

{ TfrmPersonalizar }

procedure TfrmPersonalizar.FormShow(Sender: TObject);           // SHOW
var
  cabecalho : TStringList;
begin
  cabecalho := TStringList.Create;
  cabecalho.LoadFromFile('bin/cabecalho');

  Edit1.Text := cabecalho[0];

  cabecalho.Free;
end;

procedure TfrmPersonalizar.bttSalvarClick(Sender: TObject);     // BTT SALVAR
var
  cabecalho : TStringList;
begin
  cabecalho := TStringList.Create;
  cabecalho.LoadFromFile('bin/cabecalho');

  cabecalho[0] := Edit1.Text;
  frmPrincipal.Label9.Caption := Edit1.Text;

  cabecalho.SaveToFile('bin/cabecalho');
  cabecalho.Free;

  self.Close;
end;

procedure TfrmPersonalizar.bttCancelarClick(Sender: TObject);   // BTT CANCELAR
begin
  self.Close;
end;

procedure TfrmPersonalizar.FormClose(Sender: TObject;           // FIM
  var CloseAction: TCloseAction);
begin
  CloseAction:=caFree;
end;

end.

