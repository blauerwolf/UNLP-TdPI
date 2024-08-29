{
  2. Escribir un programa que:
  ✅ a. Implemente un módulo que genere aleatoriamente información de ventas de un comercio.
  Para cada venta generar código de producto, fecha y cantidad de unidades vendidas. Finalizar
  con el código de producto 0. Un producto puede estar en más de una venta. Se pide:
  ✅ i. Generar y retornar un árbol binario de búsqueda de ventas ordenado por código de
  producto. Los códigos repetidos van a la derecha.
  ✅ ii. Generar y retornar otro árbol binario de búsqueda de productos vendidos ordenado por
  código de producto. Cada nodo del árbol debe contener el código de producto y la
  cantidad total de unidades vendidas.
  iii. Generar y retornar otro árbol binario de búsqueda de productos vendidos ordenado por
  código de producto. Cada nodo del árbol debe contener el código de producto y la lista de
  las ventas realizadas del producto.
  Nota: El módulo debe retornar TRES árboles.
  ✅ b. Implemente un módulo que reciba el árbol generado en i. y una fecha y retorne la cantidad
  total de productos vendidos en la fecha recibida.
  c. Implemente un módulo que reciba el árbol generado en ii. y retorne el código de producto
  con mayor cantidad total de unidades vendidas.
  d. Implemente un módulo que reciba el árbol generado en iii. y retorne el código de producto
  con mayor cantidad de ventas.
}

program ejercicio2;

Uses sysutils;
const 
  maxCodProducto = 100;
type 

  tipoFecha = string[10];

  // Arbol i:
  venta = record 
      cod: integer;
      fecha: tipoFecha;
      u_vendidas: integer;
  end;

  arbolVentas = ^nodoVentas;
  nodoVentas = record 
      dato: venta;
      HI: arbolVentas;
      HD: arbolVentas;
  end;

  // Arbol ii 
  producto = record 
      cod: integer;
      tot_u_vendidas: integer;
  end;

  arbolProductos = ^nodoProductos;
  nodoProductos = record 
      dato: producto;
      HI: arbolProductos;
      HD: arbolProductos;
  end;

  // TODO revisar la lista de ventas del producto
  // Arbol iii
  l_ventas = ^productoVentas;

  productoVentas = record 
      cod: integer;
      sig: l_ventas; 
  end;

  arbolProductosVentas = ^nodoProductosVentas;
  nodoProductosVentas = record 
      dato: productoVentas;
      HI: arbolProductosVentas;
      HD: arbolProductosVentas;
  end;


procedure GenerarVenta(var v: venta);

    { Genera una fecha aleatoria tipo YYYY-mm-dd }
    procedure GenerarFechaAleatoria(var fecha: tipoFecha);
    var 
        aux: integer;
        mes, dia: string[2];
    begin
        // Genero el mes
        aux := random(13) + 1;
        if (aux < 10) then mes := IntToStr(0) + IntToStr(aux)
        else mes := IntToStr(aux);

        // Genero el día
        aux := random(31) + 1;
        if (aux < 10) then dia := IntToStr(0) + IntToStr(aux)
        else dia := IntToStr(aux);

        fecha := IntToStr(random(25) + 2000) + '-' + mes + '-' + dia;
    end;

begin 
    v.cod := random(maxCodProducto);
    GenerarFechaAleatoria(v.fecha);
    v.u_vendidas := random(26) + 1; 
end;


{ Procedimientos para insertar elementos en los árboles }
Procedure InsertarVenta (var a: arbolVentas; elem: venta);
Begin
    if (a = nil) 
    then begin
        new(a);
        a^.dato:= elem; 
        a^.HI:= nil; 
        a^.HD:= nil;
    end
    else if (elem.cod < a^.dato.cod) 
        then InsertarVenta(a^.HI, elem)
        else InsertarVenta(a^.HD, elem); 
end;

{ Agrega un nuevo nodo al árbol de productos o actualiza el nodo }
procedure InsertOrUpdate(var a: arbolProductos; cod: integer; tot_u_vendidas: integer);
var aux: arbolProductos;
begin
    // CAso base, árbol vacío.
    if (a = nil) then begin 
        new(aux);
        aux^.dato.cod := cod;
        aux^.dato.tot_u_vendidas := tot_u_vendidas;
        aux^.HD := nil;
        aux^.HI := nil;
        a := aux;
    end
    else begin
        // Si estoy actualizando un nodo existente 
        if (a^.dato.cod = cod) then
            a^.dato.tot_u_vendidas := a^.dato.tot_u_vendidas + tot_u_vendidas
        else begin 
            if (a^.dato.cod > cod) then
                InsertorUpdate(a^.HI, cod, tot_u_vendidas)
            else
                InsertOrUpdate(a^.HD, cod, tot_u_vendidas);
        end;
    end;
end;

