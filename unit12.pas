unit Unit12;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, SQLDB, DB, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  DBGrids, StdCtrls, MaskEdit;

type

  { TForm12 }

  TForm12 = class(TForm)
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    Image4: TImage;
    Image5: TImage;
    Label10: TLabel;
    Label11: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label9: TLabel;
    lblEntre: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    SQLQuery1: TSQLQuery;
    SQLTransaction1: TSQLTransaction;
    tcategoria: TComboBox;
    tdata: TMaskEdit;
    tdetalhes: TEdit;
    tfornecedor: TEdit;
    tpagamento: TEdit;
    tservico: TEdit;
    tvalor: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure Image2Click(Sender: TObject);
    procedure Image4Click(Sender: TObject);
    procedure Image5Click(Sender: TObject);
    procedure Panel4Click(Sender: TObject);
  private

  public

  end;

var
  Form12: TForm12;

implementation

uses
  unit7;

{$R *.lfm}

{ TForm12 }

procedure TForm12.Image1Click(Sender: TObject);
begin
   if (tservico.Text = '') then
  begin
    ShowMessage('Por favor, insira o Serviço.');
    Exit;
  end;
   with SQLQuery1 do
  begin
    close;
    sql.clear;
    sql.add('insert into gastos (categoria, servico, data, valor, forma_pagamento, detalhes, fornecedor)');
    sql.add('values (:pcategoria, :pservico, :pdata, :pvalor, :ppagamento, :pdetalhes, :pfornecedor)');
    ParamByName('pcategoria').AsString:= tcategoria.text;
    ParamByName('pservico').AsString:= tservico.text;
    ParamByName('pdata').AsDate:= strtodate (tdata.text);
    ParamByName('pvalor').AsString:= tvalor.text;
    ParamByName('ppagamento').AsString:= tpagamento.text;
    ParamByName('pdetalhes').AsString:= tdetalhes.text;
    ParamByName('pfornecedor').AsString:= tdetalhes.text;
    ExecSQL;
    SQLTransaction1.Commit;
  end;
  with SQLQuery1 do
  begin
    close;
    sql.clear;
    sql.add('select * from gastos');
    open;
    Last;
  end;
end;

procedure TForm12.FormCreate(Sender: TObject);
begin
    // Ativar a consulta
    SQLQuery1.Open;

    // Atribuir DataSource ao TDBGrid
    DBGrid1.DataSource := DataSource1;
end;

procedure TForm12.Image2Click(Sender: TObject);
begin
  if (tservico.Text = '') then
  begin
    ShowMessage('Por favor, insira o ID do registro a ser deletado.');
    Exit;
  end;

  with SQLQuery1 do
  begin
    close;
    sql.clear;
    sql.add('delete from gastos where servico = :pservico');
    ParamByName('pservico').AsInteger := StrToInt(tservico.text);
    ExecSQL;
    SQLTransaction1.Commit;
  end;

  with SQLQuery1 do
  begin
    close;
    sql.clear;
    sql.add('select * from gastos');
    open;
    Last;
  end;
end;

procedure TForm12.Image4Click(Sender: TObject);
begin
  Form8.Left := Form12.Left;
  Form8.Top := Form12.Top;
  Form8.Width := Form12.Width;
  Form8.Height := Form12.Height;
  if Form12.WindowState = wsMaximized then
    Form8.WindowState := wsMaximized
  else
  Form8.WindowState := wsNormal;
  Form12.Hide;
  Form8.Show;
end;

procedure TForm12.Image5Click(Sender: TObject);
begin
  if (tservico.Text = '') then
  begin
    ShowMessage('Por favor, insira o Serviço.');
    Exit;
  end;

  with SQLQuery1 do
  begin
    close;
    sql.clear;
    sql.add('update gastos set categoria = :pcategoria, servico = :pservico, data = :pdata, valor = :pvalor, forma_pagamento = :ppagamento, detalhes = :pdetalhes, fornecedor = :pfornecedor');
    sql.add('where servico = :pservico');  // assuming you have an ID field to uniquely identify the record
    ParamByName('pcategoria').AsString := tcategoria.text;
    ParamByName('pservico').AsString := tservico.text;
    ParamByName('pdata').AsDate := strtodate(tdata.text);
    ParamByName('pvalor').AsString := tvalor.text;
    ParamByName('ppagamento').AsString := tpagamento.text;
    ParamByName('pdetalhes').AsString := tdetalhes.text;
    ParamByName('pfornecedor').AsString := tdetalhes.text;
    ExecSQL;
    SQLTransaction1.Commit;
  end;

  with SQLQuery1 do
  begin
    close;
    sql.clear;
    sql.add('select * from gastos');
    open;
    Last;
  end;
end;

procedure TForm12.Panel4Click(Sender: TObject);
begin
  tservico.Caption := '';
  tvalor.Caption := '';
  tfornecedor.Caption := '';
  tdetalhes.Caption := '';
  tpagamento.Caption := '';
  tcategoria.Caption := '';
  tdata.Caption := '';
end;
end.

