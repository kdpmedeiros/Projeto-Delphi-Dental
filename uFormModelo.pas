unit uFormModelo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, StdCtrls, ExtCtrls, Grids, DBGrids, FMTBcd, SqlExpr,
  Provider, DB, DBClient, uDataModule, ComCtrls, AdoDb, TAdvEditP, XPMenu, MaskUtils;

type
  TCampos = record
    Index   : Integer;
    Campo   : String;
    Tipo    : TDataType;
    Visivel : Boolean;
  end;

  TFormModelo = class(TForm)
    Panel1: TPanel;
    Panel4: TPanel;
    GroupBoxCabecalho: TGroupBox;
    Label1: TLabel;
    ComboBoxTipoPesquisa: TComboBox;
    EditConsulta: TAdvEdit;
    DS_Principal: TDataSource;
    CDSPrincipal: TClientDataSet;
    DSPPrincipal: TDataSetProvider;
    SQLPrincipal: TSQLDataSet;
    BitBtnConsulta: TSpeedButton;
    BitBtnImprimir: TSpeedButton;
    pnl_prin: TPanel;
    DBGridPrin: TDBGrid;
    PnlBotoes: TPanel;
    BitBtnIncluir: TSpeedButton;
    BitBtnAlterar: TSpeedButton;
    BitBtnExcluir: TSpeedButton;
    Panel3: TPanel;
    BitBtnFechar: TSpeedButton;
    procedure BitBtnFecharClick(Sender: TObject);
    procedure EditConsultaKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure DBGridPrinDblClick(Sender: TObject);
    procedure CDSPrincipalAfterOpen(DataSet: TDataSet);
    procedure BitBtnConsultaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure DBGridPrinTitleClick(Column: TColumn);
    procedure CDSPrincipalAfterClose(DataSet: TDataSet);
    procedure EditConsultaChange(Sender: TObject);
    procedure BitBtnExcluirClick(Sender: TObject);

  private
    { Private declarations }
    PosicaoAnterior : TBookmark;
    Excluindo, CriandoForm : Boolean;

    function Pesquisar : Boolean;
  public
    { Public declarations }
    SQL : TStringList;
    Campos : array of TCampos;
    XPMenuModelo : TXpMenu;
    OrdemSelecionada : Integer;
    procedure AlimentarCombo(Combo : TComboBox);
    procedure MostrarDados(Tabela : String; CamposEspeciais : String = '';
                           CampoOrdem : String = ''; Filtros : String = '');
    procedure ScrollMouse(var Msg: TMsg; var Handled: Boolean);
    procedure GetTextCPFCNPJ(Sender: TField; var Text: String; DisplayText: Boolean);
    procedure GetTextCEP(Sender: TField; var Text: String; DisplayText: Boolean);
  end;

var
  FormModelo: TFormModelo;

implementation

{$R *.dfm}

Uses uFuncoes;

procedure TFormModelo.BitBtnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TFormModelo.AlimentarCombo(Combo : TComboBox);
Var i : Integer;
begin
  Combo.Items.Clear;
  with CDSPrincipal do
  begin
    for i := 0 to Fields.Count - 1 do
    begin
      if Fields[i].Visible then
        Combo.Items.Add(Fields[i].DisplayLabel);

      if High(Campos) < 0 then
        SetLength(Campos,2)
      else
        SetLength(Campos,High(Campos) + 2);

      Campos[i].Index   := i;
      Campos[i].Campo   := Fields[i].FieldName;
      Campos[i].Tipo    := Fields[i].DataType;
      Campos[i].Visivel := Fields[i].Visible;
    end;
  end;
  Combo.ItemIndex := 0;
end;


procedure TFormModelo.EditConsultaKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = #13 then
    BitBtnConsulta.OnClick(BitBtnConsulta);
end;

procedure TFormModelo.FormCreate(Sender: TObject);
begin
  SQL := TStringList.Create;
  XPMenuModelo := TXPMenu.Create(Self);
  XPMenuModelo.Active       := True;
  Application.OnMessage     := ScrollMouse;
  OrdemSelecionada          := -1;
  Excluindo                 := False;
  CriandoForm               := True;
end;

procedure TFormModelo.FormDestroy(Sender: TObject);
begin
  SQL.Free;
  if XPMenuModelo <> nil then
  begin
    XPMenuModelo.Active := False;
    XPMenuModelo.Free;
  end;
end;

procedure TFormModelo.DBGridPrinDblClick(Sender: TObject);
begin
  if (BitBtnAlterar.Enabled) then
    BitBtnAlterar.OnClick(BitBtnAlterar);
end;

procedure TFormModelo.CDSPrincipalAfterOpen(DataSet: TDataSet);
begin
  if ComboBoxTipoPesquisa.ItemIndex = -1 then
    AlimentarCombo(ComboBoxTipoPesquisa);
  Excluindo := False;
  Try
    CDSPrincipal.GotoBookMark(PosicaoAnterior);
    CDSPrincipal.FreeBookMark(PosicaoAnterior);
  Except
    CDSPrincipal.Last;
    CDSPrincipal.FreeBookMark(PosicaoAnterior);
  end;
end;

procedure TFormModelo.BitBtnConsultaClick(Sender: TObject);
begin
  if Pesquisar = False then
    MessageDlg('Registro não Encontrado!', mtInformation, [mbOk], 0);
end;

