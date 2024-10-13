unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Buttons,
  ExtCtrls, mysql56conn, SQLDB;

type
  { TForm1 }
  TForm1 = class(TForm)
    CheckBox1: TCheckBox;
    Image1: TImage;
    imgLogo: TImage;
    Label1: TLabel;
    lblEntre: TLabel;
    lblEntre1: TLabel;
    lblLogin: TEdit;
    lblSenha: TEdit;
    MySQL56Connection1: TMySQL56Connection;
    Panel1: TPanel;
    SQLTransaction1: TSQLTransaction;
    procedure CheckBox1Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure Label1Click(Sender: TObject);
    procedure lblLoginClick(Sender: TObject);
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
  unit2, unit7, unit8, IniFiles;

{$R *.lfm}

{ TForm1 }

//Hello World!

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
var
  Ini: TIniFile;
  Fullscreen: Boolean;
begin
  Ini := TIniFile.Create(ChangeFileExt(Application.ExeName, '.ini'));
  try
    Fullscreen := Ini.ReadBool('Settings', 'Fullscreen', False);
    CheckBox1.Checked := Fullscreen;
    CheckBox1Change(CheckBox1);
  finally
    Ini.Free;
  end;
end;

procedure TForm1.CheckBox1Change(Sender: TObject);
var
  I: Integer;
  Ini: TIniFile;
begin
  Ini := TIniFile.Create(ChangeFileExt(Application.ExeName, '.ini'));
  try
    Ini.WriteBool('Settings', 'Fullscreen', CheckBox1.Checked);

    if CheckBox1.Checked then
    begin
      for I := 0 to Screen.FormCount - 1 do
      begin
        Screen.Forms[I].BorderStyle := bsSizeable;
        Screen.Forms[I].WindowState := wsMaximized;
      end;
    end
    else
    begin
      for I := 0 to Screen.FormCount - 1 do
      begin
        Screen.Forms[I].BorderStyle := bsSizeable;
        Screen.Forms[I].WindowState := wsNormal;
      end;
    end;
  finally
    Ini.Free;
  end;
end;

procedure TForm1.Image1Click(Sender: TObject);
begin
  if ValidateLogin(lblLogin.Text, lblSenha.Text) then
  begin
    // O cargo já está sendo tratado dentro do ValidateLogin
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

function TForm1.ValidateLogin(const Nome, Senha: string): Boolean;
var
  Query: TSQLQuery;
  Cargo: string;
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
      Query.SQL.Text := 'SELECT cargo FROM admin WHERE usuario = :usuario AND senha = :senha';
      Query.Params.ParamByName('usuario').AsString := Nome;
      Query.Params.ParamByName('senha').AsString := Senha;
      Query.Open;
    if not Query.EOF then
    begin
      Cargo := Query.FieldByName('cargo').AsString;
      Result := True;
      // Chama função para navegar para o formulário correto
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
      Form1.Hide;
      Form2.ShowModal;
    finally
      Form2.Free;
    end;
  end;
end;

end.

