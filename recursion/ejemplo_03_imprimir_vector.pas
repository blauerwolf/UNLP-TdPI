program imprimir_lista;
const 
  dimF = 50;
type
  vector = array[1..dimF] of integer;


procedure InicializarVector(var v: vector);
var i: integer;
begin 
  randomize;
  for i := 1 to dimF do 
    v[i] := random(999) + 1;
end;

procedure ImprimirVector(v: vector; dimL: integer);
begin 
  if (dimL > 0) then begin 
    ImprimirVector(v, dimL - 1);
    write('| ', v[dimL], ' ');
  end;
end;


procedure ImprimirVectorReversa(v: vector; dimL: integer);
begin 
  if (dimL > 1) then begin 
    write('| ', v[dimL], ' ');
    ImprimirVector(v, dimL - 1);
  end;
end;


{ PROGRAMA PRINCIPAL }
var 
    v: vector;
    dimL, i: integer;

Begin 
    { Cargo el vector con números aleatorios }
    dimL := dimF;
    InicializarVector(v);

    writeln('Imprimo normal');
    for i := 1 to dimF do 
      write('| ', v[i], ' ');
    writeln;

    { Impresión de recursiva del vector }
    writeln('Impresion recursiva');
    ImprimirVector(v, dimL);
    writeln;

    writeln('Impresión reversa');
    ImprimirVectorReversa(v, dimL);
    writeln;

End. 