procedure TFormModelo.MostrarDados(Tabela : String; CamposEspeciais : String = '';
                                   CampoOrdem : String = ''; Filtros : String = '');
begin
    
  with CDSPrincipal do
  begin
    DisableControls;
    SQL.Clear;
    SQL.Add(' Select ' + Tabela + '.*');
    SQL.Add(CamposEspeciais);
    SQL.Add(' from ' + Tabela);
    if Filtros <> '' then
      SQL.Add(Filtros);
    if CampoOrdem <> '' then
      SQL.Add(' Order by ' + CampoOrdem);

    Close;
    CommandText := SQL.Text;
    Open;
    EnableControls;
  end;
end;

procedure TFormModelo.FormShow(Sender: TObject);
begin
  Self.Left   := 2;
  Self.Top    := 48;
  Self.Height := 499;
  Self.Width  := 797;
  if EditConsulta.CanFocus then
    EditConsulta.SetFocus;
  
  if CriandoForm = False then
  begin
    VerifPermissoes;
    if DataModulePrin.SQLQueryPesquisa.Locate('NOMEFORM',Self.Name,[]) then
    begin
      BitBtnIncluir.Enabled := (DataModulePrin.SQLQueryPesquisa.FieldByName('INSERIR').asInteger = 1);
      BitBtnAlterar.Enabled := (DataModulePrin.SQLQueryPesquisa.FieldByName('ALTERAR').asInteger = 1);
      BitBtnExcluir.Enabled := (DataModulePrin.SQLQueryPesquisa.FieldByName('EXCLUIR').asInteger = 1);
    end;
  end;
  CriandoForm := False;
end;

procedure TFormModelo.ScrollMouse(var Msg: TMsg; var Handled: Boolean);
var 
  i: smallint; 
begin 
  if Msg.message = WM_MOUSEWHEEL then 
  begin 
    Msg.message := WM_KEYDOWN; 
    Msg.lParam := 0; 
    i := HiWord(Msg.wParam) ; 
    if i > 0 then 
      Msg.wParam := VK_UP 
    else 
      Msg.wParam := VK_DOWN; 
    Handled := False; 
  end; 
end;

procedure TFormModelo.GetTextCPFCNPJ(Sender: TField; var Text: String; DisplayText: Boolean);
begin
  if (TField(Sender).AsString <> '') and (TField(Sender).AsString <> '0') then
  begin
    if (Length(TField(Sender).AsString) <= 11) then {CPF}
      Text := FormatMaskText('!999\.999\.999\-99;0;',TField(Sender).AsString)
    else
      Text := FormatMaskText('!99\.999\.999\/9999\-99;0;',TField(Sender).AsString);
  end;
end;

procedure TFormModelo.GetTextCEP(Sender: TField; var Text: String; DisplayText: Boolean);
begin
  if (TField(Sender).AsString <> '') and (TField(Sender).AsString <> '0') then
    Text := FormatMaskText('99999\-999;0;_',TField(Sender).AsString);
end;



procedure TFormModelo.DBGridPrinTitleClick(Column: TColumn);
Var i : Integer;
begin
 if (not CDSPrincipal.Active) or (CDSPrincipal.IsEmpty) then
    Exit;

  if (Column.FieldName = '') then
    Exit;

  if CDSPrincipal.IndexFieldNames = '' then
    CDSPrincipal.IndexFieldNames := Column.FieldName
  else
  begin
    CDSPrincipal.IndexDefs.Clear;
    CDSPrincipal.IndexDefs.Add('idx' + Column.FieldName, Column.FieldName, [ixDescending]);
    CDSPrincipal.IndexName :=  'idx' + Column.FieldName;
  end;

  for I := 0 to DBGridPrin.Columns.Count - 1 do
    DBGridPrin.Columns[I].Title.Font.Style := [];

  Column.Title.Font.Style := [fsBold];
end;

function TFormModelo.Pesquisar : Boolean;
var
  PosicaoAnteriorPesq : TBookmark;
begin
  Result := False;

  Try
    If Trim(EditConsulta.Text) <> '' then
    begin
      CDSPrincipal.Locate(Campos[ComboBoxTipoPesquisa.ItemIndex].Campo,EditConsulta.Text,[loCaseInsensitive, loPartialKey])
      {with CDSPrincipal do
      begin
        PosicaoAnteriorPesq := GetBookMark;
        DisableControls;
        First;
        while Not EOF do
        begin
          If Pos(EditConsulta.Text,UpperCase(FieldByName(Campos[ComboBoxTipoPesquisa.ItemIndex].Campo).asString)) > 0 then
          begin
            Result := True;
            Break;
          end;
          Next;
        end;
        if Result = False then
          GotoBookMark(PosicaoAnteriorPesq);
        FreeBookMark(PosicaoAnteriorPesq);

        EnableControls;
      end;}
    end;
  Except
//    CDSPrincipal.FreeBookMark(PosicaoAnteriorPesq);
  end;
end;

procedure TFormModelo.CDSPrincipalAfterClose(DataSet: TDataSet);
begin
  if Excluindo = False then
    PosicaoAnterior := CDSPrincipal.GetBookmark;
end;

procedure TFormModelo.EditConsultaChange(Sender: TObject);
begin
  Pesquisar;
end;

procedure TFormModelo.BitBtnExcluirClick(Sender: TObject);
begin
  Excluindo       := True;
  PosicaoAnterior := CDSPrincipal.GetBookmark;
end;

end.



