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
  Form1 := TForm1.Create(Self);
    try
      Form1.Left := Left;
      Form1.Top := Top;
      Hide;
      Form1.ShowModal;
    finally
      Form1.Free;
    end;
end;

procedure TForm8.Image11Click(Sender: TObject);
begin
  Form9 := TForm9.Create(Self);
  try
    Form9.Left := Left;
    Form9.Top := Top;
    Hide;
    Form9.ShowModal;
  finally
    Form9.Free;
  end;
end;

procedure TForm8.Image12Click(Sender: TObject);
begin
  Form5 := TForm5.Create(Self);
  try
    Form5.Left := Left;
    Form5.Top := Top;
    Hide;
    Form5.ShowModal;
  finally
    Form5.Free;
  end;
end;

procedure TForm8.Image13Click(Sender: TObject);
begin
  Form10 := TForm10.Create(Self);
try
  Form10.Left := Left;
  Form10.Top := Top;
  Hide;
  Form10.ShowModal;
finally
  Form10.Free;
end;
end;

procedure TForm8.Image14Click(Sender: TObject);
begin
      Form11 := TForm11.Create(Self);
try
  Form11.Left := Left;
  Form11.Top := Top;
  Hide;
  Form11.ShowModal;
finally
  Form11.Free;
end;
end;

procedure TForm8.Image15Click(Sender: TObject);
begin
      Form12 := TForm12.Create(Self);
try
  Form12.Left := Left;
  Form12.Top := Top;
  Hide;
  Form12.ShowModal;
finally
  Form12.Free;
end;
end;

procedure TForm8.Image9Click(Sender: TObject);
begin
    Form3 := TForm3.Create(Self);
try
  Form3.Left := Left;
  Form3.Top := Top;
  Hide;
  Form3.ShowModal;
finally
  Form3.Free;
end;
end;

end.

