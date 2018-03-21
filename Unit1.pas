unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,Objects;

type
  TForm1 = class(TForm)
    Memo1: TMemo;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    Button8: TButton;
    procedure Button5Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);

  private
    { Private-Deklarationen }


  public
    { Public-Deklarationen }
      procedure split(Del : Char; Str: String; list : tstringlist);
      function checkCondition() : Boolean;
      function getText(filename: String): tstringlist;
      procedure StoryAblauf();
      procedure StoryContinue();
      procedure StoryClear();
      procedure StoryEnd();
      function getData() : String;
      procedure setData(setter : String);
      function getPlayer() : Tplayer;
      procedure setPlayer(setter : Tplayer);
  end;
  var
  Form1: TForm1;

implementation
  uses Unit3, Unit2, save, load;

  var

  myStory: TextFile;
  ButtonSelec : integer;
  Pause : boolean;
  selecs : Array[0..2] of selec;
  player: Tplayer;
  data : String;
  dir : String;




{$R *.dfm}
// Spieler setzen + im Stats Fenster updaten
procedure TForm1.setPlayer(setter : Tplayer);
begin
  player := setter;
  Form3.onUpdate(player);
end;

procedure TForm1.setData(setter : string);
Begin
  data := setter;
End;

function TForm1.getData;
begin
  result := data;
end;

function TForm1.getPlayer;
begin
  result := player;
end;
// Nachdem ein Selection Button gedr�ckt wird: Pr�fung ob man die n�tigen Vorraussetzungen daf�r hat
function TForm1.checkCondition() : Boolean;
var con : string;
begin
  con := selecs[ButtonSelec - 1].checkForCondition(player);
  if  not(con = '') then
  Begin
    Memo1.Lines.Append('Du hast nicht die Vorraussetzungen um das auszuf�hren ! W�hle was anderes!');
    Memo1.Lines.Append('');
    Memo1.Lines.Append('Du brauchst ' + con );
  End
  else
    StoryContinue();
end;

procedure TForm1.FormCreate(Sender: TObject);  //Initialisierung des Inventory Men�s
begin
  Form3.setInventory('Hier ist nichts!');
end;

//Dateien k�nnen hiermit in Stringlists umgewandelt werden
function TForm1.getText(filename : String) : tstringlist;
begin
  result := TStringList.Create;
  if (FileExists(filename)) then
  begin

    result.Loadfromfile(filename);
  end;

end;
// Hiermit kann ein String in Abh�ngigkeit von einem Parameter in mehrere Substrings geteilt werden damit
// man die Selections auslesen kann
procedure TForm1.split(Del : Char; Str: String;list : tstringlist );
Begin
    list.clear;
    list.Delimiter       := Del;
    list.StrictDelimiter := True; // Requires D2006 or newer.
    list.DelimitedText   := Str;
End;
// jeder Button setzt eine Variable und pr�ft dann die Conditions daf�r
procedure TForm1.Button1Click(Sender: TObject);           //Mgl1
begin
  ButtonSelec := 1;
  checkCondition();
end;
                                                          //Mgl2
procedure TForm1.Button2Click(Sender: TObject);
begin
  ButtonSelec := 2;
  checkCondition();
end;

procedure TForm1.Button3Click(Sender: TObject);           //Mgl3
begin
  ButtonSelec := 3;
  checkCondition();
end;

procedure TForm1.Button4Click(Sender: TObject);      // Stats
begin
  Form3.Show;
end;

procedure TForm1.Button5Click(Sender: TObject);      // Menu
begin
  //dlg:=TForm2.Create(self);
  //dlg.Show;
  Form1.Hide;
  Form2.Show;
end;

procedure TForm1.Button6Click(Sender: TObject);       //Save Dialog
begin
  Form4.FormCreate(Form1);
  Form4.Show;
  Form1.Enabled := false;
end;

procedure TForm1.Button7Click(Sender: TObject);       //Load Dialog
begin
  Form5.FormCreate(Form1);
  Form5.Show;
  Form1.Enabled := false;
end;

procedure TForm1.Button8Click(Sender: TObject);        //New Game
begin
  player := Tplayer.create(0, 0, 30, 10);
  Memo1.Lines.Clear;
  Form3.onUpdate(player);
  data:= GetCurrentDir() + '\Story\Prolog1.txt';
  StoryAblauf();

end;
//Die initialisierungsroutine f�r jede Story Datei
procedure TForm1.StoryAblauf();
var subs: tstringlist;
  lauf : String;
  j: Integer;
