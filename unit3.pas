unit Unit3;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, SQLDB, DB, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls, Buttons, DBGrids, ComCtrls, DBCtrls, ExtDlgs, Types;

type

  { TForm3 }

  TForm3 = class(TForm)
    BitBtn1: TBitBtn;
    Button1: TButton;
    Button10: TButton;
    Button11: TButton;
    Button12: TButton;
    Button13: TButton;
    Button14: TButton;
    Button15: TButton;
    Button16: TButton;
    Button17: TButton;
    Button2: TButton;
    Button3: TButton;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    Button8: TButton;
    Button9: TButton;
    CheckBoxMasculino: TCheckBox;
    CheckBoxFeminino: TCheckBox;
    CheckBoxInfantil: TCheckBox;
    ComboBox1: TComboBox;
    DataSource2: TDataSource;
    DataSource3: TDataSource;
    DataSource4: TDataSource;
    DBGrid2: TDBGrid;
    SQLQuery2: TSQLQuery;
    SQLQuery3: TSQLQuery;
    SQLQuery4: TSQLQuery;
    tcidade: TComboBox;
    testado: TComboBox;
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
    DBGrid3: TDBGrid;
    Label10: TLabel;
    Label11: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    lblEntre: TLabel;
    OpenPictureDialog1: TOpenPictureDialog;
    PageControl1: TPageControl;
    Panel1: TPanel;
    SQLQuery1: TSQLQuery;
    SQLTransaction1: TSQLTransaction;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    tcpf: TEdit;
    temail: TEdit;
    tfeirao: TComboBox;
    timg: TDBGroupBox;
    timg1: TDBGroupBox;
    tlinkinstac: TEdit;
    tlinkinsta: TEdit;
    tlinksitec: TEdit;
    tlinksite: TEdit;
    tlogo: TDBImage;
    tlogo1: TDBImage;
    tnome: TEdit;
    tnomemd: TEdit;
    tnomeloja: TEdit;
    tnome3: TEdit;
    tnumero: TEdit;
    tnumerol: TEdit;
    procedure BitBtn1Click(Sender: TObject);
    procedure Button10Click(Sender: TObject);
    procedure Button11Click(Sender: TObject);
    procedure Button12Click(Sender: TObject);
    procedure Button13Click(Sender: TObject);
    procedure Button14Click(Sender: TObject);
    procedure Button15Click(Sender: TObject);
    procedure Button16Click(Sender: TObject);
    procedure Button17Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
    procedure TabSheet2ContextPopup(Sender: TObject; MousePos: TPoint;
      var Handled: Boolean);
    procedure tlinkinstacClick(Sender: TObject);
    procedure tlinksitecClick(Sender: TObject);
    procedure tlogo1Click(Sender: TObject);
    procedure tnomemdChange(Sender: TObject);
  private

  public

  end;

var
  Form3: TForm3; tlogo1Path: string;

implementation

uses Unit2, LCLIntf;

{$R *.lfm}

{ TForm3 }

procedure TForm3.BitBtn1Click(Sender: TObject);
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

procedure TForm3.Button10Click(Sender: TObject);
  var
  MemoryStream: TMemoryStream;
begin
  with SQLQuery4 do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT loja, logo FROM lojas WHERE loja = :pnome');
    ParamByName('pnome').AsString := tnome3.Text;
    Open;
    if not EOF then
    begin
      tnome3.Text := FieldByName('loja').AsString;
      MemoryStream := TMemoryStream.Create;
      try
        TBlobField(FieldByName('logo')).SaveToStream(MemoryStream);
        MemoryStream.Position := 0;
        tlogo1.Picture.LoadFromStream(MemoryStream);
      finally
        MemoryStream.Free;
      end;
    end
    else
    begin
      ShowMessage('Loja não encontrada.');
    end;
  end;
end;

procedure TForm3.Button11Click(Sender: TObject);
  begin
  with SQLQuery1 do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT loja, email, numero, cpf_cnpj, tipo_produto, link_site, link_instagram FROM lojas WHERE loja = :pnome');
    ParamByName('pnome').AsString := tnomemd.Text;
    Open;
    if not EOF then
    begin
      temail.Text := FieldByName('email').AsString;
      tnomemd.Text := FieldByName('loja').AsString;
      tnumero.Text := FieldByName('numero').AsString;
      tcpf.Text := FieldByName('cpf_cnpj').AsString;
      tlinksite.Text := FieldByName('link_site').AsString;
      tlinkinsta.Text := FieldByName('link_instagram').AsString;

      // Atualiza as Check Boxes com base no valor de tipo_produto
      if Pos('Masculino', FieldByName('tipo_produto').AsString) > 0 then
        CheckBoxMasculino.Checked := True
      else
        CheckBoxMasculino.Checked := False;

      if Pos('Feminino', FieldByName('tipo_produto').AsString) > 0 then
        CheckBoxFeminino.Checked := True
      else
        CheckBoxFeminino.Checked := False;

      if Pos('Infantil', FieldByName('tipo_produto').AsString) > 0 then
        CheckBoxInfantil.Checked := True
      else
        CheckBoxInfantil.Checked := False;
    end
    else
    begin
      ShowMessage('Loja não encontrada.');
      with SQLQuery1 do
    begin
      Close;
      SQL.Clear;
      SQL.Add('select * from lojas');
      Open;
      Last;
    end;
    end;
  end;
