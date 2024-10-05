unit Unit6;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, SQLDB, DB, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls, MaskEdit, DBGrids;

type

  { TForm6 }

  TForm6 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button7: TButton;
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
    Image3: TImage;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label9: TLabel;
    lblEntre: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    SQLQuery1: TSQLQuery;
    SQLTransaction1: TSQLTransaction;
    tdata: TMaskEdit;
    tdetalhes: TEdit;
    tvalor: TEdit;
    tvalor1: TEdit;
  private

  public

  end;

var
  Form6: TForm6;

implementation

{$R *.lfm}

end.

