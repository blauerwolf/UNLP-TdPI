{
    Una clínica necesita un sistema para el procesamiento de las atenciones realizadas a los
    pacientes en julio de 2024.

        a) Implementar un módulo que lea la información de las atenciones. De cada atención se lee:
        matrícula del médico, DNI del paciente, día y diagnóstico (valor entre la A y F). La lectura
        finaliza con el DNI 0. El módulo debe retornar dos estructuras:

           i. Un árbol binario de búsqueda ordenado por la matrícula del médico. Para cada matrícula
           del médico debe almacenarse la cantidad de atenciones realizadas.
           ii. Un vector que almacene en cada posición el tipo de diagnóstico y la lista de los DNI
           de los pacientes atendidos con ese diagnóstico.

        b) Implementar un módulo que reciba el árbol generado en a), una matrícula y retorne
        la cantidad total de atenciones realizadas por los médicos con matrícula superior
        a la matrícula ingresada.

        c) Realizar un módulo recursivo que reciba el valor generado en a) y retorne el diagnóstico
        con mayor cantidad de pacientes atendidos.

    NOTA: Implementar el programa principal, que invoque a los incisos a, b y c.
}

program clinica2;

type

  rangoDiagnostico = 'A'..'F';

  atencion = record 
    matricula: integer;
    dni_paciente: integer;
    dia: integer;
    diagnostico: char;
  end;

  arbol = ^nodoArbol;
  nodoArbol = record 
    matricula: integer;
    tot_atenciones: integer;
    HI: arbol;
    HD: arbol;
  end;

  lista = ^nodo;
  nodo = record 
    dni: integer;
    sig: lista;
  end;

  vector = array[rangoDiagnostico] of lista;

procedure ModuloA(var a: arbol; var v: vector);
  procedure LeerAtencion(var at: atencion);
  begin  
      at.matricula := random(1000);
      at.dni_paciente := random(1000);
      at.dia := random(31) + 1;
      at.diagnostico := Char(random(6) + 65);
  end;


  procedure InicializarVector(var v: vector);
  var i: char;
  begin 
    for i := 'A' to 'F' do 
      v[i] := nil;
  end;

  procedure InicializarArbol(var a: arbol);
  begin 
    a := nil;
  end;


  procedure InsertarOrdenado(var l: lista; dato: atencion);
  var nue, act, ant: lista;
  begin 
    new(nue);
    nue^.dni := dato.dni_paciente;
    act := l;
    ant := l;

    while (act <> nil) and (dato.dni_paciente > act^.dni) do
    begin 
      ant := act;
      act := act^.sig;
    end;

    if (act = ant) then 
      l := nue
    else 
      ant^.sig := nue;

    nue^.sig := act;
  end;


  procedure ActualizarVector(var v: vector; pos: char; at: atencion);
  begin 
    InsertarOrdenado(v[pos], at);
  end;


  procedure InsertOrUpdate(var a: arbol; at: atencion);
  begin 
    // Caso base: arbol/nodo vacio 
    if (a = nil) then begin
      new(a);
      a^.matricula := at.dni_paciente;
      a^.tot_atenciones := 1;
      a^.HI := nil;
      a^.HD := nil;

    end 
    else if (a^.matricula = at.matricula) then 
      a^.tot_atenciones := a^.tot_atenciones + 1
    else if (a^.matricula > at.matricula) then 
      InsertOrUpdate(a^.HI, at)
    else 
      InsertOrUpdate(a^.HD, at);
  end;

  procedure ImprimirLista(l: lista);
  begin 
    if (l <> nil) then begin 
      ImprimirLista(l^.sig);
      write(l^.dni, ' | ');
    end;
  end;

  procedure ImprimirVector(v: vector);
  var i: char;
  begin 
    for i := 'A' to 'F' do begin 
      writeln;
      writeln;
      writeln('Diagnostico: ', i);
      write('DNI: | ');
      ImprimirLista(v[i]);
    end;
  end;

  procedure ImprimirArbol(a: arbol);
  begin 
    if (a <> nil) then begin 
      ImprimirArbol(a^.HI);
      writeln('Matricula: ', a^.matricula, ' Total atenciones: ', a^.tot_atenciones);
      ImprimirArbol(a^.HD);
    end;
  end;


  procedure CargarAtenciones(var a: arbol; var v: vector);
  var at: atencion;
  begin 
    InicializarVector(v);
    InicializarArbol(a);

    LeerAtencion(at);

    while (at.dni_paciente <> 0) do begin 
      InsertOrUpdate(a, at);
      ActualizarVector(v, at.diagnostico, at);

      LeerAtencion(at);
    end;   
  end;


begin 
  writeln;
  writeln('----- MODULO A -----');
  writeln;
  CargarAtenciones(a, v);
  ImprimirVector(v);
  writeln;
  ImprimirArbol(a);
end;

// Implementar un módulo que reciba el árbol generado en a), una matrícula y retorne
// la cantidad total de atenciones realizadas por los médicos con matrícula superior
// a la matrícula ingresada.
procedure ModuloB(var a: arbol);
  function GetTotalAtencionesOver(a: arbol; matricula: integer): integer;
  var cant: integer;
  begin 
    if (a = nil) then GetTotalAtencionesOver := 0 
    else begin 
      if (a^.matricula > matricula) then
        cant := a^.tot_atenciones
      else 
        cant := 0;

      GetTotalAtencionesOver := cant
          + GetTotalAtencionesOver(a^.HI, matricula)
          + GetTotalAtencionesOver(a^.HD, matricula);
    end;
  end;


var matricula, cant: integer;
begin 
  writeln;
  writeln('----- MODULO B -----');
  writeln;
  write('Ingrese matricula: ');
  readln(matricula);
  cant := GetTotalAtencionesOver(a, matricula);
  writeln('Hay un total de ', cant, ' atenciones para las matriculas superiores a ', matricula);
end;


// Realizar un módulo recursivo que reciba el valor generado en a) y retorne el diagnóstico
// con mayor cantidad de pacientes atendidos.
procedure ModuloC(v: vector);
  function ContarTratamientos(l: lista): integer;
  begin 
    if (l = nil) then ContarTratamientos := 0
    else begin 
      ContarTratamientos := 1 + ContarTratamientos(l^.sig);
    end;
  end;


  function GetTopDiagnostico(v: vector): char;
  var 
      max, act: integer;
      i, diag: char;
  begin 
      max := -1;
      diag := 'Z';

      for i := 'A' to 'F' do begin 
          act := ContarTratamientos(v[i]);
          if (act > max) then begin 
              max := act;
              diag := i;
          end;
      end;

      GetTopDiagnostico := diag;
  end;


var id: char;
begin 
  writeln;
  writeln('----- MODULO C -----');
  writeln;
  id := GetTopDiagnostico(v);
  writeln('El tratamiento ', id, ' posee la mayor cantidad de antenciones');
end;

var
  a: arbol;
  v: vector;
Begin 
  ModuloA(a,v);
  ModuloB(a);
  ModuloC(v);
End.