end;

procedure TForm3.Button12Click(Sender: TObject);
begin
  with SQLQuery2 do
  begin
    Close;
    SQL.Clear;
    SQL.Add('insert into endereco (loja, feirao, bloco, cidade, estado)');
    SQL.Add('values (:ploja, :pfeirao, :pbloco, :pcidade, :pestado)');
    ParamByName('ploja').AsString := tnomeloja.Text;
    ParamByName('pfeirao').AsString := tfeirao.Text;
    ParamByName('pbloco').AsString := tnumerol.Text;
    ParamByName('pcidade').AsString := tcidade.Text;
    ParamByName('pestado').AsString := testado.text;
    ExecSQL;
  end;
  with SQLQuery2 do
    begin
      Close;
      SQL.Clear;
      SQL.Add('select * from endereco');
      Open;
      Last;
    end;
end;

procedure TForm3.Button13Click(Sender: TObject);
begin
  tnomeloja.Clear;
  tnumerol.Clear;
  tfeirao.ItemIndex := -1;
  tcidade.ItemIndex := -1;
  testado.ItemIndex := -1;
    with SQLQuery2 do
    begin
      Close;
      SQL.Clear;
      SQL.Add('select * from endereco');
      Open;
      Last;
    end;
end;

procedure TForm3.Button14Click(Sender: TObject);
begin

end;

procedure TForm3.Button15Click(Sender: TObject);
begin
  with SQLQuery2 do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT feirao, bloco, cidade, estado FROM endereco WHERE loja = :ploja');
    ParamByName('ploja').AsString := tnomeloja.Text;
    Open;

    if not Eof then
    begin
      tfeirao.Text := FieldByName('feirao').AsString;
      tnumerol.Text := FieldByName('bloco').AsString;
      tcidade.Text := FieldByName('cidade').AsString;
      testado.Text := FieldByName('estado').AsString;
    end
    else
    begin
      ShowMessage('Loja não encontrada.');
    end;
  end;
end;


procedure TForm3.Button16Click(Sender: TObject);
var
  FileStream: TFileStream;
  MemoryStream: TMemoryStream;
begin
  if (tnome3.Text = '') then
  begin
    ShowMessage('Por favor, preencha todos os campos.');
    Exit;
  end;
  MemoryStream := TMemoryStream.Create;
  try
    with SQLQuery1 do
    begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT logo FROM lojas WHERE loja = :pnome');
      ParamByName('pnome').AsString := tnome3.Text;
      Open;
      if not EOF then
      begin
        TBlobField(FieldByName('logo')).SaveToStream(MemoryStream);
        MemoryStream.Position := 0;
      end;
      Close;
    end;
    if (tlogo1Path <> '') and FileExists(tlogo1Path) then
    begin
      FileStream := TFileStream.Create(tlogo1Path, fmOpenRead or fmShareDenyWrite);
    end
    else
    begin
      FileStream := nil;
    end;
    try
      with SQLQuery1 do
      begin
        Close;
        SQL.Clear;
        SQL.Add('UPDATE lojas SET logo = :plogo WHERE loja = :ploja');
        ParamByName('ploja').AsString := tnome3.Text;
        if Assigned(FileStream) then
        begin
          ParamByName('plogo').LoadFromStream(FileStream, ftBlob);
        end
        else if MemoryStream.Size > 0 then
        begin
          ParamByName('plogo').LoadFromStream(MemoryStream, ftBlob);
        end
        else
        begin
          ParamByName('plogo').Clear;
        end;
        ExecSQL;
      end;
    finally
      if Assigned(FileStream) then
        FileStream.Free;
    end;
  finally
    MemoryStream.Free;
  end;
end;

procedure TForm3.Button17Click(Sender: TObject);
begin
    tlogo.Picture := nil;
end;

procedure TForm3.Button1Click(Sender: TObject);
var
  tipoSelecionado: string;
