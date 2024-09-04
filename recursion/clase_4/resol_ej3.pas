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
        | tot_vendidas    |      | productoId      |
        | monto_total     |      | cant_vendidas   |
        | ventas (lista)  |      | precio_unitario | 
         =================        =================

        LISTAS 
         -----------------        -------------------- 
        | nodoLista       |      | lista = ^nodoLista |
        |-----------------|       --------------------
        | dato: venta     |
        | sig: lista      |
         =================
              

        ARBOLES:
         -----------------       
        |  nodoProductos  |      
        |-----------------|
        | dato            |
        | HI              |
        | HD              |
         =================
}

program Klass3U3;

type
    venta = record 
        id: integer;    // Redundante?
        productoId: integer;
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
        dato: producto;
        sig: lista;
    end;

    

    arbol = ^nodoProductos;

    nodoProductos = record 
        dato: producto;
        HI: arbol;
        HD: arbol;
    end;

    

procedure LeerVenta(var v: venta);
begin 
    write('Cod Venta: ', #9); readln(v.id);
    if (v.id <> -1) then begin 
        write('Cod Producto: ', #9); readln(v.productoId);
        write('Cant Vendidos: ', #9); readln(v.cant_vendidas);
        write('Precio unit: ', #9); readln(v.precio_unitario);
    end;
end;

procedure CargarVentas();
begin 
    
end;


procedure ModuloA(var a:arbol);
var v: venta;
begin
    LeerVenta(v);
end;

procedure ModuloB(a: arbol);
begin 
end;


procedure ModuloC(a: arbol);
begin 
end;


procedure ModuloD(a: arbol);
begin 
end;


procedure ModuloE(a: arbol);
begin 
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