{
    Una agencia dedicada a la venta de autos ha organizado su stock y, tiene la información de
    los autos en venta. Implementar un programa que:
    ✅ a) Genere la información de los autos (patente, año de fabricación (2010..2018), marca y
    modelo, finalizando con marca ‘MMM’) y los almacene en dos estructuras de datos:
    i. Una estructura eficiente para la búsqueda por patente.
    ii. Una estructura eficiente para la búsqueda por marca. Para cada marca se deben
    almacenar todos juntos los autos pertenecientes a ella.
    ✅ b) Invoque a un módulo que reciba la estructura generado en a) i y una marca y retorne la
    cantidad de autos de dicha marca que posee la agencia.
    ✅ c) Invoque a un módulo que reciba la estructura generado en a) ii y una marca y retorne
    la cantidad de autos de dicha marca que posee la agencia.
    ✅ d) Invoque a un módulo que reciba el árbol generado en a) i y retorne una estructura con
    la información de los autos agrupados por año de fabricación.
    ✅ e) Invoque a un módulo que reciba el árbol generado en a) i y una patente y devuelva el
    modelo del auto con dicha patente.
    ✅ f) Invoque a un módulo que reciba el árbol generado en a) ii y una patente y devuelva el
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

    autoF = record 
        marca: string;
        patente: tipoPatente;
        modelo: string;
    end;

    lista2 = ^nodo2;
    nodo2 = record
        dato: autoF;
        sig: lista2;
    end;

    vector = array[2010..2018] of lista2;




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
            new(a);
            a^.marca := dato.marca;
            a^.autos := nil;     { Inicializo la lista de autos }
            a^.HI := nil;
            a^.HD := nil;
            // Cargo el auto a la lista de autos de esta marca
            InsertarOrdenado(a^.autos, dato);
        end
        else begin
            // Si la marca coincide, inserto el auto en la lista de esa marca
            if (a^.marca = dato.marca) then
                InsertarOrdenado(a^.autos, dato)
            else begin
                // Si la marca del dato es menor, inserto en el subárbol izquierdo
                if (dato.marca < a^.marca) then
                    CargarAutoPorMarca(a^.HI, dato)
                else
                    // Si la marca del dato es mayor, inserto en el subárbol derecho
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


// Invoque a un módulo que reciba la estructura generado en a) i y una marca y retorne la
// cantidad de autos de dicha marca que posee la agencia.
procedure ModuloB(a: arbolPatente);
    function CountCarsByBrand(a: arbolPatente; marca: string): integer;
    var cant: integer;
    begin 
        // Caso base: arbol vacio
        if (a = nil) then CountCarsByBrand := 0
        else begin 
            if (a^.dato.marca = marca) then
                cant := 1
            else cant := 0;

            CountCarsByBrand := cant
              + CountCarsByBrand(a^.HI, marca)
              + CountCarsByBrand(a^.HD, marca);
        end;
    end;

var 
    marca: string;
    cantidad: integer;
begin 
    writeln;
    writeln('----- Modulo B ----->');
    writeln;
    write('Ingrese una marca a buscar ');
    readln(marca);
    cantidad := CountCarsByBrand(a, marca);
    writeln('La marca ', marca, ' posee ', cantidad, ' vehículos en la agencia.');
end;


// Invoque a un módulo que reciba la estructura generado en a) ii y una marca y retorne
// la cantidad de autos de dicha marca que posee la agencia.
procedure ModuloC(a: arbolMarca);

    function CountCars(l: lista): integer;
    begin 
        if (l = nil) then CountCars := 0
        else CountCars := 1 + CountCars(l^.sig);
    end;


    function CountCarsByBrand(a: arbolMarca; marca: string): integer;
    var cant: integer;
    begin 
        // Caso base: arbol vacio/ultimo nodo
        if (a = nil) then CountCarsByBrand := 0
        else begin
            if (a^.marca <> marca) then 
                cant := 0
            else
                // Cuento la cantidad de nodos
                cant := CountCars(a^.autos);

            CountCarsByBrand := cant
                + CountCarsByBrand(a^.HI, marca)
                + CountCarsByBrand(a^.HD, marca);
        end;
    end;
var 
    marca: string;
    cantidad: integer;
begin 
    writeln;
    writeln('----- Modulo C ----->');
    writeln;
    write('Ingrese una marca a buscar ');
    readln(marca);
    cantidad := CountCarsByBrand(a, marca);
    writeln('La marca ', marca, ' posee ', cantidad, ' vehículos en la agencia.');
end;


