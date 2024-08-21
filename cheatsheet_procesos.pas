{ Estructuras de ejemplo }
Const dimF = 200;
type 
    vector = array [1..dimF] of integer;

{
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