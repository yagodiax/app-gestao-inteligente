unit Unit7;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, DB, SQLDB, Forms, Controls, Graphics, Dialogs, Buttons,
  StdCtrls, DBCtrls, DBGrids, ExtCtrls, ExtDlgs, mysql56conn;

type

  { TForm6 }

  TForm6 = class(TForm)
    BitBtn1: TBitBtn;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button6: TButton;
    Button7: TButton;
    Label10: TLabel;
    OpenPictureDialog1: TOpenPictureDialog;
    timg: TDBGroupBox;
    tlogo2: TDBImage;
    ttiporoupa: TComboBox;
    tendereco: TComboBox;
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
    Label3: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    SQLQuery1: TSQLQuery;
    SQLTransaction1: TSQLTransaction;
    temail: TEdit;
    tlinkinsta: TEdit;
    tlinksite: TEdit;
    tnome: TEdit;
    tnumero: TEdit;
    Image1: TImage;
    Label2: TLabel;
    Label4: TLabel;
    lblEntre: TLabel;
    Panel1: TPanel;
    tcpf: TEdit;
    procedure BitBtn1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure tlogo2Click(Sender: TObject);

    private

    tlogoPath: string;
  end;
var
  Form6: TForm6;

implementation

uses Unit2;

{$R *.lfm}

{ TForm6 }


procedure TForm6.FormCreate(Sender: TObject);
begin
     with SQLQuery1 do
  begin
     close;
      sql.clear;
      sql.Add('select * from lojas order by id');
      open;
  end;
end;

procedure TForm6.tlogo2Click(Sender: TObject);
begin
  if OpenPictureDialog1.Execute = true then
     tlogo2.Picture.LoadFromFile (OpenPictureDialog1.filename);
     tlogoPath := OpenPictureDialog1.FileName;
end;

procedure TForm6.BitBtn1Click(Sender: TObject);
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

procedure TForm6.Button1Click(Sender: TObject);
var
  FileStream: TFileStream;
  MemoryStream: TMemoryStream;
begin
  if (temail.Text = '') or (tnome.Text = '') or (tnumero.Text = '') or (tcpf.Text = '') then
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
      ParamByName('pnome').AsString := tnome.Text;
      Open;
      if not EOF then
      begin
        TBlobField(FieldByName('logo')).SaveToStream(MemoryStream);
        MemoryStream.Position := 0;
      end;
      Close;
    end;
    if (tlogoPath <> '') and FileExists(tlogoPath) then
    begin
      FileStream := TFileStream.Create(tlogoPath, fmOpenRead or fmShareDenyWrite);
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
        SQL.Add('insert into lojas (email, loja, numero, cpf_cnpj, logo, endereco, tipo_produto, link_site, link_instagram)');
        SQL.Add('values (:pemail, :pnome, :pnumero, :pcpf, :plogo, :pend, :ptpp, :pls, :pli)');
        ParamByName('pemail').AsString := temail.Text;
        ParamByName('pnome').AsString := tnome.Text;
        ParamByName('pnumero').AsString := tnumero.Text;
        ParamByName('pcpf').AsString := tcpf.Text;

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
        ParamByName('pend').AsString := tendereco.Text;
        ParamByName('ptpp').AsString := ttiporoupa.Text;
        ParamByName('pls').AsString := tlinksite.Text;
        ParamByName('pli').AsString := tlinkinsta.Text;
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
    finally
      if Assigned(FileStream) then
        FileStream.Free;
    end;
  finally
    MemoryStream.Free;
  end;
end;


procedure TForm6.Button2Click(Sender: TObject);
var
  FileStream: TFileStream;
  MemoryStream: TMemoryStream;
begin
  if (tnome.Text = '') then
  begin
    ShowMessage('Por favor, insira o nome da loja.');
    Exit;
  end;

  MemoryStream := TMemoryStream.Create;
  try
    with SQLQuery1 do
    begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT logo FROM lojas WHERE loja = :pnome');
      ParamByName('pnome').AsString := tnome.Text;
      Open;
      if not EOF then
      begin
        TBlobField(FieldByName('logo')).SaveToStream(MemoryStream);
        MemoryStream.Position := 0;
      end;
      Close;
    end;

    if (tlogoPath <> '') and FileExists(tlogoPath) then
    begin
      FileStream := TFileStream.Create(tlogoPath, fmOpenRead or fmShareDenyWrite);
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
        SQL.Add('UPDATE lojas SET email = :pemail, loja = :pnome, numero = :pnumero, cpf_cnpj = :pcpf, logo = :plogo WHERE loja = :pnome');
        ParamByName('pemail').AsString := temail.Text;
        ParamByName('pnome').AsString := tnome.Text;
        ParamByName('pnumero').AsString := tnumero.Text;
        ParamByName('pcpf').AsString := tcpf.Text;

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

  with SQLQuery1 do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT * FROM lojas WHERE loja = :pnome');
    ParamByName('pnome').AsString := tnome.Text;
    Open;
    Last;
  end;
end;


procedure TForm6.Button3Click(Sender: TObject);
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
    sql.Add('delete from lojas where loja =:pnome');
    ParamByName('pnome').AsString:= tnome.text;
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

procedure TForm6.Button4Click(Sender: TObject);
begin
  with SQLQuery1 do
  begin
    close;
    sql.clear;
    sql.Add('select * from lojas order by email');
    open;
  end;
end;

procedure TForm6.Button5Click(Sender: TObject);
begin
  with SQLQuery1 do
  begin
    close;
    sql.clear;
    sql.Add('select * from lojas order by loja');
    open;
  end;
end;

procedure TForm6.Button6Click(Sender: TObject);
var
  MemoryStream: TMemoryStream;
begin
  with SQLQuery1 do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT id, loja, email, numero, cpf_cnpj, logo, endereco, tipo_produto, link_site, link_instagram FROM lojas WHERE loja = :pnome');
    ParamByName('pnome').AsString := tnome.Text;
    Open;
    if not EOF then
    begin
      temail.Text := FieldByName('email').AsString;
      tnome.Text := FieldByName('loja').AsString;
      tnumero.Text := FieldByName('numero').AsString;
      tcpf.Text := FieldByName('cpf_cnpj').AsString;
      tendereco.Text := FieldByName('endereco').AsString;
      ttiporoupa.Text := FieldByName('tipo_produto').AsString;
      tlinksite.Text := FieldByName('link_site').AsString;
      tlinkinsta.Text := FieldByName('link_instagram').AsString;
      MemoryStream := TMemoryStream.Create;
      try
        TBlobField(FieldByName('logo')).SaveToStream(MemoryStream);
        MemoryStream.Position := 0;
        tlogo2.Picture.LoadFromStream(MemoryStream);
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


procedure TForm6.Button7Click(Sender: TObject);
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
    temail.Clear;
    tnumero.Clear;
    tcpf.Clear;
    tendereco.Clear;
    ttiporoupa.Clear;
    tlinksite.Clear;
    tlinkinsta.Clear;
    tlogo2.Picture := nil;
end;
end.