var l , i : Integer;
  test1:Integer;
  test2:Integer;
Begin
    subs := getText(data);
    Memo1.Lines.BeginUpdate;    //Kein Verrutschen der Zeilen beim hinzuf�gen von Lines im Memo
    try
      for j := 1 to strtoint(subs[0]) do
        Begin
        Memo1.Lines.Append(subs[j]);
        Memo1.Lines.Append('');
        End;
    finally
      Memo1.Lines.EndUpdate;    //Das Ende von dem nicht verrutschen Befehl
    end;
  i := 0;
  for l := 0 to strtoint(subs[strtoint(subs[0])+1])-1 do  //strtoint(subs[strtoint(subs[0])+1])-1 = die Anzahl der Buttons die vorhanden sind
  Begin
    test1:= strtoint(subs[strtoint(subs[0])+1]);
    test2 := strtoint(subs[0])+ 2 +l + i;
    lauf:= subs[test2];
    if lauf <> '' then                        //lediglich eine Routine zur Sicherstellung falls leere Zeilen vorhanden sind
      selecs[l] := selec.create(lauf)         //erstellen eines Objekts mit dem Parameter lauf (weitere Initialisierung in Objects.pas automatisch)
    else
      i := i +1;
  End;

    case strtoint(subs[strtoint(subs[0])+1]) of      //Jenachdem wie viele Buttons vorhanden sind werden diese ein-/ausgeschalten und mit Text versehen
      1:Begin
          Button1.Visible := true;
          Button2.Visible := false;
          Button3.Visible := false;
          Button1.Caption := selecs[0].getText;
        End;
      2:Begin
        Button2.Visible := true;
        Button1.Visible := true;
        Button3.Visible := false;
        Button1.Caption := selecs[0].getText;
        Button2.Caption := selecs[1].getText;
      End;
      3:Begin
        Button3.Visible := true;
        Button2.Visible := true;
        Button1.Visible := true;
        Button1.Caption := selecs[0].getText;
        Button2.Caption := selecs[1].getText;
        Button3.Caption := selecs[2].getText;
      End;
    end;
  //Alle Auswahlen durchgehen
  subs.free;

  //An der Stelle wird darauf gewartet, dass eine Button Eingabe get�tigt wird

End;

procedure TForm1.StoryContinue;
var URL : String;
    ending : boolean;
begin
  if (selecs[ButtonSelec -1].getState = 2) or (selecs[ButtonSelec -1].getState = 3) THEN  //wenn ein Effekt vorhanden ist (einteilung in States bei Selections)
    ending := player.setEffect(selecs[ButtonSelec -1].getEffect);   // wird dieser Ausge�bt
  //wenn die n�chste URL leer ist dann aufh�ren
  URL := selecs[ButtonSelec - 1].getURL;                  //neue URL pr�fen
  if  (URL <> '') and (ending)then
  Begin
   //n�chste Datei einlesen
   dir := GetCurrentDir();
   data := dir + selecs[ButtonSelec -1].getURL;           // neue Datei abh�ngig von der relativen Position wird ausgelesen
   StoryClear;
  End
  else
    StoryEnd();
end;

procedure TForm1.StoryClear;
var i : integer;
begin
  for i := 0 to 2 do
   Begin
    if selecs[i] <> nil then                             // Alle Selections werden 'nil' gesetzt um diese Sp�ter wieder neu gesetzt werden k�nnen
      selecs[i].free;
    selecs[i] := nil;
   End;
   Memo1.Lines.Clear;                                    //Memo wird leer gemacht
   StoryAblauf();                                        //Neuer Beginn der Initialisierungs routine
end;

//Falls keine n�chste Datei mehr angegeben ist
procedure TForm1.StoryEnd;
var i,l : integer;
begin

  ShowMessage('Das Spiel ist in dieser Fassung des Spiels (v1.1) an dieser Stelle vorbei!' + #10#13 + 'Wir danken f�rs spielen!' + #10#13 + 'Wir hoffen es hat euch gefallen!' + #10#13 + 'Euer Team von Ansgars Adventure :)');
  //Alles zur�cksetzen
  player.free;
  for i := 0 to 2 do
    if selecs[i] <> nil then
      selecs[i].free;
  Memo1.Lines.Clear;
  for l := 0 to 10 do
    Memo1.Lines.Append('');
  Memo1.Lines.Append('                      Danke f�rs spielen!');





end;

end.
