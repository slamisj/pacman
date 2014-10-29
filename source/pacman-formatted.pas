
Uses graph,crt;

Var a,b,i,j,e,f,g,h,l,q,r,s,u,v,
  pocet{treba sebrat tecek},pocetpriser,level,rychlost,pocetstrel: integer;
  timer,vybuch,zivotu,strelax,strelay,mstrelax,mstrelay,
  body,rekord,vyslx,vysly,pocitadlo,
  pocethracu,pocetzivych,pozice: integer;
  nehybnost,jestena,zeresteny,bomba,shootingon,strelaon,jsoupriserky: boolean;
  posx,mposx,posy,mposy,tvojebarva: array[1..3] Of integer;
  c,alternativa: array[1..3] Of char;
  funkcni: array[1..20] Of boolean;
  mohu: array[1..21,1..15] Of boolean;
  pole: array[1..20,1..4] Of integer;{souradnice priser}
  barva: array[1..21,1..15] Of integer;{barvy tecek}
  tecky: array[1..21,1..15] Of boolean;{sebrana?}
  d: array[1..20] Of integer;{smer pohybu priser}
  t,jmenorekord,jmeno,x: string;
  nacteme,dstrela: char;
  soubor,bludiste: text;

Procedure Dosad;

Var i,j,k,l: integer;
Begin
  For i:=1 To 10 Do
    For j:=1 To 21 Do
      For k:=1 To 15 Do
        Begin
          If mohu[j,k] Then
            Begin
              l := 0;
              While ((j+l)<21) And(Not(getpixel((j+l)*30,(k*30)-15)=white )) Do
                Begin
                  l := l+1;
                  mohu[j+l,k] := true;
                  If (j+l=vyslx)And(k=vysly) Then exit;
                End;
              l := 0;
              While ((j-l)>1) And(Not(getpixel((j-l-1)*30,(k*30)-15)=white)) Do
                Begin
                  l := l+1;
                  mohu[j-l,k] := true;
                  If (j-l=vyslx)And(k=vysly) Then exit;
                End;
              l := 0;
              While ((k+l)<15) And(Not(getpixel(((j)*30)-15,(k+l)*30)=white)) Do
                Begin
                  l := l+1;
                  mohu[j,k+l] := true;
                  If (j=vyslx)And(k+l=vysly) Then exit;
                End;
              l := 0;
              While ((k+l)>1) And(Not(getpixel(((j)*30)-15,(k-l-1)*30)=white)) Do
                Begin
                  l := l+1;
                  mohu[j,k-l] := true;
                  If (j=vyslx)And(k-l=vysly) Then exit;
                End;

            End;
        End;
End;

Procedure VytvorBludiste;

Var i,j,k,l,carax,caray: integer;
Begin
  pocitadlo := 0;
  setcolor(white);
  line(0,0,630,0);
  line(0,0,0,450);
  line(0,450,630,450);
  line(630,0,630,450);
  setcolor(white);
  outtextxy(300,470,'Loading...');
  For i:=1 To 200+5*level Do
    Begin
      For j:= 1 To 21 Do
        For k:=1 To 15 Do
          mohu[j,k] := false;
      If random(2)=0 Then
        Begin
          Repeat
            carax := random(20)*30+30;
            caray := random(15)*30;
          Until Not(getpixel(carax,caray+15)=white);
          Begin
            setcolor(white);
            line(carax,caray,carax,caray+30);
            mohu[carax div 30,(caray Div 30)+1] := true;
            vyslx := (carax Div 30)+1;
            vysly := (caray Div 30)+1;
            Dosad;
            Begin
              If Not mohu[(carax Div 30)+1,(caray Div 30)+1] Then
                Begin
                  setcolor(black);
                  line(carax,caray,carax,caray+30);
                End
              Else
                Begin
                  write(bludiste,'line(',carax,',',caray,',',carax,',',caray+30,');');
                  If pocitadlo Mod 5=0 Then writeln(bludiste);
                  pocitadlo := pocitadlo+1;
                End;
            End;
          End
        End
      Else
        Begin
          Repeat
            carax := random(21)*30;
            caray := random(14)*30+30;
          Until Not(getpixel(carax+15,caray)=white);
          Begin
            setcolor(white);
            line(carax,caray,carax+30,caray);
            mohu[(carax Div 30)+1,(caray Div 30)] := true;
            vyslx := (carax Div 30)+1;
            vysly := (caray Div 30)+1;
            Dosad;
            Begin
              If Not mohu[(carax Div 30)+1,(caray Div 30)+1] Then
                Begin
                  setcolor(black);
                  line(carax,caray,carax+30,caray);
                End
              Else
                Begin
                  write(bludiste,'line(',carax,',',caray,',',carax+30,',',caray,');');
                  If pocitadlo Mod 5=0 Then writeln(bludiste);
                  pocitadlo := pocitadlo+1;
                End;
            End;
          End;
        End;
    End;
  setcolor(black);
  setfillstyle(1,black);
  bar(300,468,390,480);
End;

Procedure konec;
Begin
  setcolor(red);
  setfillstyle(1,red);
  For i:=1 To 100 Do
    Begin
      pieslice(random(getmaxx),random(getmaxy),0,360,random(40)+20);
      delay(10);
    End;
  setfillstyle(1,black);
  setcolor(white);
  outtextxy(300,240,'GAME OVER');

  For j:=1 To 100 Do
    Begin
      setcolor(yellow);

      pieslice(6*j,240,0+3*(j Mod 10),360-3*(j Mod 10),50);
      delay(20);
      setcolor(black);

      pieslice(6*j,240,0+3*(j Mod 10),360-3*(j Mod 10),50);


    End;

  closegraph;

  reset(soubor);
  readln(soubor,rekord);
  readln(soubor,jmenorekord);
  clrscr;
  textcolor(white);
  textbackground(black);
  writeln('Rekord: ',jmenorekord,' ',rekord);


  If body>rekord Then
    Begin
      writeln('Novy rekord!!! Ziskal jste ',body,' bodu.');
      write('Zadejte jmeno: ');
      read(jmenorekord);
      rewrite(soubor);
      writeln(soubor,body);
      writeln(soubor,jmenorekord);
    End
  Else writeln('Ziskal jste ',body,' bodu.');
  readln;
  close(soubor);
  write(bludiste,pocitadlo);
  close(bludiste);
