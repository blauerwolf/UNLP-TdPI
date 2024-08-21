{ Estructuras de ejemplo }
Const dimF = 200;
type 
    vector = array [1..dimF] of integer;


// OPERACIONES SOBRE VECTORES
{ Agrega un nodo a la lista }
procedure agregarAdelante(var l:lista; a:alumno);
var
    nue: lista;

begin
    new(nue);
    nue^.alu := a;
    nue^.sig := l;
    l := nue;
end;

procedure agregarAlFinal(var l:lista; p: prestamo);
var 
    nue, aux: lista;
begin 

    new(nue);
    nue^.elem := p;
    nue^.sig := nil;

    if ( l = nil) then
        l := nue
    else 
    begin
        aux := l;

        while (aux^.sig <> nil) do 
            aux := aux^.sig;
        
        aux^.sig := nue;
    end;
end;

// OPERACIONES SOBRE LISTAS
{ Agregar un nodo al final de la lista }
procedure agregarAlFinal(var l:lista; dni: integer);
var 
    nue, aux: lista;
begin 

    new(nue);
    nue^.cli.dni := dni;
    nue^.sig := nil;

    if ( l = nil) then
    begin 
        nue^.cli.cod := 1;
        l := nue;
    end 
    else 
    begin
        aux := l;

        while (aux^.sig <> nil) do 
            aux := aux^.sig;
        
        nue^.cli.cod := aux^.cli.cod + 1;
        aux^.sig := nue;
    end;
end;


procedure InsertarOrdenado(var l: lista; v: viaje);
var 
  actual, anterior, nuevo: lista;

begin 
  new(nuevo);
  nuevo^.trip := v;
  nuevo^.sig := nil;

  if (l = nil) then 
    l := nuevo
  else begin 
    anterior := l;
    actual := l;

    while (actual <> nil) and (actual^.trip.codigoAlumno < nuevo^.trip.codigoAlumno) do 
    begin 
      anterior := actual;
      actual := actual^.sig;
    end;

    if (actual = l) then 
    begin 
      nuevo^.sig := l;
      l := nuevo;
    end 
    else begin 
      anterior^.sig := nuevo;
      nuevo^.sig := actual;
    end;
  end;
end;


{
    ALGORITMOS DE ORDENAMIENTO
    Consideraciones:
    - T de ejecución:               N**2
    - Facilidad de escritura:       Muy fácil
    - Mem utilizada en ejecución.   El arreglo y variables
    - Complejidad de las estructuras aux necesarias.   No require
    - Require el mismo tiempo si los datos ya están ordenados, si están al azar, si se encuentran en el orden exactamente inverso al que yo losquiero tener: Siempre require el mismo tiempo de ejecución.
}
procedure sort_seleccion(var v: vector; var dimL: indice);
var 
    i, j, pos: indice;
    item: tipoElem;
begin 
    { busca el mínimo y guarda en pos la posición }
    for i := 1 to dimL - 1 do begin 
        pos := i;
        for j := i + 1 to dimL do 
            if v[j] < v[pos] then pos := j;

        { intercambia v[i] y v[p]}
        item := v[pos];
        v[pos] := v[i];
        v[i] := item;
    end;
end;

{
    Consideraciones:
    - T de ejecución:               N**2
    - Facilidad de escritura:       No es tan fácil de implementar
    - Mem utilizada en ejecución.   El arreglo y variables
    - Complejidad de las estructuras aux necesarias.   No require
    - Require el mismo tiempo si los datos ya están ordenados, si están al azar, si se encuentran en el orden exactamente inverso al que yo losquiero tener: Si los datos están ordenados de menor a mayor el algoritmo solo hace comparaciones, por lo tanto, es de orden (N). Si los datos están ordenados de mayor a menor el algoritmo hace todas las comparaciones y todos los intercambios, por lo tanto es de orden (N**2).
}
procedure sort_insercion(var v: vector; dimL: indice);
var 
    i, j: indice;
    actual: tipoElem;

begin 
    for i := 2 to dimL do begin
        actual := v[i];
        j := i - 1;

        while (j > 0) and (v[j] > actual) do 
        begin 
            v[j + 1] := v[j];
            j := j - 1;
        end;

        v[j + 1] := actual;
    end;
end;