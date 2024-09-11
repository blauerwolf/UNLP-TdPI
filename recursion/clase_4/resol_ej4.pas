{
    Una biblioteca nos ha encargado procesar la información de los préstamos realizados
    durante el año 2021. De cada préstamo se conoce el ISBN del libro, el número de socio, día
    y mes del préstamo y cantidad de días prestados. Implementar un programa con:
    
    a. Un módulo que lea préstamos y retorne 2 estructuras de datos con la información de
    los préstamos. La lectura de los préstamos finaliza con ISBN 0. Las estructuras deben
    ser eficientes para buscar por ISBN.

        i. En una estructura cada préstamo debe estar en un nodo. Los ISBN repetidos
        insertarlos a la derecha.
        ii. En otra estructura, cada nodo debe contener todos los préstamos realizados al ISBN.
        (prestar atención sobre los datos que se almacenan).

    b. Un módulo recursivo que reciba la estructura generada en i. y retorne el ISBN más
    grande.
    c. Un módulo recursivo que reciba la estructura generada en ii. y retorne el ISBN más
    pequeño.
    d. Un módulo recursivo que reciba la estructura generada en i. y un número de socio. El
    módulo debe retornar la cantidad de préstamos realizados a dicho socio.
    e. Un módulo recursivo que reciba la estructura generada en ii. y un número de socio. El
    módulo debe retornar la cantidad de préstamos realizados a dicho socio.
    f. Un módulo que reciba la estructura generada en i. y retorne una nueva estructura
    ordenada ISBN, donde cada ISBN aparezca una vez junto a la cantidad total de veces
    que se prestó.
    g. Un módulo que reciba la estructura generada en ii. y retorne una nueva estructura
    ordenada ISBN, donde cada ISBN aparezca una vez junto a la cantidad total de veces
    que se prestó.
    h. Un módulo recursivo que reciba la estructura generada en g. y muestre su contenido.
    i. Un módulo recursivo que reciba la estructura generada en i. y dos valores de ISBN. El
    módulo debe retornar la cantidad total de préstamos realizados a los ISBN
    comprendidos entre los dos valores recibidos (incluidos).
    j. Un módulo recursivo que reciba la estructura generada en ii. y dos valores de ISBN. El
    módulo debe retornar la cantidad total de préstamos realizados a los ISBN
    comprendidos entre los dos valores recibidos (incluidos).

    REGISTROS:
         -----------------        -----------------      
        |    prestamoA    |      |    prestamoB    |      
        |-----------------|      |-----------------|
        | isbn            |      | socioId         |
        | socioId         |      | dia             |
        | dia             |      | mes             |
        | mes             |      | cantDias        |
        | cantDias        |       =================
         =================     

    LISTAS:
         ------------------       ------------------------
        |  nodoPrestamoB   |     | lista = ^nodoPrestamoB |
        |------------------|      ------------------------
        | isbn             |
        | sig: lista       |
         ==================


    ARBOLES:
         -----------------        -------------------        -----------------       
        |  arbolA         |      |  arbolB           |      |  arbolC         | 
        |-----------------|      |-------------------|      |-----------------|
        | dato: prestamoA |      | isbn              |      | isbn            |
        | HI              |      | prestamos = lista |      | totalPrestamos  |
        | HD              |      | HI                |      | HI              |
         =================       | HD                |      | HD              |
                                  ===================        =================


}

program ejercicio4;

type
    rangoDia = 1..31;
    rangoMes = 1..12;

    prestamoA = record 
        isbn: integer;
        socioId: integer;
        dia: rangoDia;
        mes: rangoMes;
        cantDias: integer;
    end;

    prestamoB = record
        socioId: integer;
        dia: rangoDia;
        mes: rangoMes;
        cantDias: integer;
    end;

    lista = ^nodo;

    nodo = record 
        dato: prestamoB;
        sig: lista;
    end;

    arbolA = ^nodoA;
    nodoA = record 
        dato: prestamoA;
        HI: arbolA;
        HD: arbolA;
    end;

    arbolB = ^nodoB;
    nodoB = record 
        isbn: integer;
        prestamos: lista;
        HI: arbolB;
        HD: arbolB;
    end;

    arbolC = ^nodoC;
    nodoC = record 
        isbn: integer;
        totalPrestamos: integer;
        HI: arbolC;
        HD: arbolC;
    end;



