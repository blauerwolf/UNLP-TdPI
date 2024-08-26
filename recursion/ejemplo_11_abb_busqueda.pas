{ Árbol binario de búsqueda }
program arbol_binario;
type 
    arbol = ^nodo;

    nodo = record 
        dato: integer;
        HI: arbol;
        HD: arbol;
    end; 

{ Procedimiento recursivo. Por referencia. Solo la primera vez se modifica a }
procedure agregar(var a: arbol; dato: integer);
begin 
    { en vez de usar una variable auxiliar nue, hago new de la variable de tipo arbol }
    if (a = nil) then begin 
        new(a);
        a^.dato := dato;
        a^.HI := nil;
        a^.HD := nil;
    end else 
        if (dato <= a^.dato) then agregar(a^.HI, dato)
        else agregar(a^.HD, dato);

end;

procedure CargarArbol(var abb: arbol);
var num: integer;
begin 
    write('Ingrese número: ');
    readln(num);

    while(num <> 50) do begin 
        agregar(abb, num);

        write('Ingrese número: ');
        readln(num);
    end;
end;

procedure enOrden(a: arbol);
begin 
    if (a <> nil) then begin 
        enOrden(a^.HI);
        write(a^.dato); // O cualquier otra acción
        enOrden(a^.HD);
    end;
end;

var 
    abb: arbol;
    num: integer;

Begin 
    abb := nil;

    CargarArbol(abb);
    enOrden(abb);
End.