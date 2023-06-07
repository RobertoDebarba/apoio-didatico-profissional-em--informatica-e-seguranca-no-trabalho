unit UCobasPrewiew;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, Buttons,
  StdCtrls, ExtCtrls;

type

  { TfrmCobasPreview }

  TfrmCobasPreview = class(TForm)
    bttArnu: TBitBtn;
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    procedure bttArnuClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmCobasPreview: TfrmCobasPreview;

implementation

uses
  UCobas, UPrincipal;

{$R *.lfm}

{ TfrmCobasPreview }

procedure TfrmCobasPreview.bttArnuClick(Sender: TObject);                       // BTT INICIAR
begin
  Application.CreateForm(TfrmCobas, frmCobas);

  frmCobas.Show;
  frmPrincipal.Hide;
end;

procedure TfrmCobasPreview.FormClose(Sender: TObject;                            // SAIR
  var CloseAction: TCloseAction);
begin
  CloseAction := caFree;
end;

end.

