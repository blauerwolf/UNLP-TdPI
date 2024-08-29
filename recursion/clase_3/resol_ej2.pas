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
  ✅ iii. Generar y retornar otro árbol binario de búsqueda de productos vendidos ordenado por
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

  productoVentas = record 
      fecha: tipoFecha;
      u_vendidas: integer;
  end;


  // La lista de ventas de un  producto tiene fecha 
  // y unidades vendidas en esa venta.
  l_ventas = ^nodoProductoVentas;

  nodoProductoVentas = record 
      dato: productoVentas;
      sig: l_ventas;
  end;

  // Registro para el Arbol iii
  arbolProductosVentas = ^nodoArbolProductosVentas;
  nodoArbolProductosVentas = record 
      cod: integer;
      lista: l_ventas;
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
    // Caso base, árbol vacío.
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

{ Inserta adelante una venta individual de un producto }
procedure AgregarAdelante(var l: l_ventas; p: productoVentas);
var
    nue: l_ventas;

begin
    new(nue);
    nue^.dato := p;
    nue^.sig := l;
    l := nue;
end;

{ Inserta una venta individual de un producto en su lista }
procedure InsertarOrdenado(var L: l_ventas; dato: productoVentas);
var 
  nue: l_ventas;
  act, ant: l_ventas;          { Puntaros auxiliares para recorrido }

begin 
  { Crear el nodo a insertar }
  new (nue);
  nue^.dato := dato;
  act := L;                 { Ubica act y ant al inicio de la lista }
  ant := L;

  { Buscar la posición para insertar el nodo creado }
  while (act <> nil) and (dato.fecha > act^.dato.fecha) do 
  begin 
    ant := act;
    act := act^.sig;
  end;

  if (act = ant) then L := nue    { al inicio o lista vacía }
  else ant^.sig := nue;           { al medio o al final }
    
  nue^.sig := act;
end;


procedure InsertOrUpdateProductoVentas(var a: arbolProductosVentas; cod: integer; dato: productoVentas);
var aux: arbolProductosVentas;
begin 
    // Caso base: árbol vacío.
    if (a = nil) then  begin
        // Creo el nuevo nodo del árbol 
        new(aux);
        aux^.cod := cod;
        aux^.HD := nil;
        aux^.HI := nil;

        // Agrego la venta al producto
        // Como se que el producto es nuevo, inserto adelante el nuevo nodo.
        AgregarAdelante(aux^.lista, dato);

        writeln('Cod: ', cod, ' data: ', dato.fecha, ' ', aux^.lista <> nil);

        // Asigno al nodo como raiz del árbol
        a := aux;
    end
    else begin 
        // Si estoy actualizando un nodo existente 
        if (a^.cod = cod) then
            InsertarOrdenado(a^.lista, dato)
        else begin 
            if (a^.cod > cod) then
                InsertOrUpdateProductoVentas(a^.HI, cod, dato)
            else
                InsertOrUpdateProductoVentas(a^.HD, cod, dato);
        end;
    end;
end;



procedure GenerarArboles(var a1: arbolVentas; var a2: arbolProductos; var a3: arbolProductosVentas);
var 
  v: venta;
  p: productoVentas;
begin 
    { Inicializo todos los árboles }
    a1 := nil; a2 := nil; a3 := nil;

    { Cargo ventas hasta que se carga el producto 0 }
    GenerarVenta(v);
    p.fecha := v.fecha;
    p.u_vendidas := v.u_vendidas;

    while (v.cod <> 0) do begin 
        InsertarVenta(a1, v);

        InsertOrUpdate(a2, v.cod, v.u_vendidas);

        InsertOrUpdateProductoVentas(a3, v.cod, p);

        GenerarVenta(v);
        p.fecha := v.fecha;
        p.u_vendidas := v.u_vendidas;
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

procedure ImprimirArbolProductosVentas(a: arbolProductosVentas);
    procedure ImprimirListaProductos(l: l_ventas);
    begin
        while (l <> nil) do begin 
            writeln(l^.dato.fecha, #9, l^.dato.u_vendidas);
            l := l^.sig;
        end;
    end;


    procedure ImprimirProducto(cod: integer; l: l_ventas );
    begin
        writeln('======> Prod: ', cod, ' <======');
        writeln('   Fecha     Unidades');
        writeln('-------------------------');
        ImprimirListaProductos(l);
        writeln;
    end;
begin 
    if (a <> nil) then begin 
        ImprimirArbolProductosVentas(a^.HD);
        ImprimirProducto(a^.cod, a^.lista);
        ImprimirArbolProductosVentas(a^.HI);
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


// TODO: Verificar
function CodigoProductoMasVendido (a: arbolProductos): integer;

	procedure MaxCodigo (a: arbolProductos; var maxCod, maxVentas: integer);
	
		procedure ActualizarMaximo (p: producto; var maxCod, maxVentas: integer);
		begin
			if (p.tot_u_vendidas > maxVentas) then begin
				maxVentas:= p.tot_u_vendidas;
				maxCod:= p.cod;
			end;
		end;
	
	begin
		if (a <> nil) then begin
			if (a^.HI <> nil) then 
				MaxCodigo(a^.HI, maxCod, maxVentas);
			ActualizarMaximo (a^.dato, maxCod, maxVentas);
			if (a^.HD <> nil) then
				MaxCodigo(a^.HD, maxCod, maxVentas);
		end;
	end;

var
	maxCod, maxVentas: integer;
begin
	maxVentas:= -1;
	MaxCodigo(a, maxCod, maxVentas);
	CodigoProductoMasVendido:= maxCod;
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
    writeln('Arbol de productos con lista de ventas: ');
    ImprimirArbolProductosVentas(a3);
    writeln;

    write('Ingrese fecha de búsqueda: '); readln(fecha);
    writeln;
    
    cantProdVendidos := ObtenerTotalVendidosFecha(a1, fecha);
    writeln('Cantidad de de productos vendidos en la fecha ', fecha, #9, cantProdVendidos);
    writeln('----------------------------------------------------------------------');
    writeln;
    codTopVentas := CodigoProductoMasVendido(a2);
    writeln('Código del producto con mayor cantidad de ventas: ', codTopVentas);
    writeln;


End.

