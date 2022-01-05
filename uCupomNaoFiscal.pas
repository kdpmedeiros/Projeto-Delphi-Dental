unit uCupomNaoFiscal;

interface

uses  Classes, Forms, StdCtrls, ComCtrls,SysUtils, ExtCtrls;



function IniciaPorta(Porta:string):integer; stdcall; far; external 'Mp2032.dll';
function FechaPorta: integer	;  stdcall; far; external 'Mp2032.dll';
function BematechTX(BufTrans:string):integer; stdcall; far; external 'Mp2032.dll';
function FormataTX(BufTras:string; TpoLtra:integer; Italic:integer; Sublin:integer; expand:integer; enfat:integer):integer; stdcall; far; external 'Mp2032.dll';
function ComandoTX (BufTrans:string;TamBufTrans:integer):integer; stdcall; far; external 'Mp2032.dll';
function Status_Porta:integer; stdcall; far; external 'Mp2032.dll';
function AutenticaDoc(BufTras:string;Tempo:Integer):integer; stdcall; far; external 'Mp2032.dll';
function Le_Status:integer; stdcall; far; external 'Mp2032.dll';
function Le_Status_Gaveta:integer; stdcall; far; external 'Mp2032.dll';
function DocumentInserted:integer; stdcall; far; external 'Mp2032.dll';
function ConfiguraTamanhoExtrato(NumeroLinhas:Integer):integer; stdcall; far; external 'Mp2032.dll';
function HabilitaExtratoLongo(Flag:Integer):integer; stdcall; far; external 'Mp2032.dll';
function HabilitaEsperaImpressao(Flag:Integer):integer; stdcall; far; external 'Mp2032.dll';
function EsperaImpressao:integer; stdcall; far; external 'Mp2032.dll';
function ConfiguraModeloImpressora(ModeloImpressora:integer):integer; stdcall; far; external 'Mp2032.dll';
function AcionaGuilhotina(Modo:integer):integer; stdcall; far; external 'Mp2032.dll';
function HabilitaPresenterRetratil(Flag:Integer):integer; stdcall; far; external 'Mp2032.dll';
function ProgramaPresenterRetratil(Tempo:Integer):integer; stdcall; far; external 'Mp2032.dll';
function CaracterGrafico(Buffer: string; TamBuffer: integer):integer; stdcall; far; external 'Mp2032.dll';
function VerificaPapelPresenter():integer; stdcall; far; external 'Mp2032.dll';

{FUNÇÃO PARA CODIGO DE BARRAS}

//funções para impressão dos códigos de barras
Function ImprimeCodigoBarrasUPCA(Codigo : String) :Integer; stdcall; far; external 'Mp2032.dll';
Function ImprimeCodigoBarrasUPCE(Codigo : String) : Integer; stdcall; far; external 'Mp2032.dll';
Function ImprimeCodigoBarrasEAN13(Codigo : String) : Integer; stdcall; far; external 'Mp2032.dll';
Function ImprimeCodigoBarrasEAN8(Codigo : String) : Integer; stdcall; far; external 'Mp2032.dll';
Function ImprimeCodigoBarrasCODE39(Codigo : String) : Integer; stdcall; far; external 'Mp2032.dll';
Function ImprimeCodigoBarrasCODE93(Codigo : String) : Integer; stdcall; far; external 'Mp2032.dll';
Function ImprimeCodigoBarrasCODE128(Codigo : String) : Integer; stdcall; far; external 'Mp2032.dll';
Function ImprimeCodigoBarrasITF(Codigo : String) : Integer; stdcall; far; external 'Mp2032.dll';
Function ImprimeCodigoBarrasCODABAR(Codigo : String) : Integer; stdcall; far; external 'Mp2032.dll';
Function ImprimeCodigoBarrasISBN(Codigo : String) : Integer; stdcall; far; external 'Mp2032.dll';
Function ImprimeCodigoBarrasMSI(Codigo : String) : Integer; stdcall; far; external 'Mp2032.dll';
Function ImprimeCodigoBarrasPLESSEY(Codigo : String) : Integer; stdcall; far; external 'Mp2032.dll';
Function ImprimeCodigoBarrasPDF417(NivelCorrecaoErros , Altura , Largura , Colunas : Integer; Codigo : String) : Integer; stdcall; far; external 'Mp2032.dll';
Function ConfiguraCodigoBarras(Altura, Largura, PosicaoCaracteres, Fonte, Margem : Integer) : Integer; stdcall; far; external 'Mp2032.dll';

