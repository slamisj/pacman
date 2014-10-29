uses graph,crt;
var a,b,i,j,e,f,g,h,l,q,r,s,u,v,
     pocet{treba sebrat tecek},pocetpriser,level,rychlost,pocetstrel:integer;
     timer,vybuch,zivotu,strelax,strelay,mstrelax,mstrelay,
       body,rekord,vyslx,vysly,pocitadlo,
       pocethracu,pocetzivych,pozice:integer;
     nehybnost,jestena,zeresteny,bomba,shootingon,strelaon,jsoupriserky:boolean;
     posx,mposx,posy,mposy,tvojebarva:array[1..3]of integer;
     c,alternativa: array[1..3]of char;
     funkcni:array[1..20]of boolean;
     mohu:array[1..21,1..15]of boolean;
     pole:array[1..20,1..4]of integer;{souradnice priser}
     barva:array[1..21,1..15]of integer;{barvy tecek}
     tecky:array[1..21,1..15]of boolean;{sebrana?}
     d:array[1..20]of integer;{smer pohybu priser}
     t,jmenorekord,jmeno,x:string;
     nacteme,dstrela:char;
     soubor,bludiste:text;

Procedure Dosad;
var i,j,k,l:integer;
begin
for i:=1 to 10 do
 for j:=1 to 21 do
  for k:=1 to 15 do
  begin
   if mohu[j,k] then
   begin
    l:=0;
    while ((j+l)<21) and(not(getpixel((j+l)*30,(k*30)-15)=white )) do
    begin
     l:=l+1;
     mohu[j+l,k]:=true;
     if (j+l=vyslx)and(k=vysly) then exit;
    end;
    l:=0;
    while ((j-l)>1) and(not(getpixel((j-l-1)*30,(k*30)-15)=white)) do
    begin
     l:=l+1;
     mohu[j-l,k]:=true;
     if (j-l=vyslx)and(k=vysly) then exit;
    end;
    l:=0;
    while ((k+l)<15) and(not(getpixel(((j)*30)-15,(k+l)*30)=white)) do
    begin
     l:=l+1;
     mohu[j,k+l]:=true;
     if (j=vyslx)and(k+l=vysly) then exit;
    end;
    l:=0;
    while ((k+l)>1) and(not(getpixel(((j)*30)-15,(k-l-1)*30)=white)) do
    begin
     l:=l+1;
     mohu[j,k-l]:=true;
     if (j=vyslx)and(k-l=vysly) then exit;
    end;

    end;
    end;
    end;

Procedure VytvorBludiste;
var i,j,k,l,carax,caray:integer;
begin
pocitadlo:=0;
setcolor(white);
line(0,0,630,0);
line(0,0,0,450);
line(0,450,630,450);
line(630,0,630,450);
setcolor(white);
outtextxy(300,470,'Loading...');
for i:=1 to 200+5*level do
 begin
  for j:= 1 to 21 do
   for k:=1 to 15 do mohu[j,k]:=false;
  if random(2)=0 then
  begin
    repeat
      carax:=random(20)*30+30;
      caray:=random(15)*30;
    until not(getpixel(carax,caray+15)=white);
  begin
  setcolor(white);
  line(carax,caray,carax,caray+30);
  mohu[carax div 30,(caray div 30)+1]:=true;
  vyslx:=(carax div 30)+1;
  vysly:=(caray div 30)+1;
  Dosad;
  begin
  if not mohu[(carax div 30)+1,(caray div 30)+1] then
   begin
     setcolor(black);
     line(carax,caray,carax,caray+30);
   end
  else
   begin
     write(bludiste,'line(',carax,',',caray,',',carax,',',caray+30,');');
     if pocitadlo mod 5=0 then writeln(bludiste);
     pocitadlo:=pocitadlo+1;
   end;
   end;
   end
   end
   else
   begin
   repeat
  carax:=random(21)*30;
  caray:=random(14)*30+30;
  until not(getpixel(carax+15,caray)=white);
  begin
  setcolor(white);
  line(carax,caray,carax+30,caray);
  mohu[(carax div 30)+1,(caray div 30)]:=true;
  vyslx:=(carax div 30)+1;
  vysly:=(caray div 30)+1;
  Dosad;
  begin
  if not mohu[(carax div 30)+1,(caray div 30)+1] then
   begin
   setcolor(black);
   line(carax,caray,carax+30,caray);
   end
   else
    begin
    write(bludiste,'line(',carax,',',caray,',',carax+30,',',caray,');');
    if pocitadlo mod 5=0 then writeln(bludiste);
    pocitadlo:=pocitadlo+1;
    end;
   end;
   end;
   end;
   end;
   setcolor(black);
   setfillstyle(1,black);
   bar(300,468,390,480);
end;

procedure konec;
begin
setcolor(red);
setfillstyle(1,red);
for i:=1 to 100 do
begin
 pieslice(random(getmaxx),random(getmaxy),0,360,random(40)+20);
 delay(10);
end;
 setfillstyle(1,black);
 setcolor(white);
 outtextxy(300,240,'GAME OVER');

for j:=1 to 100 do
begin
 setcolor(yellow);

 pieslice(6*j,240,0+3*(j mod 10),360-3*(j mod 10),50);
 delay(20);
 setcolor(black);

 pieslice(6*j,240,0+3*(j mod 10),360-3*(j mod 10),50);


