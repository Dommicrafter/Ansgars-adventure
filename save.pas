unit save;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, StdCtrls;

type
  TForm4 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
    procedure initializeButton(Button : integer; filename : String);
    procedure fillFile(list : tstringlist; existing : boolean; save : integer);
  end;

var
  Form4: TForm4;
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

procedure TForm4.fillFile(list : tstringlist; existing : boolean; save : integer);
var player : Tplayer;
  i: Integer;
  l: Integer;
  test : string;
Begin
  player := Form1.getPlayer;
  if not(existing) then
  Begin
    list := list.Create;
    list.Append(InputBox('Profil Name eingeben!', 'Geben Sie Ihrem Profil einen Namen!', 'Ansgar'));
  End;
    list.append(Form1.getData());
    list.append(inttostr(player.getGold));
    list.append(inttostr(player.getArmor));
    list.append(inttostr(player.getHealth));
    list.append(inttostr(player.getStrength));
    list.append(inttostr(player.getItems.Count));
    for i := 0 to player.getItems.Count -1 do
    Begin
      list.append(player.getItems[i]);
    End;
  for l := 0 to list.Count - 1 do
  Begin
    test := list[l];
    case save of
    1: WriteLn(Save1, list[l]);
    2: WriteLn(Save2, list[l]);
    3: WriteLn(Save3, list[l]);
    end;
  End;
  case save of
  1: CloseFile(Save1);
  2: CloseFile(Save2);
  3: CloseFile(Save3);
  end;
  SaveStats1.free;
  SaveStats2.free;
  SaveStats3.free;
  Form1.Enabled := true;
  Form4.Hide;
End;

procedure TForm4.initializeButton(Button: Integer; filename : String);
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

procedure TForm4.Button1Click(Sender: TObject);
begin
  if not(SaveExist1) then
  Begin
    AssignFile(Save1, GetCurrentDir() + '\Saves\save1.zrk');
      Rewrite(Save1);
    fillFile(SaveStats1, false, 1);
  End
    else
    Begin
     DeleteFile(GetCurrentDir() + '\Saves\save1.zrk');
     AssignFile(Save1, GetCurrentDir() + '\Saves\save1.zrk');
     Rewrite(Save1);
     fillFile(SaveStats1, true, 1);
    End;
end;

procedure TForm4.Button2Click(Sender: TObject);
begin
  if not(SaveExist2) then
  Begin
    AssignFile(Save2, GetCurrentDir() + '\Saves\save2.zrk');
    Rewrite(Save2);
    fillFile(SaveStats2, false, 2);
  End
    else
    Begin
     DeleteFile(GetCurrentDir() + '\Saves\save2.zrk');
     AssignFile(Save2, GetCurrentDir() + '\Saves\save2.zrk');
     Rewrite(Save2);
     fillFile(SaveStats2, true, 2);
    End;
end;

procedure TForm4.Button3Click(Sender: TObject);
begin
if not(SaveExist3) then
  Begin
    AssignFile(Save3, GetCurrentDir() + '\Saves\save3.zrk');
    Rewrite(Save3);
    fillFile(SaveStats3, false, 3);
  End
    else
     Begin
     DeleteFile(GetCurrentDir() + '\Saves\save1.zrk');
     AssignFile(Save3, GetCurrentDir() + '\Saves\save1.zrk');
     Rewrite(Save3);
     fillFile(SaveStats3, true, 3);
     End;
end;

procedure TForm4.Button4Click(Sender: TObject);
begin
  Form1.Enabled := true;
  Form4.Hide;
end;

procedure TForm4.FormCreate(Sender: TObject);
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
