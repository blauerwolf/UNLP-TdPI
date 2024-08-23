program ej_agregar_adelante;

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


procedure agregarAdelante(var l:lista; j: jugador);
var
    nue: lista;

begin
    new(nue);
    nue^.dato := j;
    nue^.sig := l;
    l := nue;
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
    agregarAdelante(L, j);
    leerJugador(j);
  end;
end;

var                   { PROGRAMA PRINCIPAL }
  L : lista;

begin 
  L := nil;
  cargarLista(L);
end.


