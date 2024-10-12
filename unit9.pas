unit Unit9;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, DB, SQLDB, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  DBGrids, StdCtrls;

type

  { TForm9 }

  TForm9 = class(TForm)
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
    Image1: TImage;
    Image10: TImage;
    Image2: TImage;
    Image3: TImage;
    Label3: TLabel;
    Label9: TLabel;
    lblEntre: TLabel;
    logo: TImage;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    SQLQuery1: TSQLQuery;
    SQLTransaction1: TSQLTransaction;
    tservico: TEdit;
    tvalor: TEdit;
    procedure Image10Click(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure Image2Click(Sender: TObject);
    procedure Image3Click(Sender: TObject);
    procedure Image6Click(Sender: TObject);
    procedure Panel4Click(Sender: TObject);
  private

  public

  end;

var
  Form9: TForm9;

implementation

uses
  unit7;

{$R *.lfm}

{ TForm9 }

procedure TForm9.Image6Click(Sender: TObject);
begin

end;

procedure TForm9.Panel4Click(Sender: TObject);
begin
  tservico.Caption := '';
  tvalor.Caption := '';
end;

procedure TForm9.Image10Click(Sender: TObject);
begin
      Form8 := TForm8.Create(Self);
    try
      Form8.Left := Left;
      Form8.Top := Top;
      Hide;
      Form8.ShowModal;
    finally
      Form8.Free;
    end;
end;

procedure TForm9.Image1Click(Sender: TObject);
  var
  valorFormatado: String;
begin
  if (tservico.Text = '') then
  begin
    ShowMessage('Por favor, insira o nome da Loja.');
    Exit;
  end;

  valorFormatado := StringReplace(tvalor.Text, ',', '.', [rfReplaceAll]);

  with SQLQuery1 do
  begin
    close;
    sql.clear;
    sql.add('insert into servicos (nome, valor)');
    sql.add('values (:pnome, :pvalor)');
    ParamByName('pnome').AsString := tservico.Text;
    ParamByName('pvalor').AsString := valorFormatado;
    ExecSQL;
    SQLTransaction1.Commit;
  end;

  with SQLQuery1 do
  begin
    close;
    sql.clear;
    sql.add('select * from servicos');
    open;
    Last;
  end;
end;

procedure TForm9.Image2Click(Sender: TObject);
begin
  begin
  if (tservico.Text = '') then
  begin
    ShowMessage('Por favor, insira o nome do serviço a ser deletado.');
    Exit;
  end;

  with SQLQuery1 do
  begin
    Close;
    SQL.Clear;
    SQL.Add('DELETE FROM servicos WHERE nome = :pnome');
    ParamByName('pnome').AsString := tservico.Text;
    ExecSQL;
    SQLTransaction1.Commit;
  end;

  ShowMessage('Serviço deletado com sucesso.');

  // Atualiza a visualização da lista de serviços
  with SQLQuery1 do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT * FROM servicos');
    Open;
  end;
  end;
end;

procedure TForm9.Image3Click(Sender: TObject);
var
  valorFormatado: String;
begin
  if (tservico.Text = '') or (tvalor.Text = '') then
  begin
    ShowMessage('Por favor, insira o nome do serviço e o novo valor.');
    Exit;
  end;

  valorFormatado := StringReplace(tvalor.Text, ',', '.', [rfReplaceAll]);

  with SQLQuery1 do
  begin
    Close;
    SQL.Clear;
    SQL.Add('UPDATE servicos SET valor = :pvalor WHERE nome = :pnome');
    ParamByName('pnome').AsString := tservico.Text;
    ParamByName('pvalor').AsString := valorFormatado;
    ExecSQL;
    SQLTransaction1.Commit;
  end;

  ShowMessage('Valor do serviço atualizado com sucesso.');

  // Atualiza a visualização da lista de serviços
  with SQLQuery1 do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT * FROM servicos');
    Open;
  end;
end;
end.

