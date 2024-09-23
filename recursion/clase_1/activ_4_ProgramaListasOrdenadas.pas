program ProgramaListasOrdenadas;

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


function BuscarElementoOrdenado(l: lista; num: integer): boolean;
var existe: boolean;
begin 
    existe := false;

    while (l <> nil) and (l^.dato < num) do
        l := l^.sig;

    if (l <> nil) and (l^.dato = num) then
        existe := true;

    BuscarElementoOrdenado := existe;
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


{ PROGRAMA PRINCIPAL }
var 
    l: lista;
    valor: integer;

Begin 
    { Cargo la lista hasta que se genere el #120 }
    CargarListaOrdenada(l);

    ImprimirLista(l);

    write('Ingrese valor a buscar: ');
    readln(valor);

    if (BuscarElementoOrdenado(l, valor)) then 
        writeln('El número ', valor, ' se encuentra en la lista.')
    else 
        writeln('El número ', valor, ' no se ecuentra en la lista.');

End. 