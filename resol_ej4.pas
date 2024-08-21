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
	
	vectorRubro3 = array[1..dimF] of producto;
	
	
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

procedure CargarProductos(var l: lista);
var p: producto;
begin
	
end;


var

Begin
	CargarProductos();
	ImprimirCodigosPorRubro();
	GenerarVector();
	Ordenar();
	ImprimirPrecios();
	CalcularPromedio();
End.
		