End;

Procedure Vstupnatecku;
Begin
  If (posx[l] Mod 30>8) And(posx[l] Mod 30<22)
     And(posy[l] Mod 30>8) And(posy[l] Mod 30<22)
     And (tecky[(posx[l]+30) Div 30,((posy[l]+30)Div 30)])
    Then
    Begin

      pocet := pocet-1;
      body := body+1;
      If barva[(posx[l]+30) Div 30,((posy[l]+30)Div 30)]=13 Then
        Begin
          pocet := pocet-9;
          body := body+9;
        End;
      If pocet>=0 Then
        Begin
          t[8] := chr(ord('0')+(pocet Div 100));
          t[9] := chr(ord('0')+((pocet Div 10)Mod 10));
          t[10] := chr(ord('0')+(pocet Mod 10));
        End
      Else
        Begin
          t[8] := 'e';
          t[9] := 'n';
          t[10] := 'd';
        End;
      setfillstyle(1,black);
      setcolor(black);
      bar(250,470,380,480);
      setcolor(green);
      outtextxy(250,470,t);
      (tecky[(posx[l]+30) div 30,((posy[l]+30)div 30)]) := false;
      If barva[(posx[l]+30) Div 30,((posy[l]+30)Div 30)]=1 Then




        Begin

          bar(0,468,200,480);
          setcolor(1);
          outtextxy(0,470,'* Vyvola novou priserku         ');
          pocetpriser := pocetpriser+1;
          pocetzivych := pocetzivych+1;
          funkcni[pocetpriser] := true;
          pole[pocetpriser,1] := 45;
          pole[pocetpriser,2] := 45;
          pole[pocetpriser,3] := 45;
          pole[pocetpriser,4] := 45;
        End;
      If barva[(posx[l]+30) Div 30,((posy[l]+30)Div 30)]=2 Then
        Begin
          bar(0,468,200,480);
          setcolor(2);
          outtextxy(0,470,'* Znici priserku              ');
          If pocetpriser>0 Then
            Repeat
              pocetpriser := pocetpriser-1;

            Until (funkcni[pocetpriser+1])Or(pocetpriser=0);
          If pocetzivych>0 Then
            Begin
              pocetzivych := pocetzivych-1;
              body := body+30;
            End;
          setcolor(black);
          setfillstyle(2,black);
          pieslice(pole[pocetpriser+1,1],pole[pocetpriser+1,2],0,360,10);

          setcolor(blue);
          setfillstyle(1,blue);
          For i:=1 To 10 Do
            Begin
              r := random(10);
              s := random(10);
              u := random(10);
              v := random(10);
              line(pole[pocetpriser+1,1]-5+r,pole[pocetpriser+1,2]-5+s,
                   pole[pocetpriser+1,1]-10+r+u,pole[pocetpriser+1,2]-10+v+s);
            End;
          setcolor(red);
          setfillstyle(1,red);
          For i:=1 To 50 Do
            Begin
              r := random(50);
              s := random(50);
              putpixel(pole[pocetpriser+1,1]-25+r,pole[pocetpriser+1,2]-25+s,red);
            End;
        End;
      If barva[(posx[l]+30) Div 30,((posy[l]+30)Div 30)]=6 Then
        Begin
          bar(0,468,200,480);
          setcolor(6);
          outtextxy(0,470,'* Znehybni priserky               ');
          timer := 100*pocethracu;
          nehybnost := true;
        End;
      If barva[(posx[l]+30) Div 30,((posy[l]+30)Div 30)]=3 Then
        Begin
          bar(0,468,200,480);
          setcolor(3);
          outtextxy(0,470,'* Otevre pruchod               ');
          setcolor(black);
          If random(2)=0 Then
            Begin
              line(0,210,0,240);
              line(630,210,630,240);
            End
          Else
            Begin
              line(300,0,330,0);
              line(300,450,330,450);
            End;
        End;
      If barva[(posx[l]+30) Div 30,((posy[l]+30)Div 30)]=5 Then
        Begin
          bar(0,468,200,480);
          setcolor(5);
          outtextxy(0,470,'* Prochazeni stenami               ');
          zeresteny := true;
          timer := 50*pocethracu;
        End;
      If barva[(posx[l]+30) Div 30,((posy[l]+30)Div 30)]=13 Then
        Begin
          bar(0,468,200,480);
          setcolor(13);
          outtextxy(0,470,'* Za 10 cervenych tecek                   ');
        End;
      If barva[(posx[l]+30) Div 30,((posy[l]+30)Div 30)]=7 Then
        Begin
          bar(0,468,200,480);
          setcolor(7);
          outtextxy(0,470,'* Teleport                                 ');
          q := random(pocethracu)+1;
          setcolor(black);
          setfillstyle(1,black);
          pieslice(mposx[q],mposy[q],0,360,10);
          posx[q] := (random(21)*30+15);
          posy[q] := (random(15)*30+15);
          mposx[q] := posx[q];
          mposy[q] := posy[q];
        End;
      If barva[(posx[l]+30) Div 30,((posy[l]+30)Div 30)]=8 Then
        Begin
          bar(0,468,200,480);
          setcolor(8);
          outtextxy(0,470,'* Zere priserky                   ');
          timer := 100*pocethracu;
          tvojebarva[1] := 2;
          tvojebarva[2] := 2;
          tvojebarva[3] := 2;
        End;
      If (barva[(posx[l]+30) Div 30,((posy[l]+30)Div 30)]=14)
         And(zivotu<6) Then
        Begin
          bar(0,468,200,480);
          setcolor(14);
          outtextxy(0,470,'* Zivot navic                   ');
          zivotu := zivotu+1;
          setfillstyle(1,yellow);
          setcolor(yellow);
          pieslice(530+15*zivotu,470,30,330,5);
        End;


      If barva[(posx[l]+30) Div 30,((posy[l]+30)Div 30)]=12 Then
        Begin
          bar(0,468,200,480);
          setcolor(12);
          outtextxy(0,470,'* Nuke                           ');
          For i:=-1 To 1 Do
            For j:=-2 To 2 Do
              Begin
                If (tecky[(posx[l]+30) Div 30+i,((posy[l]+30)Div 30)+j])
                  Then pocet := pocet-1;
                (tecky[(posx[l]+30) div 30+i,((posy[l]+30)div 30)+j]) := false;
              End;
          For i:=-1 To 1 Do

            Begin
              If (tecky[(posx[l]+30) Div 30+2,((posy[l]+30)Div 30)+i])
                Then pocet := pocet-1;
              (tecky[(posx[l]+30) div 30+2,((posy[l]+30)div 30)+i]) := false;
            End;
          For i:=-1 To 1 Do

            Begin
              If (tecky[((posx[l]+30) Div 30)-2,((posy[l]+30)Div 30)+i])
                Then pocet := pocet-1;
              (tecky[((posx[l]+30) div 30)-2,((posy[l]+30)div 30)+i]) := false;
            End;

          vybuch := 77;
          t[8] := chr(ord('0')+(pocet Div 100));
          t[9] := chr(ord('0')+((pocet Div 10)Mod 10));
          t[10] := chr(ord('0')+(pocet Mod 10));
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
          bomba := true;

          q := l;
        End;

      If barva[(posx[l]+30) Div 30,((posy[l]+30)Div 30)]=0 Then
        Begin
          setcolor(7);
          setfillstyle(1,7);
          bar(0,468,200,480);
          setcolor(0);
          outtextxy(0,470,'* SHOOTING!!!             ');
          shootingon := true;

          pocetstrel := 6;
          setcolor(red);
          setfillstyle(6,red);
          For i:=1 To pocetstrel Do
            bar(440+10*i,465,445+10*i,475);
        End;

    End;
