unit Unit4;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, SQLDB, DB, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls, MaskEdit, DBGrids;

type

  { TForm4 }

  TForm4 = class(TForm)
    Image6: TImage;
    tpagamento: TComboBox;
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    Image4: TImage;
    Image5: TImage;
    Label10: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    lblEntre: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel6: TPanel;
    SQLQuery1: TSQLQuery;
    SQLTransaction1: TSQLTransaction;
    tdata: TMaskEdit;
    tdetalhes: TEdit;
    tnome: TEdit;
    tservico: TComboBox;
    tvalor: TEdit;
    procedure Button2Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure Image2Click(Sender: TObject);
    procedure Image4Click(Sender: TObject);
    procedure Image5Click(Sender: TObject);
    procedure Image6Click(Sender: TObject);
    procedure Panel6Click(Sender: TObject);
    procedure tservicoChange(Sender: TObject);
  private

  public

  end;

var
  Form4: TForm4;

implementation

uses
  unit2;

{$R *.lfm}

{ TForm4 }


procedure TForm4.Button2Click(Sender: TObject);
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

procedure TForm4.Button4Click(Sender: TObject);
var
  searchValue: String;
  isNumber: Boolean;
  idValue: Integer;
begin
  searchValue := tnome.Text;

  if searchValue = '' then
  begin
    ShowMessage('Por favor, insira o nome ou ID da Loja.');
    Exit;
  end;

  isNumber := TryStrToInt(searchValue, idValue);

  with SQLQuery1 do
  begin
    Close;
    SQL.Clear;

    if isNumber then
    begin
      SQL.Add('SELECT loja, servico, data, valor, forma_pagamento, detalhes FROM vendas WHERE id = :pid');
      ParamByName('pid').AsInteger := idValue;
    end
    else
    begin
      SQL.Add('SELECT loja, servico, data, valor, forma_pagamento, detalhes FROM vendas WHERE loja = :ploja');
      ParamByName('ploja').AsString := searchValue;
    end;

    Open;

    if not IsEmpty then
    begin
      tservico.Text := FieldByName('servico').AsString;
      tdata.Text := DateToStr(FieldByName('data').AsDateTime);
      tvalor.Text := FieldByName('valor').AsString;
      tpagamento.Text := FieldByName('forma_pagamento').AsString;
      tdetalhes.Text := FieldByName('detalhes').AsString;
    end
    else
    begin
      ShowMessage('Nenhum dado encontrado para o critério de pesquisa informado.');
    end;
  end;
end;

procedure TForm4.FormCreate(Sender: TObject);
begin
  // Configura a Panel6 SQL para selecionar os valores desejados
  SQLQuery1.Close;
  SQLQuery1.SQL.Text := 'SELECT nome FROM servicos';
  SQLQuery1.Open;

  // Limpa o ComboBox antes de adicionar novos itens
  tservico.Items.Clear;

  // Adiciona os valores retornados da Panel6 ao ComboBox
  while not SQLQuery1.EOF do
  begin
    tservico.Items.Add(SQLQuery1.FieldByName('nome').AsString);
    SQLQuery1.Next;
  end;

  // Fecha a Panel6
  SQLQuery1.Close;

  // Define a Panel6 original para o TDBGrid
  SQLQuery1.Close;
  SQLQuery1.SQL.Text := 'SELECT * FROM vendas';
  SQLQuery1.Open;

  // Insere a data atual no campo tdata
  tdata.Text := DateToStr(Now);
end;

procedure TForm4.Image1Click(Sender: TObject);
var
  valorFormatado: String;
begin
  if (tnome.Text = '') then
  begin
    ShowMessage('Por favor, insira o nome da Loja.');
    Exit;
  end;

  valorFormatado := StringReplace(tvalor.Text, ',', '.', [rfReplaceAll]);

  with SQLQuery1 do
  begin
    close;
    sql.clear;
    sql.add('insert into vendas (loja, servico, data, valor, forma_pagamento, detalhes)');
    sql.add('values (:ploja, :pservico, :pdata, :pvalor, :pforma, :pdetalhes)');
    ParamByName('ploja').AsString := tnome.Text;
    ParamByName('pservico').AsString := tservico.Text;
    ParamByName('pdata').AsDate := StrToDate(tdata.Text);
    ParamByName('pvalor').AsString := valorFormatado;
    ParamByName('pforma').AsString := tpagamento.Text;
    ParamByName('pdetalhes').AsString := tdetalhes.Text;
    ExecSQL;
    SQLTransaction1.Commit;
  end;

  with SQLQuery1 do
  begin
    close;
    sql.clear;
    sql.add('select * from vendas');
    open;
    Last;
  end;
end;

procedure TForm4.Image2Click(Sender: TObject);
begin
  tnome.Caption := '';
  tservico.Caption := '';
  tdata.Caption := '';
  tdetalhes.Caption := '';
  tpagamento.Caption := '';
  tvalor.Caption := '';
end;

procedure TForm4.Image4Click(Sender: TObject);
begin

end;

procedure TForm4.Image5Click(Sender: TObject);
begin
  Panel6Click(Sender);
end;

procedure TForm4.Image6Click(Sender: TObject);
begin
    with SQLQuery1 do
  begin
    close;
    sql.clear;
    sql.add('select * from vendas');
    open;
    Last;
  end;
end;

procedure TForm4.Panel6Click(Sender: TObject);
begin
   if tnome.Text = '' then
  begin
    ShowMessage('Por favor, insira o nome da Loja para filtrar.');
    Exit;
  end;

  with SQLQuery1 do
  begin
    close;
    sql.clear;
    sql.add('select * from vendas where loja = :ploja');
    ParamByName('ploja').AsString := tnome.Text;
    open;
  end;

  if SQLQuery1.IsEmpty then
  begin
    ShowMessage('Nenhum resultado encontrado para a loja especificada.');
  end;
end;

procedure TForm4.tservicoChange(Sender: TObject);
begin
  with SQLQuery1 do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT valor FROM servicos WHERE nome = :pservico');
    ParamByName('pservico').AsString := tservico.Text;
    Open;
    if not EOF then
    begin
      tvalor.Text := FieldByName('valor').AsString;
    end
    else
    begin
      ShowMessage('Serviço não encontrado.');
    end;
  end;
  with SQLQuery1 do
  begin
    close;
    sql.clear;
    sql.add('select * from vendas');
    open;
    Last;
  end;
end;

end.

