{
    Una librería requiere el procesamiento de la información de sus productos. De cada
    producto se conoce el código del producto, código de rubro (del 1 al 8) y precio.
    Implementar un programa que invoque a módulos para cada uno de los siguientes puntos:

    a. Lea los datos de los productos y los almacene ordenados por código de producto y
    agrupados por rubro, en una estructura de datos adecuada. El ingreso de los productos finaliza
    cuando se lee el precio 0.

    b. Una vez almacenados, muestre los códigos de los productos pertenecientes a cada rubro.

    c. Genere un vector (de a lo sumo 30 elementos) con los productos del rubro 3. Considerar que
    puede haber más o menos de 30 productos del rubro 3. Si la cantidad de productos del rubro 3
    es mayor a 30, almacenar los primeros 30 que están en la lista e ignore el resto.

    d. Ordene, por precio, los elementos del vector generado en c) utilizando alguno de los dos
    métodos vistos en la teoría.

    e. Muestre los precios del vector resultante del punto d).
    
    f. Calcule el promedio de los precios del vector resultante del punto d).

}


program ej4;
const
	rango = 1..8;
	dimF = 30;

type
	producto = record
		id: integer;
		rubro: rango;
		precio: real;
	end;
	
	lista = ^nodo;
	
	nodo = record
		elem: producto;
		sig: lista;
	end;
	
	vectorProductos = array[rango] of lista;
	vectorRubro3 = array[1..dimF] of producto;

procedure insertarOrdenado(var L: lista; elem: producto);
var 
  nue: lista;
  act, ant: lista;          { Puntaros auxiliares para recorrido }

begin 
  { Crear el nodo a insertar }
  new (nue);
  nue^.dato := elem;
  act := L;                 { Ucibo act y ant al inicio de la lista }
  ant := L;

  { Buscar la posición para insertar el nodo creado }
  while (act <> nil) and (elem.id > act^.dato.id) do 
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
	
procedure LeerProducto(var p: producto);
begin 
	write('Codigo: '); readln(p.id);
	if (p.precio <> 0 ) then begin
		write('rubro: ');	readln(p.rubro);
		write('Precio: ');	readln(p.precio);
	end;
	writeln;
end;

procedure InicializarLista(var l: lista);
begin
	l := nil;
end;

procedure InicializarVectorProductos(var v: vectorProductos);
var i: integer;
begin
	for i := 1 to 8 do 
		InicializarLista(v[i]);
end;

procedure CargarProductos(var l: lista);
var p: producto;
begin
	LeerProducto(p);

	while (p.precio <> 0) then begin 
		{ Inserto el producto ordenado por codigo }
		InsertarOrdenado(vP[p.rubro], p);

		LeerProducto(p);
	end;
end;

procedure ImprimirCodigosLista(L: lista);
begin 
	if (L = nil) then 
		writeln('Sin resultados')
	else begin
		write('Códigos: [');

		while (L <> nil) do begin
			write(L^.dato.id, ', ');
			L := L^.sig;
		end;

		write(']');
	end;
end;

procedure ImprimirCodigosPorRubro(vP: vectorProductos);
var i: integer;
begin 
	for i := 1 to 8 to begin 
		writeln('Rubro: ', i);
		writeln('---------');
		ImprimirCodigosLista(vP[i]);
		writeln;
	end;
end;

procedure GenerarVector(var vR3: vectorRubro3; var dimL: integer);
var i: integer;
begin

end;


var
	vP: vectorProductos;
Begin
	{ Inicializo el vector de listas de productos por rubro }
	InicializarVectorProductos(vP);

	{ Cargo los productos mientras el precio sea <> 0 }
	CargarProductos();

	{ b: Imprimi los códigos de los productos por cada rubro }
	ImprimirCodigosPorRubro();

	GenerarVector();
	Ordenar();
	ImprimirPrecios();
	CalcularPromedio();
End.
		