//Função para bitmaps
function ImprimeBmpEspecial(Nome: string; xScale : integer; yScale : integer; angle : integer) : Integer; stdcall; far; external 'Mp2032.dll';
function ImprimeBitmap(Nome: string; mode : integer) : Integer; stdcall; far; external 'Mp2032.dll';
function AjustaLarguraPapel(PaperWidth :  integer) : Integer; stdcall; far; external 'Mp2032.dll';
function SelectDithering (DitherType :  integer) : Integer; stdcall; far; external 'Mp2032.dll';
function ImprimePrn (nome : string; sleep :  integer) : Integer; stdcall; far; external 'Mp2032.dll';
procedure MostraStatus(MemoExterno : TMemo);





implementation

uses Windows, uFormCupom;



procedure MostraStatus(MemoExterno : TMemo);
begin
  MemoExterno.Clear;
  With FormCupom Do
  Begin
    TimerStatus.Enabled := False;
    Retorno := Le_Status;
    case retorno of
       0 : // imp. desligada ou cabo desc. na LPT
            if ( ComboBoxPorta.ItemIndex = 0 ) then
              MemoExterno.Text := '** Desligada ou Cabo Desconectado **'
            else // off-line na serial  E USB
              MemoExterno.Text := '** Off-line ou Fim de papel **';
      32 : // pouco papel e off-line na LPT
            if ( ComboBoxPorta.ItemIndex = 0 ) then
              MemoExterno.Text :='** Pouco papel e Off-Line **'
            else if ( (ComboBoxPorta.ItemIndex = 1) or (ComboBoxPorta.ItemIndex = 2) ) then// fim de papel na serial
              MemoExterno.Text := '** Off-line ou Fim de papel **'
            else //usb
              MemoExterno.Text := '** Fim de papel **';
      4 : // pouco papel e off-line na serial
           MemoExterno.Text :='** Pouco Papel e Off-line **';
      40 : // fim de papel na LPT
           MemoExterno.Text := '** Fim de papel **';
      5,  48 : // 5 = pouco papel serial e 48 na LPT
              MemoExterno.Text := '** Pouco Papel e On-line **';
      79 : // off-line na LPT
            MemoExterno.Text := '** Off-Line **';
      9, 128 : // 9 = head-up na serial e 128 na LPT
           MemoExterno.Text := 'Head Up';
      24, 144 : // 24 = on-line na serial e 144 na LPT
          MemoExterno.Text := '** Impressora Pronta **'; // 24 (COM) e 144 (LPT)
      65:
         if ( ComboBoxPorta.ItemIndex = 3 ) then
           MemoExterno.Text := '** Erro no Corte **' // 24 (COM) e 144 (LPT)
        Else //Se não for nenhum dos status acima
          MemoExterno.Text := '** Status desconhecido: ' + IntToStr(Retorno) + ' **';
      66:
         if ( ComboBoxPorta.ItemIndex = 3 ) then
           MemoExterno.Text := '** Temperatura da Cabeça **' // 24 (COM) e 144 (LPT)
        Else //Se não for nenhum dos status acima
          MemoExterno.Text := '** Status desconhecido: ' + IntToStr(Retorno) + ' **';
      67:
         if ( ComboBoxPorta.ItemIndex = 3 ) then
           MemoExterno.Text := '** Papel Enrroscado **' // 24 (COM) e 144 (LPT)
        Else //Se não for nenhum dos status acima
          MemoExterno.Text := '** Status Desconhecido: ' + IntToStr(Retorno) + ' **';
      68:
         if ( ComboBoxPorta.ItemIndex = 3 ) then
           MemoExterno.Text := '** Desligada ou Cabo Desconectado **' // 24 (COM) e 144 (LPT)
        Else //Se não for nenhum dos status acima
          MemoExterno.Text := '** Status Desconhecido: ' + IntToStr(Retorno) + ' **';
      69:
         if ( ComboBoxPorta.ItemIndex = 3 ) then
           MemoExterno.Text := '** Erro no Presenter **' // 24 (COM) e 144 (LPT)
        Else //Se não for nenhum dos status acima
          MemoExterno.Text := '** Status desconhecido: ' + IntToStr(Retorno) + ' **';
      70:
         if ( ComboBoxPorta.ItemIndex = 3 ) then
           MemoExterno.Text := '** Em Impressão **' // 24 (COM) e 144 (LPT)
        Else //Se não for nenhum dos status acima
          MemoExterno.Text := '** Status desconhecido: ' + IntToStr(Retorno) + ' **';
      Else //Se não for nenhum dos status acima
        MemoExterno.Text := '** Status desconhecido: ' + IntToStr(Retorno) + ' **';
    End;
    TimerStatus.Enabled := True;
  end;
end;




end.
