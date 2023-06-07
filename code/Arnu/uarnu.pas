unit UArnu;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, IpHtml, Ipfilebroker, Forms, Controls, Graphics,
  Dialogs, Buttons, StdCtrls, ExtCtrls, math;

type

  { TfrmArnu }

  TfrmArnu = class(TForm)
    BitBtn1: TBitBtn;
    bttRegras: TBitBtn;
    Edit1: TEdit;
    Edit2: TEdit;
    Image2: TImage;
    IpFileDataProvider1: TIpFileDataProvider;
    IpHtmlPanel1: TIpHtmlPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Panel1: TPanel;
    panelCorpo: TPanel;
    Panel2: TPanel;
    procedure BitBtn1Click(Sender: TObject);
    procedure bttRegrasClick(Sender: TObject);
    function calcular : integer;
    procedure Edit1KeyPress(Sender: TObject; var Key: char);
    procedure Edit2KeyPress(Sender: TObject; var Key: char);
    procedure ExibirResultado;
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormShow(Sender: TObject);
    function procurarPonto : boolean;
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  frmArnu: TfrmArnu;

implementation


uses
  UNormas, UPrincipal;

{$R *.lfm}

{ TfrmArnu }

// INICIO -------------------------------------------------------------------------------------------------------------

procedure TfrmArnu.FormShow(Sender: TObject);
var
  cabecalho : TStringList;
begin
  cabecalho := TStringList.Create;
  cabecalho.LoadFromFile('/home/roberto/Dropbox/Semestral/Projeto/bin/cabecalho');

  Label9.Caption := cabecalho[0];

  cabecalho.Free;

  Application.CreateForm(TfrmNormas, frmNormas);  // Cria form filho
end;

// Previsão de erros --------------------------------------------------------------------------------------------------

function TfrmArnu.procurarPonto : boolean;
var
  x : integer;
  i : char;

begin
  for x := 1 to LengTh(Edit1.Text) do
    begin
      i := Edit1.Text[x];
      if i = '.' then
        Result := true;
    end;
end;

