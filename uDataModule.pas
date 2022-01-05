unit uDataModule;

interface

uses
  SysUtils, Classes, DBXpress, DB, SqlExpr, FMTBcd, Provider, DBClient;

type
  TDataModulePrin = class(TDataModule)
    SQLConnectionPrin: TSQLConnection;
    SQLQueryExecuta: TSQLQuery;
    SQLQueryPesquisa: TSQLQuery;
    SQLQueryValida: TSQLQuery;
    DSPTotal: TDataSetProvider;
    CDSTemporaria: TClientDataSet;
    SQLTemporaria: TSQLDataSet;
  private
    { Private declarations }
  public
    { Public declarations }
    UsuarioLogado : Integer;
    LoginLogado   : String;
    UsuarioAdmin  : Integer;
  end;

var
  DataModulePrin: TDataModulePrin;

implementation

{$R *.dfm}


end.