end;

 closegraph;

 reset(soubor);
 readln(soubor,rekord);
 readln(soubor,jmenorekord);
  clrscr;
  textcolor(white);
  textbackground(black);
  writeln('Rekord: ',jmenorekord,' ',rekord);


 if body>rekord then
  begin
  writeln('Novy rekord!!! Ziskal jste ',body,' bodu.');
  write('Zadejte jmeno: ');
  read(jmenorekord);
  rewrite(soubor);
  writeln(soubor,body);
  writeln(soubor,jmenorekord);
  end
  else writeln('Ziskal jste ',body,' bodu.');
  readln;
  close(soubor);
  write(bludiste,pocitadlo);
  close(bludiste);
  end;

PROCEDURE Vstupnatecku;
begin
if (posx[l] mod 30>8) and(posx[l] mod 30<22)
    and(posy[l] mod 30>8) and(posy[l] mod 30<22)
      and (tecky[(posx[l]+30) div 30,((posy[l]+30)div 30)])
           then  begin

                  pocet:=pocet-1;
                  body:=body+1;
                  if barva[(posx[l]+30) div 30,((posy[l]+30)div 30)]=13 then
                   begin
                   pocet:=pocet-9;
                   body:=body+9;
                   end;
                  if pocet>=0 then
                  begin
                  t[8]:=chr(ord('0')+(pocet div 100));
                  t[9]:=chr(ord('0')+((pocet div 10)mod 10));
                  t[10]:=chr(ord('0')+(pocet mod 10));
                  end
                  else
                  begin
                  t[8]:='e';
                  t[9]:='n';
                  t[10]:='d';
                  end;
                  setfillstyle(1,black);
                  setcolor(black);
                  bar(250,470,380,480);
                  setcolor(green);
                  outtextxy(250,470,t);
                  (tecky[(posx[l]+30) div 30,((posy[l]+30)div 30)]):=false;
                  if barva[(posx[l]+30) div 30,((posy[l]+30)div 30)]=1 then




                   begin

                       bar(0,468,200,480);
                       setcolor(1);outtextxy(0,470,'* Vyvola novou priserku         ');
                       pocetpriser:=pocetpriser+1;
                       pocetzivych:=pocetzivych+1;
                       funkcni[pocetpriser]:=true;
                       pole[pocetpriser,1]:=45;pole[pocetpriser,2]:=45;
                       pole[pocetpriser,3]:=45;pole[pocetpriser,4]:=45;
                   end;
                 if barva[(posx[l]+30) div 30,((posy[l]+30)div 30)]=2 then
                   begin
                       bar(0,468,200,480);
                       setcolor(2);outtextxy(0,470,'* Znici priserku              ');
                       if pocetpriser>0 then
                       repeat
                       pocetpriser:=pocetpriser-1;

                       until (funkcni[pocetpriser+1])or(pocetpriser=0);
                       if pocetzivych>0 then begin pocetzivych:=pocetzivych-1;body:=body+30; end;
                       setcolor(black);setfillstyle(2,black);
                        pieslice(pole[pocetpriser+1,1],pole[pocetpriser+1,2],0,360,10);

                        setcolor(blue);setfillstyle(1,blue);
                        for i:=1 to 10 do begin
                        r:=random(10);s:=random(10);u:=random(10);
                        v:=random(10);line(pole[pocetpriser+1,1]-5+r,pole[pocetpriser+1,2]-5+s,
                        pole[pocetpriser+1,1]-10+r+u,pole[pocetpriser+1,2]-10+v+s);
                        end;
                        setcolor(red);
                        setfillstyle(1,red);
                       for i:=1 to 50 do begin
                       r:=random(50);s:=random(50);putpixel(pole[pocetpriser+1,1]-25+r,pole[pocetpriser+1,2]-25+s,red);
                                end;
                   end;
                 if barva[(posx[l]+30) div 30,((posy[l]+30)div 30)]=6 then
                   begin
                       bar(0,468,200,480);
                       setcolor(6);outtextxy(0,470,'* Znehybni priserky               ');
                       timer:=100*pocethracu;
                       nehybnost:=true;
                   end;
                 if barva[(posx[l]+30) div 30,((posy[l]+30)div 30)]=3 then
                   begin
                      bar(0,468,200,480);
                      setcolor(3);outtextxy(0,470,'* Otevre pruchod               ');
                      setcolor(black);
                      if random(2)=0 then
                      begin
                      line(0,210,0,240);
                      line(630,210,630,240);
                      end else
                      begin
                      line(300,0,330,0);
                      line(300,450,330,450);
                      end;
                   end;
                 if barva[(posx[l]+30) div 30,((posy[l]+30)div 30)]=5 then
                   begin
                        bar(0,468,200,480);
                        setcolor(5);outtextxy(0,470,'* Prochazeni stenami               ');
                        zeresteny:=true;
                        timer:=50*pocethracu;
                   end;
                 if barva[(posx[l]+30) div 30,((posy[l]+30)div 30)]=13 then
                  begin
                   bar(0,468,200,480);
                   setcolor(13);outtextxy(0,470,'* Za 10 cervenych tecek                   ');
                  end;
                 if barva[(posx[l]+30) div 30,((posy[l]+30)div 30)]=7 then
                  begin
                   bar(0,468,200,480);
                   setcolor(7);outtextxy(0,470,'* Teleport                                 ');
		   q:=random(pocethracu)+1;
		   setcolor(black);
                   setfillstyle(1,black);
                   pieslice(mposx[q],mposy[q],0,360,10);
                   posx[q]:=(random(21)*30+15);
                   posy[q]:=(random(15)*30+15);
                   mposx[q]:=posx[q];
                   mposy[q]:=posy[q];
                  end;
                 if barva[(posx[l]+30) div 30,((posy[l]+30)div 30)]=8 then
                  begin
                   bar(0,468,200,480);
                   setcolor(8);outtextxy(0,470,'* Zere priserky                   ');
                   timer:=100*pocethracu;
                   tvojebarva[1]:=2;
                   tvojebarva[2]:=2;
                   tvojebarva[3]:=2;
                  end;
                 if (barva[(posx[l]+30) div 30,((posy[l]+30)div 30)]=14)
                    and(zivotu<6) then
                  begin
                   bar(0,468,200,480);
                   setcolor(14);outtextxy(0,470,'* Zivot navic                   ');
                   zivotu:=zivotu+1;
                   setfillstyle(1,yellow);
                   setcolor(yellow);
                   pieslice(530+15*zivotu,470,30,330,5);
                  end;


                 if barva[(posx[l]+30) div 30,((posy[l]+30)div 30)]=12 then
                  begin
                  bar(0,468,200,480);
                   setcolor(12);outtextxy(0,470,'* Nuke                           ');
                   for i:=-1 to 1 do
                    for j:=-2 to 2 do
                     begin
                      if (tecky[(posx[l]+30) div 30+i,((posy[l]+30)div 30)+j])
                        then pocet:=pocet-1;
                     (tecky[(posx[l]+30) div 30+i,((posy[l]+30)div 30)+j]) :=false;
                     end;
                   for i:=-1 to 1 do

                     begin
                      if (tecky[(posx[l]+30) div 30+2,((posy[l]+30)div 30)+i])
                        then pocet:=pocet-1;
                      (tecky[(posx[l]+30) div 30+2,((posy[l]+30)div 30)+i]):=false;
                     end;
                   for i:=-1 to 1 do

                     begin
                      if (tecky[((posx[l]+30) div 30)-2,((posy[l]+30)div 30)+i])
                        then pocet:=pocet-1;
                      (tecky[((posx[l]+30) div 30)-2,((posy[l]+30)div 30)+i]):=false;
                     end;

                   vybuch:=77;
                   t[8]:=chr(ord('0')+(pocet div 100));
                  t[9]:=chr(ord('0')+((pocet div 10)mod 10));
                  t[10]:=chr(ord('0')+(pocet mod 10));
                  setfillstyle(1,black);
                  setcolor(black);
                  bar(250,470,380,480);
                  setcolor(green);
                  outtextxy(250,470,t);

                   setcolor(red);
                   setfillstyle(1,red);
                   pieslice(posx[l],posy[l],0,360,vybuch);
                   delay(200);
                   setcolor(black);
                   setfillstyle(1,black);
                   pieslice(posx[l],posy[l],0,360,vybuch);
                   bomba:=true;

                   q:=l;
                  end;

                  if barva[(posx[l]+30) div 30,((posy[l]+30)div 30)]=0 then
                  begin
                   setcolor(7);
                   setfillstyle(1,7);
                   bar(0,468,200,480);
                   setcolor(0);outtextxy(0,470,'* SHOOTING!!!             ');
                   shootingon:=true;

                   pocetstrel:=6;
                   setcolor(red);
                   setfillstyle(6,red);
                   for i:=1 to pocetstrel do
                   bar(440+10*i,465,445+10*i,475);
                  end;

                 end;
 end;


