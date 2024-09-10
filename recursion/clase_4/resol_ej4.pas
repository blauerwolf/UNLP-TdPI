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
         -----------------        -------------------       
        |  arbolA         |      |  arbolB           | 
        |-----------------|      |-------------------|
        | dato: prestamoA |      | isbn              |
        | HI              |      | prestamos = lista |
        | HD              |      | HI                |
         =================       | HD                |
                                  ===================


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
        LeerPrestamo(prest1);

        while (prest1.isbn <> 0) do begin
            isbn := prest1.isbn;
            CargarPrestamoB(prest2, prest1);

            // Cargo el primer árbol
            AgregarA(a1, prest1);

            // Cargo el segundo árbol
            AddOrUpdateB(a2, isbn, prest2);
            
            LeerPrestamo(prest1);
        end;
    end;

begin 
    writeln;
    writeln('----- Modulo A ----->');
    writeln;
    CargarArboles(a1, a2);
end;


var 
    a1: arbolA;
    a2: arbolB;
Begin 
    ModuloA(a1, a2);


End.