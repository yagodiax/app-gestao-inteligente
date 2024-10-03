unit Unit4;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, SQLDB, DB, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls, MaskEdit, DBGrids;

type

  { TForm4 }

  TForm4 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button4: TButton;
    Button7: TButton;
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
    Image3: TImage;
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
    SQLQuery1: TSQLQuery;
    SQLTransaction1: TSQLTransaction;
    tdata: TMaskEdit;
    tdetalhes: TEdit;
    ComboBox1: TComboBox;
    tnome: TEdit;
    tservico: TComboBox;
    tvalor: TEdit;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
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

procedure TForm4.Button1Click(Sender: TObject);
begin
   if (tnome.Text = '') then
  begin
    ShowMessage('Por favor, insira o nome da Loja.');
    Exit;
  end;
   with SQLQuery1 do
  begin
    close;
    sql.clear;
    sql.add('insert into vendas (loja, servico, data, valor, forma_pagamento, detalhes)');
    sql.add('values (:ploja, :pservico, :pdata, :pvalor, :pforma, :pdetalhes)');
    ParamByName('ploja').AsString:= tnome.text;
    ParamByName('pservico').AsString:= tservico.text;
    ParamByName('pdata').AsDate:= strtodate (tdata.text);
    ParamByName('pvalor').AsString:= tvalor.text;
    ParamByName('pforma').AsString:= ComboBox1.text;
    ParamByName('pdetalhes').AsString:= tdetalhes.text;
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
      ComboBox1.Text := FieldByName('forma_pagamento').AsString;
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

