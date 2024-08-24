program ProgramaListas;

type 
    lista = ^nodo;
    nodo = record 
        dato: integer;
        sig: lista;
    end;

procedure InicializarLista(var l: lista);
begin l := nil; end;


procedure AgregarAtras(var l:lista; r: integer);
var 
    nue, aux: lista;
begin 

    new(nue);
    nue^.dato := r;
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


procedure CargarLista(var l: lista);
var ale: integer;
begin 
    randomize;
    InicializarLista(l);

    ale := random(51) + 100;
    while (ale <> 120) do begin 
        AgregarAtras(l, ale);
        ale := random(51) + 100;
    end;
end;


procedure ImprimirLista(l: lista);
begin 
    write('Números: ');
    while (l <> nil) do begin 
        write('| ', l^.dato, ' ');

        l := l^.sig;
    end;
    write('|');
    writeln;
    writeln;
end;

function BuscarElemento(l: lista; num: integer): boolean;
var existe: boolean;
begin 
    existe := false;
    while (l <> nil) and (not existe) do begin
        if (l^.dato = num) then 
            existe := true;

        l := l^.sig;
    end;

    BuscarElemento := existe;
end;


var 
    l: lista;
    valor: integer;

begin 
    { Cargo la lista hasta que se genere el #120 }
    CargarLista(l);

    ImprimirLista(l);

    write('Ingrese valor a buscar: ');
    readln(valor);

    if (BuscarElemento(l, valor)) then 
        writeln('El número ', valor, ' se encuentra en la lista.')
    else 
        writeln('El número ', valor, ' no se ecuentra en la lista.');



end.