{
    El administrador de un edificio de oficinas tiene la información del pago de las expensas
    de dichas oficinas. Implementar un programa con:
    ✅ a) Un módulo que retorne un vector, sin orden, con a lo sumo las 300 oficinas que
    administra. Se deben cargar, para cada oficina, el código de identificación, DNI del
    propietario y valor de la expensa. La lectura finaliza cuando llega el código de
    identificación 0.
    ✅ b) Un módulo que reciba el vector retornado en a) y retorne dicho vector ordenado por
    código de identificación de la oficina. Ordenar el vector aplicando uno de los métodos
    vistos en la cursada.
    ✅ c) Un módulo que realice una búsqueda dicotómica. Este módulo debe recibir el vector
    generado en b) y un código de identificación de oficina. En el caso de encontrarlo, debe
    retornar la posición del vector donde se encuentra y en caso contrario debe retornar 0.
    Luego el programa debe informar el DNI del propietario o un cartel indicando que no
    se encontró la oficina.
    ✅ d) Un módulo recursivo que retorne el monto total de las expensas
}

program clase5_ej1;

const 
  dimF = 300;
type
    indice = 0..dimF;

    oficina = record 
      id: integer;
      dni: longint;
      expensa: real;
    end;

    vector = array [1..dimF] of oficina;


// Procedimiento recursivo para imprimir el vector
procedure ImprimirVector(v: vector; dimL: integer; headers: boolean);
begin 
    if (headers) then begin 
        writeln('#', #9, 'COD', #9, 'DNI', #9, 'EXPENSAS');
        writeln('---------------------------------');
    end;

    if (dimL > 0) then begin 
        ImprimirVector(v, dimL -1, false);
        writeln(dimL, #9, v[dimL].id, #9, v[dimL].dni, #9, v[dimL].expensa:0:2);
    end;
end;


// Un módulo que retorne un vector, sin orden, con a lo sumo las 300 oficinas que
// administra. Se deben cargar, para cada oficina, el código de identificación, DNI del
// propietario y valor de la expensa. La lectura finaliza cuando llega el código de
// identificación 0.
procedure CargarVector(var v: vector; var dimL: integer);
    
    procedure CrearOficina(var o:oficina);
    begin 
        o.id := random(301);
        o.dni := random(10000);
        o.expensa := random * 10000;
    end;

    procedure CargarValores(var v: vector; var dimL: integer);
    var 
        o: oficina;
    begin 
        dimL := 0;
        CrearOficina(o);

        while (o.id <> 0) and (dimL <= dimF) do 
        begin
            dimL := dimL + 1; 
            v[dimL] := o;

            CrearOficina(o);
        end;

    end;


begin 
    writeln;
    writeln('----- Modulo A ----->');
    writeln;
    CargarValores(v, dimL);
    writeln('.:Vector:.');
    ImprimirVector(v, dimL, true);
end;


// Un módulo que reciba el vector retornado en a) y retorne dicho vector ordenado por
// código de identificación de la oficina. Ordenar el vector aplicando uno de los métodos
// vistos en la cursada.
procedure OrdenarVector(var v: vector; dimL: integer);

    procedure Ordenar(var v: vector; dimL: integer);
    var 
        i, j: integer;
        actual: oficina;

    begin 
        for i := 2 to dimL do begin
            actual := v[i];
            j := i - 1;

            while (j > 0) and (v[j].id > actual.id) do 
            begin 
                v[j + 1] := v[j];
                j := j - 1;
            end;

            v[j + 1] := actual;
        end;
    end;

begin 
    writeln;
    writeln('----- Modulo B ----->');
    writeln;
    Ordenar(v, dimL);
end;


// Un módulo que realice una búsqueda dicotómica. Este módulo debe recibir el vector
// generado en b) y un código de identificación de oficina. En el caso de encontrarlo, debe
// retornar la posición del vector donde se encuentra y en caso contrario debe retornar 0.
// Luego el programa debe informar el DNI del propietario o un cartel indicando que no
// se encontró la oficina.
procedure Buscar(v: vector; dimL: integer);

    Procedure BusquedaDicotomica(v: vector; ini, fin: indice; dato: integer; var pos: indice);
    var 
        pri, ult, medio: indice;
        ok: boolean;
    begin 
        ok := false;
        pri := 1;
        ult := fin; //fin?
        medio := (pri + ult) DIV 2;

        while (pri <= ult) and (dato <> v[medio].id) do begin 
            if (dato < v[medio].id) then 
                ult := medio - 1
            else pri := medio + 1;

            medio := (pri + ult) DIV 2;
        end;

        if (pri <= ult) and (dato = v[medio].id) 
        then ok := true;
        
        if (ok) then pos := medio
        else pos := 0;
    end;


var id, pos: indice;
begin 
    writeln;
    writeln('----- Modulo C ----->');
    writeln;
    write('Ingrese codigo de oficina: ');
    readln(id);
    BusquedaDicotomica(v, 1, dimL, id, pos);

    if (pos <> 0) then
        writeln('DNI del propietario de la oficina #', id, ': ', v[pos].dni)
    else writeln('No se encontró la oficina #', id);

    writeln;
end;


// Un módulo recursivo que retorne el monto total de las expensas
procedure CalcularExpensas(v: vector; dimL: integer);
    function GetExpensas(v: vector; dimL: integer): real;
    begin 
        if (dimL > 0) then
            GetExpensas := v[dimL].expensa + GetExpensas(v, dimL -1)
        else GetExpensas := 0;


    end;

var expensas: real;
begin 
    writeln;
    writeln('----- Modulo C ----->');
    writeln;

    expensas := GetExpensas(v, dimL);
    writeln('Monto total de las expensas: ', expensas:0:2);
    
end;



var 
    v: vector;
    dimL: integer;
    
Begin 
    CargarVector(v, dimL);
    OrdenarVector(v, dimL);
    writeln;

    writeln('.:Vector ordenado:.');
    ImprimirVector(v, dimL, true);

    Buscar(v, dimL);
    CalcularExpensas(v, dimL);
End.