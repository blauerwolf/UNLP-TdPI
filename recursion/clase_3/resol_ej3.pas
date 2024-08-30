{
  Implementar un programa que contenga:
  ✅ a. Un módulo que lea información de los finales rendidos por los alumnos de la Facultad de
  Informática y los almacene en una estructura de datos. La información que se lee es legajo,
  código de materia, fecha y nota. La lectura de los alumnos finaliza con legajo 0. La estructura
  generada debe ser eficiente para la búsqueda por número de legajo y para cada alumno deben
  guardarse los finales que rindió en una lista.
  ✅ b. Un módulo que reciba la estructura generada en a. y retorne la cantidad de alumnos con
  legajo impar.
  ✅ c. Un módulo que reciba la estructura generada en a. e informe, para cada alumno, su legajo y
  su cantidad de finales aprobados (nota mayor o igual a 4).
  ✅ c. Un módulo que reciba la estructura generada en a. y un valor real. Este módulo debe
  retornar los legajos y promedios de los alumnos cuyo promedio supera el valor ingresado.
}

program ejercicio3;
Uses sysutils;

type 
    tipoFecha = string[10];

    final = record 
        cod_materia: integer;
        fecha: tipoFecha;
        nota: real;
    end;

    listaFinales = ^nodoFinales;
    nodoFinales = record 
        dato: final;
        sig: listaFinales;
    end;

    alumno = record 
        legajo: integer;
        finales: listaFinales;
    end;

    arbol = ^nodoArbol;
    nodoArbol = record 
        dato: alumno;
        HI: arbol;
        HD: arbol;
    end;


procedure InsertarOrdenado(var L: listaFinales; f: final);
var 
  nue: listaFinales;
  act, ant: listaFinales;          { Puntaros auxiliares para recorrido }

begin 
  { Crear el nodo a insertar }
  new (nue);
  nue^.dato := f;
  act := L;                 { Ucibo act y ant al inicio de la lista }
  ant := L;

  { Buscar la posición para insertar el nodo creado }
  while (act <> nil) and (f.fecha > act^.dato.fecha) do 
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

{
    Agrega un nuevo alumno si no existe.
    Agrega el final al alumno según su nro de legajo.
}
procedure InsertOrUpdate(var a: arbol; legajo: integer; f:final);
var 
    alu: alumno;
    exam: listaFinales;
begin 
    if (a = nil) then begin 
        // Creo el nodo para el nuevo examen final cargado
        new(exam);
        exam^.dato := f;
        exam^.sig := nil;

        // Creo el nuevo registro para el alumno.
        alu.legajo := legajo;
        alu.finales := exam;

        // Nuevo arbol/nodo
        new(a);
        a^.dato:= alu; 
        a^.HI:= nil; 
        a^.HD:= nil;
    end
    else begin 
        if (a^.dato.legajo = legajo) then
            // Agrego un final a la lista de finales
            InsertarOrdenado(a^.dato.finales, f)
        else begin
            if (legajo < a^.dato.legajo)
            then InsertOrUpdate(a^.HI, legajo, f)
            else InsertOrUpdate(a^.HD, legajo, f);
        end;
    end;
end;


procedure CargarDatos(var a: arbol);

    // Genera una fecha aleatoria en formato YYYY-mm-dd. 
    // Sin considerar casos especiales ej 31/02
    procedure GenerarFechaAleatoria(var fecha: tipoFecha);
    var 
        aux: integer;
        mes, dia: string[2];
    begin
        // Genero el mes
        aux := random(13) + 1;
        if (aux < 10) then mes := IntToStr(0) + IntToStr(aux)
        else mes := IntToStr(aux);

        // Genero el día
        aux := random(31) + 1;
        if (aux < 10) then dia := IntToStr(0) + IntToStr(aux)
        else dia := IntToStr(aux);

        fecha := IntToStr(random(25) + 2000) + '-' + mes + '-' + dia;
    end;


    procedure leerFinal(var f: final);
    begin 
        write('Codigo de materia: '); readln(f.cod_materia);
        write('Fecha final: '); 
        GenerarFechaAleatoria(f.fecha);
        writeln(f.fecha);
        write('Nota obtenida: '); readln(f.nota);
        writeln;
    end;
var 
    f: final;
    legajo: integer;    
begin 
    write('Ingrese Nro de legajo: '); readln(legajo);
    while (legajo <> 0) do begin 
        leerFinal(f);
        InsertOrUpdate(a, legajo, f);

        write('Ingrese Nro de legajo: '); readln(legajo);
    end;
end;



function CantidadLegajosImpar(a: arbol): integer;
    function esPar(n: integer): boolean;
    begin esPar := (n MOD 2 = 0); end;

var
    cant: integer;
begin 
    // Caso base, árbol vacío.
    if (a = nil) then CantidadLegajosImpar := 0
    else begin 
        if (not esPar(a^.dato.legajo)) 
        then cant := 1
        else cant := 0; 
        CantidadLegajosImpar := cant + CantidadLegajosImpar(a^.HI) + CantidadLegajosImpar(a^.HD);
    end;
end;


procedure InformarHistorial(a: arbol);
    procedure ImprimirNotas(l: listaFinales);
    begin 
        while(l <> nil) do begin 
            if (l^.dato.nota >= 4) then
                writeln('Materia: ', l^.dato.cod_materia, #9, ' Fecha: ', l^.dato.fecha, #9, ' Nota: ', l^.dato.nota:0:2);

            l := l^.sig;
        end;
        writeln;
    end;
begin 
    if (a <> nil) then begin 
        InformarHistorial(a^.HD);
        writeln('Alumno: ', a^.dato.legajo);
        writeln('--------------------------');
        ImprimirNotas(a^.dato.finales);
        InformarHistorial(a^.HI);
    end;

end;


procedure InformarPromediosSobre(a: arbol; prom: real);
    function CalcularPromedio(l: listaFinales): real;
    var 
        aux: real;      // Acumulo las notas de los finales
        tot: integer;   // Contador de la cantidad de finales
    begin 
        aux := 0;
        tot := 0;
        while (l <> nil) do begin 
            tot := tot + 1;
            aux := aux + l^.dato.nota;

            // Avanzo la lista
            l := l^.sig;
        end;

        if (tot > 0) 
        then CalcularPromedio := aux / tot
        else CalcularPromedio := 0;
    end;
var promedioAlumno: real;
begin 
    if (a <> nil) then begin 
        InformarPromediosSobre(a^.HD, prom);
        // Acción
        promedioAlumno := CalcularPromedio(a^.dato.finales);
        if (promedioAlumno >= prom) then begin 
            writeln('Alumno: ', a^.dato.legajo, #9, 'Promedio: ', promedioAlumno:0:2);
            InformarPromediosSobre(a^.HI, prom);
        end;
    end;
end;


{ PROGRAMA PRINCIPAL }
var 
  a: arbol;
  prom: real;

Begin 
    CargarDatos(a);
    writeln('Cantidad de legajos con código impar: ', CantidadLegajosImpar(a));
    InformarHistorial(a);
    writeln;
    write('Ingrese el promedio para buscar alumnos: ');
    readln(prom);
    writeln;
    writeln('Alumnos con promedio igual o superior a ', prom:0:2);
    writeln('---------------------------------------------');
    InformarPromediosSobre(a, prom);
    writeln;
End.