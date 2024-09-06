{
    Implementar un programa modularizado para una librería. Implementar módulos para:
    
        a. Almacenar los productos vendidos en una estructura eficiente para la búsqueda por
        código de producto. De cada producto deben quedar almacenados su código, la
        cantidad total de unidades vendidas y el monto total. De cada venta se lee código de
        venta, código del producto vendido, cantidad de unidades vendidas y precio unitario. El
        ingreso de las ventas finaliza cuando se lee el código de venta -1.
        b. Imprimir el contenido del árbol ordenado por código de producto.
        c. Retornar el código de producto con mayor cantidad de unidades vendidas.
        d. Retornar la cantidad de códigos que existen en el árbol que son menores que un valor
        que se recibe como parámetro.
        e. Retornar el monto total entre todos los códigos de productos comprendidos entre dos
        valores recibidos (sin incluir) como parámetros.

        REGISTROS:
         -----------------        -----------------
        |     producto    |      |      venta      |
        |-----------------|      |-----------------|
        | id              |      | id              |
        | tot_vendidas    |      | cant_vendidas   |
        | monto_total     |      | precio_unitario |
        | ventas (lista)  |       =================
         =================        

        LISTAS 
         -----------------        -------------------- 
        | nodoLista       |      | lista = ^nodoLista |
        |-----------------|       --------------------
        | dato: venta     |
        | sig: lista      |
         =================
              

        ARBOLES:
         -----------------        -----------------------       
        |  nodoProductos  |      | arbol =^nodoProductos |
        |-----------------|       -----------------------
        | dato            |      
        | HI              |      
        | HD              |      
         =================        
}

program Klass3U3;

type
    venta = record 
        id: integer; 
        cant_vendidas: integer;
        precio_unitario: real;
    end;

    lista = ^nodoLista;

    producto = record 
        id: integer;
        tot_vendidas: integer;
        monto_total: real;
        ventas: lista;
    end;

    nodoLista = record 
        dato: venta;
        sig: lista;
    end;

    arbol = ^nodoProductos;

    nodoProductos = record 
        dato: producto;
        HI: arbol;
        HD: arbol;
    end;


