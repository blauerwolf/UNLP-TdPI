{
    El administrador de un edificio de oficinas cuenta, en papel, con la información del pago de
    las expensas de dichas oficinas.

    Implementar un programa que invoque a módulos para cada uno de los siguientes puntos:
    a. Genere un vector, sin orden, con a lo sumo las 300 oficinas que administra. De cada oficina
    se ingresa el código de identificación, DNI del propietario y valor de la expensa. La lectura
    finaliza cuando se ingresa el código de identificación -1, el cual no se procesa.
    b. Ordene el vector, aplicando el método de inserción, por código de identificación de la
    oficina.
    c. Ordene el vector aplicando el método de selección, por código de identificación de la oficina.
}

program ej2;
uses sysutils;

Const 
  dimF = 300;

Type 
  oficina = record 
    codigo: integer;
    dni: LongInt;
    expensa: real;
  end;

  rango = 1..dimF;
  vector = array[1..dimF] of oficina;

procedure LeerOficina(var o: oficina);
begin 
  write('Codigo: '#9); readln(o.codigo);
  if (o.codigo <> -1) then begin
    write('DNI: '#9,#9); readln(o.dni);
    write('Valor Expensa: '#9); readln(o.expensa);
  end;
  writeln;
end;

procedure CargarPagos(var v: vector; var dimL: rango);
var o: oficina;
begin 
    // No controlo si dimL < dimF porque por def es menor o igual
    LeerOficina(o);
    while (o.codigo <> -1) and (dimL < dimF) do begin
      dimL := dimL + 1;
      v[dimL] := o;

      LeerOficina(o);
    end;
end;

procedure sort_insercion(var v: vector; dimL: rango);
var 
    i, j: rango;
    actual: oficina;

begin 
    for i := 2 to dimL do begin
        actual := v[i];
        j := i - 1;

        while (j > 0) and (v[j].codigo > actual.codigo) do 
        begin 
            v[j + 1] := v[j];
            j := j - 1;
        end;

        v[j + 1] := actual;
    end;
end;

procedure sort_seleccion(var v: vector; var dimL: rango);
var 
    i, j, pos: rango;
    item: oficina;
begin 
    { busca el mínimo y guarda en pos la posición }
    for i := 1 to dimL - 1 do begin 
        pos := i;
        for j := i + 1 to dimL do 
            if v[j].codigo < v[pos].codigo then pos := j;

        { intercambia v[i] y v[p]}
        item := v[pos];
        v[pos] := v[i];
        v[i] := item;
    end;
end;

procedure ImprimirVector(v: vector; dimL: rango);
var 
  i, j, k, longDni: integer;
begin 
  writeln(' Codigo |    DNI    | Expensas ');
  writeln('-------------------------------');
  for i := 1 to dimL do begin 
    if (v[i].codigo < 9) then 
      write('   00')
    else if (v[i].codigo < 100) then
      write('   0')
    else write('   ');

    write(v[i].codigo, '   ');

    longDni := Length(IntToStr(v[i].dni));
    if (longDni < 10) then begin
      j := 10 - longDni;

      for k := 1 to j do
        write(' ');
    end;

    write(v[i].dni, '   ');
    write(v[i].expensa:0:2);
    writeln;

  end;
end;

Var
  v1, v2: vector;
  o: oficina;
  dimL: rango;
  i: integer;

Begin
  dimL := 0;
  CargarPagos(v1, dimL);

  // Copio el vector original
  for i := 1 to dimL do 
    v2[i] := v1[i];

  writeln('----------> Vector cargado');
  ImprimirVector(v1, dimL);
  
  sort_insercion(v1, dimL);
  writeln('----------> Vector ordenado insercion');
  ImprimirVector(v1, dimL);
 
  sort_seleccion(v2,  dimL);
  writeln('----------> Vector ordenado seleccion');
  ImprimirVector(v2, dimL);
End.