// Invoque a un módulo que reciba el árbol generado en a) i y retorne una estructura con
// la información de los autos agrupados por año de fabricación.
procedure ModuloD(a: arbolPatente; var v: vector);

    procedure InicializarVector(var v: vector);
    var i: integer;
    begin 
        for i := 2010 to 2018 do
            v[i] := nil;
    end;

    procedure InsertarOrdenado(var l: lista2; dato: auto);
    var 
        nue: lista2;
        act, ant: lista2;          { Puntaros auxiliares para recorrido }

    begin 
        { Crear el nodo a insertar }
        new (nue);
        nue^.dato.marca := dato.marca;
        nue^.dato.patente := dato.patente;
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


    procedure CargarVector(a: arbolPatente; var v: vector);
    begin 
        if (a <> nil) then begin 
            CargarVector(a^.HI, v);
            InsertarOrdenado(v[a^.dato.fabricacion], a^.dato);
            CargarVector(a^.HD, v);
        end;
    end;


begin 
    writeln;
    writeln('----- Modulo D ----->');
    writeln;
    CargarVector(a, v);
    writeln('Vector cargado OK');

end;


// Invoque a un módulo que reciba el árbol generado en a) i y una patente y devuelva el
// modelo del auto con dicha patente.
procedure ModuloE(a: arbolPatente);
    procedure GetModeloByPatente(a: arbolPatente; patente: tipoPatente; var existe: boolean; var modelo: string);
    begin 
        if (a <> nil) then begin 
            if (a^.dato.patente = patente) then begin
                modelo := a^.dato.modelo;
                existe := true;
            end
            else begin 
                if (a^.dato.patente < patente) then
                    if (a^.HD <> nil) then 
                        GetModeloByPatente(a^.HD, patente, existe, modelo)
                    else begin 
                        modelo := '';
                        existe := false;
                    end
                else begin 
                    if (a^.HI <> nil) then 
                        GetModeloByPatente(a^.HI, patente, existe, modelo)
                    else modelo := '';
                end;
            end;
        end
        else begin 
            existe := false;
            modelo := '';
        end;
    end;
var 
    patente: tipoPatente;
    modelo: string;
    existe: boolean;
begin 
    writeln;
    writeln('----- Modulo E ----->');
    writeln;
    write('Ingrese el numero de patente para buscar el modelo: ');
    readln(patente);
    GetModeloByPatente(a, patente, existe, modelo);

    if (existe) then
        writeln('El modelo de vehiculo para la patente ', patente, ' es: ', modelo)
    else writeln('No existe la patente');
end;


// Invoque a un módulo que reciba el árbol generado en a) ii y una patente y devuelva el
// modelo del auto con dicha patente.
procedure ModuloF(a: arbolMarca);

    procedure BuscarVehiculo(l: lista; patente: tipoPatente; var existe: boolean; var modelo: string);
    begin
        // Caso base: si la lista está vacía, no se encontró la patente
        if (l = nil) then
            existe := false
        else begin
            // Si la patente coincide, se marca como encontrada y se asigna el modelo
            if (l^.dato.patente = patente) then begin
                modelo := l^.dato.modelo;
                existe := true;
            end
            else
                // Si no coincide, sigue buscando en el resto de la lista
                BuscarVehiculo(l^.sig, patente, existe, modelo);
        end;
    end;


    procedure GetModeloByPatente(a: arbolMarca; patente: tipoPatente; var existe: boolean; var modelo: string);
    begin
        if (a <> nil) then begin 
            BuscarVehiculo(a^.autos, patente, existe, modelo);
            if (not existe) then begin 
                GetModeloByPatente(a^.HD, patente, existe, modelo); 

                if (not existe) then
                    GetModeloByPatente(a^.HI, patente, existe, modelo);  
            end;
        end;
    end;

var
    patente: tipoPatente;
    modelo: string;
    existe: boolean;
begin 
    writeln;
    writeln('----- Modulo F ----->');
    writeln;
    write('Ingrese el numero de patente para buscar el modelo: ');
    readln(patente);
    GetModeloByPatente(a, patente, existe, modelo);

    if (existe) then
        writeln('El modelo de vehiculo para la patente ', patente, ' es: ', modelo)
    else writeln('No existe la patente');
    writeln;
end;

var 
    a: arbolPatente;
    b: arbolMarca;
    v: vector;


Begin 
    ModuloA(a, b);
    ModuloB(a);
    ModuloC(b);
    ModuloD(a, v);
    ModuloE(a);
    ModuloF(b);
End.