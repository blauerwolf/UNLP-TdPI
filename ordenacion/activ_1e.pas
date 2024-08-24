program NumAleatorio;
var 
    ale, i, F, A, B: integer;
begin
    randomize;
    write('Ingrese el número final: ');
    readln(F);

    write('Ingrese rango inferior: ');
    readln(A);

    write('Ingrese rango superior: ');
    readln(B);

    ale := random (B) + A;
    while (ale <> F) do begin
        writeln ('El número aleatorio generado es: ', ale);
        ale := random (B) + A;
    end;
    readln;
end.