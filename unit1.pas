unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Buttons,
  ExtCtrls, mysql56conn, SQLDB;

type
  { TForm1 }
  TForm1 = class(TForm)
    Image1: TImage;
    imgLogo: TImage;
    imgLogo1: TImage;
    Label1: TLabel;
    lblEntre: TLabel;
    lblLogin: TEdit;
    lblSenha: TEdit;
    MySQL56Connection1: TMySQL56Connection;
    Panel1: TPanel;
    SQLTransaction1: TSQLTransaction;
    procedure FormCreate(Sender: TObject);
    procedure Image1Click(Sender: TObject);
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
    procedure NavigateToNextPage(Cargo: string);
  public
  end;

var
  Form1: TForm1;

implementation

uses
  unit2, unit7, unit8;

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
    Image1.OnClick(Self);
  end;
end;

procedure TForm1.lblLoginClick(Sender: TObject);
begin
  lblLogin.Caption := '';
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  Position := poScreenCenter;
  Form1.WindowState := wsMaximized;
end;

procedure TForm1.Image1Click(Sender: TObject);
begin
  if ValidateLogin(lblLogin.Text, lblSenha.Text) then
  begin

  end
  else
  begin
    ShowMessage('Usuário ou senha inválidos.');
  end;
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
  Cargo: string;
begin
  Result := False;
  Query := TSQLQuery.Create(nil);
  try
    if SQLTransaction1.Active then
      SQLTransaction1.Rollback;

    Query.SQLConnection := MySQL56Connection1;
    Query.Transaction := SQLTransaction1;
    SQLTransaction1.StartTransaction;
    try
      Query.SQL.Text := 'SELECT cargo FROM admin WHERE usuario = :usuario AND senha = :senha';
      Query.Params.ParamByName('usuario').AsString := Nome;
      Query.Params.ParamByName('senha').AsString := Senha;
      Query.Open;
      if not Query.EOF then
      begin
        Cargo := Query.FieldByName('cargo').AsString;
        Result := True;
        NavigateToNextPage(Cargo);
      end;
      SQLTransaction1.Commit;
    except
      SQLTransaction1.Rollback;
      raise;
    end;
  finally
    Query.Free;
  end;
end;

procedure TForm1.NavigateToNextPage(Cargo: string);
begin
  if Cargo = 'administrador' then
  begin
    Form8 := TForm8.Create(Self);
    try
      Form8.Left := Left;
      Form8.Top := Top;
      Form8.WindowState := wsMaximized;
      Form1.Hide;
      Form8.ShowModal;
    finally
      Form8.Free;
    end;
  end
  else
  begin
    Form2 := TForm2.Create(Self);
    try
      Form2.Left := Left;
      Form2.Top := Top;
      Form2.WindowState := wsMaximized;
      Form1.Hide;
      Form2.ShowModal;
    finally
      Form2.Free;
    end;
  end;
end;

end.

