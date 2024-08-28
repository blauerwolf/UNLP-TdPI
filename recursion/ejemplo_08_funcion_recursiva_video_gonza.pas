program recursion;

function sumarRecursiva(n: integer): integer;
begin 
    // Caso base n = 1 (no achico más)
    if (n > 1) then
        sumarRecursiva := n + sumarRecursiva(n - 1)
    else 
        sumarRecursiva := 1; // Caso base
end;


var 
    num: integer;

begin 
    writeln('Ingrese un valor mayor a 1'); readln(num);
    writeln(sumarRecursiva(num));
end.