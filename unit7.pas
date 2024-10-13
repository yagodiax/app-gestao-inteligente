unit Unit7;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  Buttons;

type

  { TForm8 }

  TForm8 = class(TForm)
    Image10: TImage;
    Image11: TImage;
    Image12: TImage;
    Image13: TImage;
    Image14: TImage;
    Image15: TImage;
    Image3: TImage;
    Image9: TImage;
    Label10: TLabel;
    Label11: TLabel;
    Label5: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    lblEntre: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    procedure Image10Click(Sender: TObject);
    procedure Image11Click(Sender: TObject);
    procedure Image12Click(Sender: TObject);
    procedure Image13Click(Sender: TObject);
    procedure Image14Click(Sender: TObject);
    procedure Image15Click(Sender: TObject);
    procedure Image9Click(Sender: TObject);
  private

  public

  end;

var
  Form8: TForm8;

implementation

uses
  unit1, unit3, unit5, unit9, unit10, unit11, unit12;

{$R *.lfm}

{ TForm8 }

procedure TForm8.Image10Click(Sender: TObject);
begin
  Form1.Left := Form8.Left;
  Form1.Top := Form8.Top;
  Form1.Width := Form8.Width;
  Form1.Height := Form8.Height;
  if Form8.WindowState = wsMaximized then
    Form1.WindowState := wsMaximized
  else
  Form1.WindowState := wsNormal;
  Form8.Hide;
  Form1.Show;
end;

procedure TForm8.Image11Click(Sender: TObject);
begin
  Form9.Left := Form8.Left;
  Form9.Top := Form8.Top;
  Form9.Width := Form8.Width;
  Form9.Height := Form8.Height;
  if Form8.WindowState = wsMaximized then
    Form9.WindowState := wsMaximized
  else
  Form9.WindowState := wsNormal;
  Form8.Hide;
  Form9.Show;
end;

procedure TForm8.Image12Click(Sender: TObject);
begin
  Form5.Left := Form8.Left;
  Form5.Top := Form8.Top;
  Form5.Width := Form8.Width;
  Form5.Height := Form8.Height;
  if Form8.WindowState = wsMaximized then
    Form5.WindowState := wsMaximized
  else
  Form5.WindowState := wsNormal;
  Form8.Hide;
  Form5.Show;
end;

procedure TForm8.Image13Click(Sender: TObject);
begin
  Form10.Left := Form8.Left;
  Form10.Top := Form8.Top;
  Form10.Width := Form8.Width;
  Form10.Height := Form8.Height;
  if Form8.WindowState = wsMaximized then
    Form10.WindowState := wsMaximized
  else
  Form10.WindowState := wsNormal;
  Form8.Hide;
  Form10.Show;
end;

procedure TForm8.Image14Click(Sender: TObject);
begin
  Form11.Left := Form8.Left;
  Form11.Top := Form8.Top;
  Form11.Width := Form8.Width;
  Form11.Height := Form8.Height;
  if Form8.WindowState = wsMaximized then
    Form11.WindowState := wsMaximized
  else
  Form11.WindowState := wsNormal;
  Form8.Hide;
  Form11.Show;
end;

procedure TForm8.Image15Click(Sender: TObject);
begin
  Form12.Left := Form8.Left;
  Form12.Top := Form8.Top;
  Form12.Width := Form8.Width;
  Form12.Height := Form8.Height;
  if Form8.WindowState = wsMaximized then
    Form12.WindowState := wsMaximized
  else
  Form12.WindowState := wsNormal;
  Form8.Hide;
  Form12.Show;
end;

procedure TForm8.Image9Click(Sender: TObject);
begin
  Form3.Left := Form8.Left;
  Form3.Top := Form8.Top;
  Form3.Width := Form8.Width;
  Form3.Height := Form8.Height;
  if Form8.WindowState = wsMaximized then
    Form3.WindowState := wsMaximized
  else
  Form3.WindowState := wsNormal;
  Form8.Hide;
  Form3.Show;
end;

end.

