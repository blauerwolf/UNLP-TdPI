{
    El supermercado HayDeTodo necesita un sistema para procesar la información de sus ventas.
    De cada venta se conoce el DNI del clietne, código de sucursal (1 a 10), número de factura y monto.

        a) Implementar un módulo que lea la información de las ventas (la lectura finaliza al ingresar
        el código de cliente 0) y retorne: 

           i. Una estructura de datos eficiente para la búsqueda por DNI de cliente. Para cada DNI debe
           almacenarse una lista de todas sus compras (número de factura y monto).
           ii. Una estructura de datos que almacene la cantidad de ventas de cada surucrsa.

        b) Realizar un módulo que reciba la estructura generada en a) i., un monto y un DNI. El
        módulo debe retornar la cantidad de facturas cuyo monto supera al monto recibido para el DNI
        recibido.

        c) Realizar un módulo recursivo que reciba la estructura generada en el inciso a) ii., y retorne
        el código de sucursal con mayor cantidad de ventas.

    NOTA: Implementar el programa principal, que invoque a los incisos a, b, y c.
}


program supermercado;

type

  compra = record 
      codFactura: integer;
      monto: real;
      sucursal: integer;
  end;


  lista = ^nodo;
  nodo = record 
      dato: compra;
      sig: lista;
  end;

  arbol = ^nodoArbol;
  nodoArbol = record 
      dni: longint;
      compras: lista;
      HI: arbol;
      HD: arbol;
  end;


  // vector de ventas de sucursales
  vector = array[1..10] of integer;

procedure ModuloA(var a: arbol; var v: vector);

    procedure InicializarVector(var v: vector);
    var i: integer;
    begin 
        for i := 1 to 10 do
            v[i] := 0;
    end;

    procedure ActualizarVector(var v: vector; sucursal: integer);
    begin 
        v[sucursal] :=  v[sucursal] + 1;
    end;


    procedure InsertarOrdenado(var l: lista; dato: compra);
    var 
        nue, act, ant: lista;     { Puntaros auxiliares para recorrido }
    begin 
        { Crear el nodo a insertar }
        new (nue);
        nue^.dato := dato;
        act := l;                 { Ucibo act y ant al inicio de la lista }
        ant := l;

        { Buscar la posición para insertar el nodo creado }
        while (act <> nil) and (dato.codFactura > act^.dato.codFactura) do
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




    procedure InsertOrUpdate(var a: arbol; dni: integer; c: compra);
    begin 
        // Caso base arbol vacio.
        if (a = nil) then begin 
            new(a);
            a^.dni := dni;
            a^.compras := nil;
            a^.HI := nil;
            a^.HD := nil;

            InsertarOrdenado(a^.compras, c);
        end
        else if (a^.dni = dni) then begin
            InsertarOrdenado(a^.compras, c)
        end
        else if (a^.dni > dni) then 
            InsertOrUpdate(a^.HI, dni, c)
        else InsertOrUpdate(a^.HD, dni, c);
    end;

    procedure LeerCompra(var c: compra);
    begin 
        c.codFactura := random(10000) + 1;
        c.monto := random * 50000;
        c.sucursal := random(10) + 1;
    end;


    procedure CargarDatos(var a: arbol;  var v: vector);
    var 
      dni: longint;
      c: compra;
    begin 
        // genero un dni
        dni := random(1000);

        while (dni <> 0) do begin 
            LeerCompra(c);

            InsertOrUpdate(a, dni, c);
            ActualizarVector(v, c.sucursal);


            dni := random(1000);
        end;
    end;
begin 
    randomize;
    writeln;
    writeln('----- MODULO A -----');
    writeln;
    InicializarVector(v);
    CargarDatos(a, v);
end;


// Realizar un módulo que reciba la estructura generada en a) i., un monto y un DNI. El
// módulo debe retornar la cantidad de facturas cuyo monto supera al monto recibido para el DNI
// recibido.
procedure ModuloB(a: arbol);

    function ContarFacturas(l: lista; monto: real):integer;
    var cant: integer;
    begin 
        if (l = nil) then ContarFacturas := 0
        else begin 
            if (l^.dato.monto > monto) then
                cant := 1
            else 
                cant := 0;

            ContarFacturas := cant + ContarFacturas(l^.sig, monto);
        end;
    end;


    function GetCantFacturas(a: arbol; dni: longint; monto: real): integer;
    begin 
        // Caso base, arbol vacio.
        if (a = nil) then GetCantFacturas := 0
        else begin 

            if (a^.dni = dni) then
                GetCantFacturas := ContarFacturas(a^.compras, monto)
            
            else if (a^.dni > dni) then 
                GetCantFacturas := GetCantFacturas(a^.HI, dni, monto)
            else 
                GetCantFacturas := GetCantFacturas(a^.HD, dni, monto);
        end;
    end;

var 
  dni: longint;
  monto: real;
  cant: integer;
begin 
    writeln;
    writeln('----- MODULO B -----');
    writeln;
    write('Ingrese un DNI: ');
    readln(dni);
    write('Ingrese un monto: ');
    readln(monto);
    cant := GetCantFacturas(a, dni, monto);
    writeln('Para el DNI ', dni, ' hay ', cant, ' que superan el monto $', monto:0:2);

end;

// Realizar un módulo recursivo que reciba la estructura generada en el inciso a) ii., y retorne
// el código de sucursal con mayor cantidad de ventas.
procedure ModuloC(v: vector);

    function GetTopSales(v: vector; dimL: integer): integer;
    var posResto: integer;
    begin
        if (dimL = 1) then GetTopSales := 1
        else begin 
            posResto := GetTopSales(v, dimL -1);

            if (v[dimL] > v[posResto]) then 
                GetTopSales := dimL
            else    
                GetTopSales := posResto;
        end;
    end;

    procedure ImprimirVector(v: vector);
    var i: integer;
    begin 
        for i := 1 to 10 do 
            writeln('Sucursal: ', i, ', ventas: ', v[i]);
    end;


var maxId: integer;
begin 
    writeln;
    writeln('----- MODULO C -----');
    writeln;
    maxId := GetTopSales(v, 10);
    writeln('La sucursal con mayor cantidad de ventas es: ', maxId);
    ImprimirVector(v);
end;



var 
    a: arbol;
    v: vector;
Begin 
    ModuloA(a, v);
    ModuloB(a);
    ModuloC(v);

End.