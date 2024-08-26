program recursion_factorial;

function factorial (num: integer): integer;
begin
    if (num = 0) then 
        factorial := 1
    else
        factorial := num * factorial(num - 1)
    
end;

var n: integer;

begin 
    n := 5;
    writeln('El factorial de ', n, ' es: ', factorial(n));
end.