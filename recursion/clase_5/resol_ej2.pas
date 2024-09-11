{
    Una agencia dedicada a la venta de autos ha organizado su stock y, tiene la información de
    los autos en venta. Implementar un programa que:
    a) Genere la información de los autos (patente, año de fabricación (2010..2018), marca y
    modelo, finalizando con marca ‘MMM’) y los almacene en dos estructuras de datos:
    i. Una estructura eficiente para la búsqueda por patente.
    ii. Una estructura eficiente para la búsqueda por marca. Para cada marca se deben
    almacenar todos juntos los autos pertenecientes a ella.
    b) Invoque a un módulo que reciba la estructura generado en a) i y una marca y retorne la
    cantidad de autos de dicha marca que posee la agencia.
    c) Invoque a un módulo que reciba la estructura generado en a) ii y una marca y retorne
    la cantidad de autos de dicha marca que posee la agencia.
    d) Invoque a un módulo que reciba el árbol generado en a) i y retorne una estructura con
    la información de los autos agrupados por año de fabricación.
    e) Invoque a un módulo que reciba el árbol generado en a) i y una patente y devuelva el
    modelo del auto con dicha patente.
    f) Invoque a un módulo que reciba el árbol generado en a) ii y una patente y devuelva el
    modelo del auto con dicha patente.
}

program clase5_ej2;
uses sysutils;


type
    rangoYear = 2010..2018;
    tipoPatente = string[7];

    auto = record 
        marca: string;
        patente: tipoPatente;
        fabricacion: rangoYear;
        modelo: string;
    end;

    arbolPatente = ^nodoArbolPatente;
    nodoArbolPatente = record 
        dato: auto;
        HI: arbolPatente;
        HD: arbolPatente;
    end;

    autoM = record 
        patente: string[7];
        fabricacion: rangoYear;
        modelo: string;
    end;

    lista = ^nodoAutoM;
    nodoAutoM = record
        dato: autoM;
        sig: lista;
    end;

    arbolMarca = ^nodoArbolMarca;
    nodoArbolMarca = record 
        marca: string;
        autos: lista;
        HI: arbolMarca; 
        HD: arbolMarca;
    end;