End;


Procedure Zacatek;
Begin
  assign(bludiste,'bludiste.pas');
  rewrite(bludiste);
  body := 0;
  textcolor(1);
  writeln('* Vyvola novou priserku(Od ulohy 1)');
  textcolor(3);
  writeln('* Otevre pruchod(Od ulohy 1)');

  textcolor(6);
  writeln('* Znehybni priserky(Od ulohy 2)');
  textcolor(13);
  writeln('* Za 10 cervenych tecek(Od ulohy 2)');
  textcolor(7);
  writeln('* Teleport(Od ulohy 2)');

  textcolor(5);
  writeln('* Prochazeni stenami(Od ulohy 3)');

  textcolor(8);
  writeln('* Zere priserky(Od ulohy 3)');
  textcolor(2);
  writeln('* Znici priserku(Od ulohy 4)');
  textcolor(12);
  writeln('* Nuke(Od ulohy 4)');
  textcolor(0);
  textbackground(7);
  writeln('* Strelba klavesou ''0'' ,resp. ''a'', ''n'',(Od ulohy 5)');
  textbackground(black);
  textcolor(14);
  writeln('* Zivot navic(Od ulohy 6)');
  textbackground(black);
  writeln;
  textcolor(white);
  writeln('Klavesa ''-'' ukonci hru.');
  writeln('Ovladani klavesami 4,5,6,8, druhy hrac e,s,d,f, treti i,j,k,l.');
  writeln('Pocet hracu???');
  readln(pocethracu);
  writeln('Rychlost??? 1-10');
  readln(rychlost);
  If pocethracu=1 Then
    assign(soubor,'rekordy.txt')
  Else
    If pocethracu=2 Then
      assign(soubor,'rekordy2.txt')
  Else
    assign(soubor,'rekordy3.txt');
  textbackground(black);
  textcolor(black);
  clrscr;
  level := 1;
  zivotu := 6;
{if pocethracu=1 then zivotu:=3;}
  textbackground(black);
  detectgraph(a,b);
  initgraph(a,b,'C:\wamp\www\pacman');
End;


{telo programu}
Begin
  Zacatek;

  Repeat
    jsoupriserky := true;
    setcolor(black);
    setfillstyle(1,black);
    bar(0,0,640,480);
    For i:=1 To 20 Do
      funkcni[i] := true;
    randomize;
    zeresteny := false;
    tvojebarva[1] := 13;
    tvojebarva[2] := 3;
    tvojebarva[3] := 7;
    timer := 0;
    For i:=1 To 21 Do
      For j:=1 To 15 Do
        Begin
          barva[i,j] := 4;{cervena}
          If (random(200)=0)  And(level>1)Then  barva[i,j] := 13;{=za 10 normalnich}
          If (random(200)=0) And(level>0) Then  barva[i,j] := 1;{modra=nova priserka}
          If (random(250)=0) And (level>3) Then barva[i,j] := 2;{zelena=znici priserku}
          If (random(200)=0) And(level>1) Then barva[i,j] := 6;{tmave zluta=znehybni priserky}
          If (random(350)=0) And(level>0) Then barva[i,j] := 3;{svetle modra=pruchod}
          If (random(200)=0) And(level>2) Then barva[i,j] := 5;{fialova=zere steny}
          If (random(1000)=0) And(level>5) Then  barva[i,j] := 14;{svetle zluta=zivot}
          If (random(200)=0) And(level>1) Then  barva[i,j] := 7;{bila=teleport}
          If (random(200)=0) And(level>2) Then  barva[i,j] := 8;{kill them}

