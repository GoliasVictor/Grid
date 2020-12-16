Program Pzim ;
const max = 64;
Type Cordenada = record
  x:longint;
  y:longint;
end;

var Tam:byte;
var fim:boolean;
var repetir:boolean;
var Player:Cordenada;
var key:char;
var Grid: array[1..max, 1..max] of boolean;

{Gemoetria analitica}
function CordAleatoria():Cordenada;
var Aux:Cordenada;
begin
  Aux.x:= random(Tam-2)+2;
  Aux.y:= random(Tam-2)+2;
  CordAleatoria:= Aux;
end;

{geração}
Procedure GerarParedes(Tamanho:integer);
var x,y,i:byte;
begin

  Tam := Tamanho;
  
  for x:= 1 to Tamanho do
  for y:= 1 to Tamanho do
	grid[x,y] := (random(100) < 0);//30% do mapa e parede
	
  for i:= 1 to Tamanho do
  begin
    grid[i,Tamanho] := true;//parede de baixo
    grid[Tamanho,i] := true;//parede da direita
    grid[i,1] := true;//parede de cima
    grid[1,i] := true;//parede da esquerda
  end;
end;

{Gerencimento}

Procedure MoverPlayer(MaisMenos:integer);
Begin
  case key of
    #80: Player.y := Player.y + MaisMenos; // baixo
		#72: Player.y := Player.y - MaisMenos; // cima 
    #77: Player.x := Player.x + MaisMenos; // direita
    #75: Player.x := Player.x - MaisMenos; // esquerda
  end;
  if grid[Player.x,Player.y] then MoverPlayer(-1);
End;


{Saida}
Procedure imprimir_grid() ;
var x,y:byte;
Begin
  textbackground(black );
  clrscr;
  gotoxy(1,1);
  for y := 1 to Tam do begin
    for x := 1 to Tam do begin
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


Begin
  repeat
    textbackground(black );
    clrscr;
    cursoroff;
    randomize;
    GerarParedes(random(30)+10);
    repeat     
      Player := CordAleatoria 
    until not grid[Player.x,Player.y]; // define uma cordenada aleatoria para o player ate o local onde ele esta não seja verdadeiro
   
    imprimir_grid;
    repetir := false;
    
    pintar(Player,red);
    repeat
		  key:= upcase(readkey);
		  case(key) of
		    #72,#80,#77,#75:
		    begin
		      pintar(Player,green);
		      MoverPlayer(1);
		      pintar(Player,Red);
		    end;
		    #27: fim := true;  //esc
		    'R': repetir := true;
		  end;
      
    until fim or repetir ;
    
  until not repetir;
  
end.