begin
  tipoSelecionado := '';
  if CheckBoxMasculino.Checked then
    tipoSelecionado := tipoSelecionado + 'Masculino,';
  if CheckBoxFeminino.Checked then
    tipoSelecionado := tipoSelecionado + 'Feminino,';
  if CheckBoxInfantil.Checked then
    tipoSelecionado := tipoSelecionado + 'Infantil,';
  if tipoSelecionado.EndsWith(',') then
    SetLength(tipoSelecionado, Length(tipoSelecionado) - 1);
  with SQLQuery1 do
  begin
    Close;
    SQL.Clear;
    SQL.Add('insert into lojas (email, loja, numero, cpf_cnpj, tipo_produto, link_site, link_instagram)');
    SQL.Add('values (:pemail, :pnome, :pnumero, :pcpf, :ptipo, :plinksite, :plinkinsta)');
    ParamByName('pemail').AsString := temail.Text;
    ParamByName('pnome').AsString := tnomemd.Text;
    ParamByName('pnumero').AsString := tnumero.Text;
    ParamByName('pcpf').AsString := tcpf.Text;
    ParamByName('ptipo').AsString := tipoSelecionado;
    ParamByName('plinksite').AsString := tlinksite.Text;
    ParamByName('plinkinsta').AsString := tlinkinsta.Text;
    ExecSQL;
  end;
  with SQLQuery1 do
    begin
      Close;
      SQL.Clear;
      SQL.Add('select * from lojas');
      Open;
      Last;
    end;
end;

procedure TForm3.Button2Click(Sender: TObject);
  var
  tipoSelecionado: string;
begin
  tipoSelecionado := '';
  if CheckBoxMasculino.Checked then
    tipoSelecionado := tipoSelecionado + 'Masculino,';
  if CheckBoxFeminino.Checked then
    tipoSelecionado := tipoSelecionado + 'Feminino,';
  if CheckBoxInfantil.Checked then
    tipoSelecionado := tipoSelecionado + 'Infantil,';

  // Remove a última vírgula, se houver
  if tipoSelecionado.EndsWith(',') then
    SetLength(tipoSelecionado, Length(tipoSelecionado) - 1);

  with SQLQuery1 do
  begin
    Close;
    SQL.Clear;
    SQL.Add('UPDATE lojas SET email = :pemail, loja = :pnome, numero = :pnumero, cpf_cnpj = :pcpf, tipo_produto = :ptipo, link_site = :plinksite, link_instagram = :plinkinsta WHERE loja = :pnome');
    ParamByName('pemail').AsString := temail.Text;
    ParamByName('pnome').AsString := tnomemd.Text;
    ParamByName('pnumero').AsString := tnumero.Text;
    ParamByName('pcpf').AsString := tcpf.Text;
    ParamByName('ptipo').AsString := tipoSelecionado;
    ParamByName('plinksite').AsString := tlinksite.Text;
    ParamByName('plinkinsta').AsString := tlinkinsta.Text;
    ExecSQL;
  end;

  // Atualiza a visualização dos dados
  with SQLQuery1 do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT * FROM lojas ORDER BY id');
    Open;
    Last;
  end;
end;

procedure TForm3.Button3Click(Sender: TObject);
begin
  if (tnomemd.Text = '') then
  begin
    ShowMessage('Por favor, insira o nome da loja que deseja deletar.');
    Exit;
  end;
  if MessageDlg('Você realmente deseja excluir esta loja?', mtConfirmation, [mbYes, mbNo], 0) = mrYes  then
  with SQLQuery1 do
  begin
    close;
    sql.clear;
    sql.Add('delete from lojas where loja =:pnome');
    ParamByName('pnome').AsString:= tnomemd.text;
    ExecSQL;
  end;
  with SQLQuery1 do
  begin
    close;
    sql.clear;
    sql.add('select * from lojas');
    open;
    Last;
  end;
end;

procedure TForm3.Button4Click(Sender: TObject);
begin
  with SQLQuery1 do
  begin
    Close;
    SQL.Clear;
    SQL.Add('insert into lojas (email, loja, numero, cpf_cnpj, tipo_produto, link_site, link_instagram)');
    SQL.Add('values (:pemail, :pnome, :pnumero, :pcpf, :ptipo, :plinksite, :plinkinsta)');
    ParamByName('pemail').AsString := temail.Text;
    ParamByName('pnome').AsString := tnomemd.Text;
    ParamByName('pnumero').AsString := tnumero.Text;
    ParamByName('pcpf').AsString := tcpf.Text;
    ExecSQL;
  end;
  with SQLQuery1 do
    begin
      Close;
      SQL.Clear;
      SQL.Add('select * from enderecos');
      Open;
      Last;
    end;
