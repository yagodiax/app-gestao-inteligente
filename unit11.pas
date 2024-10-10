unit Unit11;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, SQLDB, DB, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  DBGrids, StdCtrls, MaskEdit;

type

  { TForm11 }

  TForm11 = class(TForm)
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
    Image1: TImage;
    Image3: TImage;
    Image4: TImage;
    Image5: TImage;
    Image6: TImage;
    Image7: TImage;
    Image8: TImage;
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
    tpagamento: TComboBox;
    tservico: TComboBox;
    tvalor: TEdit;
    procedure Image1Click(Sender: TObject);
    procedure Image5Click(Sender: TObject);
    procedure Image6Click(Sender: TObject);
    procedure Image7Click(Sender: TObject);
    procedure Image8Click(Sender: TObject);
    procedure Panel6Click(Sender: TObject);
  private

  public

  end;

var
  Form11: TForm11;

implementation

{$R *.lfm}

{ TForm11 }

procedure TForm11.Image1Click(Sender: TObject);
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

procedure TForm11.Image5Click(Sender: TObject);
begin
  Panel6Click(Sender);
end;

procedure TForm11.Image6Click(Sender: TObject);
begin

end;

procedure TForm11.Image7Click(Sender: TObject);
begin

end;

procedure TForm11.Image8Click(Sender: TObject);
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
    sql.add('update vendas set servico = :pservico, data = :pdata, valor = :pvalor, forma_pagamento = :pforma, detalhes = :pdetalhes');
    sql.add('where id = :ploja');
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

procedure TForm11.Panel6Click(Sender: TObject);
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

end.

