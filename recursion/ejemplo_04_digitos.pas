program imprimir_digitos;
const 
  dimF = 10;
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

procedure ImprimirDigitos (v: vector; dimL: integer);

  procedure DescomponerNumero(n: integer);
  begin
    if (n < 10) then 
      write(' ', n, ' ')
    else begin 
      DescomponerNumero(n DIV 10);
      write(' ', n MOD 10, ' ');
    end; 
  end;


begin 
  if (dimL > 0) then begin 
    write('Descompone ', v[dimL], ': ');
    DescomponerNumero(v[dimL]);
    writeln;
    ImprimirDigitos(v, dimL - 1);
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
    writeln;
    ImprimirDigitos(v, dimL);

End. 


{
program DescomponerNumeroRecursivo;

procedure ImprimirDigitos(num: integer);
begin
  if num < 10 then
    writeln(num)  // Caso base: si el número tiene un solo dígito, lo imprimimos.
  else
  begin
    ImprimirDigitos(num div 10);  // Llamada recursiva para imprimir todos los dígitos anteriores.
    writeln(num mod 10);  // Imprimimos el último dígito del número.
  end;
end;

var
  numero: integer;

begin
  writeln('Ingrese un número:');
  readln(numero);

  writeln('Los dígitos del número son:');
  ImprimirDigitos(numero);  // Llamamos al procedimiento para imprimir los dígitos del número.

  readln;
end.
}