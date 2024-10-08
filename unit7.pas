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
    Image9: TImage;
    Label5: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    lblEntre: TLabel;
    logo: TImage;
    Panel1: TPanel;
    Panel2: TPanel;
    procedure Image10Click(Sender: TObject);
    procedure Image11Click(Sender: TObject);
    procedure Image12Click(Sender: TObject);
    procedure Image13Click(Sender: TObject);
    procedure Image9Click(Sender: TObject);
  private

  public

  end;

var
  Form8: TForm8;

implementation

uses
  unit4, unit5;

{$R *.lfm}

{ TForm8 }

procedure TForm8.Image10Click(Sender: TObject);
begin

end;

procedure TForm8.Image11Click(Sender: TObject);
begin
    Form4 := TForm4.Create(Self);
  try
    Form4.Left := Left;
    Form4.Top := Top;
    Form4.WindowState := wsMaximized; // Corrigido para maximizar Form4
    Hide;
    Form4.ShowModal;
  finally
    Form4.Free;
  end;
end;

procedure TForm8.Image12Click(Sender: TObject);
begin
    Form4 := TForm4.Create(Self);
  try
    Form4.Left := Left;
    Form4.Top := Top;
    Form4.WindowState := wsMaximized; // Corrigido para maximizar Form4
    Hide;
    Form4.ShowModal;
  finally
    Form4.Free;
  end;
end;

procedure TForm8.Image13Click(Sender: TObject);
begin
    Form4 := TForm4.Create(Self);
  try
    Form4.Left := Left;
    Form4.Top := Top;
    Form4.WindowState := wsMaximized; // Corrigido para maximizar Form4
    Hide;
    Form4.ShowModal;
  finally
    Form4.Free;
  end;
end;

procedure TForm8.Image9Click(Sender: TObject);
begin
    Form5 := TForm5.Create(Self);
  try
    Form5.Left := Left;
    Form5.Top := Top;
    Form5.WindowState := wsMaximized; // Corrigido para maximizar Form4
    Hide;
    Form5.ShowModal;
  finally
    Form5.Free;
  end;
end;

end.

