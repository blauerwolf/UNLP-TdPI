{
  Implementar un programa que contenga:
  a. Un módulo que lea información de los finales rendidos por los alumnos de la Facultad de
  Informática y los almacene en una estructura de datos. La información que se lee es legajo,
  código de materia, fecha y nota. La lectura de los alumnos finaliza con legajo 0. La estructura
  generada debe ser eficiente para la búsqueda por número de legajo y para cada alumno deben
  guardarse los finales que rindió en una lista.
  b. Un módulo que reciba la estructura generada en a. y retorne la cantidad de alumnos con
  legajo impar.
  c. Un módulo que reciba la estructura generada en a. e informe, para cada alumno, su legajo y
  su cantidad de finales aprobados (nota mayor o igual a 4).
  c. Un módulo que reciba la estructura generada en a. y un valor real. Este módulo debe
  retornar los legajos y promedios de los alumnos cuyo promedio supera el valor ingresado.
}

program ejercicio3;

type 
    
    // TODO: El record para el alumno no debería tener la nota
    final = record 
        legajo: integer;
        cod_materia: integer;
        fecha: string[10];
        nota: real;
    end;

    arbol = ^nodoArbol;
    nodoArbol = record 
        dato: final;
        HI: arbol;
        HD: arbol;
    end;

procedure leerFinal(f: final);
begin 
    write('Legajo alumno: '); readln(f.legajo);
    if (f.legajo <> 0) then begin 
        write('Codigo de materia: '); readln(f.cod_materia);
        write('Fecha final: '); readln(f.fecha);
        write('Nota obtenida: '); readln(f.nota);
    end;
end;


Procedure InsertarElemento (var a: arbol; elem: final);
Begin
  if (a = nil) 
  then begin
      new(a);
      a^.dato:= elem; 
      a^.HI:= nil; 
      a^.HD:= nil;
  end
  else if (elem.cod < a^.dato.cod) 
        then InsertarElemento(a^.HI, elem)
        else InsertarElemento(a^.HD, elem); 
End;


procedure CargarFinales(var a: arbol);
var f: final;
begin 
    leerFinal(f);
    while (f.legajo <> 0) do begin 
        Agregar(a, f);
        leerFinal(f);
    end;
end;


{ PROGRAMA PRINCIPAL }
var 
  a: arbol;

Begin 
    CargarFinales(a);
End.