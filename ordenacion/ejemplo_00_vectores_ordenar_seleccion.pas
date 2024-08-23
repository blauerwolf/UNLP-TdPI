{ Algoritmo de ordenamiento seleccion }
program ordenamos;
const 
  tam = 150;

type 
  numeros = array[1..tam] of integer; 

procedure Ordenar(var v: numeros; dimLog: integer);
var i, j, p, item: integer; 
begin 
  for i := 1 to dimLog -1 do 
  begin         { Busca el mínimo v[p] entre v[i], ..., v[N] }
    p := i;
    for j := i + 1 to dimLog do 
      if v[j] < v[p] then 
        p := j;

    { Intercambia v[i] y v[p] }
    item := v[p];
    v[p] := v[i];
    v[i] := item;
  end;
end;

procedure llenarNumeros(var v: numeros; var dim: integer);
var i: integer;
begin 
  Randomize();
  for i := 1 to tam do 
    v[i] := random(1000) + 1;

  dim := i;
    
end;

procedure  imprimirVector(v: numeros;  dimL:integer);
var i: integer;
begin 
  for i := 1 to dimL do
    write(v[i],    ' | ');
  
  writeln;
end;

var 
  VN: numeros; dimL: integer;

begin 
  llenarNumeros(VN,dimL);
  writeln('Vector sin ordenar: ');
  imprimirVector(VN, dimL);
  Ordenar(VN, dimL);
  writeln;
  writeln('Vector ordenado: ');
  imprimirVector(VN, dimL);
  
end.