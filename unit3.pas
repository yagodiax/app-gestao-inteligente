unit Unit3;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, SQLDB, DB, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls, DBGrids, MaskEdit, Buttons;

type

  { TForm3 }

  TForm3 = class(TForm)
    ComboBox1: TComboBox;
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    Image4: TImage;
    Image5: TImage;
    Label1: TLabel;
    Label10: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    lblEntre: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    Panel6: TPanel;
    SQLQuery1: TSQLQuery;
    tdata: TMaskEdit;
    tdata1: TMaskEdit;
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure Image3Click(Sender: TObject);
    procedure Panel2Click(Sender: TObject);
    procedure Panel6Click(Sender: TObject);
  private

  public

  end;

var
  Form3: TForm3;

implementation

uses
  unit7;

{$R *.lfm}

{ TForm3 }



procedure TForm3.Button2Click(Sender: TObject);
begin

end;

procedure TForm3.FormCreate(Sender: TObject);
begin
  begin

  SQLQuery1.Close;
  SQLQuery1.SQL.Text := 'SELECT nome FROM servicos';
  SQLQuery1.Open;

  ComboBox1.Items.Clear;

  while not SQLQuery1.EOF do
  begin
    ComboBox1.Items.Add(SQLQuery1.FieldByName('nome').AsString);
    SQLQuery1.Next;
  end;

  SQLQuery1.Close;

  begin
  SQLQuery1.Close;
  SQLQuery1.SQL.Text := 'SELECT * FROM vendas';
  SQLQuery1.Open;
  end;
end
end;

procedure TForm3.Image1Click(Sender: TObject);
begin
  Panel6Click(Sender);
end;

procedure TForm3.Image3Click(Sender: TObject);
begin
  Form8 := TForm8.Create(Self);
    try
      Form8.Left := Left;
      Form8.Top := Top;
      Form8.WindowState := wsMaximized;
      Hide;
      Form8.ShowModal;
    finally
      Form8.Free;
    end;
end;

procedure TForm3.Panel2Click(Sender: TObject);
begin

end;

procedure TForm3.Panel6Click(Sender: TObject);
  var
  startDate, endDate, comboBoxText: String;
  totalValue: Double;
  recordCount: Integer;
  itemList: TStringList;
  serviceList: TStringList;
  i, j: Integer;
  serviceCount: Integer;
  serviceName: String;
  begin
  startDate := tdata.Text;
  endDate := tdata1.Text;
  comboBoxText := ComboBox1.Text;

  Label7.Caption := 'R$ 0,00';
  Label6.Caption := '0';
  Label10.Caption := '';

  SQLQuery1.Close;

  if (startDate = '') or (endDate = '') then
  begin
    ShowMessage('Por favor, preencha ambos os campos de data.');
    Exit;
  end;

  SQLQuery1.SQL.Text := 'SELECT * FROM vendas WHERE data BETWEEN :startDate AND :endDate';

  if comboBoxText <> '' then
  begin
    SQLQuery1.SQL.Add(' AND servico = :comboBoxText');
    SQLQuery1.Params.ParamByName('comboBoxText').AsString := comboBoxText;
  end;

  SQLQuery1.Params.ParamByName('startDate').AsDate := StrToDate(startDate);
  SQLQuery1.Params.ParamByName('endDate').AsDate := StrToDate(endDate);

  SQLQuery1.Open;

  if SQLQuery1.IsEmpty then
  begin
    ShowMessage('Nenhum dado encontrado.');
    Exit;
  end;

  totalValue := 0;
  recordCount := 0;
  itemList := TStringList.Create;
  serviceList := TStringList.Create;
  serviceList.Sorted := True;
  serviceList.Duplicates := dupIgnore;
  try
    itemList.Clear;
    serviceList.Clear;

    SQLQuery1.First;
    while not SQLQuery1.EOF do
    begin
      totalValue := totalValue + SQLQuery1.FieldByName('valor').AsFloat;
      recordCount := recordCount + 1;
      serviceName := SQLQuery1.FieldByName('servico').AsString;

      itemList.Add(serviceName);
      serviceList.Add(serviceName);

      SQLQuery1.Next;
    end;

    Label7.Caption := 'R$ ' + FormatFloat('0.00', totalValue);
    Label6.Caption := IntToStr(recordCount);

    itemList.Sort;
    Label10.Caption := '';
    for i := 0 to serviceList.Count - 1 do
    begin
      serviceName := serviceList[i];
      serviceCount := 0;
      for j := 0 to itemList.Count - 1 do
      begin
        if itemList[j] = serviceName then
          Inc(serviceCount);
      end;
      Label10.Caption := Label10.Caption + serviceName + ': ' + IntToStr(serviceCount) + sLineBreak;
    end;
  finally
    itemList.Free;
    serviceList.Free;
  end;
end;

end.
