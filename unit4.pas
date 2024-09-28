unit Unit4;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, DB, SQLDB, Forms, Controls, Graphics, Dialogs, StdCtrls,
  Buttons, ExtCtrls, DBGrids, DBCtrls, MaskEdit, Grids, mysql56conn,
  DateTimePicker;

type

  { TForm4 }

  TForm4 = class(TForm)
    BitBtn1: TBitBtn;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    Button8: TButton;
    ComboBox1: TComboBox;
    DataSource1: TDataSource;
    DateTimePicker1: TDateTimePicker;
    Label7: TLabel;
    Label8: TLabel;
    SQLQuery1: TSQLQuery;
    SQLTransaction1: TSQLTransaction;
    tdtass: TMaskEdit;
    tmetodo: TEdit;
    tnome: TEdit;
    tvalor: TEdit;
    tdtpg: TMaskEdit;
    tdtu: TMaskEdit;
    tiduser: TEdit;
    DBGrid1: TDBGrid;
    Image1: TImage;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    lblEntre: TLabel;
    Panel1: TPanel;
    procedure BitBtn1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private

  public

  end;
var
  Form4: TForm4;

implementation

uses Unit2;

{$R *.lfm}

{ TForm4 }


procedure TForm4.FormCreate(Sender: TObject);
begin
       with SQLQuery1 do
  begin
     close;
      sql.clear;
      sql.Add('select * from assinaturas order by id');
      open;
  end;
end;

procedure TForm4.FormShow(Sender: TObject);
begin
  DateTimePicker1.Date := Now;
end;

procedure TForm4.BitBtn1Click(Sender: TObject);
begin
  Form2 := TForm2.Create(Self);
try
  Form2.Left := Left;
  Form2.Top := Top;
  Hide;
  Form2.ShowModal;
finally
  Form2.Free;
end;
end;

procedure TForm4.Button1Click(Sender: TObject);
begin
  if (tdtu.Text = '') or (tnome.Text = '') or (tdtpg.Text = '') or (tdtass.Text = '') or (tmetodo.Text = '') or (tvalor.Text = '') then
  begin
    ShowMessage('Por favor, preencha todos os campos.');
    Exit;
  end;
   with SQLQuery1 do
  begin
    close;
    sql.clear;
    sql.add('insert into assinaturas (loja, ultimo_pag, proximo_pag, inicio_ass, tipo_pag, valor_pag)');
    sql.add('values (:ploja, :pdtu, :pdtpg, :pdtass, :ptppg, :pvp)');
    ParamByName('ploja').AsString:= tnome.text;
    ParamByName('pdtu').AsDate:= strtodate (tdtu.text);
    ParamByName('pdtpg').AsDate:= strtodate (tdtpg.text);
    ParamByName('pdtass').AsDate:= strtodate (tdtass.text);
    ParamByName('ptppg').AsString:= tmetodo.text;
    ParamByName('pvp').AsFloat:= StrToFloat (tvalor.text);
    ExecSQL;
  end;
  with SQLQuery1 do
  begin
    close;
    sql.clear;
    sql.add('select * from assinaturas');
    open;
    Last;
  end;
end;

procedure TForm4.Button2Click(Sender: TObject);
begin
  if (tnome.Text = '') then
  begin
    ShowMessage('Por favor, insira o nome da loja.');
    Exit;
  end;
  with SQLQuery1 do
  begin
    close;
    sql.clear;
    sql.Add('update assinaturas set loja =:pnome, ultimo_pag =:pdtu, proximo_pag =:pdtpg, inicio_ass =:pdtass, tipo_pag =:ptppg, valor_pag =:pvp where loja =:pnome');
    ParamByName('pnome').AsString:= tnome.text;
    ParamByName('pdtu').AsDate:= strtodate (tdtu.text);
    ParamByName('pdtpg').AsDate:= strtodate (tdtpg.text);
    ParamByName('pdtass').AsDate:= strtodate (tdtass.text);
    ParamByName('ptppg').AsString:= tmetodo.text;
    ParamByName('pvp').AsFloat:= StrToFloat (tvalor.text);
    ExecSQL;
  end;
  with SQLQuery1 do
  begin
    close;
    sql.clear;
    SQL.Add('SELECT * FROM assinaturas WHERE loja = :pnome');
    ParamByName('pnome').AsString := tnome.Text;
    open;
    Last;
  end;