PROCEDURE Zacatek;
begin
assign(bludiste,'bludiste.pas');
rewrite(bludiste);
body:=0;
textcolor(1);writeln('* Vyvola novou priserku(Od ulohy 1)');
textcolor(3);writeln('* Otevre pruchod(Od ulohy 1)');

textcolor(6);writeln('* Znehybni priserky(Od ulohy 2)');
textcolor(13);writeln('* Za 10 cervenych tecek(Od ulohy 2)');
textcolor(7);writeln('* Teleport(Od ulohy 2)');

textcolor(5);writeln('* Prochazeni stenami(Od ulohy 3)');

textcolor(8);writeln('* Zere priserky(Od ulohy 3)');
textcolor(2);writeln('* Znici priserku(Od ulohy 4)');
textcolor(12);writeln('* Nuke(Od ulohy 4)');
textcolor(0);textbackground(7);writeln('* Strelba klavesou ''0'' ,resp. ''a'', ''n'',(Od ulohy 5)');
textbackground(black);
textcolor(14);writeln('* Zivot navic(Od ulohy 6)');
textbackground(black);
writeln;
textcolor(white);
writeln('Klavesa ''-'' ukonci hru.');
writeln('Ovladani klavesami 4,5,6,8, druhy hrac e,s,d,f, treti i,j,k,l.');
writeln('Pocet hracu???');
readln(pocethracu);
writeln('Rychlost??? 1-10');
readln(rychlost);
if pocethracu=1 then
assign(soubor,'rekordy.txt')
else
if pocethracu=2 then
assign(soubor,'rekordy2.txt')
else
assign(soubor,'rekordy3.txt');
textbackground(black);
textcolor(black);
clrscr;
level:=1;
zivotu:=6;
{if pocethracu=1 then zivotu:=3;}
textbackground(black);
detectgraph(a,b);
initgraph(a,b,'C:\wamp\www\pacman');
end;


