program ProgramaVectores;
const dimF = 50;
type 
    vector = array[1..dimF] of integer;

{ Carga un vector con a lo sumo 50 elementos con números aleatorios hasta que salga 0 }
procedure CargarVector(var v:vector; var dimL:integer; min,max:integer);
var ale: integer;
begin 
    randomize;
    ale := random(max) + min;

    while (ale <> 0) and (dimL < dimF) do begin 
        dimL := dimL + 1;
        v[dimL] := ale;

        ale := random(max) + min;
    end;
end;

procedure ImprimirVector(v: vector; dimL: integer);
var i: integer;
begin 
    write('Valores: ');

    for i := 1 to dimL do 
        write('| ', v[i], ' ');

    write('|');
    writeln;
    writeln;
end;

procedure ImprimirVectorReverso(v: vector; dimL: integer);
var i: integer;
begin
    write('Valores: ');

    for i := dimL downto 1 do 
        write('| ', v[i], ' ');

    write('|');
    writeln;
    writeln;
end;

var 
    min, max, dimL: integer;
    v: vector;
begin
    write('Ingrese el mínimo: ');
    readln(min);
    write('Ingrese el máximo: ');
    readln(max);
    readln;

    CargarVector(v, dimL, min, max);
    ImprimirVector(v, dimL);
    ImprimirVectorReverso(v, dimL);
    readln;
end.