end;

procedure TForm3.Button5Click(Sender: TObject);
begin
  with SQLQuery2 do
  begin
    Close;
    SQL.Clear;
    SQL.Add('UPDATE endereco SET feirao = :pfeirao, bloco = :pbloco, cidade = :pcidade, estado = :pestado WHERE loja = :ploja');
    ParamByName('ploja').AsString := tnomeloja.Text;
    ParamByName('pfeirao').AsString := tfeirao.Text;
    ParamByName('pbloco').AsString := tnumerol.Text;
    ParamByName('pcidade').AsString := tcidade.Text;
    ParamByName('pestado').AsString := testado.Text;
    ExecSQL;
  end;
  with SQLQuery2 do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT * FROM endereco');
    Open;
    Last;
  end;
end;

procedure TForm3.Button6Click(Sender: TObject);
var
  MemoryStream: TMemoryStream;
begin
  with SQLQuery1 do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT loja, logo, link_site, link_instagram FROM lojas WHERE loja = :pnome');
    ParamByName('pnome').AsString := tnome.Text;
    Open;
    if not EOF then
    begin
      tnome.Text := FieldByName('loja').AsString;
      tlinksitec.Text := FieldByName('link_site').AsString;
      tlinkinstac.Text := FieldByName('link_instagram').AsString;
      MemoryStream := TMemoryStream.Create;
      try
        TBlobField(FieldByName('logo')).SaveToStream(MemoryStream);
        MemoryStream.Position := 0;
        tlogo.Picture.LoadFromStream(MemoryStream);
      finally
        MemoryStream.Free;
      end;
    end
    else
    begin
      ShowMessage('Loja não encontrada.');
      Close;
      SQL.Clear;
      SQL.Add('SELECT * FROM lojas ORDER BY id');
      Open;
    end;
  end;
  DataSource1.DataSet := SQLQuery1;
end;

procedure TForm3.Button7Click(Sender: TObject);
begin
  with SQLQuery1 do
      begin
        Close;
        SQL.Clear;
        SQL.Add('SELECT * FROM lojas');
        Open;
      end;
    DataSource1.DataSet := SQLQuery1;
    tnome.Clear;
    tlinksitec.Clear;
    tlinkinstac.Clear;
    tlogo.Picture := nil;
end;

procedure TForm3.Button8Click(Sender: TObject);
begin
  if (tnomemd.Text = '') then
  begin
    ShowMessage('Por favor, insira o nome da loja que deseja deletar.');
    Exit;
  end;
  if MessageDlg('Você realmente deseja excluir esta loja?', mtConfirmation, [mbYes, mbNo], 0) = mrYes  then
  with SQLQuery1 do
  begin
    close;
    sql.clear;
    sql.Add('delete from endereco where loja =:pnome');
    ParamByName('pnome').AsString:= tnomeloja.text;
    ExecSQL;
  end;
  with SQLQuery1 do
  begin
    close;
    sql.clear;
    sql.add('select * from endereco');
    open;
    Last;
  end;
end;

procedure TForm3.Button9Click(Sender: TObject);
begin
  temail.Clear;
  tnome.Clear;
  tnumero.Clear;
  tcpf.Clear;
  tlinksite.Clear;
  tlinkinsta.Clear;
  CheckBoxMasculino.Checked := False;
  CheckBoxFeminino.Checked := False;
  CheckBoxInfantil.Checked := False;
    with SQLQuery1 do
    begin
      Close;
      SQL.Clear;
      SQL.Add('select * from lojas');
      Open;
      Last;
    end;
end;

procedure TForm3.FormCreate(Sender: TObject);
begin

end;

procedure TForm3.PageControl1Change(Sender: TObject);
begin

end;

procedure TForm3.TabSheet2ContextPopup(Sender: TObject; MousePos: TPoint;
  var Handled: Boolean);
begin

end;

procedure TForm3.tlinkinstacClick(Sender: TObject);
begin
  OpenURL(tlinkinstac.Text);
end;

procedure TForm3.tlinksitecClick(Sender: TObject);
begin
  OpenURL(tlinksitec.Text);
end;

procedure TForm3.tlogo1Click(Sender: TObject);
begin
  if OpenPictureDialog1.Execute = true then
     tlogo1.Picture.LoadFromFile (OpenPictureDialog1.filename);
     tlogo1Path := OpenPictureDialog1.FileName;
end;

procedure TForm3.tnomemdChange(Sender: TObject);
begin

end;

end.

