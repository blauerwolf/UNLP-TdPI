{
    Una oficina requiere el procesamiento de los reclamos de las personas. De cada reclamo
    se ingresa código, DNI de la persona, año y tipo de reclamo. El ingreso finaliza con el
    código de igual a 0. Se pide:

    ✅ a) Un módulo que retorne estructura adecuada para la búsqueda por DNI. Para cada DNI
    se deben tener almacenados cada reclamo y la cantidad total de reclamos que realizó.
    ✅ b) Un módulo que reciba la estructura generada en a) y un DNI y retorne la cantidad de
    reclamos efectuados por ese DNI.
    ✅ c) Un módulo que reciba la estructura generada en a) y dos DNI y retorne la cantidad de
    reclamos efectuados por todos los DNI comprendidos entre los dos DNI recibidos.
    ✅ d) Un módulo que reciba la estructura generada en a) y un año y retorne los códigos de
    los reclamos realizados en el año recibido.
}

program clase5_ej4;

type
    reclamo = record 
        codigo: integer;
        year: integer;
        reclamo: string;
    end;

    lista = ^nodo;
    nodo = record
        dato: reclamo;
        sig: lista;
    end;

    arbol = ^nodoArbol;
    nodoArbol = record 
        dni: integer;
        reclamos: lista;
        HI: arbol;
        HD: arbol;
    end;

