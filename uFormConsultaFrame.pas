unit uFormConsultaFrame;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, StdCtrls, Buttons, ExtCtrls, DB, DBClient, uDataModule,
  Provider, FMTBcd, SqlExpr, ADODB,TAdvEditP;

type
  TCampos = record
    Campo         : String;
    Chave         : Boolean;
    Tamanho       : Integer;
    Descricao     : String;
    Visivel       : Boolean;
    Formato       : String;
    CampoOrdem    : Boolean;
    CampoDestaque : Boolean;
  end;

  TCamposPesquisa = record
    Index : Integer;
    Campo : String;
    Tipo  : TDataType;
  end;

  TFormConsultaFrame = class(TForm)
    PnlBotoes: TPanel;
    BitBtnConfirmar: TSpeedButton;
    BitBtnCancelar: TSpeedButton;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    BitBtnConsulta: TSpeedButton;
    ComboBoxTipoPesquisa: TComboBox;
    EditConsulta: TEdit;
    DBGridPesquisa: TDBGrid;
    SpeedButtonManutencao: TSpeedButton;
    CDSPesquisa: TClientDataSet;
    DSPesquisa: TDataSource;
    DSPPesquisa: TDataSetProvider;
    SQLQueryPesquisa: TSQLQuery;
    Label2: TLabel;
    procedure CDSPesquisaAfterOpen(DataSet: TDataSet);
    procedure BitBtnConfirmarClick(Sender: TObject);
    procedure BitBtnCancelarClick(Sender: TObject);
    procedure SpeedButtonManutencaoClick(Sender: TObject);
    procedure DBGridPesquisaDblClick(Sender: TObject);
    procedure BitBtnConsultaClick(Sender: TObject);
    procedure EditConsultaKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure DBGridPesquisaTitleClick(Column: TColumn);
    procedure EditConsultaChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure DBGridPesquisaDrawColumnCell(Sender: TObject;
      const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    Campos : array of TCampos;
    CamposPesq : array of TCamposPesquisa;
    CampoAlimentar : TEdit;
    OrdemSelecionada : Integer;
    CampoDestaque  : String;
    function PegarCampoChave : String;
    procedure AlimentarCombo(Combo : TComboBox; CampoOrdem : String);
    function Pesquisar : Boolean;
  public
    { Public declarations }
    FormManutencao : TForm;
    FormClass      : TComponentClass;
    procedure MontarConsulta(ConteudoSelect : TStrings; var Campo : TAdvEdit);
    procedure AddCampo(Campo, Descricao : String; Tamanho : Integer; Visivel  : Boolean; Chave : Boolean = False; Formato : String = ''; CampoOrdem : Boolean = False; CampoDestaque : Boolean = False);
  end;

var
  FormConsultaFrame: TFormConsultaFrame;

implementation

{$R *.dfm}

Uses uFuncoes;

procedure TFormConsultaFrame.MontarConsulta(ConteudoSelect : TStrings; var Campo : TAdvEdit);
begin      
  with CDSPesquisa do
  begin
    Close;
    CommandText := ConteudoSelect.Text;
    Open;
  end;
  CampoAlimentar := Campo;
end;

procedure TFormConsultaFrame.AddCampo(Campo, Descricao : String; Tamanho : Integer; Visivel  : Boolean; Chave : Boolean = False; Formato : String = ''; CampoOrdem : Boolean = False; CampoDestaque : Boolean = False);
begin
  if High(Campos) < 0 then
    SetLength(Campos,2)
  else
    SetLength(Campos,High(Campos) + 2);

  Campos[High(Campos)].Campo         := Campo;
  Campos[High(Campos)].Chave         := Chave;
  Campos[High(Campos)].Descricao     := Descricao;
  Campos[High(Campos)].Tamanho       := Tamanho;
  Campos[High(Campos)].Visivel       := Visivel;
  Campos[High(Campos)].Formato       := Formato;
  Campos[High(Campos)].CampoOrdem    := CampoOrdem;
  Campos[High(Campos)].CampoDestaque := CampoDestaque;
end;

procedure TFormConsultaFrame.CDSPesquisaAfterOpen(DataSet: TDataSet);
Var i, j : Integer;
    CampoOrdem : String;
begin
  CampoOrdem    := '';
  CampoDestaque := '';

  with CDSPesquisa do
  begin
    for i := 0 to FieldCount - 1 do
    begin
      Fields[i].Visible := False;

      for j := 0 to High(Campos) do
      begin
        if Fields[i].FieldName = Campos[j].Campo then
        begin
          Fields[i].Visible       := Campos[j].Visivel;
          Fields[i].DisplayWidth  := Campos[j].Tamanho;
          Fields[i].DisplayLabel  := Campos[j].Descricao;
          if Campos[j].Chave then
            Fields[i].ProviderFlags := [pfInKey];
          if Campos[j].Formato <> '' then
            (Fields[i] as TNumericField).DisplayFormat := Campos[j].Formato;
          if (Campos[j].CampoOrdem) and (CampoOrdem = '') then
            CampoOrdem := Campos[j].Descricao;
          if (Campos[j].CampoDestaque) and (CampoDestaque = '') then
            CampoDestaque := Campos[j].Campo;
        end;
      end;
    end;
  end;
  AlimentarCombo(ComboBoxTipoPesquisa, CampoOrdem);
end;

procedure TFormConsultaFrame.BitBtnConfirmarClick(Sender: TObject);
begin
  CampoAlimentar.Text := CDSPesquisa.FieldByName(PegarCampoChave).AsString;
  if Assigned(CampoAlimentar.OnExit) then
    CampoAlimentar.OnExit(CampoAlimentar);
  Close;
end;

function TFormConsultaFrame.PegarCampoChave : String;
Var i : Integer;
begin
  for i := 0 to High(Campos) do
  begin
    if Campos[i].Chave then
    begin
      Result := Campos[i].Campo;
      Break;
    end;
  end; 
end;

procedure TFormConsultaFrame.BitBtnCancelarClick(Sender: TObject);
begin
  Close;
end;

procedure TFormConsultaFrame.SpeedButtonManutencaoClick(Sender: TObject);
begin
  if Assigned(FormClass) then
  begin
    Try
      Application.CreateForm(FormClass, FormManutencao);
      FormManutencao.Visible   := False;
      FormManutencao.ShowModal;
    Finally
      with CDSPesquisa do
      begin
        Close;
        Open;
      end;
      FormManutencao.Free;
    end;
  end;
end;

procedure TFormConsultaFrame.DBGridPesquisaDblClick(Sender: TObject);
begin
  BitBtnConfirmar.OnClick(BitBtnConfirmar);
end;

procedure TFormConsultaFrame.AlimentarCombo(Combo : TComboBox; CampoOrdem : String);
Var i, Indice : Integer;
begin
  Combo.Items.Clear;
  with CDSPesquisa do
  begin
    for i := 0 to Fields.Count - 1 do
    begin
      if Fields[i].Visible then
      begin
        Indice := Combo.Items.Add(Fields[i].DisplayLabel);
        if High(CamposPesq) < 0 then
          SetLength(CamposPesq,2)
        else               
          SetLength(CamposPesq,High(CamposPesq) + 2);

        CamposPesq[Indice].Index := Indice;
        CamposPesq[Indice].Campo := Fields[i].FieldName;
        CamposPesq[Indice].Tipo  := Fields[i].DataType;
      end;
    end;
  end;

  if CampoOrdem <> '' then
  begin
    if Combo.Items.IndexOf(CampoOrdem) <> - 1 then
      Combo.ItemIndex := Combo.Items.IndexOf(CampoOrdem);
  end
  else
  begin
    if Combo.Items.IndexOf('Descrição') <> - 1 then
      Combo.ItemIndex := Combo.Items.IndexOf('Descrição')
    else if Combo.Items.IndexOf('Nome') <> - 1 then
      Combo.ItemIndex := Combo.Items.IndexOf('Nome')
    else
      Combo.ItemIndex := 0;
  end;   

end;


procedure TFormConsultaFrame.BitBtnConsultaClick(Sender: TObject);
begin
  if Pesquisar = False then
    MessageDlg('Registro não Encontrado!', mtInformation, [mbOk], 0);
end;

procedure TFormConsultaFrame.EditConsultaKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = #13 then
    DBGridPesquisa.OnDblClick(DBGridPesquisa);
end;

procedure TFormConsultaFrame.FormCreate(Sender: TObject);
begin
  OrdemSelecionada := -1;
end;

procedure TFormConsultaFrame.DBGridPesquisaTitleClick(Column: TColumn);
Var i : Integer;
begin
 if (not CDSPesquisa.Active) or (CDSPesquisa.IsEmpty) then
    Exit;

  if (Column.FieldName = '') then
    Exit;

  if CDSPesquisa.IndexFieldNames = '' then
    CDSPesquisa.IndexFieldNames := Column.FieldName
  else
  begin
    CDSPesquisa.IndexDefs.Clear;
    CDSPesquisa.IndexDefs.Add('idx' + Column.FieldName, Column.FieldName, [ixDescending]);
    CDSPesquisa.IndexName :=  'idx' + Column.FieldName;
  end;

  for I := 0 to DBGridPesquisa.Columns.Count - 1 do
    DBGridPesquisa.Columns[I].Title.Font.Style := [];


  Column.Title.Font.Style := [fsBold];

end;

procedure TFormConsultaFrame.EditConsultaChange(Sender: TObject);
begin
  Pesquisar;
end;

function TFormConsultaFrame.Pesquisar : Boolean;
begin
  Result := False;

  If Trim(EditConsulta.Text) <> '' then
  begin
    with CDSPesquisa do
    begin
      Result := CDSPesquisa.Locate(CamposPesq[ComboBoxTipoPesquisa.ItemIndex].Campo, EditConsulta.Text,[loCaseInsensitive, loPartialKey]);
    end;
  end;
end;


procedure TFormConsultaFrame.FormShow(Sender: TObject);
begin
  EditConsulta.SetFocus;
end;

procedure TFormConsultaFrame.DBGridPesquisaDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  if UpperCase(Column.FieldName) = CampoDestaque  then
  begin
    DBGridPesquisa.Canvas.Font.Color   := clRed;
    DBGridPesquisa.Canvas.Font.Style   := [fsBold];
    DBGridPesquisa.Canvas.FillRect(Rect);
    DBGridPesquisa.DefaultDrawColumnCell(Rect, DataCol, Column, State);
  end;
end;

procedure TFormConsultaFrame.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_F2 then
  begin
    EditConsulta.Clear;
    EditConsulta.SetFocus;
  end;
end;

procedure TFormConsultaFrame.FormKeyPress(Sender: TObject; var Key: Char);
begin
  case ord(key) of
    VK_ESCAPE : begin
                  Self.Perform(WM_NEXTDLGCTL, 1 , 0 );
                  key := #0;
                end;
  end;
end;

end.
