program NumAleatorio;
var 
    ale, i, N, A, B: integer;
begin
    randomize;
    write('Ingrese cantidad de Aleatorios a generar: ');
    readln(N);

    write('Ingrese rango inferior: ');
    readln(A);

    write('Ingrese rango superior: ');
    readln(B);

    for i := 1 to N do begin 
        ale := random (B) + A;
        { Imprime un número aleatorio entre 0 y 99 }
        writeln ('El número aleatorio generado es: ', ale);
    end;
    readln;
end.