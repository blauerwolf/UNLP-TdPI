program recursion;
const 
    N = 80;
type 
    vector = array[1..N] of integer;


procedure imprimirNumerosRecursivo(N: integer);
begin    
    // Reduzco el problema
    if (N > 1) then 
        imprimirNumerosRecursivo(N - 1);

    // Caso base
    writeln(N);
end;

procedure cargarVector(var v: vector; var dimL: integer);
begin 
    v[1] := 100;
    v[2] := 101;
    v[3] := 102;
    v[4] := 103;
    dimL := 4;
end;

procedure imprimirVector(v: vector; dimL: integer);
var i: integer;
begin 
    for i := 1 to dimL do 
        writeln(v[i]);
end;

procedure imprimirVectorRecursivo(v: vector; dimL: integer);
begin 
    // Caso base, vector vacio, dimL = 0
    if (dimL > 0) then 
    begin 
        imprimirVectorRecursivo(v, dimL - 1);
        writeln(v[dimL]);
    end;
end;

procedure imprimirVectorRecursivoInverso(v: vector; dimL: integer);
begin 
    // Caso base, vector vacio, dimL = 0
    if (dimL > 0) then 
    begin 
        writeln(v[dimL]);
        imprimirVectorRecursivoInverso(v, dimL - 1);
    end;
end;


var 
    num, dimL: integer;
    v: vector;

begin 
    cargarVector(v, dimL);
    imprimirVector(v, dimL);
    writeln;
    imprimirVectorRecursivo(v, dimL);
    writeln;
    imprimirVectorRecursivoInverso(v, dimL);
end.