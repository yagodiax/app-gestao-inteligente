unit Unit5;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, SQLDB, DB, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls, Buttons, DBGrids, MaskEdit;

type

  { TForm5 }

  TForm5 = class(TForm)
    BitBtn1: TBitBtn;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button7: TButton;
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
    Image1: TImage;
    Label10: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label9: TLabel;
    lblEntre: TLabel;
    Panel1: TPanel;
    SQLQuery1: TSQLQuery;
    tdata: TMaskEdit;
    tmetodo: TComboBox;
    tservico: TComboBox;
    tnome: TEdit;
    tvalor: TEdit;
    tdetalhes: TEdit;
    procedure BitBtn1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private

  public

  end;

var
  Form5: TForm5;

implementation

uses
  Unit2;

{$R *.lfm}

{ TForm5 }

procedure TForm5.BitBtn1Click(Sender: TObject);
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

procedure TForm5.Button1Click(Sender: TObject);
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
    ParamByName('pforma').AsString:= tmetodo.text;
    ParamByName('pdetalhes').AsString:= tdetalhes.text;
    ExecSQL;
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

procedure TForm5.Button2Click(Sender: TObject);
begin

end;

procedure TForm5.Button3Click(Sender: TObject);
begin

end;

procedure TForm5.Button4Click(Sender: TObject);
begin
  with SQLQuery1 do
  begin
    close;
    sql.clear;
    SQL.Add('SELECT * FROM vendas WHERE loja = :ploja');
    ParamByName('ploja').AsString:= tnome.text;
    Open;
  end;
end;

procedure TForm5.Button6Click(Sender: TObject);
begin

end;

procedure TForm5.Button7Click(Sender: TObject);
begin

end;

procedure TForm5.FormCreate(Sender: TObject);
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
end.