procedure TfrmArnu.Edit1KeyPress(Sender: TObject; var Key: char);    // Edit1
begin
  {if (LengTh(Edit1.Text) > 14) and (Key <> #8) then
    Key := #0;
              }
  if not (Key in ['0'..'9', '.', ',', #8]) then
    Key := #0;

  if (Key = ',') then
    Key := '.';

  if (Key = '.') and (Edit1.Text = '')then
    Key := #0;

  if (Key = '.') and (procurarPonto) then
  begin
    Key := #0;
  end;
end;

procedure TfrmArnu.Edit2KeyPress(Sender: TObject; var Key: char);    // Edit2
begin
  if not (Key in ['0'..'9', #8]) then
    Key := #0;
end;

// Botão --------------------------------------------------------------------------------------------------------------

procedure TfrmArnu.BitBtn1Click(Sender: TObject);       // Arredondar -----------------------------
var
  valor : real;
  casas : integer;

begin
  if (Edit1.Text <> '') and (Edit2.Text <> '') then  // Erro - Campo vazio
  begin
    if (procurarPonto) then                          // Erro - sem ponto
    begin
      ExibirResultado;     // Descobrir norma. Resultado apenas para exibição, não interfere no calculo;

      valor := StrToFloat(Edit1.Text);        // Label para VAR
      casas := StrToInt(Edit2.Text);

      Label1.Caption := FloatToStr(RoundTo(valor, -(casas)));    // Calculo de arredondamento
    end
    else
      ShowMessage('Nenhuma casa decimal encontrada!');
  end
  else
    ShowMessage('Os campos devem conter algum valor!');
end;

procedure TfrmArnu.bttRegrasClick(Sender: TObject);     // Normas ---------------------------------
begin
  frmNormas.Show;
  frmNormas.Parent := panelCorpo;
end;

// Exibe resultado ----------------------------------------------------------------------------------------------------

procedure TfrmArnu.ExibirResultado;      // Chama procedure de calculo;
var
  resultado, x, i, QG1 : integer;
  arq : TextFile;

begin
  resultado := Calcular;     // Atribui resultado à variavel para não chamar procedure Calcular varias vezes;

  AssignFile(arq, 'Arnu/bin/index.html');
  ReWrite(arq);

  WriteLn(arq, '<html>');
  WriteLn(arq, '<head><meta http-equiv="content-type" content="text/html; charset=ANSI"></head>');
  WriteLn(arq, '<body>');

  if resultado = 1 then
  begin
    // Exibir norma 1
    WriteLn(arq, '1ª Norma: quando o primeiro algarismo a ser <font color="orange">abandonado</font> for 0, 1, 2, 3 ou 4, fica inalterado o último algarismo a <font color="green">permanecer</font>.');
  end
  else if resultado = 2 then
  begin
    // Exibir norma 2
    WriteLn(arq, '2ª Norma: quando o primeiro algarismo a ser <font color="orange">abandonado</font> for 6, 7, 8 ou 9, aumenta-se em uma unidade o último algarismo a <font color="green">permanecer</font>.');
  end
  else if resultado = 3 then
  begin
    // Exibir norma 3
    WriteLn(arq, '3ª Norma: quando o primeiro algarismo a ser <font color="orange">abandonado</font> for 5 e este for seguido de algum número distinto de zero, aumenta-se em uma unidade o último algarismo a <font color="green">permanecer</font>.');
  end
  else if resultado = 4 then
  begin
    // Exibir norma 4
    WriteLn(arq, '4ª Norma: quando o primeiro algarismo a ser <font color="orange">abandonado</font> for 5 e este for seguido apenas por zeros, o último algarismo a ser <font color="green">conservado</font> será aumentado se for ímpar.');
  end;

  WriteLn(arq, '<br>');
  WriteLn(arq, '<br>');
  WriteLn(arq, '<br>');
  WriteLn(arq, '<br>');
  WriteLn(arq, '<center>');
  WriteLn(arq, '<table cellspacing="0" cellpadding="2">');
  WriteLn(arq, '<tr>');
  for x := 1 to LengTh(Edit1.Text) do                     // Preenche numeros
  begin
    WriteLn(arq, '<td><font size="6">' + Edit1.Text[x] + '</td>');
  end;
  WriteLn(arq, '</tr>');
  WriteLn(arq, '<tr>');

  for x := 1 to LengTh(Edit1.Text) do     // Marca posisão do . <ponto>
  begin
    if Edit1.Text[x] = '.' then
      i := x;                             // i = <ponto>
  end;

  for x := 1 to (i + StrToInt(Edit2.Text) - 1) do                //Azul
    WriteLn(arq, '<td bgcolor="blue" height="3"></td>');

  WriteLn(arq, '<td bgcolor="green" height="3"></td>');      // Verde
  WriteLn(arq, '<td bgcolor="orange" height="3"></td>');     // Amarelo

  if Edit1.Text[i + StrToInt(Edit2.text) + 1] <> '5' then                  //Vermelho
  begin
    for x := (i + StrToInt(Edit2.text) + 1) to LengTh(Edit1.text) do
      WriteLn(arq, '<td bgcolor="red" height="3"></td>');
  end
  else
  begin
    QG1 := 2;
    if Edit1.Text[i + StrToInt(Edit2.text) + 2] <> '0' then
      WriteLn(arq, '<td bgcolor="orange" height="3"></td>');
      QG1 := 3;
    for X := (i + StrToInt(Edit2.text) + QG1) to LengTh(Edit1.text) + 1 do
      WriteLn(arq, '<td bgcolor="red" height="3"></td>');
  end;

  WriteLn(arq, '</tr>');
  WriteLn(arq, '</table>');
  WriteLn(arq, '</body>');
  WriteLn(arq, '</html>');

  CloseFile(arq);

  //HTMLViewer1.LoadFromFile('bin/index.html');
  IpHtmlPanel1.OpenURL(ExpandLocalHtmlFileName('Arnu/bin/index.html'));
end;

// Calculo ------------------------------------------------------------------------------------------------------------

function TfrmArnu.calcular : integer;
var
  casas, contador, contadorInteiro, x, referencia : integer;
  a : char;
  resto : string;

begin
  // Contador de casas decimais ------------------------------------------------
  casas := StrToInt(Edit2.Text);
  contador := 0;
  for x := 1 to LengTh(Edit1.text) do
  begin
    a :=  Edit1.text[x];

    inc(contador);
    if a = '.' then
    begin
      ContadorInteiro{numeros inteiro + ponto} := contador;
      contador{numero decimais} := 0;
    end;
  end;

  // Verifica se numero de decimais é mais que valor digitado para permanecer --

  if (contador <= casas) then
  begin
    ShowMessage('Número de casas decimais insuficientes para arredondamento!');
    abort;
  end;

  // Identificador de norma ----------------------------------------------------

  referencia := contadorInteiro + casas + 1; // Define posicao a ser analisada

  if (StrToInt(Edit1.text[referencia]) < 5) then      // Norma 1
  begin
    Result := 1;
  end
  else if (StrToInt(Edit1.text[referencia]) > 5) then // Norma 2
  begin
    Result := 2;
  end
  else if (StrToInt(Edit1.text[referencia]) = 5) then // +  +  +  +  +
  begin
    resto := '';

    for x := (referencia + 1) to LengTh(Edit1.text) do  // Captura numeros apos 5
    begin
      resto := resto + Edit1.text[x];
    end;

    if resto = '' then        // Atribui valor caso não tenha numeros apos 5. Necessario para nao travar proximo passo;
      resto := '0';
    //

    if StrToInt(resto) <> 0 then     // Norma 3
    begin
      Result := 3;
    end
    else                             // Norma 4
    begin
      Result := 4;
    end;
  end;

end;

// SAIR --------------------------------------------------------------------------------------------------

procedure TfrmArnu.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  frmNormas.Free; // Mata form filho

  frmPrincipal.Show;
  CloseAction := caFree;
end;

end.

