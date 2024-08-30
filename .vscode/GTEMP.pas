program recursion_factorial;

function factorial (num: longint): longint;
begin
    if (num = 0) then 
        factorial := 1
    else
        factorial := num * factorial(num - 1)
    
end;

var n: longint;

begin 
    write('Ingresar numero para calcular factorial: '); readln(n);
    writeln('El factorial de ', n, ' es: ', factorial(n));
end.