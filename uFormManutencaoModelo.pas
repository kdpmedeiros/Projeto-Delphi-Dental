unit uFormManutencaoModelo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, ComCtrls, DB, DBTables, uDataModule,
  Mask, DBCtrls, uFormPrincipal,DBXpress, SqlTimSt,Math, DBClient, XPMenu;

type
  TFormManutencao = class(TForm)
    PnlBotoes: TPanel;
    BitBtnConfirmar: TBitBtn;
    BitBtnCancelar: TBitBtn;
    CheckBoxFecharTela: TCheckBox;
    DBNavegador: TDBNavigator;
    DS_Manutencao: TDataSource;
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure BitBtnCancelarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure CheckBoxFecharTelaClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    CDSCadastro : TClientDataset;
    iTipo : Integer;
    SQL : TStringList;
    XPMenuManutencao : TXPMenu;
    procedure InicializaTela(Tipo : Integer; CDSCadastro : TClientDataset);
  end;

var
  FormManutencao: TFormManutencao;


implementation

uses DateUtils, StrUtils, uFuncoes;

{$R *.dfm}

procedure TFormManutencao.InicializaTela(Tipo : Integer; CDSCadastro : TClientDataset);
begin
  iTipo := Tipo;
  if Tipo = 1 then //Inclusão
    Self.Caption := 'Incluindo ...'
  else if Tipo = 2 then //Alteração
    Self.Caption := 'Alterando ...';
  Self.CDSCadastro := CDSCadastro;
  DS_Manutencao.DataSet := CDSCadastro;
end;




procedure TFormManutencao.FormKeyPress(Sender: TObject; var Key: Char);
begin
  case ord(key) of

    VK_RETURN : begin
                  Self.Perform(WM_NEXTDLGCTL,0,0);
                  key := #0;
                end;
    VK_ESCAPE : begin
                  Self.Perform(WM_NEXTDLGCTL, 1 , 0 );
                  key := #0;
                end;
  end;
end;

procedure TFormManutencao.BitBtnCancelarClick(Sender: TObject);
begin
  close;
end;


procedure TFormManutencao.FormCreate(Sender: TObject);
begin
  SQL := TStringList.Create;
  XPMenuManutencao :=  TXPMenu.Create(Self);
  XPMenuManutencao.Active := False;
end;

procedure TFormManutencao.FormDestroy(Sender: TObject);
begin
  SQL.Free;
  if XPMenuManutencao <> nil then
  begin
    XPMenuManutencao.Active := False;
    XPMenuManutencao.Free;
  end;

end;

procedure TFormManutencao.FormShow(Sender: TObject);
begin
  XPMenuManutencao.Active := True;
  if iTipo = 2 then
    DBNavegador.Enabled := True;
end;

procedure TFormManutencao.CheckBoxFecharTelaClick(Sender: TObject);
begin
  if iTipo = 2 then
    DBNavegador.Enabled := (CheckBoxFecharTela.Checked = False);
end;

end.
