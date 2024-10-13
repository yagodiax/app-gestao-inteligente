unit Unit2;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, SQLDB, Forms, Controls, Graphics, Dialogs, StdCtrls,
  Buttons, ExtCtrls;

type

  { TForm2 }

  TForm2 = class(TForm)
    Image10: TImage;
    logo: TImage;
    Image2: TImage;
    Image8: TImage;
    Label4: TLabel;
    Label6: TLabel;
    lblEntre: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    procedure FormCreate(Sender: TObject);
    procedure Image10Click(Sender: TObject);
    procedure Image2Click(Sender: TObject);
    procedure Image8Click(Sender: TObject);
  private
  public

  end;
var
  Form2: TForm2;

implementation

uses Unit1, Unit4, Unit6;

{$R *.lfm}

{ TForm2 }


procedure TForm2.FormCreate(Sender: TObject);
begin

end;

procedure TForm2.Image10Click(Sender: TObject);
begin
  Form1.Left := Form2.Left;
  Form1.Top := Form2.Top;
  Form1.Width := Form2.Width;
  Form1.Height := Form2.Height;

  if Form2.WindowState = wsMaximized then
    Form1.WindowState := wsMaximized
  else
    Form1.WindowState := wsNormal;

  Form2.Hide;
  Form1.Show;
end;

procedure TForm2.Image2Click(Sender: TObject);
begin
  Form4.Left := Form2.Left;
  Form4.Top := Form2.Top;
  Form4.Width := Form2.Width;
  Form4.Height := Form2.Height;
  if Form2.WindowState = wsMaximized then
    Form4.WindowState := wsMaximized
  else
  Form4.WindowState := wsNormal;
  Form2.Hide;
  Form4.Show;
end;

procedure TForm2.Image8Click(Sender: TObject);
begin
  Form6.Left := Form2.Left;
  Form6.Top := Form2.Top;
  Form6.Width := Form2.Width;
  Form6.Height := Form2.Height;
  if Form2.WindowState = wsMaximized then
    Form6.WindowState := wsMaximized
  else
  Form6.WindowState := wsNormal;
  Form2.Hide;
  Form6.Show;
end;
end.

