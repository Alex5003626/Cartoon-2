unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Timer1: TTimer;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;
  i, s, ClDelta, ClDelta2, Sangle, angle1, angle2, bangle: integer;
  flag, flag2, flagBall: Boolean;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);                            // первоначальные данные //
begin
  i:= 0;
  s:= 0;
  Sangle:= 230;
  ClDelta:= 0;
  ClDelta2:= 300;
  ClientHeight:= 600;
  ClientWidth:= 1000;
  angle1:= -80;
  angle2:= 90;
  bangle:= 80;
  flag:= True;
  flag2:= False;
  flagBall:= True;
end;


function RandomColor(): TColor;
begin
  Randomize;

  Result := RGBToColor(Random(256), Random(256), Random(256));
end;


procedure rotate(var x : integer; var y : integer; angle : double);      // поворот //
var
  xbuf : double;
  rangle : double;
begin
   rangle := angle * pi / 180;
   xbuf := x * cos(rangle) + y * sin(rangle);
   y := Trunc(-x * sin(rangle) + y * cos(rangle));
   x := Trunc(xbuf);
end;



procedure Background(Canvas: Tcanvas);                                // небо //
begin

  Canvas.Clear;
  Canvas.Clear;

  if (i < 28) then
    Canvas.Brush.Color:= RGBToColor(135, 206, 235);
    Canvas.FillRect(0, 0, 1500, 500);

  if (i > 27) and (i < 50) then
    Canvas.Brush.Color:= RGBToColor(141, 209, 254);
    Canvas.FillRect(0, 0, 1500, 500);

  if (i > 49) then
    Canvas.Brush.Color:= RGBToColor(99, 192, 254);
    Canvas.FillRect(0, 0, 1500, 500);

  if (i > 65) then
    i:= 0;

  i:= i + 1;
end;


procedure Sun(Canvas: Tcanvas);                                         // солнце //
var
  x, y: integer;
begin
  x:=300;
  y:=300;
  rotate(x, y, Sangle);
  Canvas.Pen.Color:= clWhite;
  Canvas.Brush.Color:= clYellow;
  Canvas.Ellipse(550+ x, 500 + y - 100,650 + x,500 + y);

  if s < 80 then
     Sangle:= Sangle - 1;
     s:= s + 1;

end;

procedure Clouds(Canvas: Tcanvas);                                             // облака //
begin

    Canvas.Brush.Color:= clCream;
    Canvas.Pen.Color:= clCream;

    Canvas.Ellipse(50 + ClDelta, 80, 200 +  ClDelta, 150);                     // ОБЛАКО 1 //
    Canvas.Ellipse(130 + ClDelta, 50, 240 + ClDelta, 100);
    Canvas.Ellipse(220 + ClDelta, 80, 320 + ClDelta, 150);
    Canvas.Polygon([point(100 + ClDelta, 140), point(300 + ClDelta, 120), point(160 + ClDelta, 60)] );

    if flag then
      ClDelta:= ClDelta + 5;

    if not flag then
      ClDelta:= ClDelta - 5;

    if ClDelta > 680  then
      flag:= False;

    if ClDelta < -30 then
      flag:= True;


    Canvas.Ellipse(30 + ClDelta2, 100, 200 +  ClDelta2, 150);                     // ОБЛАКО 2 //
    Canvas.Ellipse(130 + ClDelta2, 50, 240 + ClDelta2, 100);
    Canvas.Ellipse(220 + ClDelta2, 80, 320 + ClDelta2, 150);
    Canvas.Polygon([point(80 + ClDelta2, 140), point(180 + ClDelta2, 120), point(160 + ClDelta2, 60)] );

    if flag2 then
      ClDelta2:= ClDelta2 + 5;

    if not flag2 then
      ClDelta2:= ClDelta2 - 5;

    if ClDelta2 > 680  then
      flag2:= False;

    if ClDelta2 < -30 then
      flag2:= True;


end;
                                                                                  // дом //
procedure House(Canvas: TCanvas);
begin
    Canvas.Pen.Width:= 0;
    Canvas.Brush.Color:= RandomColor();
    Canvas.FillRect(700, 350, 850, 280);
    Canvas.Polygon([point(850, 280), point(700, 280), point(760, 200)]);
    Canvas.FillRect(800, 280, 830, 190);
