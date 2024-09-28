{
    La Feria del Artesano necesita un sistema para obtener estadísticas sobre las artesanías presentadas.

        a) Implementar un módulo que lea información de las artesanías. De cada artesanía se conoce:
        número de identificación de la artesanía, DNI del artesano y código del material base (1: madera,
        2: yeso, 3: cerámica, 4: vidrio, 5: acero, 6: procelana, 7: lana, 8: cartón). La lectura finaliza
        con el valor 0 para el DNI. El módulo debe retornar dos estructuras:

        i. Un árbol binario de búsqueda ordenado por el DNI del artesano. Para cada DNI del artesano
        debe almacenarse la cantidad de artesanías correspondientes al DNI.
        ii. Un vector que almacene para cada material base, el código del material y la cantidad de
        artesanías del material base.

        b) Implementar un módulo que reciba el árbol generado en a) y un DNI. El módulo debe retornar
        la cantidad de artesanos con DNI menor al DNI generado.

        c) Implementar un módulo que reciba el vector generado en a), lo ordene por cantidad de 
        artesanías de menor a mayor y retorne el nombre de material base con mayor cantidad de 
        artesanías.

    NOTA: Implementar el programa principal, que invoque a los incisos a, b y c.
}

program artesano;

type

    artesania = record 
        id: integer;
        dni: integer;
        cod_base: integer;
    end;

    arbol = ^nodoArbol;
    nodoArbol = record
        dni: integer;
        cant: integer;
        HI: arbol;
        HD: arbol;
    end;

    vector = array[1..8] of integer;



procedure ModuloA(var a: arbol; var v: vector);

    procedure InicializarVector(var v: vector);
    var i: integer;
    begin 
        for i := 1 to 8 do
            v[i] := 0;
    end;


    procedure InicializarArbol(var a: arbol);
    begin 
        a := nil;
    end;


    procedure ActualizarVector(var v: vector; cod_base: integer);
    begin 
        v[cod_base] := v[cod_base] + 1;
    end;


    procedure InsertOrUpdate(var a: arbol; dato: artesania);
    begin 
        // Caso base, arbol vacio
        if (a = nil) then begin 
            new(a);
            a^.dni := dato.dni;
            a^.cant := 1;
            a^.HI := nil;
            a^.HD := nil;
        end
        else if (a^.dni = dato.dni) then 
            // Actualizo el nodo
            a^.cant := a^.cant + 1
        else if (a^.dni > dato.dni) then 
            InsertOrUpdate(a^.HI, dato)
        else 
            InsertOrUpdate(a^.HD, dato); 
    end;


    procedure LeerArtesania(var art: artesania);
    begin 
        art.id := random(1000) + 1000;
        art.dni := random(10000);
        art.cod_base := random(8) + 1;
    end;


    procedure CargarArtesanias(var a: arbol; var v: vector);
    var art: artesania;
    begin 
        InicializarVector(v);
        InicializarArbol(a);

        LeerArtesania(art);

        while (art.dni <> 0) do begin 

            ActualizarVector(v, art.cod_base);
            InsertOrUpdate(a, art);

            LeerArtesania(art);
        end;
    end;

    procedure ImprimirVector(v: vector; dimL: integer);
    begin 
        if (dimL > 0) then begin 
            ImprimirVector(v, dimL - 1);
            writeln('#', dimL, ': ', v[dimL]);
        end;
    end;

    procedure ImprimirArbol(a: arbol);
    begin 
        if (a <> nil) then begin 
            ImprimirArbol(a^.HI);
            writeln('DNI: ', a^.dni, '. Cant: ', a^.cant);
            ImprimirArbol(a^.HD);
        end;
    end;


begin 
    writeln;
    writeln('----- MODULO A -----');
    writeln;
    CargarArtesanias(a, v);
    ImprimirVector(v, 8);
    ImprimirArbol(a);
end;


// Implementar un módulo que reciba el árbol generado en a) y un DNI. El módulo debe retornar
// la cantidad de artesanos con DNI menor al DNI generado.
procedure ModuloB(var a: arbol);

    function GetArtesanosUnder(a: arbol; dni: integer): integer;
    var cant: integer;
    begin 
        // Caso base, arbol vacio/nodo vacio
        if (a = nil) then GetArtesanosUnder := 0
        else begin 
            if (a^.dni < dni) then
                cant := 1
            else 
                cant := 0;

            GetArtesanosUnder := cant
                + GetArtesanosUnder(a^.HI, dni)
                + GetArtesanosUnder(a^.Hd, dni);
        end;
    end;

    
var dni, cant: integer;
begin 
    writeln;
    writeln('----- MODULO B -----');
    writeln;
    write('Ingrese un DNI: ');
    readln(dni);
    cant := GetArtesanosUnder(a, dni);
    writeln('Hay ', cant, ' artesanos con DNI menor a ', dni);
end;


// Implementar un módulo que reciba el vector generado en a), lo ordene por cantidad de 
// artesanías de menor a mayor y retorne el nombre de material base con mayor cantidad de 
// artesanías.

procedure ModuloC(v: vector);

    procedure Ordenar(var v: vector; dimLog: integer);
    var 
        i, j, actual: integer;

    begin 
        for i := 2 to dimLog do begin
            actual := v[i];
            j := i - 1;

            while (j > 0) and (v[j] > actual) do 
            begin 
                v[j + 1] := v[j];
                j := j - 1;
            end;

            v[j + 1] := actual;
        end;
    end;

    function GetTopId(v: vector; dimL: integer): integer;
    var posResto: integer;
    begin 
        if (dimL = 1) then GetTopId := 1
        else begin 
            posResto := GetTopId(v, dimL -1);

            if (v[dimL] > v[posResto]) then
                GetTopId := dimL 
            else 
                GetTopId := posResto;
        end;
    end;


    procedure ImprimirVector(v: vector; dimL: integer);
    begin 
        if (dimL > 0) then begin 
            ImprimirVector(v, dimL - 1);
            writeln('#', dimL, ': ', v[dimL]);
        end;
    end;

    function OrdenarRetornarTop(v: vector; dimL: integer): integer;
    begin 
        Ordenar(v, dimL);
        OrdenarRetornarTop := GetTopId(v, dimL);
    end;


var 
    id: integer;
    materiales: array[1..8] of string = (
        'madera', 'yeso', 'ceramica', 'vidrio',
        'acero', 'porcelana', 'lana', 'carton'
    );

begin 
    writeln;
    writeln('----- MODULO C -----');
    writeln;
    id := OrdenarRetornarTop(v, 8);
    writeln('Material con mas artesanias: ', materiales[id]);
end;

var
    a: arbol;
    v: vector;
Begin 

    ModuloA(a, v);
    ModuloB(a);
    ModuloC(v);
End.