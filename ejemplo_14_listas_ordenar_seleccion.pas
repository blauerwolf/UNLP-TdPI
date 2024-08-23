



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