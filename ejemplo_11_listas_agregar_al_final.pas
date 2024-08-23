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

procedure agregarAtras(var l:lista; j:jugador);
var 
    nue, aux: lista;
begin 

    new(nue);
    nue^.dato := j;
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
    agregarAtras(L, j);
    leerJugador(j);
  end;
end;

var                   { PROGRAMA PRINCIPAL }
  L : lista;

begin 
  L := nil;
  cargarLista(L);
end.