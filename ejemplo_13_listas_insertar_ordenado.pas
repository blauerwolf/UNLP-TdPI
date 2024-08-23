program ej_insertar_ordenado;
type 
  jugador = record 
    dni: integer;
    nomyAp: string[30];
    altura: integer;
  end;

  lista = ^nodo;

  nodo = record 
    dato: jugador;
    sig: lista;
  end;

procedure insertarOrdenado(var L: lista; j: jugador);
var 
  nue: lista;
  act, ant: lista;          { Puntaros auxiliares para recorrido }

begin 
  { Crear el nodo a insertar }
  new (nue);
  nue^.dato := j;
  act := L;                 { Ucibo act y ant al inicio de la lista }
  ant := L;

  { Buscar la posición para insertar el nodo creado }
  while (act <> nil) and (j.altura > act^.dato.altura) do 
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

procedure leerJugador(var j: jugador);
begin 
  write('DNI: '); readln(j.dni);
  write('Nombre y Apellido: '); readln(j.nomyAp);
  write('Altura: '); readln(j.altura);
  writeln;
end;


procedure cargarLista(var L: lista);
var j: jugador;

Begin
  leerJugador(j);
  while(j.dni <> 0) do begin 
    insertarOrdenado(J, j);
    leerJugador(j);
  end;
end;


var                   { PROGRAMA PRINCIPAL }
  L : lista;

begin 
  L := nil;
  cargarLista(L);
end.
