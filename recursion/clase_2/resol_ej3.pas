{
    3.- Implementar un programa que invoque a los siguientes módulos.
    a. Un módulo recursivo que retorne un vector de 20 números enteros “random” mayores a 300
    y menores a 1550 (incluidos ambos).
    ✅ b. Un módulo que reciba el vector generado en a) y lo retorne ordenado. (Utilizar lo realizado
    en la práctica anterior)
    c. Un módulo que realice una búsqueda dicotómica en el vector, utilizando el siguiente
    encabezado:
    Procedure busquedaDicotomica (v: vector; ini,fin: indice; dato:integer; var pos: indice);
    Nota: El parámetro “pos” debe retornar la posición del dato o -1 si el dato no se encuentra
    en el vector.
}

program ejercicio3;
const 
  dimF = 20;
type 
  indice = -1..dimF;
  vector = array[1..dimF] of integer;

procedure CargarVector (var v: vector; var dimL: integer);

  procedure CargarVectorRecursivo (var v: vector; var dimL: integer);
  var valor: integer;
  begin
    valor:= random(1251) + 300;

    if (dimL < dimF)
    then begin
          dimL:= dimL + 1;
          v[dimL]:= valor;
          CargarVectorRecursivo (v, dimL);
         end;
  end;
  
begin
  dimL:= 0;
  CargarVectorRecursivo (v, dimL);
end;

procedure ImprimirVectorRecursivo (v: vector; dimL: integer);
begin    
  if (dimL > 0) then begin 
    ImprimirVectorRecursivo(v, dimL - 1);
    write('| ', v[dimL], ' ');
  end;     
end; 


procedure Ordenar(var v: vector; dimL: integer);
var 
    i, j, actual: integer;

begin 
    for i := 2 to dimL do begin
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

{
  1. Se calcula la posicion media del vector (teniendo en cuenta la cantidad de elementos)
  2. Mientras ((el elemento buscado sea <> arreglo[medio]) y (inf <= sup)): 
    - Actualizo sup
    Sino
      Actualizo inf
    Calculo nuevamente el medio
  3. Determino porque condicion se ha terminaod el while y devuelvo el resultado.
}
Procedure busquedaDicotomica(v: vector; ini, fin: indice; dato: integer; var pos: indice);
var 
  pri, ult, medio: indice;
  ok: boolean;
begin 
  ok := false;
  pri := 1;
  ult := fin; //fin?
  medio := (pri + ult) DIV 2;

  while (pri <= ult) and (dato <> v[medio]) do begin 
    if (dato < v[medio]) then 
      ult := medio - 1
    else pri := medio + 1;
    medio := (pri + ult) DIV 2;
  end;

  if (pri <= ult) and (dato = v[medio]) then ok := true;
  
  if (ok) then pos := medio
  else pos := -1;
end;


{ PROGRAMA PRINCIPAL }
var
  v: vector;
  dimL, valor: integer;
  pos: indice;

Begin 
  randomize;
  CargarVector(v, dimL);
  writeln;
  writeln('Vector cargado: ');
  ImprimirVectorRecursivo(v,  dimL);
  Ordenar(v, dimL);
  writeln;
  writeln('Vector ordenado: ');
  ImprimirVectorRecursivo(v,  dimL);

  
  write('Ingrese valor a buscar: ');
  readln(valor);

  busquedaDicotomica(v, 1, dimL, valor, pos);
  if (pos = -1) then 
    writeln('El valor ', valor, ' NO se encuentra en el vector')
  else 
    writeln('El valor ', valor, ' se encuentra en el vector');

End.