{if (random(200)=0)and(level>3) then if (i>3)and(i<18)and(j>3)and(j<12) then
                 barva[i,j]:=12;}
          {ruzova=nuke}
          If (random(350)=0)And(level>4) Then barva[i,j] := 0;{shooting}
        End;
{prisera}
    pocetpriser := level+3;
    pocetzivych := level+3;

    pocet := 250+15*pocethracu;

    setfillstyle(1,yellow);
    setcolor(yellow);
    For i:=1 To zivotu Do
      pieslice(530+15*i,470,30,330,5);

    For i:=1 To 20 Do
      Begin
        d[i] := random(4);

{pole[i,1]:=random(20)*30+15;
pole[i,3]:=pole[i,1];
pole[i,2]:=random(15)*30+15;
pole[i,4]:=pole[i,2];}
        If i Mod 6=0 Then
          Begin
            pole[i,1] := 45;
            pole[i,2] := 45;
            pole[i,3] := 45;
            pole[i,4] := 45;
          End;
        If i Mod 6=1 Then
          Begin
            pole[i,1] := 585;
            pole[i,2] := 45;
            pole[i,3] := 585;
            pole[i,4] := 45;
          End;
        If i Mod 6=2 Then
          Begin
            pole[i,1] := 45;
            pole[i,2] := 405;
            pole[i,3] := 45;
            pole[i,4] := 405;
          End;
        If i Mod 6=3 Then
          Begin
            pole[i,1] := 585;
            pole[i,2] := 405;
            pole[i,3] := 585;
            pole[i,4] := 405;
          End;
        If i Mod 6=4 Then
          Begin
            pole[i,1] := 315;
            pole[i,2] := 45;
            pole[i,3] := 315;
            pole[i,4] := 45;
          End;
        If i Mod 6=5 Then
          Begin
            pole[i,1] := 315;
            pole[i,2] := 405;
            pole[i,3] := 315;
            pole[i,4] := 405;
          End;
      End;
    setcolor(white);
    posx[1] := random(2)*30+315;
    mposx[1] := posx[1];
    posy[1] := random(2)*30+225;
    mposy[1] := posy[1];
    posx[2] := random(2)*30+315;
    mposx[2] := posx[2];
    posy[2] := random(2)*30+225;
    mposy[2] := posy[2];
    posx[3] := random(2)*30+315;
    mposx[3] := posx[3];
    posy[3] := random(2)*30+225;
    mposy[3] := posy[3];
    line(0,0,630,0);
    line(0,0,0,450);
    line(0,450,630,450);
    line(630,0,630,450);
    setfillstyle(1,red);
    setcolor(red);
    For i:=1 To 21 Do
      For j:=1 To 15 Do
        Begin
          If (barva[i,j]>0)And(barva[i,j]<>14) Then
            Begin
              setcolor(barva[i,j]);
              setfillstyle(1,barva[i,j]);
              pieslice(30*i-15,30*j-15,0,360,3);
            End
          Else
            If barva[i,j]=0 Then
              Begin
                setcolor(7);
                circle(30*i-15,30*j-15,3);
              End
          Else
            Begin
              setcolor(yellow);
              setfillstyle(1,black);
              pieslice(30*i-15,30*j-15,30,330,3);
            End;
        End;
    setcolor(white);
    For i:=1 To 21 Do
      For j:=1 To 15 Do
        tecky[i,j] := true;

    If level>0 Then
      Begin
        VytvorBludiste;

      End;
    c[1] := '8';
    c[2] := 'e';
    c[3] := 'i';
    alternativa[1] := '8';
    alternativa[2] := 'e';
    alternativa[3] := 'i';
    t := 'Pocet: 265';
    setcolor(red);
    setfillstyle(6,red);
    For i:=1 To pocetstrel Do
      bar(440+10*i,465,445+10*i,475);

    x := 'level   ';
    x[7] := chr(ord('0')+(level Div 10));
    x[8] := chr(ord('0')+(level Mod 10));

    setcolor(black);
    setfillstyle(1,black);
    bar(380,468,445,480);
    setcolor(blue);
    outtextxy(380,470,x);

    delay(1000);

