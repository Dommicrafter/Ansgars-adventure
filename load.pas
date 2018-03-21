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
    Button4: TButton;
    procedure FormCreate(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
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

uses Unit1, Objects;

procedure TForm5.initializeButton(Button: Integer; filename : String);      //Kn�pfe werden initialisiert (s. save.pas)
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

procedure TForm5.Button1Click(Sender: TObject);                 //Save 1
var player : Tplayer;
    items : TStringList;
    i : integer;
begin
  if(SaveExist1) then                                           //wenn dieser Save existiert
  Begin
    items := TStringList.Create;
    Form1.setData(SaveStats1[1]);                              //URL wird in Hauptroutine auf gespeicherte URL gesetzt
    player := Tplayer.create(strtoint(SaveStats1[2]), strtoint(SaveStats1[3]), strtoint(SaveStats1[4]), strtoint(SaveStats1[5]));   // neuer Player wird erstelt
    if StrToInt(SaveStats1[6]) <> 0 then
      for i := 0 to strtoint(SaveStats1[6]) - 1 do
      Begin
        items.Append(SaveStats1[7 + i]);                       // items werden dem neuem player hinzugef�gt
      End;
    player.setItems(items);
    Form1.setPlayer(player);                                   //player zur Hauptroutine hinzugef�gt
    Form1.Enabled := true;
    Form1.StoryClear;
    ShowMessage('Profil geladen!');
    Form5.Hide
  End;
end;
                                                              //Save 2
procedure TForm5.Button2Click(Sender: TObject);
var player : Tplayer;
    items : TStringList;
    i : integer;
begin
  if(SaveExist2) then
  Begin
    items := TStringList.Create;
    Form1.setData(SaveStats2[1]);
    player := Tplayer.create(strtoint(SaveStats2[2]), strtoint(SaveStats2[3]), strtoint(SaveStats2[4]), strtoint(SaveStats2[5]));
    for i := 0 to strtoint(SaveStats2[6]) do
    Begin
      items.Append(SaveStats2[7 + i]);
    End;
    Form1.setPlayer(player);
    Form1.Enabled := true;
    Form1.StoryClear;
    ShowMessage('Profil geladen!');
    Form5.Hide
  End;
end;

procedure TForm5.Button3Click(Sender: TObject);       //Save 3
var player : Tplayer;
    items : TStringList;
    i : integer;
begin
  if(SaveExist3) then
  Begin
    items := TStringList.Create;
    Form1.setData(SaveStats3[1]);
    player := Tplayer.create(strtoint(SaveStats3[2]), strtoint(SaveStats3[3]), strtoint(SaveStats3[4]), strtoint(SaveStats3[5]));
    for i := 0 to strtoint(SaveStats3[6]) do
    Begin
      items.Append(SaveStats3[7 + i]);
    End;
    Form1.setPlayer(player);
    Form1.Enabled := true;
    Form1.StoryClear;
    ShowMessage('Profil geladen!');
    Form5.Hide
  End;
end;

procedure TForm5.Button4Click(Sender: TObject);        // Cancel
begin
  Form1.Enabled := true;
  Form5.Hide;
end;
                                                      // bei jedem Start ded Fensters wird das ausgef�hrt (s. save.pas)
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
