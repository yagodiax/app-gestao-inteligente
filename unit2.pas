unit Unit2;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Buttons,
  ExtCtrls, Unit5;

type

  { TForm2 }

  TForm2 = class(TForm)
    BitBtn2: TBitBtn;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Image1: TImage;
    Label2: TLabel;
    lblEntre: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
  public

  end;
var
  Form2: TForm2;

implementation

uses Unit1, Unit3, Unit4;

{$R *.lfm}

{ TForm2 }


procedure TForm2.FormCreate(Sender: TObject);
begin

end;

procedure TForm2.BitBtn1Click(Sender: TObject);
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

procedure TForm2.BitBtn2Click(Sender: TObject);
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

procedure TForm2.Button1Click(Sender: TObject);
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

procedure TForm2.Button2Click(Sender: TObject);
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

procedure TForm2.Button3Click(Sender: TObject);
begin
  Form4 := TForm4.Create(Self);
  try
    Form4.Left := Left;
    Form4.Top := Top;
    Hide;
    Form4.ShowModal;
  finally
    Form4.Free;
  end;
end;

end.

