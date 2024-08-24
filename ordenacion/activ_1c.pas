program NumAleatorio;
var ale, i: integer;
begin
    randomize;
    for i := 1 to 20 do begin 
        ale := random (100);
        { Imprime un número aleatorio entre 0 y 99 }
        writeln ('El número aleatorio generado es: ', ale);
    end;
    readln;
end.