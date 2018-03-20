unit load;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TForm5 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    procedure FormCreate(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
    procedure initializeButton(Button: Integer; filename : String);
  end;

var
  Form5: TForm5;
  Save1: TextFile;
  SaveStats1 : tstringlist;
  SaveExist1: boolean;
  Save2 : TextFile;
  SaveStats2 : tstringlist;
  SaveExist2: boolean;
  Save3 : TextFile;
  SaveStats3 : tstringlist;
  SaveExist3: boolean;

implementation

{$R *.dfm}

procedure TForm5.initializeButton(Button: Integer; filename : String);
begin
  case Button of
  1:Begin
    SaveStats1:= Form1.getText(filename);
    AssignFile(Save1, filename);
    Reset(Save1);
    Button1.Caption := SaveStats1[0];
    CloseFile(Save1);
  End;
  2:Begin
    SaveStats2:= Form1.getText(filename);
    AssignFile(Save2, filename);
    Reset(Save2);
    Button2.Caption := SaveStats1[0];
    CloseFile(Save2);
  End;
  3:Begin
    SaveStats1:= Form1.getText(filename);
    AssignFile(Save1, filename);
    Reset(Save3);
    Button1.Caption := SaveStats1[0];
    CloseFile(Save3);
  End;
  end;

end;

procedure TForm5.FormCreate(Sender: TObject);
begin
  SaveStats1 := tstringlist.create;
  SaveStats2 := tstringlist.create;
  SaveStats3 := tstringlist.create;
  if FileExists(GetCurrentDir() + '\Saves\save1.zrk') then
  Begin
    initializeButton(1, GetCurrentDir() + '\Saves\save1.zrk');
    SaveExist1 := true;
  End
  else SaveExist1 := false;

  if FileExists(GetCurrentDir() + '\Saves\save2.zrk') then
  Begin
    initializeButton(2, GetCurrentDir() + '\Saves\save2.zrk');
    SaveExist2 := true;
  End
  else  SaveExist2 := false;
  if FileExists(GetCurrentDir() + '\Saves\save3.zrk') then
  Begin
    initializeButton(3, GetCurrentDir() + '\Saves\save3.zrk');
    SaveExist3 := true;
  End
  else SaveExist3 := false;
end;

end.
