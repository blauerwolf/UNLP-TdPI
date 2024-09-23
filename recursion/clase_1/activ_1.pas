program NumAleatorio;
var ale: integer;
begin
    randomize;
    ale := random (100);
    { Imprime un número aleatorio entre 0 y 99 }
    writeln ('El número aleatorio generado es: ', ale);
    readln;
end.