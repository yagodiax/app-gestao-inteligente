unit Unit5;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, DB, SQLDB, mysql56conn, Forms, Controls, Graphics, Dialogs,
  ExtCtrls, DBGrids, MaskEdit, StdCtrls;

type

  { TForm5 }

  TForm5 = class(TForm)
    DataSource1: TDataSource;
    DataSource2: TDataSource;
    DBGrid1: TDBGrid;
    DBGrid2: TDBGrid;
    Image2: TImage;
    Image3: TImage;
    Image5: TImage;
    Image6: TImage;
    Image7: TImage;
    Image8: TImage;
    Image9: TImage;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    MySQL56Connection1: TMySQL56Connection;
    SQLQuery3: TSQLQuery;
    SQLTransaction3: TSQLTransaction;
    tlucro: TLabel;
    Label17: TLabel;
    tganho: TLabel;
    tdespesa: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    lblEntre: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel5: TPanel;
    Panel6: TPanel;
    Panel7: TPanel;
    Panel8: TPanel;
    Panel9: TPanel;
    SQLQuery1: TSQLQuery;
    SQLQuery2: TSQLQuery;
    SQLTransaction1: TSQLTransaction;
    SQLTransaction2: TSQLTransaction;
    tdata: TMaskEdit;
    tdata1: TMaskEdit;
    procedure Image2Click(Sender: TObject);
    procedure Image4Click(Sender: TObject);
    procedure Image7Click(Sender: TObject);
    procedure Panel7Click(Sender: TObject);
  private

  public

  end;

var
  Form5: TForm5;

implementation

uses
  unit7;

{$R *.lfm}

{ TForm5 }

procedure TForm5.Image4Click(Sender: TObject);
begin
  with SQLQuery1 do
  begin
    close;
    sql.clear;
    sql.add('select * from vendas');
    open;
    Last;
  end;
  with SQLQuery2 do
  begin
    close;
    sql.clear;
    sql.add('select * from gastos');
    open;
    Last;
  end;
end;

procedure TForm5.Image7Click(Sender: TObject);
begin
  Panel7Click(Sender);
end;

procedure TForm5.Image2Click(Sender: TObject);
begin
    Form8 := TForm8.Create(Self);
    try
      Form8.Left := Left;
      Form8.Top := Top;
      Form8.WindowState := wsMaximized;
      Hide;
      Form8.ShowModal;
    finally
      Form8.Free;
    end;
end;

procedure TForm5.Panel7Click(Sender: TObject);
var
  QueryVendas, QueryGastos: TSQLQuery;
  SomaValor, SomaGastos, Lucro: Double;
  startDate, endDate: String;
begin
  startDate := tdata.Text;
  endDate := tdata1.Text;
  SomaValor := 0;
  SomaGastos := 0;
  Lucro := 0;
  QueryVendas := TSQLQuery.Create(nil);
  QueryGastos := TSQLQuery.Create(nil);
  try
    if SQLTransaction1.Active then
      SQLTransaction1.Rollback;
    QueryVendas.SQLConnection := MySQL56Connection1;
    QueryGastos.SQLConnection := MySQL56Connection1;
    QueryVendas.Transaction := SQLTransaction3;
    QueryGastos.Transaction := SQLTransaction3;
    SQLTransaction1.StartTransaction;
    try
      QueryVendas.SQL.Text := 'SELECT SUM(valor) AS TotalValor FROM vendas WHERE data BETWEEN :dataInicio AND :dataFim';
      QueryVendas.Params.ParamByName('dataInicio').AsDate := StrToDate(startDate);
      QueryVendas.Params.ParamByName('dataFim').AsDate := StrToDate(endDate);
      QueryVendas.Open;
      if not QueryVendas.EOF then
      begin
        SomaValor := QueryVendas.FieldByName('TotalValor').AsFloat;
      end;

      QueryGastos.SQL.Text := 'SELECT SUM(valor) AS TotalGastos FROM gastos WHERE data BETWEEN :dataInicio AND :dataFim';
      QueryGastos.Params.ParamByName('dataInicio').AsDate := StrToDate(startDate);
      QueryGastos.Params.ParamByName('dataFim').AsDate := StrToDate(endDate);
      QueryGastos.Open;
      if not QueryGastos.EOF then
      begin
        SomaGastos := QueryGastos.Fields[0].AsFloat;
      end;

      SQLTransaction1.Commit;
    except
      SQLTransaction1.Rollback;
      raise;
    end;
  finally
    QueryVendas.Free;
    QueryGastos.Free;
  end;

  Lucro := SomaValor - SomaGastos;

  tganho.Caption := FormatFloat('R$: 0.00', SomaValor);
  tdespesa.Caption := FormatFloat('R$: 0.00', SomaGastos);
  tlucro.Caption := FormatFloat('R$: 0.00', Lucro);

  with SQLQuery1 do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT * FROM vendas WHERE data BETWEEN :dataInicio AND :dataFim');
    Params.ParamByName('dataInicio').AsDate := StrToDate(startDate);
    Params.ParamByName('dataFim').AsDate := StrToDate(endDate);
    Open;
    Last;
  end;

  with SQLQuery2 do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT * FROM gastos WHERE data BETWEEN :dataInicio AND :dataFim');
    Params.ParamByName('dataInicio').AsDate := StrToDate(startDate);
    Params.ParamByName('dataFim').AsDate := StrToDate(endDate);
    Open;
    Last;
  end;
end;
end.

