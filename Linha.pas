Program Pzim ;
const max = 64;
Type Cordenada = record
  x,y:longint;
end;

var i,tam:byte;
fim,repetir:boolean;
Pincel,P1,P2,aux:Cordenada ;
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
  Aux.x:= random(Tam-2)+2;
  Aux.y:= random(Tam-2)+2;
  CordAleatoria:= Aux;
end;


function DistanciaPontos(A,B:Cordenada): real;
begin
  DistanciaPontos:= sqrt(sqr(A.x-B.x)+sqr(A.y-B.y));
end;
{retorna uma cordenada a qt de distancia de A, se aproximando de B}
function Aproximacao(A,B:Cordenada;Qt:integer):Cordenada;
var Distancia:real;
begin
  Distancia := DistanciaPontos(A,B);
  A.x:= A.x + round( Qt * (B.x - A.x) / Distancia);
  A.y:= A.y + round( Qt * (B.y - A.y) / Distancia);
  Aproximacao := A;
end;



Procedure imprimir_grid() ;
var x,y:byte;
Begin
  textbackground(white );
  clrscr;
  gotoxy(1,1);
  for y := 1 to Tam do begin
    for x := 1 to Tam do begin
      if grid[x,y]
      then textbackground(black)
      else textbackground(White);
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
procedure apagar(Cord:Cordenada);
begin
  
  if Grid[Cord.x,Cord.y] then pintar(Cord,Black)
  else pintar(Cord,White);
end;


Procedure MoverPincel();
Begin
  case key of
    #80: if Pincel.y < Tam - 1 then Pincel.y := Pincel.y + 1; // baixo
    #72: if Pincel.y > 2   then Pincel.y := Pincel.y - 1; // cima
    #77: if Pincel.x < Tam - 1 then Pincel.x := Pincel.x + 1; // direita
    #75: if Pincel.x > 2   then Pincel.x := Pincel.x - 1; // esquerda
  end;
End;


procedure MostrarRecords();
begin           
	textbackground( white);  
  gotoxy(Tam*2-1+4,1);
  writeln('Ponto 1: {x:',P1.x:2,', y:',P1.y:2,'}');
  gotoxy(Tam*2-1+4,2);
  writeln('Ponto 2: {x:',P2.x:2,', y:',P2.y:2,'}');
  gotoxy(Tam*2-1+4,3);
  writeln('Pincel : {x:',pincel.x:2,', y:',pincel.y:2,'}');
end;
  

Procedure GerarParedes(Tamanho:integer);
var x,y,i:byte;
begin
	
	tam := Tamanho;  
	for x:= 1 to Tamanho do
	for y:= 1 to Tamanho do
	begin
			grid[x,y]:= false;
	end;
	for i:= 1 to Tamanho do
	begin
    grid[i,Tamanho] := true;//parede de baixo
    grid[Tamanho,i] := true;//parede da direita
    grid[i,1] := true;//parede de cima
    grid[1,i] := true;//parede da esquerda
	end;
end;

Begin
  
  repeat
    textbackground(white );
    textcolor(black);
    clrscr;
    cursoroff;
    randomize;
    
    GerarParedes(random(30)+10);
    Pincel := CordAleatoria;
    P1 := CordAleatoria;
    P2 := CordAleatoria;
		imprimir_grid;
    repetir := false;
    
    pintar(Pincel,magenta);
    pintar(P1,red);
    pintar(P2,blue);
    repeat
		key:= upcase(readkey);
    case(key) of
      #72,#80,#77,#75:
      begin
	      if (Pincel.x =  p1.x) and (Pincel.y = p1.y) then pintar(Pincel, red)
	      else if  (Pincel.x =  p2.x) and (Pincel.y = p2.y) then pintar(Pincel, blue)
	      else apagar(Pincel);
	      
	      MoverPincel;
	      pintar(Pincel,magenta);
	      MostrarRecords;
      end;
      '1': begin
        apagar(P1);
        P1 := Pincel;
        pintar(P1,red);
        MostrarRecords;
        end;
      '2':
      begin
        apagar(P2);
        P2 := Pincel;
        pintar(P2,blue);
        MostrarRecords;
      end;
      #13:
      begin
        i:= 1;
        aux:= p1;
        while (aux.x <> p2.x) or (aux.y <> p2.y) do
        begin
          aux := aproximacao(p1,p2,i);
          grid[aux.x,aux.y]:= true;
          i:= i+1;
        end;
        imprimir_grid();
        pintar(P1,red);
        pintar(P2,blue);
        MostrarRecords;
          
      end;
      #27: fim := true;  //esc
      'R': repetir := true;
      end;
    until fim or repetir ;
    
  until not repetir;
  
end.