procedure InsertarOrdenado(var L: l_ventas; cod: integer);
var 
  nue: l_ventas;
  act, ant: l_ventas;          { Puntaros auxiliares para recorrido }

begin 
  { Crear el nodo a insertar }
  new (nue);
  nue^.dato := cod;
  act := L;                 { Ucibo act y ant al inicio de la lista }
  ant := L;

  { Buscar la posición para insertar el nodo creado }
  while (act <> nil) and (f.fecha > act^.dato.fecha) do 
  begin 
    ant := act;
    act := act^.sig;
  end;

  if (act = ant) then     { al inicio o lista vacía }
    L := nue
  else                    { al medio o al final }
    ant^.sig := nue;

  nue^.sig := act;
end;


procedure GenerarArboles(var a1: arbolVentas; var a2: arbolProductos; var a3: arbolProductosVentas);
var 
  v: venta;
begin 
    { Inicializo todos los árboles }
    a1 := nil; a2 := nil; a3 := nil;

    { Cargo ventas hasta que se carga el producto 0 }
    GenerarVenta(v);
    while (v.cod <> 0) do begin 
        InsertarVenta(a1, v);

        InsertOrUpdate(a2, v.cod, v.u_vendidas);

        InsertOrUpdate(a3, v.cod, )

        GenerarVenta(v);
    end;
end;


procedure ImprimirArbolVentas(a: arbolVentas);
    procedure ImprimirVenta(v: venta);
    begin 
      writeln(v.cod, #9, v.fecha, #9, v.u_vendidas);
    end;

begin
    if (a <> nil) then begin 
        ImprimirArbolVentas(a^.HI);
        ImprimirVenta(a^.dato);
        ImprimirArbolVentas(a^.HD);
        
    end;
end;


procedure ImprimirArbolProductos(a: arbolProductos);
    procedure ImprimirProducto(p: producto);
    begin 
        writeln(p.cod, #9, p.tot_u_vendidas);
    end;

begin 
    if (a <> nil) then begin 
        ImprimirArbolProductos(a^.HD);
        ImprimirProducto(a^.dato);
        ImprimirArbolProductos(a^.HI);
    end;
end;

function ObtenerTotalVendidosFecha(a: arbolVentas; fecha: tipoFecha): integer;
var cant: integer;
begin 
    // Caso base, árbol vacío.
    if (a = nil) then ObtenerTotalVendidosFecha := 0
    else begin 
        if (a^.dato.fecha = fecha) 
        then cant := a^.dato.u_vendidas
        else cant := 0;

        ObtenerTotalVendidosFecha := cant 
              + ObtenerTotalVendidosFecha(a^.HD, fecha)
              + ObtenerTotalVendidosFecha(a^.HI, fecha);
    end;
end;


function ObtenerCodProdMaxVentas(a: arbolProductos): integer;

var
    codIzq, codDer, codMax, maxIzq, maxDer: integer;
begin 
    if (a = nil) then ObtenerCodProdMaxVentas := -1
    else begin 
        // Asumo que el actual es el código con mayor ventas
        codMax := a^.dato.cod;
        maxIzq := -1;
        maxDer := -1;

        codIzq := ObtenerCodProdMaxVentas(a^.HI);
        codDer := ObtenerCodProdMaxVentas(a^.HD);

        if (a^.HI <> nil) then 
            maxIzq := a^.HI^.dato.tot_u_vendidas;


        if (a^.HD <> nil) then 
            maxDer := a^.HD^.dato.tot_u_vendidas;


        if (codIzq <> -1) and (maxIzq > a^.dato.tot_u_vendidas) then
        begin
            if (maxIzq >= maxDer)
            then codMax := codIzq;
        end;

        if (codDer <> -1) and (maxDer > a^.dato.tot_u_vendidas) then 
        begin
            if (maxDer >= maxIzq)
            then codMax := codDer;
        end;

        ObtenerCodProdMaxVentas := codMax;

    end;
end;



{ PROGRAMA PRINCIPAL }
Var 
    a1: arbolVentas;
    a2: arbolProductos;
    a3: arbolProductosVentas;
    fecha: tipoFecha;
    cantProdVendidos, codTopVentas: integer;
Begin 
    randomize;
    GenerarArboles(a1, a2, a3);
    writeln('Arbol de ventas cargado: ');
    ImprimirArbolVentas(a1);
    writeln;
    writeln('Arbol de productos: ');
    ImprimirArbolProductos(a2);
    writeln;

    write('Ingrese fecha de búsqueda: '); readln(fecha);
    writeln;
    
    cantProdVendidos := ObtenerTotalVendidosFecha(a1, fecha);
    writeln('Cantidad de de productos vendidos en la fecha ', fecha, #9, cantProdVendidos);
    writeln('----------------------------------------------------------------------');
    writeln;
    codTopVentas := ObtenerCodProdMaxVentas(a2);
    writeln('Código del producto con mayor cantidad de ventas: ', codTopVentas);
    writeln;


End.

