unit Unit2;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Buttons,
  ExtCtrls;

type

  { TForm2 }

  TForm2 = class(TForm)
    BitBtn2: TBitBtn;
    Image1: TImage;
    Image2: TImage;
    Image6: TImage;
    Image7: TImage;
    Image8: TImage;
    Image9: TImage;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    lblEntre: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Image2Click(Sender: TObject);
    procedure Image6Click(Sender: TObject);
    procedure Image7Click(Sender: TObject);
    procedure Image8Click(Sender: TObject);
  private
  public

  end;
var
  Form2: TForm2;

implementation

uses Unit1, Unit3, Unit4, Unit5, Unit6;

{$R *.lfm}

{ TForm2 }


procedure TForm2.FormCreate(Sender: TObject);
begin
  Form2.WindowState := wsMaximized;
end;

procedure TForm2.Image2Click(Sender: TObject);
begin
  Form1 := TForm1.Create(Self);
    try
      Form1.Left := Left;
      Form1.Top := Top;
      Form1.WindowState := wsMaximized;
      Hide;
      Form1.ShowModal;
    finally
      Form1.Free;
    end;
end;

procedure TForm2.Image6Click(Sender: TObject);
begin
    Form3 := TForm3.Create(Self);
  try
    Form3.Left := Left;
    Form3.Top := Top;
    Form3.WindowState := wsMaximized;
    Hide;
    Form3.ShowModal;

  finally
    Form3.Free;
  end;
end;

procedure TForm2.Image7Click(Sender: TObject);
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

procedure TForm2.Image8Click(Sender: TObject);
begin
     Form6 := TForm6.Create(Self);
  try
    Form6.Left := Left;
    Form6.Top := Top;
    Form6.WindowState := wsMaximized;
    Hide;
    Form6.ShowModal;
  finally
    Form6.Free;
  end;
end;

procedure TForm2.BitBtn1Click(Sender: TObject);
begin
  Form3 := TForm3.Create(Self);
    try
      Form3.Left := Left;
      Form3.Top := Top;
      Form3.WindowState := wsMaximized;
      Hide;
      Form3.ShowModal;
    finally
      Form3.Free;
    end;
end;

procedure TForm2.BitBtn2Click(Sender: TObject);
begin
Form5 := TForm5.Create(Self);
  try
    Form5.Left := Left;
    Form5.Top := Top;
    Form5.WindowState := wsMaximized;
    Hide;
    Form5.ShowModal;
  finally
    Form5.Free;
  end;
end;
end.

