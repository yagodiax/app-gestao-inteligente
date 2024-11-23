unit Unit6;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, SQLDB, DB, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls, MaskEdit, DBGrids;

type

  { TForm6 }

  TForm6 = class(TForm)
    tcategoria: TComboBox;
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    Image4: TImage;
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
    SQLQuery1: TSQLQuery;
    SQLTransaction1: TSQLTransaction;
    tdata: TMaskEdit;
    tdetalhes: TEdit;
    tfornecedor: TEdit;
    tpagamento: TEdit;
    tvalor: TEdit;
    tservico: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure Image2Click(Sender: TObject);
    procedure Image4Click(Sender: TObject);
  private

  public

  end;

var
  Form6: TForm6;

implementation

uses
  unit2;

{$R *.lfm}

{ TForm6 }

procedure TForm6.Image4Click(Sender: TObject);
begin
    Form2 := TForm2.Create(Self);
    try
      Form2.Left := Left;
      Form2.Top := Top;
      Form2.WindowState := wsMaximized;
      Hide;
      Form2.ShowModal;
    finally
      Form2.Free;
    end;
end;

procedure TForm6.Image1Click(Sender: TObject);
begin
   if (tservico.Text = '') or (tfornecedor.Text = '') or (tdata.Text = '') or (tpagamento.Text = '') or (tcategoria.Text = '') or (tvalor.Text = '') THEN
  begin
    ShowMessage('Por favor, insira todos os campos.');
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

procedure TForm6.Image2Click(Sender: TObject);
begin
  tfornecedor.Caption := '';
  tservico.Caption := '';
  tdata.Caption := '';
  tdetalhes.Caption := '';
  tpagamento.Caption := '';
  tcategoria.Caption := '';
  tvalor.Caption := '';
end;

procedure TForm6.FormCreate(Sender: TObject);
begin
    with SQLQuery1 do
  begin
    close;
    sql.clear;
    sql.add('select * from gastos');
    open;
    Last;
  end;
end;
end.

