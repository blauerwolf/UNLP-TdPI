program recursion;

type 
    lista = ^nodo;
    nodo = record 
        dato: integer;
        sig: lista;
    end;


procedure agregarAdelante(var L: lista; num: integer);
var aux: lista;
begin
    new (aux); aux^.dato := num; aux^.sig := L; L := aux;
end;


procedure cargarLista(var L: lista);
begin 
    L := nil;
    agregarAdelante(L, 3);
    agregarAdelante(L, 4);
    agregarAdelante(L, 5);
    agregarAdelante(L, 6);
end;


procedure imprimirLista(L: lista);
begin 
    while (L <> nil) do begin 
        writeln(L^.dato);
        L := L^.sig;
    end;
end;


procedure imprimirListaRecursivo(L: lista);
begin 
    // Caso base lista vacía

    // Recursion achico la lista en 1
    if (L <> nil) then begin 
        writeln(L^.dato);
        imprimirListaRecursivo(L^.sig);
    end;
end;

procedure imprimirListaRecursivaInverso(L: lista);
begin 
    // Caso base lista vacía

    // Recursion achico la lista en 1
    if (L <> nil) then begin 
        imprimirListaRecursivaInverso(L^.sig);
        writeln(L^.dato);
    end;
end;


var 
    l: lista;

begin 
    cargarLista(l);
    imprimirLista(l);
    writeln;
    imprimirListaRecursivo(l);
    writeln;
    imprimirListaRecursivaInverso(l);
end.