procedure ModuloA(var a1: arbolPatente; var a2: arbolMarca);

    // Genera un caracter aleatorio del abecedario
    function letraAleatoria(): char;
    begin 
        letraAleatoria := Chr(Random(26) + 65); 
    end;


    // Genera un año aleatorio dentro del rango
    function randomYear(): integer;
    begin 
        randomYear := random(8) + 2010;
    end;


    // Genero un strin para la patente con el formato vigente
    procedure GenerarPatente(var p: tipoPatente);
    begin
        p := letraAleatoria() 
            + letraAleatoria()
            + Chr(random(10) + 48)
            + Chr(random(10) + 48)
            + Chr(random(10) + 48)
            + letraAleatoria()
            + letraAleatoria();
    end;


    // Genera aleatoriamente marcas de auto incluida la de corte
    procedure GenerarMarca(var m: string);
    var 
        aux: array[1..21] of string = (
            'byd', 'chery', 'dongfeng', 'fiat', 'ford', 'chevrolet', 'renault', 
            'toyota', 'volkswagen', 'audi', 'ferrari', 'kia', 'subaru', 'tesla', 
            'lamborgini', 'masseratti', 'bmw', 'ram', 'jeep', 'bugatti', 'MMM'
        );

    begin 
        m := aux[random(21) + 1];
    end;


    // Genera aleatoriamente modelos de auto
    procedure GenerarModelo(var mdl: string);
    var 
        aux: array[1..9] of string = (
            'SUV', 'Hatchback', 'Coupe', 
            'Convertible', 'Pickup', 'Minivan', 
            'Crossover', 'Roaster', 'Supersport'
        );

    begin 
        mdl := aux[random(9) + 1];
    end;


    // Genera aleatoriamente valores de un auto
    procedure GenerarAuto(var a: auto);
    begin 
        GenerarMarca(a.marca);
        GenerarPatente(a.patente );
        GenerarModelo(a.modelo);
        a.fabricacion := randomYear();
    end;


    // Imprime la info de un auto
    procedure ImprimirAuto(a: auto);
    begin 
        writeln(a.patente, #9, a.fabricacion, #9, a.marca, #9, a.modelo);
    end;


    // Recorre e imprimie el arbol de patentes
    procedure ImprimirArbolPatente(a: arbolPatente; headers: boolean);
    begin 
        if (a <> nil) then begin
            if (headers) then begin 
                writeln('DOMINIO', #9, 'AÑO', #9, 'MARCA', #9, 'MODELO');
                writeln('-------------------------------------');
            end;

            ImprimirArbolPatente(a^.HI, false);
            ImprimirAuto(a^.dato);
            ImprimirArbolPatente(a^.HD, false);
        end;
    end;


    procedure ImprimirArbolMarca(a: arbolMarca; headers: boolean);
        procedure ImprimirLista(l: lista; headers: boolean);
        begin 
            if (l <> nil) then begin 
                if (headers) then begin 
                    writeln('DOMINIO', #9, 'AÑO', #9, 'MODELO');
                    writeln('--------------------------')
                end;

                ImprimirLista(l^.sig, false);
                writeln(l^.dato.patente, #9, l^.dato.fabricacion, #9, l^.dato.modelo);
                
            end;
        end;


    begin 
        if (a <> nil) then begin 
            ImprimirArbolMarca(a^.HI, false);
            writeln;
            writeln('MARCA: ', a^.marca, ' |');
            ImprimirLista(a^.autos, true);
            ImprimirArbolMarca(a^.HD, false);
        end;
    end;


    procedure CargarAutoPorPatente(var a: arbolPatente; dato: auto);
    begin 
        if (a = nil) then begin 
            new(a);
            a^.dato := dato;
            a^.HI := nil;
            a^.HD := nil;
        end else 
            if (dato.patente < a^.dato.patente) then
                CargarAutoPorPatente(a^.HI, dato)
            else CargarAutoPorPatente(a^.HD, dato);
    end;


    procedure InsertarOrdenado(var l: lista; dato: auto);
    var 
      nue: lista;
      act, ant: lista;          { Puntaros auxiliares para recorrido }

    begin 
      { Crear el nodo a insertar }
      new (nue);
      nue^.dato.patente := dato.patente;
      nue^.dato.fabricacion := dato.fabricacion;
      nue^.dato.modelo := dato.modelo;
      act := l;                 { Ucibo act y ant al inicio de la lista }
      ant := l;

      { Buscar la posición para insertar el nodo creado }
      while (act <> nil) and (dato.patente > act^.dato.patente) do
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


    procedure CargarAutoPorMarca(var a: arbolMarca; dato: auto);
    var aux: arbolMarca;
    begin
        // Caso base, árbol vacío.
        if (a = nil) then begin

            new(aux);
            aux^.marca := dato.marca;
            aux^.autos := nil;     { Inicializo la lista de prestamos }
            aux^.HD := nil;
            aux^.HI := nil;
            
            // Cargo la venta al producto:
            //AgregarAdelante(aux^.prestamos, dato);  <- Opcion B de carga
            InsertarOrdenado(aux^.autos, dato);

            // Actualizo el nodo inicial
            a := aux;
        end
        else begin
            // Si estoy actualizando un nodo existente 
            if (a^.marca = dato.marca) then
                //AgregarAdelante(a^.autos, dato) <- Opcion B de carga
                InsertarOrdenado(a^.autos, dato)

            else begin 
                if (a^.marca > dato.marca) then
                    CargarAutoPorMarca(a^.HI, dato)
                else
                    CargarAutoPorMarca(a^.HD, dato);
            end;
        end;
    end;


    procedure CargarAutos(var a: arbolPatente; var b: arbolMarca);
    var aux: auto;
    begin 
        GenerarAuto(aux);
        while (aux.marca <> 'MMM') do
        begin

            CargarAutoPorPatente(a, aux);
            CargarAutoPorMarca(b, aux);

            GenerarAuto(aux);
        end;
    end;


begin 
    writeln;
    writeln('----- Modulo A ----->');
    writeln;
    CargarAutos(a1, a2);
    ImprimirArbolPatente(a1, true);
    ImprimirArbolMarca(a2, true);
end;


var 
    a: arbolPatente;
    b: arbolMarca;

Begin 
    ModuloA(a, b);
    //ModuloB();
    //ModuloC();
    //ModuloD();
    //ModuloE();
    //ModuloF();
End.