{telo programu}
begin
Zacatek;

repeat
jsoupriserky:=true;
setcolor(black);
setfillstyle(1,black);
bar(0,0,640,480);
for i:=1 to 20 do funkcni[i]:=true;
randomize;
zeresteny:=false;
tvojebarva[1]:=13;
tvojebarva[2]:=3;
tvojebarva[3]:=7;
timer:=0;
for i:=1 to 21 do
 for j:=1 to 15 do
 begin
  barva[i,j]:=4;{cervena}
  if (random(200)=0)  and(level>1)then  barva[i,j]:=13;{=za 10 normalnich}
  if (random(200)=0) and(level>0) then  barva[i,j]:=1;{modra=nova priserka}
  if (random(250)=0) and (level>3) then barva[i,j]:=2;{zelena=znici priserku}
  if (random(200)=0) and(level>1) then barva[i,j]:=6;{tmave zluta=znehybni priserky}
  if (random(350)=0) and(level>0) then barva[i,j]:=3;{svetle modra=pruchod}
  if (random(200)=0) and(level>2) then barva[i,j]:=5;{fialova=zere steny}
  if (random(1000)=0) and(level>5) then  barva[i,j]:=14;{svetle zluta=zivot}
  if (random(200)=0) and(level>1) then  barva[i,j]:=7;{bila=teleport}
  if (random(200)=0) and(level>2) then  barva[i,j]:=8;{kill them}
  {if (random(200)=0)and(level>3) then if (i>3)and(i<18)and(j>3)and(j<12) then
                 barva[i,j]:=12;}{ruzova=nuke}
  if (random(350)=0)and(level>4) then barva[i,j]:=0;{shooting}
 end;
{prisera}
pocetpriser:=level+3;
pocetzivych:=level+3;

pocet:=250+15*pocethracu;

setfillstyle(1,yellow);
setcolor(yellow);
for i:=1 to zivotu do pieslice(530+15*i,470,30,330,5);

for i:=1 to 20 do
begin
d[i]:=random(4);
{pole[i,1]:=random(20)*30+15;
pole[i,3]:=pole[i,1];
pole[i,2]:=random(15)*30+15;
pole[i,4]:=pole[i,2];}
if i mod 6=0 then begin pole[i,1]:=45;pole[i,2]:=45;pole[i,3]:=45;pole[i,4]:=45;end;
if i mod 6=1 then begin pole[i,1]:=585;pole[i,2]:=45;pole[i,3]:=585;pole[i,4]:=45;end;
if i mod 6=2 then begin pole[i,1]:=45;pole[i,2]:=405;pole[i,3]:=45;pole[i,4]:=405;end;
if i mod 6=3 then begin pole[i,1]:=585;pole[i,2]:=405;pole[i,3]:=585;pole[i,4]:=405;end;
if i mod 6=4 then begin pole[i,1]:=315;pole[i,2]:=45;pole[i,3]:=315;pole[i,4]:=45;end;
if i mod 6=5 then begin pole[i,1]:=315;pole[i,2]:=405;pole[i,3]:=315;pole[i,4]:=405;end;
end;
setcolor(white);
posx[1]:=random(2)*30+315;
mposx[1]:=posx[1];
posy[1]:=random(2)*30+225;
mposy[1]:=posy[1];
posx[2]:=random(2)*30+315;
mposx[2]:=posx[2];
posy[2]:=random(2)*30+225;
mposy[2]:=posy[2];
posx[3]:=random(2)*30+315;
mposx[3]:=posx[3];
posy[3]:=random(2)*30+225;
mposy[3]:=posy[3];
line(0,0,630,0);
line(0,0,0,450);
line(0,450,630,450);
line(630,0,630,450);
setfillstyle(1,red);
setcolor(red);
for i:=1 to 21 do
 for j:=1 to 15 do
  begin
  if (barva[i,j]>0)and(barva[i,j]<>14) then
  begin
  setcolor(barva[i,j]);setfillstyle(1,barva[i,j]);
  pieslice(30*i-15,30*j-15,0,360,3);
  end
  else
  if barva[i,j]=0 then
  begin
  setcolor(7);
  circle(30*i-15,30*j-15,3);
  end
  else
  begin
  setcolor(yellow);
  setfillstyle(1,black);
  pieslice(30*i-15,30*j-15,30,330,3);
  end;
  end;
setcolor(white);
for i:=1 to 21 do
 for j:=1 to 15 do
  tecky[i,j]:=true;

if level>0 then
begin
VytvorBludiste;

end;
c[1]:='8';
c[2]:='e';
c[3]:='i';
alternativa[1]:='8';
alternativa[2]:='e';
alternativa[3]:='i';
t:='Pocet: 265';
setcolor(red);
setfillstyle(6,red);
for i:=1 to pocetstrel do
bar(440+10*i,465,445+10*i,475);

x:='level   ';
x[7]:=chr(ord('0')+(level div 10));
x[8]:=chr(ord('0')+(level mod 10));

setcolor(black);
setfillstyle(1,black);
bar(380,468,445,480);
setcolor(blue);
outtextxy(380,470,x);

