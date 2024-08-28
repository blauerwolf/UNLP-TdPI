{
  2. Escribir un programa que:
  ✅ a. Implemente un módulo que genere aleatoriamente información de ventas de un comercio.
  Para cada venta generar código de producto, fecha y cantidad de unidades vendidas. Finalizar
  con el código de producto 0. Un producto puede estar en más de una venta. Se pide:
  ✅ i. Generar y retornar un árbol binario de búsqueda de ventas ordenado por código de
  producto. Los códigos repetidos van a la derecha.
  ii. Generar y retornar otro árbol binario de búsqueda de productos vendidos ordenado por
  código de producto. Cada nodo del árbol debe contener el código de producto y la
  cantidad total de unidades vendidas.
  iii. Generar y retornar otro árbol binario de búsqueda de productos vendidos ordenado por
  código de producto. Cada nodo del árbol debe contener el código de producto y la lista de
  las ventas realizadas del producto.
  Nota: El módulo debe retornar TRES árboles.
  b. Implemente un módulo que reciba el árbol generado en i. y una fecha y retorne la cantidad
  total de productos vendidos en la fecha recibida.
  c. Implemente un módulo que reciba el árbol generado en ii. y retorne el código de producto
  con mayor cantidad total de unidades vendidas.
  d. Implemente un módulo que reciba el árbol generado en iii. y retorne el código de producto
  con mayor cantidad de ventas.
}

program ejercicio2;

Uses sysutils;

type 

  venta = record 
    cod: integer;
    fecha: string[10];
    vendidas: integer;
  end;

  arbol = ^nodoArbol;
  nodoArbol = record
    dato: venta;
    HI: arbol;
    HD: arbol;
  end;

  arbolVendidos = ^nodoVendidos;
  nodoVendidos = record 
    dato: vendidos;
    HI: arbolVendidos;
    HD: arbolVendidos;
  end;


{
  i. Generar y retornar un árbol binario de búsqueda de ventas ordenado por código de
  producto. Los códigos repetidos van a la derecha.
}
procedure GenerarArbol(a: arbol);
    procedure GenerarVenta(var v: venta);
    var 
      aux: integer;
      mes, dia: string[2];
    begin 

      // Genero la fecha en 'formato iso', no controlo fechas especiales como 31 FEB
      aux := random(13) + 1;
      if (aux < 10) then mes := IntToStr(0) + IntToStr(aux)
      else mes := IntToStr(aux);

      aux := random(31) + 1;
      if (aux < 10) then dia := IntToStr(0) + IntToStr(aux)
      else dia := IntToStr(aux);

      v.cod := random(100);
      v.fecha := IntToStr(random(25) + 2000) + '-' + mes + '-' + dia;
      v.vendidas := random(26) + 1; 
    end;

    Procedure InsertarElemento (var a: arbol; elem: venta);
    Begin
      if (a = nil) 
      then begin
              new(a);
              a^.dato:= elem; 
              a^.HI:= nil; 
              a^.HD:= nil;
            end
      else if (elem.cod < a^.dato.cod) 
            then InsertarElemento(a^.HI, elem)
            else InsertarElemento(a^.HD, elem); 
    End;


var unaVenta: venta;
begin 
    writeln;
    writeln ('----- Carga de ventas y armado del arbol ----->');
    writeln;
    a:= nil;
    GenerarVenta (unaVenta);
    while (unaVenta.cod <> 0)do begin
      InsertarElemento (a, unaVenta);
      GenerarVenta (unaVenta);
    end;
    writeln;
    writeln ('-------------------------------------------------');
    writeln;
end;

procedure ImprimirVenta(v: venta);
begin 
  writeln(v.cod, #9, v.fecha, #9, v.vendidas);
end;


var 
  a: arbol;

begin 
    randomize;
    GenerarArbol(a);

end.