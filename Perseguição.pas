Program Pzim ;
const max = 64;
Type Cordenada = record
  x,y:longint;
end;

var TamanhoGrid:byte;
fim,repetir:boolean;
Player:cordenada; 
Stalker:Cordenada ;
key:char;
Grid: array[1..max, 1..max] of boolean;




{Geometria analitica} 

function NovaCord(x,y:longint):Cordenada;
var aux:cordenada;
begin
  aux.x := x;
  aux.y := y;
  NovaCord := aux;
end;

function CordAleatoria():Cordenada;
var Aux:Cordenada;
begin
  Aux.x:= random(TamanhoGrid-2)+2;
  Aux.y:= random(TamanhoGrid-2)+2;
  CordAleatoria:= Aux;
end;

{}
function DistanciaPontos(A,B:Cordenada): real;
begin
  DistanciaPontos:= sqrt(sqr(A.x-B.x)+sqr(A.y-B.y));
end;

{retorna uma cordenada a qt de distancia de A, se aproximando de B}

{Link de como e feito o calculo: https://www.geogebra.org/m/f6bcprsw}

function Aproximacao(A,B:Cordenada;Qt:integer):Cordenada;
var Distancia:real;
begin
  Distancia := DistanciaPontos(A,B);
  if Distancia > 0  then 
	begin 
		A.x:= A.x + round( Qt * (B.x - A.x) / Distancia);
		A.y:= A.y + round( Qt * (B.y - A.y) / Distancia);
  end;
	Aproximacao := A;
end;

{calculo mais legivel}
{
function StalkeruirEvacuar(Stalkeruidor,Alvo:Cordenada;Dis:integer):Cordenada;
var DisPontos,movex, movey:real;
begin
  Distancia := DistanciaPontos(alvo,Stalkeruidor);
  
  movex:= (alvo.x - Stalkeruidor.x) / Distancia;
  movey:= (alvo.y - Stalkeruidor.y) / Distancia;
  Stalkeruidor.x := Stalkeruidor.x + round( Dis* movex)
  Stalkeruidor.y := Stalkeruidor.y + round( Dis* movey)
  StalkeruirEvacuar := Stalkeruidor;
end;
}


Procedure imprimir_grid() ;
var x,y:byte;
Begin
  textbackground(black );
  clrscr;
  gotoxy(1,1);
  for y := 1 to TamanhoGrid do begin
    for x := 1 to TamanhoGrid do begin
      if grid[x,y]
      then textbackground(brown)
      else textbackground(green);
      write('  ');
    end;
    writeln;
  end;
End;


procedure pintar(Cord:Cordenada;color:integer);
begin
  gotoxy(Cord.x*2-1,Cord.y);
  textbackground(color);
  write('  ');
end;


Procedure MoverPlayeryer(MaisMenos:integer);
Begin
  case key of
    #80: Player.y := Player.y + MaisMenos; // para cima, posição y aumenta
    #72: Player.y := Player.y - MaisMenos;// para baixo, posição y diminue
    #77: Player.x := Player.x + MaisMenos; // para direita, posição y aumenta
    #75: Player.x := Player.x - MaisMenos;// para esquerda, posição x diminue
  end;
  if grid[Player.x,Player.y] then MoverPlayeryer(-1);
End;

procedure Verificar();
begin
	if ((Stalker.x = Player.x) and (Stalker.y = Player.y))
  then begin
		pintar(Player,green);
		Player := CordAleatoria;
		pintar(Player,blue);
	end;
end;


Procedure GerarParedes(Tamanho:integer);    
var i:byte;
begin
  for i:= 1 to Tamanho do
  begin
    grid[i,Tamanho] := true;
    grid[Tamanho,i] := true;
    grid[i,1] := true;
    grid[1,i] := true;
  end;
end;
procedure MostrarRecords();
begin
  normvideo;
  gotoxy(TamanhoGrid*2-1+4,1);
  writeln('Player:  {x:',Player.x:2,', y:',Player.y:2,'}');
  gotoxy(TamanhoGrid*2-1+4,2);
  writeln('Stalker: {x:',Stalker.x:2,', y:',Stalker.y:2,'}');
end;



Begin
  
  TamanhoGrid := 30;
  
  repeat
    textbackground(black );
    clrscr;
    cursoroff;
    randomize;
    Player := NovaCord(2,2);
    Stalker := NovaCord(TamanhoGrid-1,TamanhoGrid-1);
    GerarParedes(tamanhoGrid);
    imprimir_grid;
    repetir := false;
    
    pintar(Player,Blue);
    repeat
    key:= upcase(readkey);
    case(key) of
      #72,#80,#77,#75:
      begin
        pintar(Player,green);
        
        MoverPlayeryer(1);
        if ((Stalker.x = Player.x) and (Stalker.y = Player.y))
        then Player := CordAleatoria;
        pintar(Player,blue);
        Verificar;
        MostrarRecords;
      end;
      #27: fim := true;  //esc
      'R': repetir := true;
    end;
    pintar(Stalker,green);
    Stalker := Aproximacao(Stalker,Player,1);
    Verificar;
    pintar(Stalker,Red);
    
      
      
    until fim or repetir ;
    
  until not repetir;
  
end.
