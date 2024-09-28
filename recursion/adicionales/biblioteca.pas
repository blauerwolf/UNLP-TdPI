{
    * RECURSANTES *
    Una biblioteca necesita un sistema para procesar la información de libros. De cada libro se conoce:
    ISBN, año de edición, código de autor y código de género (1 a 15).

        a) Implementar un módulo que lea la información de los libros y retorne una estructura de datos
        eficiente para la búsqueda por código de autor que contenga código de autor y una lista
        de todos sus libros.

        b) Realizar un módulo que reciba la estructura generada en el inciso a) y un código. El módulo
        debe retornar una lista con códigos de autor y su cantidad de libros, para cada autor co ncódigo
        superior al código ingresado.

        c) Realizar un módulo recursivo que reciba la estructura generada en el inciso b) y retorn
        cantidad y código de autor con mayor cantidad de libros.

    NOTA: Implementar el programa principal, que invoque los incisos a, b y c.
}

program biblio;

type
  tipoGenero = 1..15;

  libro = record 
      isbn: integer;
      edicion:  integer;
      genero: tipoGenero;
  end;

  lista = ^nodo;
  nodo = record 
      dato: libro;
      sig: lista;
  end;

  lista2 = ^nodo2;
  nodo2 = record
      idAutor: integer;
      cantidad: integer;
      sig: lista2;
  end;

  arbol = ^nodoArbol;
  nodoArbol = record 
      idAutor: integer;
      libros: lista;
      HI: arbol;
      HD: arbol;
  end;


// Implementar un módulo que lea la información de los libros y retorne una estructura de datos
// eficiente para la búsqueda por código de autor que contenga código de autor y una lista
// de todos sus libros.
procedure ModuloA(var a: arbol);

    procedure InsertarOrdenado(var l: lista; dato: libro);
    var 
        nue, act, ant: lista;     { Puntaros auxiliares para recorrido }
        
    begin 
        { Crear el nodo a insertar }
        new (nue);
        nue^.dato := dato;
        act := l;                 { Ucibo act y ant al inicio de la lista }
        ant := l;

        { Buscar la posición para insertar el nodo creado }
        while (act <> nil) and (dato.isbn > act^.dato.isbn) do
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

    procedure AddOrUpdate(var a: arbol; idAutor: integer; dato: libro);
    begin 
        // Caso base, arbol vacio
        if (a = nil) then begin 
            new(a);
            a^.idAutor := idAutor;
            a^.libros := nil;
            a^.HI := nil;
            a^.HD := nil;

            InsertarOrdenado(a^.libros, dato);
        end
        else if (a^.idAutor = idAutor) then begin 
            InsertarOrdenado(a^.libros, dato)
        end
        else  
            if (a^.idAutor < idAutor) then 
                AddOrUpdate(a^.HD, idAutor, dato)
            else AddOrUpdate(a^.HI, idAutor, dato);
    end;

    procedure LeerLibro(var l: libro);
    begin 
        l.isbn :=  random(1000);
        l.edicion := random(20) + 2000;
        l.genero := random(15) + 1;
    end;


    procedure CargarLibros(var a: arbol);
    var 
        idAutor: integer;
        lib: libro;
    begin 

        idAutor := random(400);

        while (idAutor <> 0) do begin 
            LeerLibro(lib);

            AddOrUpdate(a, idAutor, lib);

            idAutor := random(400);
        end;
    end;

    procedure ImprimirLibros(l: lista);
    begin 
        if (l <> nil) then begin 
            write(l^.dato.isbn,'::', l^.dato.edicion, '::', l^.dato.genero, ' | ');
            ImprimirLibros(l^.sig);
        end;
    end;

    procedure ImprimirArbol(a: arbol);
    begin 
        if (a <> nil) then begin 
            ImprimirArbol(a^.HI);
            writeln;
            writeln('Autor: ', a^.idAutor);
            writeln('----------');
            write('ISBN::Año::Genero -> | ');
            ImprimirLibros(a^.libros);
            writeln;

            ImprimirArbol(a^.HD);
        end;
    end;


begin 
    writeln;
    writeln('----- MODULO A -----');
    writeln;
    CargarLibros(a);
    ImprimirArbol(a);
end;


// Realizar un módulo que reciba la estructura generada en el inciso a) y un código. El módulo
// debe retornar una lista con códigos de autor y su cantidad de libros, para cada autor co ncódigo
// superior al código ingresado.
procedure ModuloB(a: arbol; var b: lista2);

    procedure InsertarOrdenado2(var l: lista2; idAutor: integer; cant: integer);
    var 
        nue, act, ant: lista2;     { Puntaros auxiliares para recorrido }
        
    begin 
        { Crear el nodo a insertar }
        new (nue);
        nue^.idAutor := idAutor;
        nue^.cantidad := cant;
        act := l;                 { Ucibo act y ant al inicio de la lista }
        ant := l;

        { Buscar la posición para insertar el nodo creado }
        while (act <> nil) and (idAutor > act^.idAutor) do
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

    function ContarLibros(l: lista): integer;
    begin 
        // Caso base, lista vacia
        if (l = nil) then  ContarLibros := 0
        else
            ContarLibros := 1 + ContarLibros(l^.sig);
    end;


    procedure GenerarLista(a: arbol; idAutor: integer; var l: lista2);
    var cant: integer;
    begin 
        // Caso base: arbol vacio.
        if (a <> nil) then begin 
            if (idAutor < a^.idAutor)  then
            begin 
                // Copio los valores en la lista
                cant := ContarLibros(a^.libros);
                InsertarOrdenado2(l, a^.idAutor, cant);

                
            end;

            // Llamada recursiva.
            GenerarLista(a^.HD, idAutor, l);
            GenerarLista(a^.HI, idAutor, l);
        end;
    end;


    procedure ImprimirLista(l: lista2);
    begin 
        if (l <> nil) then begin
            write(' ', l^.idAutor, '=', l^.cantidad,' | ');
            ImprimirLista(l^.sig);
        end;
    end;


var cod: integer;
begin 
    b := nil;
    writeln;
    writeln('----- MODULO B -----');
    writeln;
    write('Ingrese codigo: ');
    readln(cod);
    writeln('Lista generada correctamente');
    GenerarLista(a, cod, b);
    writeln;
    ImprimirLista(b);

end;

// Realizar un módulo recursivo que reciba la estructura generada en el inciso b) y retorn
// cantidad y código de autor con mayor cantidad de libros.
procedure ModuloC(b: lista2);
    procedure GetTopAutor(b: lista2; var maxId, cant: integer);
    begin 
        // Caso base, lista vacia
        if (b <> nil) then begin 
            if (b^.cantidad > cant) then begin 
                maxId := b^.idAutor;
                cant := b^.cantidad;
            end;

            GetTopAutor(b^.sig, maxId, cant);
        end;
    end;


var maxId, cant: integer;
begin 
    writeln;
    writeln('----- MODULO C -----');
    writeln;
    maxId := -1;
    cant := -1;
    GetTopAutor(b, maxId, cant);
    if (b <> nil) then 
        writeln('El autor con mas publicaciones (', cant, ') es: ', maxId)
    else writeln('No hay resultados en la lista');
end;


var 
  a: arbol;
  b: lista2;
Begin 

  ModuloA(a);
  ModuloB(a, b);
  ModuloC(b);
End.