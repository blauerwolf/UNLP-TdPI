program imprimir_lista;

type
    lista = ^nodo;
    nodo = record 
        dato: integer;
        sig: lista;
    end;


procedure InicializarLista(var l: lista);
begin l := nil; end;


procedure InsertarOrdenado(var L: lista; num: integer);
var 
  nue, act, ant: lista;         

begin 
  { Crear el nodo a insertar }
  new (nue);
  nue^.dato := num;
  act := L;                 { Ucibo act y ant al inicio de la lista }
  ant := L;

  { Buscar la posición para insertar el nodo creado }
  while (act <> nil) and (num > act^.dato) do 
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


procedure CargarListaOrdenada(var l: lista);
var ale: integer;
begin 
    randomize;
    InicializarLista(l);
    ale := random(51) + 100;
    while (ale <> 120) do begin 
        InsertarOrdenado(l, ale);
        ale := random(51) + 100;
    end;
end;

procedure ImprimirLista(l: lista);
    procedure imprimir(pri: lista);
    begin 
        if (pri <> nil) then begin 
            write('| ', pri^.dato, ' ');
            pri := pri^.sig;

            imprimir(pri);
        end;
    end;

begin 
    write('Números: ');
    imprimir(l);
    write('|');
    writeln;
    writeln;
end;


{ PROGRAMA PRINCIPAL }
var 
    l: lista;
    valor: integer;

Begin 
    { Cargo la lista hasta que se genere el #120 }
    CargarListaOrdenada(l);

    { Impresión de recursiva de la lista }
    ImprimirLista(l);

End. 