end;

procedure Playground(Canvas: TCanvas);                                            // площадка //
var
  i, deltaX, deltaY, Delta: integer;
begin
    Delta := 0;
    deltaX:= 10;
    deltaY:= 0;


    Canvas.Brush.Color:= RGBToColor(0, 206, 0);
    Canvas.FillRect(0, 330, 1000, 650);

    Canvas.Brush.Color:= RGBToColor(195, 195, 195);
    Canvas.Polygon([point(75 , 515), point(195 , 360), point(880 , 360), point(770 , 515)] );

    Canvas.Pen.Color:= clBlack;
    Canvas.Line(430, 500, 430, 330);
    Canvas.Line(575, 390, 575, 230);

    Canvas.Pen.Color:= clWhite;

    for i:= 0 to 4 do
    begin
      Canvas.Line(430, 330 + Delta, 575, 230 + Delta);

      Delta:= Delta + 15;
    end;

    for i:= 0 to 13 do
    begin
      Canvas.Line(430 + deltaX, 380 + deltaY, 430 + deltaX, 330 + deltaY);

      deltaX:= deltaX + 10;
      deltaY:= deltaY - 7;
    end;


end;


procedure Player1(Canvas: TCanvas);
var                                                                              // левый игрок //
  x, y: integer;
begin
    x:= 30;
    y:= 30;

    rotate(x, y, angle1);

    Canvas.Pen.Color:= clBlue;
    Canvas.Pen.Width:= 3;
    Canvas.Line(170, 490, 205, 450);
    Canvas.Line(233, 470, 205, 450);

    Canvas.Line(205, 450, 205, 380);

    Canvas.Line(205, 410, 200 + x, 410 + y);                                           // левая //

    Canvas.Line(205, 410, 230, 380);
    Canvas.Ellipse(180, 340, 230, 380);

    angle1:= angle1 + 7;
end;


procedure Player2(Canvas: TCanvas);
var                                                                               // правый игрок //
  deltaY, deltaX, x, y: integer;
begin
    deltaY:= 80;
    deltaX:= 500;

    x:= 30;
    y:= 30;

    rotate(x, y, angle2);

    Canvas.Pen.Color:= clBlue;
    Canvas.Pen.Width:= 3;
    Canvas.Line(190 + deltaX, 490 - deltaY, 225 + deltaX, 450 - deltaY);
    Canvas.Line(253 + deltaX, 470 - deltaY, 225 + deltaX, 450 - deltaY);

    Canvas.Line(225 + deltaX, 450 - deltaY, 225 + deltaX, 380 - deltaY);
    Canvas.Line(225 + deltaX, 410 - deltaY, 190 + deltaX, 390 - deltaY);

    Canvas.Line(225 + deltaX, 410 - deltaY, 230 + x + deltaX, 410 + y - deltaY);          // правая //

    Canvas.Ellipse(200 + deltaX, 340 - deltaY, 250 + deltaX, 380 - deltaY);

    angle2:= angle2 + 7;

end;

procedure Ball(Canvas: TCanvas);
var
  x, y: integer;
begin
    x:= 200;
    y:= 200;

    rotate(x, y, bangle);

    Canvas.Pen.Color:= clBlack;
    Canvas.Pen.Width:= 1;
    Canvas.Brush.Color:= RGBToColor(226, 226, 226);

    Canvas.Ellipse(500 + x, 410 + y, 530 + x, 440 + y);

    if flagBall then
      bangle:= bangle + 2;

    if not flagBall then
      bangle:= bangle - 2;

    if bangle > 220 then
      flagBall:= False;

    if bangle < 70 then
      flagBall:= True;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  Timer1.Enabled:= True;
end;


procedure TForm1.Timer1Timer(Sender: TObject);
begin
  Background(Canvas);
  Sun(Canvas);
  Clouds(Canvas);
  Playground(Canvas);
  House(Canvas);
  Player1(Canvas);
  Player2(Canvas);
  Ball(Canvas);


end;

end.

