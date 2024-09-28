unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Buttons,
  ExtCtrls, Unit8, Unit2, mysql56conn, SQLDB;

type
  { TForm1 }
  TForm1 = class(TForm)
    btnLogin: TBitBtn;
    Label1: TLabel;
    lblLogin: TEdit;
    lblSenha: TEdit;
    imgLogo: TImage;
    lblEntre: TLabel;
    MySQL56Connection1: TMySQL56Connection;
    SQLTransaction1: TSQLTransaction;
    procedure btnLoginClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Label1Click(Sender: TObject);
    procedure lblEntreClick(Sender: TObject);
    procedure lblLoginChange(Sender: TObject);
    procedure lblLoginClick(Sender: TObject);
    procedure lblLoginEnter(Sender: TObject);
    procedure lblLoginKeyPress(Sender: TObject; var Key: char);
    procedure lblSenhaClick(Sender: TObject);
    procedure lblSenhaKeyPress(Sender: TObject; var Key: char);
  private
    function ValidateLogin(const Nome, Senha: string): Boolean;
    procedure NavigateToNextPage;
  public
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

//Hello World!

procedure TForm1.lblLoginEnter(Sender: TObject);
begin

end;

procedure TForm1.lblLoginKeyPress(Sender: TObject; var Key: char);
begin
  if Key = #13 then
  begin
    lblSenha.SetFocus;
  end;
end;

procedure TForm1.lblSenhaClick(Sender: TObject);
begin
  lblSenha.Caption := '';
end;

procedure TForm1.lblSenhaKeyPress(Sender: TObject; var Key: char);
begin
  if Key = #13 then
  begin
    SelectNext(ActiveControl as TWinControl, True, True);
    Key := #0;
    btnLogin.Click;
  end;
end;

procedure TForm1.lblLoginClick(Sender: TObject);
begin
  lblLogin.Caption := '';
end;

procedure TForm1.btnLoginClick(Sender: TObject);
begin
  if ValidateLogin(lblLogin.Text, lblSenha.Text) then
  begin
    NavigateToNextPage;
  end
  else
  begin
    ShowMessage('Usuário ou senha inválidos.');
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  Position := poScreenCenter;
end;

procedure TForm1.Label1Click(Sender: TObject);
begin
  Form7 := TForm7.Create(Self);
  try
    Form7.Left := Left;
    Form7.Top := Top;
    Form1.Hide;
    Form7.ShowModal;
  finally
    Form7.Free;
  end;
end;

procedure TForm1.lblEntreClick(Sender: TObject);
begin

end;

procedure TForm1.lblLoginChange(Sender: TObject);
begin

end;

function TForm1.ValidateLogin(const Nome, Senha: string): Boolean;
var
  Query: TSQLQuery;
begin
  Result := False;
  Query := TSQLQuery.Create(nil);
  try
    if SQLTransaction1.Active then
      SQLTransaction1.Rollback;  // Reverte a transação ativa, se houver

    Query.SQLConnection := MySQL56Connection1;
    Query.Transaction := SQLTransaction1;
    SQLTransaction1.StartTransaction;
    try
      Query.SQL.Text := 'SELECT COUNT(*) FROM admin WHERE usuario = :usuario AND senha = :senha';
      Query.Params.ParamByName('usuario').AsString := Nome;
      Query.Params.ParamByName('senha').AsString := Senha;
      Query.Open;
      if not Query.EOF and (Query.Fields[0].AsInteger > 0) then
        Result := True;
      SQLTransaction1.Commit;
    except
      SQLTransaction1.Rollback;
      raise;
    end;
  finally
    Query.Free;
  end;
end;

procedure TForm1.NavigateToNextPage;
begin
  Form2 := TForm2.Create(Self);
  try
    Form2.Left := Left;
    Form2.Top := Top;
    Form1.Hide;
    Form2.ShowModal;
  finally
    Form2.Free;
  end;
end;

end.

