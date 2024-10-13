unit Unit10;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, SQLDB, DB, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls, DBGrids;

type

  { TForm10 }

  TForm10 = class(TForm)
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
    Image1: TImage;
    Image10: TImage;
    Image2: TImage;
    Image3: TImage;
    Label3: TLabel;
    Label4: TLabel;
    Label9: TLabel;
    lblEntre: TLabel;
    logo: TImage;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    SQLQuery1: TSQLQuery;
    SQLTransaction1: TSQLTransaction;
    tcargo: TComboBox;
    tusuario: TEdit;
    tsenha: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure Image10Click(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure Image2Click(Sender: TObject);
    procedure Image3Click(Sender: TObject);
    procedure Panel4Click(Sender: TObject);
  private

  public

  end;

var
  Form10: TForm10;

implementation

uses
  unit7;

{$R *.lfm}

{ TForm10 }

procedure TForm10.Image1Click(Sender: TObject);
begin
  if (tusuario.Text = '') then
  begin
    ShowMessage('Por favor, insira o nome da Loja.');
    Exit;
  end;
  with SQLQuery1 do
  begin
    close;
    sql.clear;
    sql.add('insert into admin (usuario, senha, cargo)');
    sql.add('values (:pnome, :psenha, :pcargo)');
    ParamByName('pnome').AsString := tusuario.Text;
    ParamByName('psenha').AsString := tsenha.Text;
    ParamByName('pcargo').AsString := tcargo.Text;
    ExecSQL;
    SQLTransaction1.Commit;
  end;

  with SQLQuery1 do
  begin
    close;
    sql.clear;
    sql.add('select * from admin');
    open;
    Last;
  end;
end;

procedure TForm10.Image10Click(Sender: TObject);
begin
  Form8.Left := Form10.Left;
  Form8.Top := Form10.Top;
  Form8.Width := Form10.Width;
  Form8.Height := Form10.Height;
  if Form10.WindowState = wsMaximized then
    Form8.WindowState := wsMaximized
  else
  Form8.WindowState := wsNormal;
  Form10.Hide;
  Form8.Show;
end;

procedure TForm10.FormCreate(Sender: TObject);
begin
  with SQLQuery1 do
  begin
    close;
    sql.clear;
    sql.add('select * from admin');
    open;
    Last;
  end;
end;

procedure TForm10.Image2Click(Sender: TObject);
begin
  if (tusuario.Text = '') then
  begin
    ShowMessage('Por favor, insira o nome do usuário a ser deletado.');
    Exit;
  end;

  with SQLQuery1 do
  begin
    Close;
    SQL.Clear;
    SQL.Add('DELETE FROM admin WHERE usuario = :pnome');
    ParamByName('pnome').AsString := tusuario.Text;
    ExecSQL;
    SQLTransaction1.Commit;
  end;

  ShowMessage('Usuário deletado com sucesso.');

  // Atualiza a visualização da lista de administradores
  with SQLQuery1 do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT * FROM admin');
    Open;
  end;
end;

procedure TForm10.Image3Click(Sender: TObject);
begin
  if (tusuario.Text = '') or (tsenha.Text = '') or (tcargo.Text = '') then
  begin
    ShowMessage('Por favor, insira o nome do usuário, a senha e o cargo.');
    Exit;
  end;

  with SQLQuery1 do
  begin
    Close;
    SQL.Clear;
    SQL.Add('UPDATE admin SET senha = :psenha, cargo = :pcargo WHERE usuario = :pnome');
    ParamByName('pnome').AsString := tusuario.Text;
    ParamByName('psenha').AsString := tsenha.Text;
    ParamByName('pcargo').AsString := tcargo.Text;
    ExecSQL;
    SQLTransaction1.Commit;
  end;

  ShowMessage('Dados do usuário atualizados com sucesso.');

  // Atualiza a visualização da lista de administradores
  with SQLQuery1 do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT * FROM admin');
    Open;
  end;
end;

procedure TForm10.Panel4Click(Sender: TObject);
begin
  tusuario.Caption := '';
  tsenha.Caption := '';
  tcargo.Caption := '';
end;
end.

