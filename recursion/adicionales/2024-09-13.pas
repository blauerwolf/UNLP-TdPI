{
    Una empresa de alquiler de autos desea procesar la información de sus alquileres.
        a) implementar un módulo que lea información de los alquileres y retorne un vector que agrepe
        los alquileres de acuerdo a la cantidad de días de alquiler. Para cada cantidad de días, los
        alquileres deben almacenarse en un árbol binario de búsqueda ordenado por número de chasis del auto.
        De cada alquiler se lee: dni del cliente, número de chasis, y cantidad de días (1 a 7).
        La lectura finaliza con el número de chasis 0.

        b) Implementar un módulo que reciba la estructura generada en a) y un dni D.
        Este módulo debe retornar la cantidad de alquileres realizados por el dni D.

        c) Implementar un módulo que reciba la estructura generada en a), un día D y dos números
        de chasis N1 y N2. Este módulo debe retornar la cantidad de alquileres realizados en el día D,
        para los chasis entre N1 y N2 (ambos incluidos).

    NOTA: implementar el programa principal, que invoque a los incisos a, b y c. En caso de ser necesario
    puede utilizar los módulos que se encuentran a continuación.
}


program autos;

type
    sub_dias = 1..7;

    alquiler = record 
        dni: integer;
        cantDias: sub_dias;
        chasis: integer;
    end;

    arbol = ^nodoArbol;
    nodoArbol = record 
        dato: alquiler;
        HI: arbol;
        HD: arbol;
    end;

    vector = array[sub_dias] of arbol;

    
procedure ModuloA(var v: vector);

    procedure InicializarVector(var v: vector);
    var i: integer;
    begin 
        for i := 1 to 7 do 
            v[i] := nil;
    end;


    procedure InicializarArbol(var a: arbol);
    begin 
        a := nil;
    end;


    procedure leerAlquiler(var alq: alquiler);
    begin 
        alq.chasis := Random(700);
        if (alq.chasis <> 0) then
        begin 
            alq.dni := Random(5000) + 1;
            alq.cantDias := Random(7) + 1;
        end;
    end;


    procedure Agregar(var a: arbol; dato: alquiler);
    begin 
        if (a = nil) then begin 
            new(a);
            a^.dato := dato;
            a^.HI := nil;
            a^.HD := nil;
        end
        else begin 
            if (a^.dato.chasis > dato.chasis) then 
                Agregar(a^.HI, dato)
            else
                Agregar(a^.HD, dato);
        end;
    end;


    procedure ActualizarVector(var v: vector; dia: integer; dato: alquiler);
    begin 
        Agregar(v[dia], dato);
    end;


    procedure CargarAlquileres(var v: vector);
    var alq: alquiler;
    begin   
        leerAlquiler(alq);

        while (alq.chasis <> 0) do
        begin 
            ActualizarVector(v, alq.cantDias, alq);
            leerAlquiler(alq);
        end;
    end;

    procedure ImprimirArbol(a: arbol);
    begin 
        if (a <> nil) then begin 
            ImprimirArbol(a^.HI);
            writeln('DNI: ', a^.dato.dni, ' :: Chasis: ', a^.dato.chasis);
            ImprimirArbol(a^.HD);
        end;
    end;


    procedure ImprimirVector(v: vector);
    var i: integer;
    begin 
        for i := 1 to 7 do
        begin 
            writeln;
            writeln('Dia: ', i);
            writeln('----------');
            ImprimirArbol(v[i]);
        end;
    end;


begin
    writeln;
    writeln('----- MODULO A -----');
    writeln;
    CargarAlquileres(v);
    ImprimirVector(v);

end;


procedure ModuloB(v: vector);
begin
    writeln;
    writeln('----- MODULO B -----');
    writeln;
end;


procedure ModuloC(v: vector);
begin
    writeln;
    writeln('----- MODULO C -----');
    writeln;
end;

var 
    a: arbol;
    v: vector;

Begin 
    ModuloA(v);
    ModuloB(v);
    ModuloC(v);

End.