delay(1000);

{hra}
repeat

begin
 if (pocetzivych+rychlost<19)and(not(nehybnost)) then
 delay(36-2*(pocetzivych+rychlost));
 if nehybnost then delay(20);
 if keypressed then
 begin
 nacteme:=readkey;
 case nacteme of
  'i','k','l','j':l:=3;
  'e','s','d','f':l:=2;
  '8','4','5','6':l:=1;
  '-':begin c[1]:='-';c[2]:='-';alternativa[1]:='-';alternativa[2]:='-';end;
  'v':begin c[1]:='v';c[2]:='v';alternativa[1]:='v';alternativa[2]:='v';end;
  'a','n','0':
    begin
     if nacteme='a' then q:=2 else if nacteme='n' then q:=3 else q:=1;
     if (not(strelaon))and(shootingon) then
     begin
     strelaon:=true;

     setcolor(black);
     strelax:=posx[q];
     mstrelax:=posx[q];
     strelay:=posy[q];
     mstrelay:=posy[q];
     dstrela:=c[q];
     setfillstyle(1,black);

     bar(440+10*pocetstrel,465,445+10*pocetstrel,475);
     pocetstrel:=pocetstrel-1;
     if pocetstrel=0 then shootingon:=false;
     end;

    end;{}
    end;
    case nacteme of 'e','s','d','f','i','k','l','j','8','4','5','6':
   alternativa[l]:=nacteme;end;
 end;
 for l:=1 to pocethracu do
  begin
 if ((posx[l] mod 30)>14)and((posx[l] mod 30)<16)and((posy[l] mod 30)>14)
  and((posy[l] mod 30)<16)and(alternativa[l]<>'a')and
   (alternativa[l]<>'n')and (alternativa[l]<>'0') then c[l]:=alternativa[l];



   setfillstyle(1,black);
   setcolor(black);
   pieslice(mposx[l],mposy[l],0,360,10);
Vstupnatecku;

 if pocet<=0 then begin c[l]:='v' end;






   case c[l] of
    'e','i','8': begin
        if ((posx[l] mod 30)<15)or((posx[l] mod 30)>15) then posy[l]:=posy[l]+3 else
         begin
              if (getpixel(posx[l],(posy[l] -15))=white)and(not zeresteny) then posy[l]:=posy[l]+3;
         end;
         if posy[l]<0 then posy[l]:=450;
         posy[l]:=posy[l]-3;
         setfillstyle(1,black);
         setcolor(tvojebarva[l]);
         pieslice(posx[l],posy[l],120,360,10);
         pieslice(posx[l],posy[l],0,60,10);
         setcolor(black);
         line(posx[l]+1,posy[l],posx[l]+9,posy[l]);

        end;
    's','j','4': begin
         if ((posy[l] mod 30)<15)or((posy[l] mod 30)>15) then posx[l]:=posx[l]+3 else
         begin
          if (getpixel(posx[l] -15,posy[l])=white)and(not zeresteny) then posx[l]:=posx[l]+3;
         end;
          if posx[l]<0 then posx[l]:=630;
         begin
         posx[l]:=posx[l]-3;
         setfillstyle(1,black);
         setcolor(tvojebarva[l]);
         pieslice(posx[l],posy[l],0,150,10);
         pieslice(posx[l],posy[l],210,360,10);
         setcolor(black);
         line(posx[l]+1,posy[l],posx[l]+9,posy[l]);
         end;
        end;
    'f','l','6': begin
        if ((posy[l] mod 30)<15)or((posy[l] mod 30)>15) then posx[l]:=posx[l]-3 else
        begin
         if (getpixel(posx[l] +15,posy[l])=white)and(not zeresteny) then posx[l]:=posx[l]-3;
        end;
         if posx[l]>630 then posx[l]:=0;
        begin
         posx[l]:=posx[l]+3;
         setfillstyle(1,black);
         setcolor(tvojebarva[l]);
         pieslice(posx[l],posy[l],30,330,10);
         setcolor(black);
         line(posx[l]+1,posy[l],posx[l]+9,posy[l]);
         end;
        end;
    'd','k','5': begin
        if((posx[l] mod 30)<15)or((posx[l] mod 30)>15) then posy[l]:=posy[l]-3 else
        begin
         if (getpixel(posx[l],(posy[l] +15))=white)and(not zeresteny) then posy[l]:=posy[l]-3;
        end;
         if posy[l]>450 then posy[l]:=0;
         begin
         posy[l]:=posy[l]+3;
         setfillstyle(1,black);
         setcolor(tvojebarva[l]);
         pieslice(posx[l],posy[l],0,240,10);
         pieslice(posx[l],posy[l],300,360,10);
         setcolor(black);
         line(posx[l]+1,posy[l],posx[l]+9,posy[l]);
         end;
        end;
     end;
     mposx[l]:=posx[l];
     mposy[l]:=posy[l];

if timer>0 then timer:=timer-1;
if (timer=0)and((posx[l] mod 30)>14)and((posx[l] mod 30)<16)and((posy[l] mod 30)>14)
  and((posy[l] mod 30)<16) then zeresteny:=false;
if timer=0 then  begin nehybnost:=false;tvojebarva[1]:=(13);
  tvojebarva[2]:=3;tvojebarva[3]:=7; end;
