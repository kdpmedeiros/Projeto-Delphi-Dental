unit uFormConexao;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, TAdvEditP, ExtCtrls, Buttons;

type
  TFormConexao = class(TForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    PnlBotoes: TPanel;
    BitBtnConfirmar: TSpeedButton;
    BitBtnCancelar: TSpeedButton;
    Image1: TImage;
    EditServidor: TAdvEdit;
    Label2: TLabel;
    EditCaminho: TAdvEdit;
    Label3: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure BitBtnCancelarClick(Sender: TObject);
    procedure BitBtnConfirmarClick(Sender: TObject);
    procedure EditCaminhoKeyPress(Sender: TObject; var Key: Char);
    procedure EditServidorKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }

  public
    { Public declarations }
    Modal_Ok : Boolean;
  end;

var
  FormConexao: TFormConexao;

implementation

{$R *.dfm}

procedure TFormConexao.FormCreate(Sender: TObject);
begin
  Modal_Ok := False;
end;

procedure TFormConexao.BitBtnCancelarClick(Sender: TObject);
begin
  Modal_Ok := False;
  Close;
end;

procedure TFormConexao.BitBtnConfirmarClick(Sender: TObject);
begin
  if Trim(EditServidor.Text) = '' then
  begin
    MessageDlg('Preencha o Servidor!', mtInformation, [mbOk], 0);
    EditServidor.SetFocus;
    Exit;
  end;

  if Trim(EditCaminho.Text) = '' then
  begin
    MessageDlg('Preencha o Caminho do Banco!', mtInformation, [mbOk], 0);
    EditCaminho.SetFocus;
    Exit;
  end;
  Close;
  Modal_Ok := True;
end;

procedure TFormConexao.EditCaminhoKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
    BitBtnConfirmar.OnClick(BitBtnConfirmar);
end;

procedure TFormConexao.EditServidorKeyPress(Sender: TObject;
  var Key: Char);
begin
  case ord(key) of

    VK_RETURN : begin
                  Self.Perform(WM_NEXTDLGCTL,0,0);
                  key := #0;
                end;
  end;
end;

end.
