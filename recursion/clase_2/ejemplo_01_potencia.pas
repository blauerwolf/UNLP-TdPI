program recursion_potencia;

function potencia (x,n: integer): integer;
begin
    if (n = 0) then potencia := 1
    else if (n = 1) then potencia := x
    else 
      potencia := x * potencia(x, n - 1);
    
end;

var x,n: integer;

begin 
    x := 5;
    n := 3;
    writeln('La potencia ', n, ' de ', x, ' es: ', potencia(x, n));
end.