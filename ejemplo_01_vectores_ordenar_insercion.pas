{ Algoritmo de ordenamiento seleccion }
program ordenamos;
const 
  tam = 150;

type 
  numeros = array[1..tam] of integer; 


procedure Ordenar(var v: numeros; dimLog: integer);
var 
    i, j, actual: integer;

begin 
    for i := 2 to dimLog do begin
        actual := v[i];
        j := i - 1;

        while (j > 0) and (v[j] > actual) do 
        begin 
            v[j + 1] := v[j];
            j := j - 1;
        end;

        v[j + 1] := actual;
    end;
end;

procedure llenarNumeros(var v: numeros; var dim: integer);
var i: integer;
begin 
  Randomize();
  for i := 1 to dim do 
    v[i] := random(1000) + 1;

  dim := i;
    
end;

var 
  VN: numeros; dimL: integer;

begin 
  llenarNumeros(VN,dimL);
  ordenar(VN, dimL);
end.