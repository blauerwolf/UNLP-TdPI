{
    Netflix ha publicado la lista de películas que estarán disponibles durante el mes de
    diciembre de 2022. De cada película se conoce: código de película, código de género (1: acción,
    2: aventura, 3: drama, 4: suspenso, 5: comedia, 6: bélico, 7: documental y 8: terror) y puntaje
    promedio otorgado por las críticas.
    Implementar un programa que invoque a módulos para cada uno de los siguientes puntos:
    a. Lea los datos de películas, los almacene por orden de llegada y agrupados por código de
    género, y retorne en una estructura de datos adecuada. La lectura finaliza cuando se lee el
    código de la película -1.
    b. Genere y retorne en un vector, para cada género, el código de película con mayor puntaje
    obtenido entre todas las críticas, a partir de la estructura generada en a)..
    c. Ordene los elementos del vector generado en b) por puntaje utilizando alguno de los dos
    métodos vistos en la teoría.
    d. Muestre el código de película con mayor puntaje y el código de película con menor puntaje,
    del vector obtenido en el punto c).
}

program ej3;
type 
  rangoGenero = 1..8;
  pelicula = record 
    id: integer;
    genero: rangoGenero;
    puntaje:  real;
  end;

  lista = ^nodo;
  nodo = record 
    elem: pelicula;
    sig: lista;
  end;

  vectorPeliculas = array[rangoGenero] of lista;
  vectorGeneros =  array[rangoGenero] of string;

procedure LeerPelicula(var p: pelicula);
begin 
  write('Codigo: '); readln(p.id);
  if (p.id <> -1) then begin
    write('Genero: '); readln(p.genero);
    write('Puntaje: '); readln(p.puntaje);
  end
  else writeln(':: Fin de lectura ::');

  writeln;
end;

{ Agregar un nodo al final de la lista }
procedure agregarAlFinal(var l:lista; p:pelicula);
var 
    nue, aux: lista;
begin 

    new(nue);
    nue^.elem :=  p;
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

procedure CargarPeliculas(v: vectorPeliculas);
var 
  p: pelicula;
begin 
  LeerPelicula(p);

  while (p.id <> -1) do 
  begin 
    AgregarAlFinal(v[p.genero], p);
    LeerPelicula(p);
  end;
end;

procedure InicializarVector(var v:vectorPeliculas);
  procedure InicializarLista(var l: lista);
  begin 
    l := nil;
  end;

var i: integer;
begin 
  for i := 1 to 8 do 
    InicializarLista(v[i]);
end;

procedure InicializarGeneros(var g: vectorGeneros);
begin
  g[1] := 'Accion'; g[2] := 'Aventura'; g[3] := 'Drama'; g[4] := 'Suspenso'; 
  g[5] := 'Comedia'; g[6] := 'Belico'; g[7] := 'Documental'; g[8] := 'Terror';
end;

procedure ImprimirLista(l: lista);
begin 
  while (l <> nil) do 
  begin 
    writeln('Codigo: ', l^.elem.id);
    writeln('Puntaje: ', l^.elem.puntaje:0:2);
    writeln;
  end;
end;

procedure ImprimirVector(vP: vectorPeliculas; vg: vectorGeneros);
var i: integer;
begin 
  for i := 1 to 8 do begin 
    writeln('=============> Genero: ', vG[i]);
    ImprimirLista(vP[i]);
  end;
end;

var 
  l: lista;
  vP: vectorPeliculas;
  g: vectorGeneros;

Begin 
  InicializarGeneros(g);
  InicializarVector(vP);
  CargarPeliculas(vP);
  ImprimirVector(vP, g);

End.