{
    a. Un módulo que lea préstamos y retorne 2 estructuras de datos con la información de
    los préstamos. La lectura de los préstamos finaliza con ISBN 0. Las estructuras deben
    ser eficientes para buscar por ISBN.

    i. En una estructura cada préstamo debe estar en un nodo. Los ISBN repetidos
    insertarlos a la derecha.
    ii. En otra estructura, cada nodo debe contener todos los préstamos realizados al ISBN.
    (prestar atención sobre los datos que se almacenan).
}
procedure ModuloA(var a1: arbolA; var a2: arbolB);

    procedure ImprimirPrestamo(p: prestamoA);
    begin 
        writeln(p.isbn, #9, #9, p.socioId, #9, #9, p.dia, '/', p.mes, '/2021', #9, p.cantDias);
    end;

    procedure LeerPrestamo(var p:prestamoA);
    begin 
        write('ISBN: '); readln(p.isbn);
        if (p.isbn <> 0) then  begin 
            write('Cod. Socio: '); readln(p.socioId);
            write('Dia: '); readln(p.dia);
            write('Mes: '); readln(p.mes);
            write('Cantidad de dias: '); readln(p.cantDias);
        end;
        writeln;
        writeln('-- FIN DE CARGA --');
    end;

    procedure LeerPrestamoRandom(var p:prestamoA; headers: boolean);
    begin
        p.isbn := random(100);
        if (p.isbn <> 0) then begin 
            p.socioId := random(500) + 1;
            p.dia := random(30) + 1;
            p.mes := random(12) + 1;
            p.cantDias := random(7) + 1;

            if (headers) then 
                writeln('ISBN:', #9, 'Socio', #9, 'Fecha', #9, #9, 'Dias prestado');

            ImprimirPrestamo(p);
        end 
        else begin 
            writeln;
            writeln('-- FIN DE CARGA --');
        end;
    end;

    procedure CargarPrestamoB(var p: prestamoB; orig: prestamoA);
    begin 
        p.socioId := orig.socioId; 
        p.dia := orig.dia;
        p.mes := orig.mes;
        p.cantDias := orig.cantDias;
    end;


    // Agrega un nuevo nodo adelante en la lista de prestamos del arbolB
    procedure AgregarAdelante(var l:lista; dato: prestamoB);
    var
        nue: lista;
    begin
        new(nue);
        nue^.dato := dato;
        nue^.sig := l;
        l := nue;
    end;


    procedure InsertarOrdenado(var l: lista; dato: prestamoB);
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
      while (act <> nil) and (dato.mes > act^.dato.mes) do
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


    // Procedimiento recursivo. Por referencia. Solo la primera vez se modifica a
    // Los repetidos van a la derecha.
    procedure AgregarA(var a: arbolA; dato: prestamoA);
    begin 
        { en vez de usar una variable auxiliar nue, hago new de la variable de tipo arbol }
        if (a = nil) then begin 
            new(a);
            a^.dato := dato;
            a^.HI := nil;
            a^.HD := nil;
        end else 
            if (dato.isbn < a^.dato.isbn) then AgregarA(a^.HI, dato)
            else AgregarA(a^.HD, dato);

    end;


    procedure AddOrUpdateB(var a: arbolB; isbn: integer; dato: prestamoB);
    var aux: arbolB;
    begin
        // Caso base, árbol vacío.
        if (a = nil) then begin

            new(aux);
            aux^.isbn := isbn;
            aux^.prestamos := nil;     { Inicializo la lista de prestamos }
            aux^.HD := nil;
            aux^.HI := nil;
            
            // Cargo la venta al producto:
            //AgregarAdelante(aux^.prestamos, dato);
            InsertarOrdenado(aux^.prestamos, dato);

            // Actualizo el nodo inicial
            a := aux;
        end
        else begin
            // Si estoy actualizando un nodo existente 
            if (a^.isbn = isbn) then
                AgregarAdelante(a^.prestamos, dato)

            else begin 
                if (a^.isbn > isbn) then
                    AddOrUpdateB(a^.HI, isbn, dato)
                else
                    AddOrUpdateB(a^.HD, isbn, dato);
            end;
        end;
    end;

    procedure CargarArboles(var a1: arbolA; var a2: arbolB);
    var 
        prest1: prestamoA;
        prest2: prestamoB;
        isbn: integer;
    begin 
        // Leo los valores hasta que se cumpla la condicion
        //LeerPrestamo(prest1);
        randomize;
        LeerPrestamoRandom(prest1, true);

        while (prest1.isbn <> 0) do begin
            isbn := prest1.isbn;
            CargarPrestamoB(prest2, prest1);

            // Cargo el primer árbol
            AgregarA(a1, prest1);

            // Cargo el segundo árbol
            AddOrUpdateB(a2, isbn, prest2);
            
            //LeerPrestamo(prest1);
            LeerPrestamoRandom(prest1, false);
        end;
    end;

begin 
    writeln;
    writeln('----- Modulo A ----->');
    writeln;
    CargarArboles(a1, a2);
end;


//  Un módulo recursivo que reciba la estructura generada en i. y retorne el ISBN más
//  grande.
procedure ModuloB(a1: arbolA);
    function GetTopISBN(a: arbolA): integer;
    begin 
        if (a <> nil) then begin
            if (a^.HD <> nil) then 
                GetTopISBN := GetTopISBN(a^.HD)
            else GetTopISBN := a^.dato.isbn;
        end
        else GetTopISBN := -1;
    end;

var isbn: integer;
begin 
    writeln;
    writeln('----- Modulo B ----->');
    writeln;
    isbn := GetTopISBN(a1);
    writeln('El mayor ISBN es: ', isbn);
    writeln;
end;


// Un módulo recursivo que reciba la estructura generada en ii. y retorne el ISBN más
// pequeño.
procedure ModuloC(a2: arbolB);
    function GetBottomISBN(a: arbolB): integer;
    begin 
        if (a <> nil) then begin
            if (a^.HI <> nil) then 
                GetBottomISBN := GetBottomISBN(a^.HD)
            else GetBottomISBN := a^.isbn;
        end
        else GetBottomISBN := -1;
    end;

var isbn: integer;
begin 
    writeln;
    writeln('----- Modulo C ----->');
    writeln;
    isbn := GetBottomISBN(a2);
    writeln('El menor ISBN es: ', isbn);
    writeln;
end;


// Un módulo recursivo que reciba la estructura generada en i. y un número de socio. El
// módulo debe retornar la cantidad de préstamos realizados a dicho socio
procedure ModuloD(a1: arbolA);
    function GetTotalPrestamos(a: arbolA; socioId: integer): integer;
    var suma: integer;
    begin 
        if (a = nil) then GetTotalPrestamos := 0
        else begin 
            if (a^.dato.socioId = socioId) 
            then suma := 1
            else suma := 0;

            GetTotalPrestamos := suma 
                + GetTotalPrestamos(a^.HI, socioId)
                + GetTotalPrestamos(a^.HD, socioId);

        end;
    end;

var socioId, total: integer;
begin 
    writeln;
    writeln('----- Modulo D ----->');
    writeln;
    write('Ingrese numero de socio a buscar: ');
    readln(socioId);
    total := GetTotalPrestamos(a1, socioId);
    writeln('El socio ', socioId, ' posee ', total, ' prestamos.');
end;


// Un módulo recursivo que reciba la estructura generada en ii. y un número de socio. El
// módulo debe retornar la cantidad de préstamos realizados a dicho socio.
procedure ModuloE(a: arbolB);

    function SumarPrestamos(l: lista; socioId: integer): integer;
    var suma: integer;
    begin 
        if (l = nil) then SumarPrestamos := 0
        else begin
            if (l^.dato.socioId = socioId) 
            then suma := 1
            else suma := 0;

            SumarPrestamos := suma + SumarPrestamos(l^.sig, socioId);
        end;
    end;
    
    function GetTotalPrestamosB(a: arbolB; socioId: integer): integer;
    var suma: integer;
    begin 
        // Caso base: arbol vacio
        if (a = nil) then GetTotalPrestamosB := 0
        else begin 
            suma := SumarPrestamos(a^.prestamos, socioId);

            GetTotalPrestamosB := suma
                + GetTotalPrestamosB(a^.HI, socioId)
                + GetTotalPrestamosB(a^.HD, socioId);
        end;
    end;


var socioId, total: integer;
begin 
    writeln;
    writeln('----- Modulo E ----->');
    writeln;
    write('Ingrese numero de socio a buscar: ');
    readln(socioId);
    total := GetTotalPrestamosB(a, socioId);
    writeln('El socio ', socioId, ' posee ', total, ' prestamos.');
end;



// Un módulo que reciba la estructura generada en i. y retorne una nueva estructura
// ordenada ISBN, donde cada ISBN aparezca una vez junto a la cantidad total de veces
// que se prestó.
procedure ModuloF(a1: arbolA; var a3: arbolC);

    procedure AddOrUpdateC(var a: arbolC; isbn: integer);
    var aux: arbolC;
    begin
        // Caso base, árbol vacío.
        if (a = nil) then begin

            new(aux);
            aux^.isbn := isbn;
            aux^.totalPrestamos := 1;
            aux^.HD := nil;
            aux^.HI := nil;

            // Actualizo el nodo inicial
            a := aux;
        end
        else begin
            // Si estoy actualizando un nodo existente 
            if (a^.isbn = isbn) then
                // Actualizo los valores de totales de préstamo:
                a^.totalPrestamos := a^.totalPrestamos + 1

            else begin 
                if (a^.isbn > isbn) then
                    AddOrUpdateC(a^.HI, isbn)
                else
                    AddOrUpdateC(a^.HD, isbn);
            end;
        end;
    end;


    procedure CargarArbolC(a1: arbolA; var a3: arbolC);
    begin 
        // Caso base: arbol a1 vacio, no hago nada.
        if (a1 <> nil) then begin
            AddOrUpdateC(a3, a1^.dato.isbn);
            CargarArbolC(a1^.HI, a3);
            CargarArbolC(a1^.HD, a3);
        end;
    end;

begin
    a3 := nil;
    writeln;
    writeln('----- Modulo F ----->');
    writeln;
    CargarArbolC(a1, a3);
end;


// Un módulo que reciba la estructura generada en ii. y retorne una nueva estructura
// ordenada ISBN, donde cada ISBN aparezca una vez junto a la cantidad total de veces
// que se prestó.
procedure ModuloG(a1: arbolB; var a4: arbolC);

    function ContarPrestamos(l: lista): integer;
    begin 
        if (l = nil) then ContarPrestamos := 0
        else 
            ContarPrestamos := 1 + ContarPrestamos(l^.sig);
    end;


    procedure AddOrUpdateC(var a: arbolC; isbn: integer; total: integer);
    var aux: arbolC;
    begin
        // Caso base, árbol vacío.
        if (a = nil) then begin

            new(aux);
            aux^.isbn := isbn;
            aux^.totalPrestamos := total;
            aux^.HD := nil;
            aux^.HI := nil;

            // Actualizo el nodo inicial
            a := aux;
        end
        else begin
            if (a^.isbn > isbn) then
                AddOrUpdateC(a^.HI, isbn, total)
            else
                AddOrUpdateC(a^.HD, isbn, total);
        end;
    end;


    procedure CargarArbolC(a2: arbolB; var a4: arbolC);
    var totalPrestamos: integer;
    begin 
        if (a2 <> nil) then begin 
            // Obtengo la cantidad de prestamos para ese ISBN
            totalPrestamos := ContarPrestamos(a2^.prestamos);
            AddOrUpdateC(a4, a2^.isbn, totalPrestamos);
            CargarArbolC(a2^.HI, a4);
            CargarArbolC(a2^.HD, a4);
        end;
    end;

begin 
    a4 := nil;
    writeln;
    writeln('----- Modulo G ----->');
    writeln;
    CargarArbolC(a1, a4);
end;


// Un módulo recursivo que reciba la estructura generada en g. y muestre su contenido.
procedure ModuloH(a: arbolC);

    procedure ImprimirArbol(a: arbolC);
    begin 
        if (a <> nil) then begin 
            ImprimirArbol(a^.HI);
            writeln(a^.isbn, #9, a^.totalPrestamos);
            ImprimirArbol(a^.HD);
        end;
    end;


begin 
    writeln;
    writeln('----- Modulo H ----->');
    writeln;
    writeln('ISBN', #9, 'Total Prestamos');
    ImprimirArbol(a);
end;


// Un módulo recursivo que reciba la estructura generada en i. y dos valores de ISBN. El
// módulo debe retornar la cantidad total de préstamos realizados a los ISBN
procedure ModuloI(a: arbolA);

    function GetTotalPrestamos2ISBN(a: arbolA; isbn1, isbn2: integer): integer;
    var prestamo: integer;
    begin 
        if (a = nil) then GetTotalPrestamos2ISBN := 0
        else begin 
            if (a^.dato.isbn = isbn1) or (a^.dato.isbn = isbn2) 
            then prestamo := 1
            else prestamo := 0;

            GetTotalPrestamos2ISBN := prestamo
                + GetTotalPrestamos2ISBN(a^.HI, isbn1, isbn2)
                + GetTotalPrestamos2ISBN(a^.HD, isbn1, isbn2);
        end;
    end;


var isbn1, isbn2, total: integer;
begin 
    writeln;
    writeln('----- Modulo I ----->');
    writeln;
    write('Ingrese el primer ISBN: ');
    readln(isbn1);
    write('Ingrese el segundo ISBN: ');
    readln(isbn2);
    total := GetTotalPrestamos2ISBN(a, isbn1, isbn2);
    writeln('El total de prestamos a los ISBN ', isbn1, ' y ', isbn2, ' es: ', total);
end;


// Un módulo recursivo que reciba la estructura generada en ii. y dos valores de ISBN. El
// módulo debe retornar la cantidad total de préstamos realizados a los ISBN
// comprendidos entre los dos valores recibidos (incluidos).
procedure ModuloJ(a: arbolB);

    function ContarPrestamos(l: lista): integer;
    begin 
        if (l = nil) then ContarPrestamos := 0
        else 
            ContarPrestamos := 1 + ContarPrestamos(l^.sig);
    end;


    function GetTotalPrestamos2ISBN_B(a: arbolB; isbn1, isbn2: integer): integer;
    var prestamo: integer;
    begin 
        if (a = nil) then GetTotalPrestamos2ISBN_B := 0
        else begin 
            if (a^.isbn = isbn1) or (a^.isbn = isbn2)
            then prestamo := ContarPrestamos(a^.prestamos)
            else prestamo := 0;

            GetTotalPrestamos2ISBN_B := prestamo 
                + GetTotalPrestamos2ISBN_B(a^.HI, isbn1, isbn2)
                + GetTotalPrestamos2ISBN_B(a^.HD, isbn1, isbn2);
        end;
    end;

var isbn1, isbn2, total: integer;
begin 
    writeln;
    writeln('----- Modulo J ----->');
    writeln;
    write('Ingrese el primer ISBN: ');
    readln(isbn1);
    write('Ingrese el segundo ISBN: ');
    readln(isbn2);
    total := GetTotalPrestamos2ISBN_B(a, isbn1, isbn2);
    writeln('El total de prestamos a los ISBN ', isbn1, ' y ', isbn2, ' es: ', total);
end;

var 
    a1: arbolA;
    a2: arbolB;
    a3, a4: arbolC;
    
Begin 
    ModuloA(a1, a2);
    ModuloB(a1);
    ModuloC(a2);
    ModuloD(a1);
    ModuloE(a2);
    ModuloF(a1, a3);
    ModuloG(a2, a4);
    ModuloH(a4);
    ModuloI(a1);
    ModuloJ(a2);
End.