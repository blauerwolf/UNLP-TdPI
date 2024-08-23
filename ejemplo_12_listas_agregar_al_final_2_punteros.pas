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
  if (j.dni <> 0) then begin
    write('Nombre y Apellido: '); readln(j.nomyAp);
    write('Altura: '); readln(j.altura);
  end;
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

procedure imprimirLista(L: lista);
var 
  espacios, i: integer;
begin 
  if (L <> nil) then begin
    writeln('   DNI   |        Nombre y Apellido     |  Altura');
    writeln('---------------------------------------------------');
  end;

  while (L <> nil) do begin

    { Controlo el tamaño del dni ingresado }
    espacios := Length(IntToStr(L^.dato.dni));
    if (espacios < 8) then begin
      for i := 1 to (8 - espacios) do
        write(' ');

      write(L^.dato.dni);

    end else if (espacios > 8) then begin
      for i := 1 to 6 do 
        write(IntToStr(L^.dato.dni)[i]);

      write('..');
    end else begin
      write(L^.dato.dni);
    end;

    write(' |');

    { Controlo el tamaño del Nombre y apellido ingresado }
    espacios := Length(L^.dato.nomyAp);
    if (espacios < 30) then begin 
      for i := 1 to (30 - espacios) do
        write(' ');

      write(L^.dato.nomyAp);
    end else 
      write(L^.dato.nomyAp);
      
    write('|   ', L^.dato.altura);
    writeln;

    L := L^.sig;
  end;

  writeln;
end;

var                   { PROGRAMA PRINCIPAL }
  L : lista;

begin 
  L := nil;
  cargarLista(L);
  imprimirLista(L);
end.