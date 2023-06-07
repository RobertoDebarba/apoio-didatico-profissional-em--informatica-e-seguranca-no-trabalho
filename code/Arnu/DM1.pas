unit DMdb;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, mysql55conn, sqldb, FileUtil;

type

  { TDMdb }

  TDMdb = class(TDataModule)
    DBSemestral: TMySQL55Connection;
    SQLQuery1: TSQLQuery;
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  DMdb: TDMdb;

implementation

{$R *.lfm}

end.

