{
    Una clínica necesita implementar un sistema para el procesamiento de las atenciones 
    realizadas a los pacientes en julio de 2024.

    a) Implementar un módulo que lea la información de las atenciones. Decada atención se lee:
        - matrícula del médico
        - dni del paciente
        - dia
        - diagnóstico (Valor entre la A y F).

        La lectura finaliza con el dni 0. El módulo debe retornar dos estructuras:

        i. Un árbol binario de búsqueda ordenado por la matrícula del médico. Para cada matrícula
        del médico debe almacenarse la cantidad de atenciones realizadas.
        ii. Un vector que almacene en cada posición el tipo de diagnóstico y la lista de los DNI
        de los pacientes atendidos con ese diagnóstico.

    b) Implementar un módulo que reciba el árbol generado en a), una matrícula y retorne la cantidad
    total de atenciones realizadas por los médicos con matrícula superior a la matrícula ingresada.

    c) Realizar un módulo recursivo que reciba el vector generador en a) y retorne el diagnóstico
    con mayor cantidad de pacientes antendidos.

    NOTA: Implementar el programa principal, que invoque a los incisos a, b y c.
}

program parcial;

type

    atencion = record 
        matricula: integer;
        dni: integer;
        dia: integer;
        diagnostico: char;
    end;

    lista = ^nodo;
    nodo = record 
        dni: integer;
        sig: lista;
    end;

    arbol = ^nodoArbol;
    nodoArbol = record 
        matricula: integer;
        atenciones: integer;
        HI: arbol;
        HD: arbol;
    end;

    vector = array['A'..'F'] of lista;



{
procedure agregarAdelante(var L: lista; R: registro);
var 
    nuevo: lista;

begin 
    new(nuevo);
    nuevo^.dato := R;
    nuevo^.sig := L;
    L := nuevo;
end;
}

{
procedure agregarAtras(var L, ult: lista; R: registro);
var 
    nuevo: lista;
begin 
    new(nuevo);
    nuevo^.dato := R;
    nuevo^.sig := NIL;
    if (L = nil) then 
        L := nuevo
    else 
        nuevo^.sig := ult;
    
    ult := nuevo;
end;
}


procedure ModuloA(var a: arbol; var v: vector);

    procedure insertarOrdenado(var L: lista; R: integer);
    var 
        nuevo, ant, act: lista;
    begin 
        new(nuevo);
        nuevo^.dni := R;
        act := L;

        while (act <> nil) and (act^.dni < R) do 
        begin 
            ant := act;
            act := act^.sig;
        end;

        if (act = L) then 
            L := nuevo
        else 
            ant^.sig := nuevo;

        nuevo^.sig := act;
    end;


    procedure leerAtencion(var a: atencion);
    var 
        v: array[1..6] of char = ('A', 'B', 'C', 'D', 'E', 'F');
    begin 
        a.dni := Random(5000);
        if (a.dni <> 0) then begin 
            a.matricula := Random(1000) + 2000;
            a.dia := Random(31) + 1;
            a.diagnostico := v[Random(6) + 1];
        end;
    end;

    procedure InsertOrUpdate(var a: arbol; matricula: integer);
    begin 
        // Caso base: arbol vacio.
        if (a = nil) then begin 
            new(a);
            a^.matricula := matricula;
            a^.HI := nil;
            a^.HD := nil;
            a^.atenciones := 1;

        end
        // Caso que esté actualizando un registro
        else if (a^.matricula = matricula) then begin 
            a^.matricula := a^.matricula + 1
        end 
        else begin 
            if (a^.matricula > matricula) then 
                InsertOrUpdate(a^.HI, matricula)
            else 
                InsertOrUpdate(a^.HD, matricula);
        end;

    end;


    procedure ImprimirLista(l: lista);
    begin 
        if (l <> nil) then begin
            write('| ', l^.dni, ' ');
            ImprimirLista(l^.sig);
        end;
    end;


    procedure ImprimirVector(v: vector);
    var i: char;
    begin 
        for i := 'A' to 'F' do begin
            writeln;
            writeln('Diagnostico: ', i);
            writeln('DNIs:  atendidos');
            writeln('-------------');
            ImprimirLista(v[i]);
        end;
    end;

    
    procedure ImprimirArbol(a: arbol);
    begin 
        if (a <> nil) then begin 
            ImprimirArbol(a^.HI);
            writeln('Matricula: ', a^.matricula, #9, 'Atenciones: ', a^.atenciones);
            ImprimirArbol(a^.HD);
        end;
    end;


    procedure CargarAtenciones(var a: arbol; var v: vector);
    var r: atencion;
    begin 
        leerAtencion(r);

        while (r.dni <> 0) do begin 

            // Agrego el dni a la lista del vector de diagnósticos
            insertarOrdenado(v[r.diagnostico], r.dni);

            // Agregar al árbol
            InsertOrUpdate(a, r.matricula);

            leerAtencion(r);
        end;
    end;
begin 
    writeln;
    writeln('----- MODULO A -----');
    writeln;
    CargarAtenciones(a, v);
    ImprimirVector(v);
    ImprimirArbol(a);
end;

// Implementar un módulo que reciba el árbol generado en a), una matrícula y retorne la cantidad
// total de atenciones realizadas por los médicos con matrícula superior a la matrícula ingresada.
procedure ModuloB(a: arbol);
    function GetAtencionesAbove(a: arbol; matricula: integer): integer;
    begin
        // Caso base: arbol vacio.
        if (a = nil) then GetAtencionesAbove := 0
        else begin 
            if (a^.matricula > matricula) then
                GetAtencionesAbove := a^.atenciones + GetAtencionesAbove(a^.HD, matricula);
        end;
    end;
    
var matricula, total: integer;
begin 
    writeln;
    writeln('----- MODULO B -----');
    writeln;
    write('Ingrese un numero de matricula: ');
    readln(matricula);
    total := GetAtencionesAbove(a, matricula);
    writeln('Cantidad de atenciones de matriculas superiores a ', matricula, ': ', total);
end;

// Realizar un módulo recursivo que reciba el vector generador en a) y retorne el diagnóstico
// con mayor cantidad de pacientes antendidos.
procedure ModuloC(v: vector);
    function ContarAtenciones(l: lista): integer;
    begin 
        if (l = nil) then ContarAtenciones := 0
        else
            ContarAtenciones := 1 + ContarAtenciones(l^.sig);
    end;


    function GetTopDiagnostico(v: vector): char;
    var 
        max, act: integer;
        i, diag: char;
    begin 
        max := -1;
        diag := 'Z';

        for i := 'A' to 'F' do begin 
            act := ContarAtenciones(v[i]);
            if (act > max) then begin 
                max := act;
                diag := i;
            end;
        end;

        GetTopDiagnostico := diag;
    end;
var diagnostico: char;
begin 
    writeln;
    writeln('----- MODULO C -----');
    writeln;
    diagnostico := GetTopDiagnostico(v);
    writeln('Diagnostico con mayor cantidad de pacientes atendidos: ', diagnostico);
end;


var 
    a: arbol;
    v: vector;

Begin 
    ModuloA(a, v);
    ModuloB(a);
    ModuloC(v);

End.