end;

procedure TForm4.Button3Click(Sender: TObject);
begin
  if (tnome.Text = '') then
  begin
    ShowMessage('Por favor, insira o nome da loja que deseja deletar.');
    Exit;
  end;
  if MessageDlg('Você realmente deseja excluir esta loja?', mtConfirmation, [mbYes, mbNo], 0) = mrYes  then
  with SQLQuery1 do
  begin
    close;
    sql.clear;
    sql.Add('delete from assinaturas where loja =:pnome');
    ParamByName('pnome').AsString:= tnome.text;
    ExecSQL;
  end;
  with SQLQuery1 do
  begin
    close;
    sql.clear;
    sql.add('select * from assinaturas');
    open;
    Last;
  end;
end;

procedure TForm4.Button4Click(Sender: TObject);
begin
  With SQLQuery1 do
  begin
    close;
    sql.clear;
    sql.Add('select * from assinaturas order by ultimo_pag');
    open;
  end;
end;

procedure TForm4.Button5Click(Sender: TObject);
begin
  with SQLQuery1 do
  begin
    close;
    sql.clear;
    sql.Add('select * from assinaturas order by proximo_pag');
    open;
  end;
end;

procedure TForm4.Button6Click(Sender: TObject);
begin
  with SQLQuery1 do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT ultimo_pag, proximo_pag, inicio_ass, tipo_pag, valor_pag FROM assinaturas WHERE loja = :pnome');
    ParamByName('pnome').AsString := tnome.Text;
    Open;
  if not EOF then
  begin
    tdtu.Text := DateToStr(FieldByName('ultimo_pag').AsDateTime);
    tdtpg.Text := DateToStr(FieldByName('proximo_pag').AsDateTime);
    tdtass.Text := DateToStr(FieldByName('inicio_ass').AsDateTime);
    tmetodo.Text := FieldByName('tipo_pag').AsString;
    tvalor.Text := FloatToStr(FieldByName('valor_pag').AsFloat);
    SQL.Clear;
    SQL.Add('SELECT * FROM assinaturas WHERE loja = :pnome');
    ParamByName('pnome').AsString := tnome.Text;
    Open;
  end
  else
  begin
    ShowMessage('Loja não encontrada.');
  end;
  end;
    DataSource1.DataSet := SQLQuery1;
end;
procedure TForm4.Button7Click(Sender: TObject);
begin
  with SQLQuery1 do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT * FROM assinaturas');
    Open;
  end;
  DataSource1.DataSet := SQLQuery1;
  tnome.Clear;
  tdtu.Clear;
  tdtpg.Clear;
  tdtass.Clear;
  tmetodo.Clear;
  tvalor.Clear;
end;

procedure TForm4.Button8Click(Sender: TObject);
begin
  with SQLQuery1 do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT * FROM assinaturas WHERE proximo_pag < :currentDate');
    ParamByName('currentDate').AsDate := Now;
    Open;
  end;
end;

procedure TForm4.DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumn; State: TGridDrawState);
var
  CellDate: TDateTime;
begin
  if (Column.FieldName = 'proximo_pag') then
  begin
    CellDate := Column.Field.AsDateTime;
    if CellDate < Now then
      DBGrid1.Canvas.Brush.Color := clRed // Atrasado
    else if CellDate <= Now + 7 then
      DBGrid1.Canvas.Brush.Color := clYellow // Dentro de uma semana
    else
      DBGrid1.Canvas.Brush.Color := clGreen; // Mais de uma semana à frente
    DBGrid1.Canvas.FillRect(Rect);
    DBGrid1.DefaultDrawColumnCell(Rect, DataCol, Column, State);
  end
  else
    DBGrid1.DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;
end.

