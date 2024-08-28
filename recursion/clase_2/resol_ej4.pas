{
    Desafío…
    ✅ 4.- Realizar un programa que lea números y que utilice un módulo recursivo que escriba el
    equivalente en binario de un número decimal. El programa termina cuando el usuario ingresa
    el número 0 (cero).
    Ayuda: Analizando las posibilidades encontramos que: Binario (N) es N si el valor es menor a 2.
    ¿Cómo obtenemos los dígitos que componen al número? ¿Cómo achicamos el número para la
    próxima llamada recursiva? Ejemplo: si se ingresa 23, el programa debe mostrar: 10111.
}

program ejercicio4;

Uses sysutils;

function Binario(N:integer): string;
begin 
  if (N < 2) then 
    Binario := IntToStr(N)
  else
    Binario := Binario(n DIV 2) + IntToStr(n MOD 2);
end;

{ PROGRAMA PRINCIPAL }
var n: integer;

Begin 
  write('Ingrese un numero: ');
  readln(n);
  writeln('La representacion binaria de ', n, ' es: ', Binario(n));
End.