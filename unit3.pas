unit Unit3;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, SQLDB, DB, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls, DBGrids, MaskEdit, Buttons;

type

  { TForm3 }

  TForm3 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    ComboBox1: TComboBox;
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    lblEntre: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    SQLQuery1: TSQLQuery;
    tdata: TMaskEdit;
    tdata1: TMaskEdit;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private

  public

  end;

var
  Form3: TForm3;

implementation

uses
  unit2;

{$R *.lfm}

{ TForm3 }


procedure TForm3.Button1Click(Sender: TObject);
var
  startDate, endDate, comboBoxText: String;
  totalValue: Double;
begin
  startDate := tdata.Text;
  endDate := tdata1.Text;
  comboBoxText := ComboBox1.Text;

  SQLQuery1.Close;

  // Verifica se os campos de data estão preenchidos
  if (startDate = '') or (endDate = '') then
  begin
    ShowMessage('Por favor, preencha ambos os campos de data.');
    Exit;
  end;

  // Define a consulta com os parâmetros necessários
  SQLQuery1.SQL.Text := 'SELECT * FROM vendas WHERE data BETWEEN :startDate AND :endDate';

  if comboBoxText <> '' then
  begin
    SQLQuery1.SQL.Add(' AND servico = :comboBoxText');
    SQLQuery1.Params.ParamByName('comboBoxText').AsString := comboBoxText;
  end;

  SQLQuery1.Params.ParamByName('startDate').AsDate := StrToDate(startDate);
  SQLQuery1.Params.ParamByName('endDate').AsDate := StrToDate(endDate);

  // Executa a consulta
  SQLQuery1.Open;

  // Verifica se há registros retornados
  if SQLQuery1.IsEmpty then
  begin
    ShowMessage('Nenhum dado encontrado.');
    Label7.Caption := 'Total de valor: R$ 0,00';
    Label6.Caption := 'Total de registros: 0';
    Exit;
  end;

  // Conta os registros retornados
  Label6.Caption := IntToStr(SQLQuery1.RecordCount);

  // Soma os valores do campo 'valor'
  totalValue := 0;
  SQLQuery1.First;
  while not SQLQuery1.EOF do
  begin
    totalValue := totalValue + SQLQuery1.FieldByName('valor').AsFloat;
    SQLQuery1.Next;
  end;

  // Exibe o total de valores em Label7
  Label7.Caption := 'R$: ' + FormatFloat('0.00', totalValue);
end;

procedure TForm3.Button2Click(Sender: TObject);
begin
    Form2 := TForm2.Create(Self);
    try
      Form2.Left := Left;
      Form2.Top := Top;
      Hide;
      Form2.ShowModal;
    finally
      Form2.Free;
    end;
end;

procedure TForm3.FormCreate(Sender: TObject);
begin
  begin
  // Configura a consulta SQL para selecionar os valores desejados
  SQLQuery1.Close;
  SQLQuery1.SQL.Text := 'SELECT nome FROM servicos';
  SQLQuery1.Open;

  // Limpa o ComboBox antes de adicionar novos itens
  ComboBox1.Items.Clear;

  // Adiciona os valores retornados da consulta ao ComboBox
  while not SQLQuery1.EOF do
  begin
    ComboBox1.Items.Add(SQLQuery1.FieldByName('nome').AsString);
    SQLQuery1.Next;
  end;

  // Fecha a consulta
  SQLQuery1.Close;

  begin
  // Define a consulta original para o TDBGrid
  SQLQuery1.Close;
  SQLQuery1.SQL.Text := 'SELECT * FROM vendas';
  SQLQuery1.Open;
  end;
end
end;

end.
