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
  if (j.dni <> 0) then begin
    write('Nombre y Apellido: '); readln(j.nomyAp);
    write('Altura: '); readln(j.altura);
  end;
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
