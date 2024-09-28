{
    La Feria del Libro necesita un sistema para obtener estadísticas sobre los libros prestados.
    
    a) Implementar un módulo que lea información de los libros. De cada libro se conoce:
        - ISBN
        - Código del autor
        - Código del género 
            - 1: literario
            - 2: filosofía
            - 3: biología
            - 4: arte
            - 5: computación
            - 6: medicina
            - 7: ingeniería.
        La lectura finaliza con el valor 0 para el ISBN. El módulo debe retornar dos estructuras:

        i. Un árbol binario de búsqueda ordenado por código de autor. Para cada código de autor debe
        almacenarse la cantidad de libros correspondientes al código.
        ii. Un vector que almacena para cada género, el código del género y la cantidad de libros
        del género.

    b) Implementar un módulo que reciba el vector generado en a), lo ordene por cantidad de libros
    de mayor a menor y retorne el nombre de género con mayor cantidad de libros.

    c) Implementar un módulo que reciba el árbol generado en a) y dos códigos. El módulo debe retornar
    la cantidad total de libros correspondientes a los códigos de autores entre dos códigos
    ingresados (incluidos ambos).

    NOTA: Implementar el programa principal, que invoque a los incisos a, b y c.
}


program feria_libro;

type 

    libro = record 
        isbn: integer;
        idAutor: integer;
        idGenero: integer;
    end;

    arbol = ^nodoArbol;
    nodoArbol = record 
        idAutor: integer;
        cantidad: integer;
        HI: arbol;
        HD: arbol;
    end;

    vector = array[1..7] of integer;


procedure ModuloA(var a: arbol; var v: vector);

    procedure LeerLibro(var l: libro);
    begin 
        l.isbn := random(1000);
        l.idAutor := random(100);
        l.idGenero := random(7) + 1;
    end;

    procedure InicializarVector(var v: vector);
    var i: integer;
    begin 
        for i := 1 to 7 do 
            v[i] := 0;
    end;


    procedure InicializarArbol(var a: arbol);
    begin 
        a := nil;
    end;


    procedure InsertOrUpdate(var a: arbol; dato: libro);
    begin 
        // Caso base: arbol/nodo vacio
        if (a = nil) then begin 
            new (a);
            a^.idAutor := dato.idAutor;
            a^.cantidad := 1;
            a^.HI := nil;
            a^.HD := nil;
        end
        else if (a^.idAutor = dato.idAutor) then 
            // Actualizo el registro
            a^.cantidad := a^.cantidad + 1
        else if (a^.idAutor > dato.idAutor) then 
            InsertOrUpdate(a^.HI, dato)
        else
            InsertOrUpdate(a^.HD, dato);
    end;


    procedure ActualizarVector(var v: vector; idGenero: integer);
    begin 
        v[idGenero] := v[idGenero] + 1;
    end;


    procedure CargarLibros(var a: arbol; var v: vector);
    var 
        l: libro;
    begin 
        InicializarVector(v);
        InicializarArbol(a);

        LeerLibro(l);

        while (l.isbn <> 0) do begin 
            
            InsertOrUpdate(a, l);
            ActualizarVector(v, l.idGenero);

            LeerLibro(l);
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
            writeln('Autor: ', a^.idAutor, ' Cantidad: ', a^.cantidad);
            ImprimirArbol(a^.HD);
        end;
    end;


begin 
    writeln;
    writeln('----- MODULO A -----');
    writeln;
    CargarLibros(a, v);
    ImprimirVector(v, 7);
    writeln;
    ImprimirArbol(a);
end;


// Implementar un módulo que reciba el vector generado en a), lo ordene por cantidad de libros
// de mayor a menor y retorne el nombre de género con mayor cantidad de libros.
procedure ModuloB(v: vector);

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

    function OrdenarRetornarTop(v: vector; dimL: integer): integer;
    begin 
        Ordenar(v, dimL);
        OrdenarRetornarTop := GetTopId(v, dimL);
    end;

var id: integer;
begin 
    writeln;
    writeln('----- MODULO B -----');
    writeln;
    id := OrdenarRetornarTop(v, 7);
    writeln(id);

end;


// Implementar un módulo que reciba el árbol generado en a) y dos códigos. El módulo debe retornar
// la cantidad total de libros correspondientes a los códigos de autores entre dos códigos
// ingresados (incluidos ambos).
procedure ModuloC(var a: arbol);
    function GetTotalBooks(a: arbol; cod1, cod2: integer): integer;
    var cant: integer;
    begin 
        if (a = nil) then GetTotalBooks := 0
        else begin 
            if (a^.idAutor > cod1) and (a^.idAutor < cod2) then 
                cant := 1
            else
                cant := 0;

            GetTotalBooks := cant 
                + GetTotalBooks(a^.HI, cod1, cod2)
                + GetTotalBooks(a^.HD, cod1, cod2);
        end;
    end;

var cod1, cod2, cant: integer;
begin 
    writeln;
    writeln('----- MODULO C -----');
    writeln;
    write('Ingrese codigo 1: '); 
    readln(cod1);
    write('Ingrese codigo 2: ');
    readln(cod2);
    cant := GetTotalBooks(a, cod1, cod2);
    writeln('Hay ', cant, ' libros entre los codigos de autores ', cod1, ' y ', cod2);
end;

var 
    a: arbol;
    v: vector;
Begin 
    ModuloA(a, v);
    ModuloB(v);
    ModuloC(a);
End.

