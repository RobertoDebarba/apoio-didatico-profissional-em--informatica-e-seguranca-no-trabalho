unit UArnuPreview;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, Buttons,
  ExtCtrls, StdCtrls;

type

  { TfrmArnuPreview }

  TfrmArnuPreview = class(TForm)
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
  frmArnuPreview: TfrmArnuPreview;

implementation

uses
  UArnu, UPrincipal;

{$R *.lfm}

{ TfrmArnuPreview }

procedure TfrmArnuPreview.bttArnuClick(Sender: TObject);
begin
  Application.CreateForm(TfrmArnu, frmArnu);

  frmArnu.Show;
  frmPrincipal.Hide;
end;

procedure TfrmArnuPreview.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
  CloseAction := caFree;
end;

end.