// Un módulo que retorne estructura adecuada para la búsqueda por DNI. Para cada DNI
// se deben tener almacenados cada reclamo y la cantidad total de reclamos que realizó.
procedure ModuloA(var a: arbol);
    procedure GenerarTextoRandom(var texto: string);
    var 
        palabras: array[1..5] of string = (
            'lorem', 'ipsum', 'dolor', 'sit', 'amet'
        );
        i, idx: integer;
    begin 
        texto := '';

        for i := 1 to 5 do begin 
            idx := random(5) + 1;
            texto := texto + palabras[idx] + ' ';
        end;
    end;


    procedure GenerarReclamo(var r: reclamo);
    begin 
        r.codigo := random(100);
        r.year := random(10) + 2010;
        GenerarTextoRandom(r.reclamo);
    end;


    procedure InsertarOrdenado(var l: lista; dato: reclamo);
    var 
        nue: lista;
        act, ant: lista;          { Puntaros auxiliares para recorrido }

    begin 
        { Crear el nodo a insertar }
        new (nue);
        nue^.dato := dato;
        act := l;                 { Ucibo act y ant al inicio de la lista }
        ant := l;

        { Buscar la posición para insertar el nodo creado }
        while (act <> nil) and (dato.codigo > act^.dato.codigo) do
        begin 
            ant := act;
            act := act^.sig;
        end;

        if (act = ant) then     { al inicio o lista vacía }
            l := nue
        else                    { al medio o al final }
            ant^.sig := nue;

        nue^.sig := act;
    end;


    procedure Agregar(var a: arbol; dni: longint; r: reclamo);
    begin 
        { en vez de usar una variable auxiliar nue, hago new de la variable de tipo arbol }
        if (a = nil) then begin 
            new(a);
            a^.dni := dni;
            a^.reclamos := nil;
            a^.HI := nil;
            a^.HD := nil;

            InsertarOrdenado(a^.reclamos, r);

        end else 
            // Si la marca coincide, inserto el auto en la lista de esa marca
            if (a^.dni = dni) then
                InsertarOrdenado(a^.reclamos, r)
            else begin
                // Si la marca del dato es menor, inserto en el subárbol izquierdo
                if (dni < a^.dni) then
                    Agregar(a^.HI, dni, r)
                else
                    // Si la marca del dato es mayor, inserto en el subárbol derecho
                    Agregar(a^.HD, dni, r);
            end;
    end;

    procedure CargarReclamos(var a: arbol);
    var 
        dni: longint;
        r: reclamo;
    begin 
        randomize;
        dni := random(10000);
        GenerarReclamo(r);

        while (r.codigo <> 0) do begin 
            Agregar(a, dni, r);

            dni := random(10000);
            GenerarReclamo(r);
        end;
    end;


    procedure ImprimirLista(l: lista);
    begin 
        if (l <> nil) then begin 
            writeln('COD', #9, 'AÑO', #9, 'TIPO');
            writeln('----------------------------------');
        end; 

        while (l <> nil) do begin 
            writeln(l^.dato.codigo, #9, l^.dato.year, #9, l^.dato.reclamo);
            l := l^.sig;
        end;
    end;

    procedure ImprimirArbol(a: arbol);
    begin 
        if (a <> nil) then begin 

            ImprimirArbol(a^.HI);
            writeln;
            writeln('Reclamos del DNI: ', a^.dni);
            ImprimirLista(a^.reclamos);
            ImprimirArbol(a^.HD);
        end;
    end;

begin 
    writeln;
    writeln('----- Modulo A ----->');
    writeln;
    CargarReclamos(a);
    ImprimirArbol(a);
end;


// Común a ModuloB y ModuloC, cuenta elementos de la lista
function ContarLista(l: lista): integer;
begin 
    if (l = nil) then ContarLista := 0
    else begin 
        ContarLista := 1 + ContarLista(l^.sig);
    end;
end;

// Un módulo que reciba la estructura generada en a) y un DNI y retorne la cantidad de
// reclamos efectuados por ese DNI.
procedure ModuloB(a: arbol);

    function ContarReclamos(a: arbol; dni: longint): integer;
    var reclamos: integer;
    begin 
        if (a = nil) then ContarReclamos := 0
        else begin 
            if (a^.dni = dni) then 
                ContarReclamos := ContarLista(a^.reclamos)
            else if (dni < a^.dni) then 
                ContarReclamos := ContarReclamos(a^.HI, dni)
            else ContarReclamos := ContarReclamos(a^.HD, dni);

        end;
    end;
var 
    dni: longint;
    tot: integer;
begin 
    writeln;
    writeln('----- Modulo B ----->');
    writeln;
    write('Ingrese DNI a buscar: ');
    readln(dni);
    tot := ContarReclamos(a, dni);
    writeln('Cantidad de reclamos del DNI ', dni, ': ', tot);
end;


// Un módulo que reciba la estructura generada en a) y dos DNI y retorne la cantidad de
// reclamos efectuados por todos los DNI comprendidos entre los dos DNI recibidos.
procedure ModuloC(a: arbol);

    function ContarReclamosEntre(a: arbol; dni1, dni2: longint): integer;
    var cant: integer;
    begin 
        if (a = nil) then ContarReclamosEntre := 0
        else begin 
            if (a^.dni > dni1) and (a^.dni < dni2) then 
                cant := ContarLista(a^.reclamos)
            else 
                cant := 0;

            ContarReclamosEntre := cant
                + ContarReclamosEntre(a^.HI, dni1, dni2)
                + ContarReclamosEntre(a^.HD, dni1, dni2);
        end;
    end;

var 
    dni1, dni2: longint;
    tot: integer;
begin 
    writeln;
    writeln('----- Modulo C ----->');
    writeln;
    write('Ingrese primer DNI: ');
    readln(dni1);
    write('Ingrese segundo DNI: ');
    readln(dni2);
    tot := ContarReclamosEntre(a, dni1, dni2);
    writeln('Cantidad de reclamos entre los DNI ', dni1, ' y ', dni2, ': ', tot);

end;


// Un módulo que reciba la estructura generada en a) y un año y retorne los códigos de
// los reclamos realizados en el año recibido.
procedure ModuloD(a: arbol);
    function ContarLista(l: lista; year: integer): integer;
    var cant: integer;
    begin 
        if (l = nil) then ContarLista := 0
        else begin
            if (l^.dato.year = year) then
                cant := 1
            else 
                cant := 0;

            ContarLista := cant + ContarLista(l^.sig, year);
        end;
    end;


    function ContarReclamosDurante(a: arbol; year: integer): integer;
    var cant: integer;
    begin 
        if (a = nil) then ContarReclamosDurante := 0
        else begin 
            cant := ContarLista(a^.reclamos, year);
            ContarReclamosDurante := cant
                + ContarReclamosDurante(a^.HI, year)
                + ContarReclamosDurante(a^.HD, year);
        end;
    end;


var year, tot: integer;
begin 
    writeln;
    writeln('----- Modulo D ----->');
    writeln;
    write('Ingrese un año: '); 
    readln(year);
    tot := ContarReclamosDurante(a, year);
    writeln('Cantidad de reclamos durante el año ', year, ': ', tot);
end;

var 
    a: arbol;
    
Begin 
    ModuloA(a);
    ModuloB(a);
    ModuloC(a);
    ModuloD(a);
End.