if strelaon then
begin
setcolor(black);
setfillstyle(1,black);
circle(mstrelax,mstrelay,2);
case dstrela of
 'e','i','8':strelay:=strelay-12;
 's','j','4':strelax:=strelax-12;
 'f','l','6':strelax:=strelax+12;
 'd','k','5':strelay:=strelay+12;
 end;
if (strelax<10 )or(strelax>619)or(strelay<10)or(strelay>439)then
 strelaon:=false
 else
 begin
setcolor(green);
setfillstyle(6,green);
circle(strelax,strelay,2);
mstrelax:=strelax;
mstrelay:=strelay;
 end;
end;
end;
end;
{konec opakovani pro 3 hrace}
jsoupriserky:=false;
begin
  for g:=1 to pocetpriser do if funkcni[g] then
 begin
    jsoupriserky:=true;
    if  (not nehybnost)  then
 begin


  begin

   setfillstyle(1,black);
 setcolor(black);
 pieslice(pole[g,3],pole[g,4],0,360,10);


 if (((pole[g,1] mod 30)>14)and ((pole[g,1] mod 30)<16))
  and (((pole[g,2] mod 30)>14)and((pole[g,2] mod 30)<16)) then
  begin
   jestena:=true;
   if tvojebarva[1]<>2 then
   begin
   for i:=1 to pocethracu do
   begin
   jestena:=true;
   if  (posx[i]=pole[g,1])and(posy[i]<pole[g,2]) then
       begin
        jestena:=false;
        q:=0;
        pozice:=(posy[i]div 30)*30+30;
        while pozice+q<pole[g,2] do
         begin
              if getpixel(posx[i],pozice+q)=white then jestena:=true;
              q:=q+30;
         end;
         if not jestena then d[g]:=0;
        end;
   if not jestena then break;
   if jestena then
        if  (posx[i]=pole[g,1])and(posy[i]>pole[g,2]) then
       begin
        jestena:=false;
        q:=0;
        pozice:=(posy[i]div 30)*30;
        while pozice-q>pole[g,2] do
         begin
              if getpixel(posx[i],pozice-q)=white then jestena:=true;
              q:=q+30;
         end;
         if not jestena then d[g]:=3;
        end;
   if not jestena then break;
   if  (posy[i]=pole[g,2])and(posx[i]<pole[g,1]) then
       begin
        jestena:=false;
        q:=0;
        pozice:=(posx[i]div 30)*30+30;
        while pozice+q<pole[g,1] do
         begin
              if getpixel(pozice+q,posy[i])=white then jestena:=true;
              q:=q+30;
         end;
         if not jestena then d[g]:=1;
        end;
        if not jestena then break;
   if jestena then
        if  (posy[i]=pole[g,2])and(posx[i]>pole[g,1]) then
       begin
        jestena:=false;
        q:=0;
        pozice:=(posx[i]div 30)*30;
        while pozice-q>pole[g,1] do
         begin
              if getpixel(pozice-q,posy[i])=white then jestena:=true;
              q:=q+30;
         end;
         if not jestena then d[g]:=2;
        end;
       if not jestena then break;
        end;
       end;






       if jestena then
       begin





   d[g]:=random(4);
   if (posx[l]<pole[g,1])and(random(6)=0)then d[g]:=1;
   if (posx[l]>pole[g,1])and(random(6)=0)then d[g]:=2;
   if (posy[l]<pole[g,2])and(random(6)=0)then d[g]:=0;
   if (posy[l]>pole[g,2])and(random(6)=0)then d[g]:=3;

   i:=0;

   while (((getpixel(pole[g,1],(pole[g,2] -15))=white) and(d[g]=0))or
   ((getpixel((pole[g,1] -15),pole[g,2])=white) and(d[g]=1))or
   ((getpixel((pole[g,1])+15,pole[g,2])=white) and(d[g]=2))or
   ((getpixel(pole[g,1],(pole[g,2])+15)=white) and(d[g]=3)))and
    (i<10)
   do begin
     d[g]:=random(4);
     i:=i+1;
   end;
   end;
  end;

   case d[g] of
    0: begin

        if ((pole[g,1] mod 30)<15)or((pole[g,1] mod 30)>15) then pole[g,2]:=pole[g,2]+3 else
         if getpixel(pole[g,1],pole[g,2]-15)=white then pole[g,2]:=pole[g,2]+3;
         if pole[g,2]<0 then pole[g,2]:=450;
         pole[g,2]:=pole[g,2]-3;
         setfillstyle(1,yellow);
         setcolor(yellow);
         pieslice(pole[g,1],pole[g,2],120,360,10);
         pieslice(pole[g,1],pole[g,2],0,60,10);
         setcolor(black);
         line(pole[g,1]+1,pole[g,2],pole[g,1]+9,pole[g,2]);
         if (pole[g,2] mod 30=0) and(tecky[((pole[g,1]+15)div 30),((pole[g,2]+30)div 30)])
           then  begin
                 if (barva[((pole[g,1]+15)div 30),((pole[g,2]+30)div 30)]>0)
                    and(barva[((pole[g,1]+15)div 30),((pole[g,2]+30)div 30)]<>14) then
                 begin
                 setcolor(barva[((pole[g,1]+15)div 30),((pole[g,2]+30)div 30)]);
                 setfillstyle(1,barva[((pole[g,1]+15)div 30),((pole[g,2]+30)div 30)]);
                     pieslice((pole[g,1]),pole[g,2]+15,0,360,3)
                 end
                 else
                 if (barva[((pole[g,1]+15)div 30),((pole[g,2]+30)div 30)]=0)
                 then
                 begin
                 setcolor(7);
                 setfillstyle(1,black);
                 circle((pole[g,1]),pole[g,2]+15,3);
                 end
                 else
                 begin
                 setcolor(14);
                 setfillstyle(1,black);
                 pieslice((pole[g,1]),pole[g,2]+15,30,330,3)
                 end;
                 end;

        end;

   1: begin

         if ((pole[g,2] mod 30)<15)or((pole[g,2] mod 30)>15) then pole[g,1]:=pole[g,1]+3 else
          if getpixel(pole[g,1]-15,pole[g,2])=white then pole[g,1]:=pole[g,1]+3;
         if pole[g,1]<0 then pole[g,1]:=630;
         begin
         pole[g,1]:=pole[g,1]-3;
         setfillstyle(1,yellow);
         setcolor(yellow);
         pieslice(pole[g,1],pole[g,2],0,150,10);
         pieslice(pole[g,1],pole[g,2],210,360,10);
         setcolor(black);
         line(pole[g,1]+1,pole[g,2],pole[g,1]+9,pole[g,2]);
         if (pole[g,1] mod 30=0) and(tecky[((pole[g,1]+30)div 30),((pole[g,2]+15)div 30)])
           then  begin
                   if (barva[((pole[g,1]+30)div 30),((pole[g,2]+15)div 30)]>0)and
                   (barva[((pole[g,1]+30)div 30),((pole[g,2]+15)div 30)]<>14)
                      then
                    begin
                    setcolor(barva[((pole[g,1]+30)div 30),((pole[g,2]+15)div 30)]);
                    setfillstyle(1,barva[((pole[g,1]+30)div 30),((pole[g,2]+15)div 30)]);

                   pieslice((pole[g,1]+15),pole[g,2],0,360,3)
                    end
                    else
                    if(barva[((pole[g,1]+30)div 30),((pole[g,2]+15)div 30)]=0)then
                    begin
                     setcolor(7);

                     circle((pole[g,1]+15),(pole[g,2]),3)
                    end
                    else

                    begin
                    setcolor(14);
                    setfillstyle(1,black);
                    pieslice((pole[g,1]+15),pole[g,2],30,330,3)
                    end;
                  end;


         end;
        end;
    2: begin

        if ((pole[g,2] mod 30)<15)or((pole[g,2] mod 30)>15) then pole[g,1]:=pole[g,1]-3 else
         if getpixel(pole[g,1]+15,pole[g,2])=white then pole[g,1]:=pole[g,1]-3;
         if pole[g,1]>630 then pole[g,1]:=0;
        begin
         pole[g,1]:=pole[g,1]+3;
         setfillstyle(1,yellow);
         setcolor(yellow);
         pieslice(pole[g,1],pole[g,2],30,330,10);
         setcolor(black);
         line(pole[g,1]+1,pole[g,2],pole[g,1]+9,pole[g,2]);
         if (pole[g,1] mod 30=0) and(tecky[((pole[g,1])div 30),((pole[g,2]+15)div 30)])
           then  begin
                   if (barva[((pole[g,1])div 30),((pole[g,2]+15)div 30)]>0)and
                      (barva[((pole[g,1])div 30),((pole[g,2]+15)div 30)]<>14) then
                   begin

                   setcolor(barva[((pole[g,1])div 30),((pole[g,2]+15)div 30)]);
                   setfillstyle(1,barva[((pole[g,1])div 30),((pole[g,2]+15)div 30)]);

                  pieslice((pole[g,1]-15),pole[g,2],0,360,3)
                  end
                  else
                  if (barva[((pole[g,1])div 30),((pole[g,2]+15)div 30)]=0)
                  then
                  begin
                  setcolor(7);
                  circle(((pole[g,1]-15)),((pole[g,2])),3);
                  end
                  else
                  begin
                   setcolor(14);
                    setfillstyle(1,black);
                    pieslice((pole[g,1]-15),pole[g,2],30,330,3)
                  end;
                  end;
         end;
        end;
    3: begin

        if((pole[g,1] mod 30)<15)or((pole[g,1] mod 30)>15) then pole[g,2]:=pole[g,2]-3 else
         if getpixel(pole[g,1],pole[g,2]+15)=white then pole[g,2]:=pole[g,2]-3;
         if pole[g,2]>450 then pole[g,2]:=0;
         begin
         pole[g,2]:=pole[g,2]+3;
         setfillstyle(1,yellow);
         setcolor(yellow);
         pieslice(pole[g,1],pole[g,2],0,240,10);
         pieslice(pole[g,1],pole[g,2],300,360,10);
         setcolor(black);
         line(pole[g,1]+1,pole[g,2],pole[g,1]+9,pole[g,2]);
         if (pole[g,2] mod 30=0) and(tecky[((pole[g,1]+15)div 30),((pole[g,2])div 30)])
           then  begin
                     if (barva[((pole[g,1]+15)div 30),((pole[g,2])div 30)]>0)and
                     (barva[((pole[g,1]+15)div 30),((pole[g,2])div 30)]<>14)   then
                     begin

                    setcolor(barva[((pole[g,1]+15)div 30),((pole[g,2])div 30)]);
                    setfillstyle(1,barva[((pole[g,1]+15)div 30),((pole[g,2])div 30)]);

                   pieslice((pole[g,1]),pole[g,2]-15,0,360,3)
                   end
                   else
                   if (barva[((pole[g,1]+15)div 30),((pole[g,2])div 30)]=0)then
                   begin
                   setcolor(7);
                   circle(((pole[g,1])),((pole[g,2]-15)),3);
                   end
                   else
                   begin
                   setcolor(14);
                    setfillstyle(1,black);
                    pieslice((pole[g,1]),pole[g,2]-15,30,330,3)

                   end;

                  end;
         end;

        end;
     end;
     pole[g,3]:=pole[g,1];
     pole[g,4]:=pole[g,2];
   end;
   end;
   {i kdyz je priserka znehybnena}
   for l:=1 to pocethracu do
   begin
   if (abs(pole[g,1]-posx[l])<20)and (abs(pole[g,2]-posy[l])<20)
    then if (tvojebarva[l]=2) then begin funkcni[g]:=false;body:=body+30;
        setcolor(black);setfillstyle(2,black);
        pieslice(pole[g,1],pole[g,2],0,360,10);
        setcolor(blue);setfillstyle(1,blue);
        for i:=1 to 10 do begin
                        r:=random(10);s:=random(10);u:=random(10);
                        v:=random(10);line(pole[g,1]-5+r,pole[g,2]-5+s,
                        pole[g,1]-10+u+r,pole[g,2]-10+v+s);
                        end;
                        setcolor(red);
                        setfillstyle(1,red);
        for i:=1 to 50 do begin
         r:=random(50);s:=random(50);putpixel(pole[g,1]-25+r,pole[g,2]-25+s,red);
         end;
        if pocetzivych>0 then pocetzivych:=pocetzivych-1; end else begin
       if zivotu>0 then
       begin
       setcolor(black);
       setfillstyle(1,black);
       pieslice(530+15*zivotu,470,30,330,5);
       pieslice(posx[l],posy[l],0,360,10);
       zivotu:=zivotu-1;
       posx[l]:=random(2)*30+315;
       mposx[l]:=posx[l];
       posy[l]:=random(2)*30+225;
       mposy[l]:=posy[l];
       timer:=50*pocethracu;
       tvojebarva[l]:=2;
       delay(200);
       end
       else
       begin
       strelaon:=false;
       c[l]:='-';
       end;
       end;
       end;
   begin
   if (bomba)and(abs(pole[g,1]-posx[q])<vybuch)and (abs(pole[g,2]-posy[q])<vybuch)then
     begin funkcni[g]:=false;body:=body+30;
     setcolor(black);setfillstyle(2,black);
        pieslice(pole[g,1],pole[g,2],0,360,10);
        setcolor(blue);setfillstyle(1,blue);
        for i:=1 to 10 do begin
                        r:=random(10);s:=random(10);u:=random(10);
                        v:=random(10);line(pole[g,1]-5+r,pole[g,2]-5+s,
                        pole[g,1]-10+u+r,pole[g,2]-10+v+s);
                        end;
                        setcolor(red);
                        setfillstyle(1,red);
     for i:=1 to 50 do begin
         r:=random(50);s:=random(50);putpixel(pole[g,1]-25+r,pole[g,2]-25+s,red);
         end;
     if pocetzivych>0 then pocetzivych:=pocetzivych-1;end;
   end;
   if (strelaon)then begin
      if ((abs(strelax-pole[g,1])<20)and(abs(strelay-pole[g,2])<14)and
         (dstrela in ['s','f','j','l','4','6']))or((abs(strelax-pole[g,1])<14)and(abs(strelay-pole[g,2])<20)and
         (dstrela in ['e','d','i','k','8','5'])) then
    begin
    funkcni[g]:=false;body:=body+30;
    setcolor(black);setfillstyle(2,black);
        pieslice(pole[g,1],pole[g,2],0,360,10);
    setcolor(blue);setfillstyle(1,blue);
        for i:=1 to 10 do begin
                        r:=random(10);s:=random(10);u:=random(10);
                        v:=random(10);line(pole[g,1]-5+r,pole[g,2]-5+s,
                        pole[g,1]-5+u+r,pole[g,2]-5+v+s);
                        end;
        setcolor(red);
        setfillstyle(1,red);
    for i:=1 to 50 do begin
         r:=random(50);s:=random(50);putpixel(pole[g,1]-25+r,pole[g,2]-25+s,red);
         end;
    if pocetzivych>0 then pocetzivych:=pocetzivych-1;
    end;
    end;


  end;
  end;
  bomba:=false;

  if not(jsoupriserky)then
   begin
    c[1]:='v';
    body:=body+pocet;
    strelaon:=false;
   end;




until  (c[1]='-')or(c[1]='v')or(c[2]='-')or(c[2]='v')or(c[3]='-')or(c[3]='v');
 if (c[1]='v')or(c[2]='v')or(c[3]='v') then begin
  level:=level+1;
  setfillstyle(1,black);
  bar(0,468,200,480);
  setcolor(white);
  outtextxy(0,470,'Postupujete na dalsi uroven.');
  delay(1000);

  end;

until (c[1]='-')or(c[2]='-')or(c[3]='-');
konec;





end.
