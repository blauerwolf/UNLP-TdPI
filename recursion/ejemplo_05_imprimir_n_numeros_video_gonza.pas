program recursion;

procedure imprimirNumeros(N: integer);
var 
    i: integer;

begin 
    for i := 1 to N do 
        writeln(i);

end;

procedure imprimirNumerosInverso(N: integer);
var i: integer;
begin 
    for i := N downto 1 do 
        writeln(i);
end;

{ 
    Que imprima antes o después de la recursión determina si 
    se ejecuta en orden directo o inverso.
}
procedure imprimirNumerosRecursivo(N: integer);
begin    
    // Reduzco el problema
    if (N > 1) then 
        imprimirNumerosRecursivo(N - 1);

    // Caso base
    writeln(N);
end;

procedure imprimirNumerosRecursivoInverso(N: integer);
begin
    writeln(N);

    if (N > 1) then 
        imprimirNumerosRecursivoInverso(N - 1);
end;  

var
    num: integer;

begin 
    writeln('Ingrese un valor mayor a 1'); readln(num);
    writeln('SECUENCIA');
    imprimirNumeros(num);
    writeln;
    writeln('INVERSO');
    imprimirNumerosInverso(num);
    writeln;
    writeln('RECURSIVO');
    imprimirNumeros(num);
    writeln;
    writeln('INVERSO RECURSIVO');
    imprimirNumerosRecursivoInverso(num);
end.