{hra}
    Repeat

      Begin
        If (pocetzivych+rychlost<19)And(Not(nehybnost)) Then
          delay(36-2*(pocetzivych+rychlost));
        If nehybnost Then delay(20);
        If keypressed Then
          Begin
            nacteme := readkey;
            Case nacteme Of
              'i','k','l','j': l := 3;
              'e','s','d','f': l := 2;
              '8','4','5','6': l := 1;
              '-':
                   Begin
                     c[1] := '-';
                     c[2] := '-';
                     alternativa[1] := '-';
                     alternativa[2] := '-';
                   End;
              'v':
                   Begin
                     c[1] := 'v';
                     c[2] := 'v';
                     alternativa[1] := 'v';
                     alternativa[2] := 'v';
                   End;
              'a','n','0':
                           Begin
                             If nacteme='a' Then q := 2
                             Else If nacteme='n' Then q := 3
                             Else q := 1;
                             If (Not(strelaon))And(shootingon) Then
                               Begin
                                 strelaon := true;

                                 setcolor(black);
                                 strelax := posx[q];
                                 mstrelax := posx[q];
                                 strelay := posy[q];
                                 mstrelay := posy[q];
                                 dstrela := c[q];
                                 setfillstyle(1,black);

                                 bar(440+10*pocetstrel,465,445+10*pocetstrel,475);
                                 pocetstrel := pocetstrel-1;
                                 If pocetstrel=0 Then shootingon := false;
                               End;

                           End;{}
            End;
            Case nacteme Of
              'e','s','d','f','i','k','l','j','8','4','5','6':
                                                               alternativa[l] := nacteme;
            End;
          End;
        For l:=1 To pocethracu Do
          Begin
            If ((posx[l] Mod 30)>14)And((posx[l] Mod 30)<16)And((posy[l] Mod 30)>14)
               And((posy[l] Mod 30)<16)And(alternativa[l]<>'a')And
               (alternativa[l]<>'n')And (alternativa[l]<>'0') Then c[l] := alternativa[l];



            setfillstyle(1,black);
            setcolor(black);
            pieslice(mposx[l],mposy[l],0,360,10);
            Vstupnatecku;

            If pocet<=0 Then
              Begin
                c[l] := 'v'
              End;






            Case c[l] Of
              'e','i','8':
                           Begin
                             If ((posx[l] Mod 30)<15)Or((posx[l] Mod 30)>15) Then posy[l] := posy[l]
                                                                                             +3
                             Else
                               Begin
                                 If (getpixel(posx[l],(posy[l] -15))=white)And(Not zeresteny) Then
                                   posy[l] := posy[l]+3;
                               End;
                             If posy[l]<0 Then posy[l] := 450;
                             posy[l] := posy[l]-3;
                             setfillstyle(1,black);
                             setcolor(tvojebarva[l]);
                             pieslice(posx[l],posy[l],120,360,10);
                             pieslice(posx[l],posy[l],0,60,10);
                             setcolor(black);
                             line(posx[l]+1,posy[l],posx[l]+9,posy[l]);

                           End;
              's','j','4':
                           Begin
                             If ((posy[l] Mod 30)<15)Or((posy[l] Mod 30)>15) Then posx[l] := posx[l]
                                                                                             +3
                             Else
                               Begin
                                 If (getpixel(posx[l] -15,posy[l])=white)And(Not zeresteny) Then
                                   posx[l] := posx[l]+3;
                               End;
                             If posx[l]<0 Then posx[l] := 630;
                             Begin
                               posx[l] := posx[l]-3;
                               setfillstyle(1,black);
                               setcolor(tvojebarva[l]);
                               pieslice(posx[l],posy[l],0,150,10);
                               pieslice(posx[l],posy[l],210,360,10);
                               setcolor(black);
                               line(posx[l]+1,posy[l],posx[l]+9,posy[l]);
                             End;
                           End;
              'f','l','6':
                           Begin
                             If ((posy[l] Mod 30)<15)Or((posy[l] Mod 30)>15) Then posx[l] := posx[l]
                                                                                             -3
                             Else
                               Begin
                                 If (getpixel(posx[l] +15,posy[l])=white)And(Not zeresteny) Then
                                   posx[l] := posx[l]-3;
                               End;
                             If posx[l]>630 Then posx[l] := 0;
                             Begin
                               posx[l] := posx[l]+3;
                               setfillstyle(1,black);
                               setcolor(tvojebarva[l]);
                               pieslice(posx[l],posy[l],30,330,10);
                               setcolor(black);
                               line(posx[l]+1,posy[l],posx[l]+9,posy[l]);
                             End;
                           End;
              'd','k','5':
                           Begin
                             If ((posx[l] Mod 30)<15)Or((posx[l] Mod 30)>15) Then posy[l] := posy[l]
                                                                                             -3
                             Else
                               Begin
                                 If (getpixel(posx[l],(posy[l] +15))=white)And(Not zeresteny) Then
                                   posy[l] := posy[l]-3;
                               End;
                             If posy[l]>450 Then posy[l] := 0;
                             Begin
                               posy[l] := posy[l]+3;
                               setfillstyle(1,black);
                               setcolor(tvojebarva[l]);
                               pieslice(posx[l],posy[l],0,240,10);
                               pieslice(posx[l],posy[l],300,360,10);
                               setcolor(black);
                               line(posx[l]+1,posy[l],posx[l]+9,posy[l]);
                             End;
                           End;
            End;
            mposx[l] := posx[l];
            mposy[l] := posy[l];

            If timer>0 Then timer := timer-1;
            If (timer=0)And((posx[l] Mod 30)>14)And((posx[l] Mod 30)<16)And((posy[l] Mod 30)>14)
               And((posy[l] Mod 30)<16) Then zeresteny := false;
            If timer=0 Then
              Begin
                nehybnost := false;
                tvojebarva[1] := (13);
                tvojebarva[2] := 3;
                tvojebarva[3] := 7;
              End;
            If strelaon Then
              Begin
                setcolor(black);
                setfillstyle(1,black);
                circle(mstrelax,mstrelay,2);
                Case dstrela Of
                  'e','i','8': strelay := strelay-12;
                  's','j','4': strelax := strelax-12;
                  'f','l','6': strelax := strelax+12;
                  'd','k','5': strelay := strelay+12;
                End;
                If (strelax<10 )Or(strelax>619)Or(strelay<10)Or(strelay>439)Then
                  strelaon := false
                Else
                  Begin
                    setcolor(green);
                    setfillstyle(6,green);
                    circle(strelax,strelay,2);
                    mstrelax := strelax;
                    mstrelay := strelay;
                  End;
              End;
          End;
      End;
{konec opakovani pro 3 hrace}
      jsoupriserky := false;
      Begin
        For g:=1 To pocetpriser Do
          If funkcni[g] Then
            Begin
              jsoupriserky := true;
              If  (Not nehybnost)  Then
                Begin


                  Begin

                    setfillstyle(1,black);
                    setcolor(black);
                    pieslice(pole[g,3],pole[g,4],0,360,10);


                    If (((pole[g,1] Mod 30)>14)And ((pole[g,1] Mod 30)<16))
                       And (((pole[g,2] Mod 30)>14)And((pole[g,2] Mod 30)<16)) Then
                      Begin
                        jestena := true;
                        If tvojebarva[1]<>2 Then
                          Begin
                            For i:=1 To pocethracu Do
                              Begin
                                jestena := true;
                                If  (posx[i]=pole[g,1])And(posy[i]<pole[g,2]) Then
                                  Begin
                                    jestena := false;
                                    q := 0;
                                    pozice := (posy[i]Div 30)*30+30;
                                    While pozice+q<pole[g,2] Do
                                      Begin
                                        If getpixel(posx[i],pozice+q)=white Then jestena := true;
                                        q := q+30;
                                      End;
                                    If Not jestena Then d[g] := 0;
                                  End;
                                If Not jestena Then break;
                                If jestena Then
                                  If  (posx[i]=pole[g,1])And(posy[i]>pole[g,2]) Then
                                    Begin
                                      jestena := false;
                                      q := 0;
                                      pozice := (posy[i]Div 30)*30;
                                      While pozice-q>pole[g,2] Do
                                        Begin
                                          If getpixel(posx[i],pozice-q)=white Then jestena := true;
                                          q := q+30;
                                        End;
                                      If Not jestena Then d[g] := 3;
                                    End;
                                If Not jestena Then break;
                                If  (posy[i]=pole[g,2])And(posx[i]<pole[g,1]) Then
                                  Begin
                                    jestena := false;
                                    q := 0;
                                    pozice := (posx[i]Div 30)*30+30;
                                    While pozice+q<pole[g,1] Do
                                      Begin
                                        If getpixel(pozice+q,posy[i])=white Then jestena := true;
                                        q := q+30;
                                      End;
                                    If Not jestena Then d[g] := 1;
                                  End;
                                If Not jestena Then break;
                                If jestena Then
                                  If  (posy[i]=pole[g,2])And(posx[i]>pole[g,1]) Then
                                    Begin
                                      jestena := false;
                                      q := 0;
                                      pozice := (posx[i]Div 30)*30;
                                      While pozice-q>pole[g,1] Do
                                        Begin
                                          If getpixel(pozice-q,posy[i])=white Then jestena := true;
                                          q := q+30;
                                        End;
                                      If Not jestena Then d[g] := 2;
                                    End;
                                If Not jestena Then break;
                              End;
                          End;






                        If jestena Then
                          Begin





                            d[g] := random(4);
                            If (posx[l]<pole[g,1])And(random(6)=0)Then d[g] := 1;
                            If (posx[l]>pole[g,1])And(random(6)=0)Then d[g] := 2;
                            If (posy[l]<pole[g,2])And(random(6)=0)Then d[g] := 0;
                            If (posy[l]>pole[g,2])And(random(6)=0)Then d[g] := 3;

                            i := 0;

                            While (((getpixel(pole[g,1],(pole[g,2] -15))=white) And(d[g]=0))Or
                                  ((getpixel((pole[g,1] -15),pole[g,2])=white) And(d[g]=1))Or
                                  ((getpixel((pole[g,1])+15,pole[g,2])=white) And(d[g]=2))Or
                                  ((getpixel(pole[g,1],(pole[g,2])+15)=white) And(d[g]=3)))And
                                  (i<10)
                              Do
                              Begin
                                d[g] := random(4);
                                i := i+1;
                              End;
                          End;
                      End;

                    Case d[g] Of
                      0:
                         Begin

                           If ((pole[g,1] Mod 30)<15)Or((pole[g,1] Mod 30)>15) Then pole[g,2] :=
                                                                                                pole
                                                                                                 [g,
                                                                                                 2]+
                                                                                                 3
                           Else
                             If getpixel(pole[g,1],pole[g,2]-15)=white Then pole[g,2] := pole[g,2]+3
                           ;
                           If pole[g,2]<0 Then pole[g,2] := 450;
                           pole[g,2] := pole[g,2]-3;
                           setfillstyle(1,black);
                           setcolor(yellow);
                           pieslice(pole[g,1],pole[g,2],120,360,10);
                           pieslice(pole[g,1],pole[g,2],0,60,10);
                           setcolor(black);
                           line(pole[g,1]+1,pole[g,2],pole[g,1]+9,pole[g,2]);
                           If (pole[g,2] Mod 30=0) And(tecky[((pole[g,1]+15)Div 30),((pole[g,2]+30)
                              Div 30)])
                             Then
                             Begin
                               If (barva[((pole[g,1]+15)Div 30),((pole[g,2]+30)Div 30)]>0)
                                  And(barva[((pole[g,1]+15)Div 30),((pole[g,2]+30)Div 30)]<>14) Then
                                 Begin
                                   setcolor(barva[((pole[g,1]+15)div 30),((pole[g,2]+30)div 30)]);
                                   setfillstyle(1,barva[((pole[g,1]+15)div 30),((pole[g,2]+30)div 30
                                   )]);
                                   pieslice((pole[g,1]),pole[g,2]+15,0,360,3)
                                 End
                               Else
                                 If (barva[((pole[g,1]+15)Div 30),((pole[g,2]+30)Div 30)]=0)
                                   Then
                                   Begin
                                     setcolor(7);
                                     setfillstyle(1,black);
                                     circle((pole[g,1]),pole[g,2]+15,3);
                                   End
                               Else
                                 Begin
                                   setcolor(14);
                                   setfillstyle(1,black);
                                   pieslice((pole[g,1]),pole[g,2]+15,30,330,3)
                                 End;
                             End;

                         End;

                      1:
                         Begin

                           If ((pole[g,2] Mod 30)<15)Or((pole[g,2] Mod 30)>15) Then pole[g,1] :=
                                                                                                pole
                                                                                                 [g,
                                                                                                 1]+
                                                                                                 3
                           Else
                             If getpixel(pole[g,1]-15,pole[g,2])=white Then pole[g,1] := pole[g,1]+3
                           ;
                           If pole[g,1]<0 Then pole[g,1] := 630;
                           Begin
                             pole[g,1] := pole[g,1]-3;
                             setfillstyle(1,black);
                             setcolor(yellow);
                             pieslice(pole[g,1],pole[g,2],0,150,10);
                             pieslice(pole[g,1],pole[g,2],210,360,10);
                             setcolor(black);
                             line(pole[g,1]+1,pole[g,2],pole[g,1]+9,pole[g,2]);
                             If (pole[g,1] Mod 30=0) And(tecky[((pole[g,1]+30)Div 30),((pole[g,2]+15
                                )Div 30)])
                               Then
                               Begin
                                 If (barva[((pole[g,1]+30)Div 30),((pole[g,2]+15)Div 30)]>0)And
                                    (barva[((pole[g,1]+30)Div 30),((pole[g,2]+15)Div 30)]<>14)
                                   Then
                                   Begin
                                     setcolor(barva[((pole[g,1]+30)div 30),((pole[g,2]+15)div 30)]);
                                     setfillstyle(1,barva[((pole[g,1]+30)div 30),((pole[g,2]+15)div
                                     30)]);

                                     pieslice((pole[g,1]+15),pole[g,2],0,360,3)
                                   End
                                 Else
                                   If (barva[((pole[g,1]+30)Div 30),((pole[g,2]+15)Div 30)]=0)Then
                                     Begin
                                       setcolor(7);

                                       circle((pole[g,1]+15),(pole[g,2]),3)
                                     End
                                 Else

                                   Begin
                                     setcolor(14);
                                     setfillstyle(1,black);
                                     pieslice((pole[g,1]+15),pole[g,2],30,330,3)
                                   End;
                               End;


                           End;
                         End;
                      2:
                         Begin

                           If ((pole[g,2] Mod 30)<15)Or((pole[g,2] Mod 30)>15) Then pole[g,1] :=
                                                                                                pole
                                                                                                 [g,
                                                                                                 1]-
                                                                                                 3
                           Else
                             If getpixel(pole[g,1]+15,pole[g,2])=white Then pole[g,1] := pole[g,1]-3
                           ;
                           If pole[g,1]>630 Then pole[g,1] := 0;
                           Begin
                             pole[g,1] := pole[g,1]+3;
                             setfillstyle(1,black);
                             setcolor(yellow);
                             pieslice(pole[g,1],pole[g,2],30,330,10);
                             setcolor(black);
                             line(pole[g,1]+1,pole[g,2],pole[g,1]+9,pole[g,2]);
                             If (pole[g,1] Mod 30=0) And(tecky[((pole[g,1])Div 30),((pole[g,2]+15)
                                Div 30)])
                               Then
                               Begin
                                 If (barva[((pole[g,1])Div 30),((pole[g,2]+15)Div 30)]>0)And
                                    (barva[((pole[g,1])Div 30),((pole[g,2]+15)Div 30)]<>14) Then
                                   Begin

                                     setcolor(barva[((pole[g,1])div 30),((pole[g,2]+15)div 30)]);
                                     setfillstyle(1,barva[((pole[g,1])div 30),((pole[g,2]+15)div 30)
                                     ]);

                                     pieslice((pole[g,1]-15),pole[g,2],0,360,3)
                                   End
                                 Else
                                   If (barva[((pole[g,1])Div 30),((pole[g,2]+15)Div 30)]=0)
                                     Then
                                     Begin
                                       setcolor(7);
                                       circle(((pole[g,1]-15)),((pole[g,2])),3);
                                     End
                                 Else
                                   Begin
                                     setcolor(14);
                                     setfillstyle(1,black);
                                     pieslice((pole[g,1]-15),pole[g,2],30,330,3)
                                   End;
                               End;
                           End;
                         End;
                      3:
                         Begin

                           If ((pole[g,1] Mod 30)<15)Or((pole[g,1] Mod 30)>15) Then pole[g,2] :=
                                                                                                pole
                                                                                                 [g,
                                                                                                 2]-
                                                                                                 3
                           Else
                             If getpixel(pole[g,1],pole[g,2]+15)=white Then pole[g,2] := pole[g,2]-3
                           ;
                           If pole[g,2]>450 Then pole[g,2] := 0;
                           Begin
                             pole[g,2] := pole[g,2]+3;
                             setfillstyle(1,black);
                             setcolor(yellow);
                             pieslice(pole[g,1],pole[g,2],0,240,10);
                             pieslice(pole[g,1],pole[g,2],300,360,10);
                             setcolor(black);
                             line(pole[g,1]+1,pole[g,2],pole[g,1]+9,pole[g,2]);
                             If (pole[g,2] Mod 30=0) And(tecky[((pole[g,1]+15)Div 30),((pole[g,2])
                                Div 30)])
                               Then
                               Begin
                                 If (barva[((pole[g,1]+15)Div 30),((pole[g,2])Div 30)]>0)And
                                    (barva[((pole[g,1]+15)Div 30),((pole[g,2])Div 30)]<>14)   Then
                                   Begin

                                     setcolor(barva[((pole[g,1]+15)div 30),((pole[g,2])div 30)]);
                                     setfillstyle(1,barva[((pole[g,1]+15)div 30),((pole[g,2])div 30)
                                     ]);

                                     pieslice((pole[g,1]),pole[g,2]-15,0,360,3)
                                   End
                                 Else
                                   If (barva[((pole[g,1]+15)Div 30),((pole[g,2])Div 30)]=0)Then
                                     Begin
                                       setcolor(7);
                                       circle(((pole[g,1])),((pole[g,2]-15)),3);
                                     End
                                 Else
                                   Begin
                                     setcolor(14);
                                     setfillstyle(1,black);
                                     pieslice((pole[g,1]),pole[g,2]-15,30,330,3)

                                   End;

                               End;
                           End;

                         End;
                    End;
                    pole[g,3] := pole[g,1];
                    pole[g,4] := pole[g,2];
                  End;
                End;
   {i kdyz je priserka znehybnena}
              For l:=1 To pocethracu Do
                Begin
                  If (abs(pole[g,1]-posx[l])<20)And (abs(pole[g,2]-posy[l])<20)
                    Then If (tvojebarva[l]=2) Then
                           Begin
                             funkcni[g] := false;
                             body := body+30;
                             setcolor(black);
                             setfillstyle(2,black);
                             pieslice(pole[g,1],pole[g,2],0,360,10);
                             setcolor(blue);
                             setfillstyle(1,blue);
                             For i:=1 To 10 Do
                               Begin
                                 r := random(10);
                                 s := random(10);
                                 u := random(10);
                                 v := random(10);
                                 line(pole[g,1]-5+r,pole[g,2]-5+s,
                                      pole[g,1]-10+u+r,pole[g,2]-10+v+s);
                               End;
                             setcolor(red);
                             setfillstyle(1,red);
                             For i:=1 To 50 Do
                               Begin
                                 r := random(50);
                                 s := random(50);
                                 putpixel(pole[g,1]-25+r,pole[g,2]-25+s,red);
                               End;
                             If pocetzivych>0 Then pocetzivych := pocetzivych-1;
                           End
                  Else
                    Begin
                      If zivotu>0 Then
                        Begin
                          setcolor(black);
                          setfillstyle(1,black);
                          pieslice(530+15*zivotu,470,30,330,5);
                          pieslice(posx[l],posy[l],0,360,10);
                          zivotu := zivotu-1;
                          posx[l] := random(2)*30+315;
                          mposx[l] := posx[l];
                          posy[l] := random(2)*30+225;
                          mposy[l] := posy[l];
                          timer := 50*pocethracu;
                          tvojebarva[l] := 2;
                          delay(200);
                        End
                      Else
                        Begin
                          strelaon := false;
                          c[l] := '-';
                        End;
                    End;
                End;
              Begin
                If (bomba)And(abs(pole[g,1]-posx[q])<vybuch)And (abs(pole[g,2]-posy[q])<vybuch)Then
                  Begin
                    funkcni[g] := false;
                    body := body+30;
                    setcolor(black);
                    setfillstyle(2,black);
                    pieslice(pole[g,1],pole[g,2],0,360,10);
                    setcolor(blue);
                    setfillstyle(1,blue);
                    For i:=1 To 10 Do
                      Begin
                        r := random(10);
                        s := random(10);
                        u := random(10);
                        v := random(10);
                        line(pole[g,1]-5+r,pole[g,2]-5+s,
                             pole[g,1]-10+u+r,pole[g,2]-10+v+s);
                      End;
                    setcolor(red);
                    setfillstyle(1,red);
                    For i:=1 To 50 Do
                      Begin
                        r := random(50);
                        s := random(50);
                        putpixel(pole[g,1]-25+r,pole[g,2]-25+s,red);
                      End;
                    If pocetzivych>0 Then pocetzivych := pocetzivych-1;
                  End;
              End;
              If (strelaon)Then
                Begin
                  If ((abs(strelax-pole[g,1])<20)And(abs(strelay-pole[g,2])<14)And
                     (dstrela In ['s','f','j','l','4','6']))Or((abs(strelax-pole[g,1])<14)And(abs(
                     strelay-pole[g,2])<20)And
                     (dstrela In ['e','d','i','k','8','5'])) Then
                    Begin
                      funkcni[g] := false;
                      body := body+30;
                      setcolor(black);
                      setfillstyle(2,black);
                      pieslice(pole[g,1],pole[g,2],0,360,10);
                      setcolor(blue);
                      setfillstyle(1,blue);
                      For i:=1 To 10 Do
                        Begin
                          r := random(10);
                          s := random(10);
                          u := random(10);
                          v := random(10);
                          line(pole[g,1]-5+r,pole[g,2]-5+s,
                               pole[g,1]-5+u+r,pole[g,2]-5+v+s);
                        End;
                      setcolor(red);
                      setfillstyle(1,red);
                      For i:=1 To 50 Do
                        Begin
                          r := random(50);
                          s := random(50);
                          putpixel(pole[g,1]-25+r,pole[g,2]-25+s,red);
                        End;
                      If pocetzivych>0 Then pocetzivych := pocetzivych-1;
                    End;
                End;


            End;
      End;
      bomba := false;

      If Not(jsoupriserky)Then
        Begin
          c[1] := 'v';
          body := body+pocet;
          strelaon := false;
        End;




    Until  (c[1]='-')Or(c[1]='v')Or(c[2]='-')Or(c[2]='v')Or(c[3]='-')Or(c[3]='v');
    If (c[1]='v')Or(c[2]='v')Or(c[3]='v') Then
      Begin
        level := level+1;
        setfillstyle(1,black);
        bar(0,468,200,480);
        setcolor(white);
        outtextxy(0,470,'Postupujete na dalsi uroven.');
        delay(1000);

      End;

  Until (c[1]='-')Or(c[2]='-')Or(c[3]='-');
  konec;





End.
