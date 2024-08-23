program ej_agregar_final;

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

procedure agregarAtras(var L, ULT: lista; j:jugador);
var 
  nue: lista;

Begin 
  new (nue);          { Creo el nodo }
  nue^.dato := j;     { Cargo el dato }
  nue^.sig := nil;    { Inicializo enlace en nil }

  if (L = nil) then   { Si la lista está vacía }
    L := nue          { Actualizo el inicio }
  else                { si la lista no está vacía }
    ULT^.sig := nue;  { Realizo enlace con el último }
  
  ULT := nue;         { Actualizo el último }
end;

procedure leerJugador(var j: jugador);
begin 
  write('DNI: '); readln(j.dni);
  write('Nombre y Apellido: '); readln(j.nomyAp);
  write('Altura: '); readln(j.altura);
  writeln;
end;

procedure cargarLista(var L:lista);
var 
  j: jugador;
  ULT: lista;

Begin 
  leerJugador(j);
  while(j.dni <> 0) do begin 
    agregarAtras(L, ULT, j);
    leerJugador(j);
  end;
end;

var                   { PROGRAMA PRINCIPAL }
  L : lista;

begin 
  L := nil;
  cargarLista(L);
end.