{ 
  Almacenar los productos vendidos en una estructura eficiente para la búsqueda por
  código de producto. De cada producto deben quedar almacenados su código, la
  cantidad total de unidades vendidas y el monto total. De cada venta se lee código de
  venta, código del producto vendido, cantidad de unidades vendidas y precio unitario. El
  ingreso de las ventas finaliza cuando se lee el código de venta -1.
}
procedure ModuloA(var a:arbol);

    procedure LeerVenta(var v: venta; var idProducto: integer);
    begin 
        write('Cod Venta: ', #9); readln(v.id);
        if (v.id <> -1) then begin 
            write('Cod Producto: ', #9); readln(idProducto);
            write('Cant Vendidos: ', #9); readln(v.cant_vendidas);
            write('Precio unit: ', #9); readln(v.precio_unitario);
        end;
        writeln;
    end;

    procedure CargarVentas(var a: arbol);


        procedure AgregarAdelante(var l:lista; dato: venta);
        var
            nue: lista;

        begin
            new(nue);
            nue^.dato := dato;
            nue^.sig := l;
            l := nue;
        end;
    
        

        // Actualiza los totales de ventas para el producto en cuestión.
        procedure ActualizarTotales(var a: arbol; v: venta);
        begin 
            a^.dato.tot_vendidas := a^.dato.tot_vendidas + v.cant_vendidas;
            a^.dato.monto_total := a^.dato.monto_total + v.cant_vendidas * v.precio_unitario;
        end;


        // Inserta un producto en el árbol si no existe.
        { Agrega un nuevo nodo al árbol de productos o actualiza el nodo }
        procedure InsertOrUpdate(var a: arbol; idProducto: integer; v: venta);
        var 
            aux: arbol;
            ULT: lista;
        begin
            // Caso base, árbol vacío.
            if (a = nil) then begin

                new(aux);
                aux^.dato.id := idProducto;
                aux^.dato.tot_vendidas := 0;    // Se actualiza con ActualizarTotales
                aux^.dato.monto_total := 0;     // Se actualiza con ActualizarTotales
                aux^.dato.ventas := nil;     { Inicializo la lista de ventas }
                aux^.HD := nil;
                aux^.HI := nil;

                ULT := nil;
                
                // Cargo la venta al producto:
                AgregarAdelante(aux^.dato.ventas, v);

                // Actualizo los totales de compra del producto
                ActualizarTotales(aux, v);

                // Actualizo el nodo inicial
                a := aux;
            end
            else begin
                // Si estoy actualizando un nodo existente 
                if (a^.dato.id = idProducto) then begin
                    AgregarAdelante(a^.dato.ventas, v);
                    ActualizarTotales(a, v);
                end
                else begin 
                    if (a^.dato.id > idProducto) then
                        InsertOrUpdate(a^.HI, idProducto, v)
                    else
                        InsertOrUpdate(a^.HD, idProducto, v);
                end;
            end;
        end;


    var 
      v: venta;
      idProducto: integer;
    begin
        // Inicializo el arbol
        a := nil; 
        LeerVenta(v, idProducto); 

        while (v.id <> -1) do begin 
            InsertOrUpdate(a, idProducto, v);


            LeerVenta(v, idProducto);
        end;   
    end;

{ PRINCIPAL DE MODULO A }
begin
    writeln;
    writeln('----- Modulo A ----->');
    writeln;
    CargarVentas(a);
end;


// Imprimir el contenido del árbol ordenado por código de producto.
procedure ModuloB(a: arbol);
    procedure ImprimirProducto(p: producto);
    begin
        //writeln;
        //writeln('Prod',#9, 'Tot.vendido', #9, 'Monto tot.');
        //writeln('------------------------------------------------------------');
        writeln(p.id, #9, p.tot_vendidas, #9, #9, p.monto_total:0:2);
        //writeln;
    end;

    // No pide imprimir ventas, pero lo guardo igual en una lista
    procedure ImprimirVentas(l: lista);
    begin
        if (l <> nil) then begin
            writeln('Cod.Venta', #9, 'Cant.Vendidas', #9, 'Prec.unit');
            writeln('------------------------------------------------------------');
        end;

        while (l <> nil) do begin 
            writeln(l^.dato.id, #9, #9, l^.dato.cant_vendidas, #9, #9, l^.dato.precio_unitario:0:2);

            l := l^.sig;
        end; 
    end;


    procedure ImprimirArbol(a: arbol);
    begin 
        if (a <> nil) then begin 
            ImprimirArbol(a^.HI);
            ImprimirProducto(a^.dato);
            //ImprimirVentas(a^.dato.ventas);
            ImprimirArbol(a^.HD);
        end;
    end;


begin
    writeln;
    writeln('----- Modulo B ----->');
    writeln;
    writeln('Prod',#9, 'Tot.vendido', #9, 'Monto tot.');
    writeln('------------------------------------------------------------');
    ImprimirArbol(a);

end;


// Retornar el código de producto con mayor cantidad de unidades vendidas.
procedure ModuloC(a: arbol);
    procedure ActualizarMaximo(p: producto; var maxVendidas, maxCod: integer);
    begin 
        if (p.tot_vendidas > maxVendidas) then begin 
            maxVendidas := p.tot_vendidas;
            maxCod := p.id;
        end;
    end;
    
    procedure ImprimirCodigoTopVentas(a: arbol; max: integer);
    var cod: integer;
    begin 
        // Caso base: arbol vacio
        if (a = nil) then 
          // Devuelvo objeto vacío

        else begin
          // Asumo el máximo con el nodo actual
          cod := a^.dato.id;
          max := a^.dato.tot_vendidas;

          if (a^.HD <> nil) then
              ImprimirCodigoTopVentas(a^.HD) ;

          ActualizarMaximo(a^.dato, max, cod);

          if (a^.HI <> nil) then
              ImprimirCodigoTopVentas(a^.HI);

        end;

    end;


begin
    writeln;
    writeln('----- Modulo C ----->');
    writeln;
    ImprimirCodigoTopVentas(a);
end;


// Retornar la cantidad de códigos que existen en el árbol que son menores que un valor
// que se recibe como parámetro.
procedure ModuloD(a: arbol);
begin 
    writeln;
    writeln('----- Modulo D ----->');
    writeln;
end;

// Retornar el monto total entre todos los códigos de productos comprendidos entre dos
// valores recibidos (sin incluir) como parámetros.
procedure ModuloE(a: arbol);
begin 
    writeln;
    writeln('----- Modulo E ----->');
    writeln;
end;





{ PROGRAMA PRINCIPAL }
var 
    a: arbol;
Begin 
    ModuloA (a);
    ModuloB (a);
    ModuloC (a);
    ModuloD (a);
    ModuloE (a);
End.