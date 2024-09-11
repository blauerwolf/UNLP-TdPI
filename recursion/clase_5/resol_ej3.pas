{
    Un supermercado requiere el procesamiento de sus productos. De cada producto se
    conoce código, rubro (1..10), stock y precio unitario. Se pide:

    ✅ a) Generar una estructura adecuada que permita agrupar los productos por rubro. A su
    vez, para cada rubro, se requiere que la búsqueda de un producto por código sea lo
    más eficiente posible. El ingreso finaliza con el código de producto igual a 0.
    ✅ b) Implementar un módulo que reciba la estructura generada en a), un rubro y un código
    de producto y retorne si dicho código existe o no para ese rubro.
    ✅ c) Implementar un módulo que reciba la estructura generada en a), y retorne, para cada
    rubro, el código y stock del producto con mayor código.
    ✅ d) Implementar un módulo que reciba la estructura generada en a), dos códigos y
    retorne, para cada rubro, la cantidad de productos con códigos entre los dos valores
    ingresados.
}

program clase5_ej3;

type
    tipoRubro = 1..10;

    producto = record 
        codigo: integer;
        stock: integer;
        precio_u: real;
    end;

    arbol = ^nodo;
    nodo = record 
        dato: producto;
        HI: arbol;
        HD: arbol;
    end;

    vector = array[tipoRubro] of arbol;


// Generar una estructura adecuada que permita agrupar los productos por rubro. A su
// vez, para cada rubro, se requiere que la búsqueda de un producto por código sea lo
// más eficiente posible. El ingreso finaliza con el código de producto igual a 0.
procedure ModuloA(var v: vector);
    procedure InicializarVector(var v: vector);
    var i: integer;
    begin 
        for i := 1 to 10 do
            v[i] := nil;
    end;


    procedure GenerarProducto(var p: producto);
    begin 
        p.codigo := random(100);
        p.stock := random(10);
        p.precio_u := random * 10000;
    end;

    procedure Agregar(var a: arbol; dato: producto);
    begin 
        { en vez de usar una variable auxiliar nue, hago new de la variable de tipo arbol }
        if (a = nil) then begin 
            new(a);
            a^.dato := dato;
            a^.HI := nil;
            a^.HD := nil;
        end else 
            if (dato.codigo < a^.dato.codigo) then 
                Agregar(a^.HI, dato)
            else 
                Agregar(a^.HD, dato);

    end;


    procedure CargarProductos(var v: vector);
    var 
        p: producto;
        rubro: tipoRubro;

    begin
        rubro := random(10) + 1;
        GenerarProducto(p);

        while (p.codigo <> 0) do begin 
            Agregar(v[rubro], p);
            rubro := random(10) + 1;
            GenerarProducto(p);
        end;
    end;

    procedure ImprimirArbol(a: arbol);
    begin 
        if (a <> nil) then begin 
            ImprimirArbol(a^.HI);
            writeln(a^.dato.codigo, #9, a^.dato.stock, #09, a^.dato.precio_u:0:2);
            ImprimirArbol(a^.HD);
        end;
    end;


    procedure ImprimirVector(v: vector);
    var i: integer;
    begin 
        for i := 1 to 10 do begin 
            if (v[i] <> nil) then
            begin
                writeln;
                writeln('Rubro: ', i);
                ImprimirArbol(v[i]);
            end
            else writeln('Rubro: ', i, ' SIN PRODUCTOS');
        end;
    end;

begin 
    writeln;
    writeln('----- Modulo A ----->');
    writeln;
    InicializarVector(v);
    CargarProductos(v);
    ImprimirVector(v);
end;


// Implementar un módulo que reciba la estructura generada en a), un rubro y un código
// de producto y retorne si dicho código existe o no para ese rubro.
procedure ModuloB(v: vector);
    function Existe(a: arbol; cod: integer): boolean;
    begin 
        // Caso base, arbol vacio.
        if (a = nil) then Existe := false
        else begin 
            if (a^.dato.codigo = cod) then Existe := true
            else begin 
                if (a^.dato.codigo > cod) then 
                    Existe := Existe(a^.HI, cod)
                else Existe := Existe(a^.HD, cod);
            end;
        end;
    end;

var 
    rubro: tipoRubro;
    cod: integer;
    e: boolean;

begin 
    writeln;
    writeln('----- Modulo B ----->');
    writeln;
    write('Intrese un rubro (1..10): ');
    readln(rubro);
    write('Ingrese un codigo de producto: ');
    readln(cod);
    e := Existe(v[rubro], cod);
    if (e) then
        writeln('El codigo ', cod, ' para el rubro ', rubro, ' se encuentra registrado')
    else 
        writeln('El codigo ', cod, ' para el rubro ', rubro, ' NO se en cuentra registrado');
    
end;


// Implementar un módulo que reciba la estructura generada en a), y retorne, para cada
// rubro, el código y stock del producto con mayor código.
procedure ModuloC(v: vector);
    procedure GetTopProduct(a: arbol; var p: producto);
    begin 
        if (a <> nil) then begin
            if (a^.HD = nil) then 
                p := a^.dato
            else
                GetTopProduct(a^.HD, p);
        end;
    end;


    procedure ImprimirMaximos(v: vector);
    var 
        i: integer;
        p: producto;
    begin 
        for i := 1 to 10 do begin 
            if (v[i] <> nil) then begin 
                GetTopProduct(v[i], p);
                writeln('Rubro: ', i, '. MAX COD: ', p.codigo, ' STOCK: ', p.stock);
            end 
            else writeln('Rubro ', i, ' SIN PRODUCTOS');

        end;
        writeln;
    end;
begin 
    writeln;
    writeln('----- Modulo C ----->');
    writeln;
    ImprimirMaximos(v);
end;


// Implementar un módulo que reciba la estructura generada en a), dos códigos y
// retorne, para cada rubro, la cantidad de productos con códigos entre los dos valores
// ingresados.
procedure ModuloD(v: vector);
    function CantidadEntre(a: arbol; cod1, cod2: integer): integer;
    var cant: integer;
    begin 
        if (a = nil) then CantidadEntre := 0
        else begin 
            if (a^.dato.codigo > cod1) and (a^.dato.codigo < cod2) then 
                cant := 1
            else 
                cant := 0;

            Cantidadentre := cant
                + CantidadEntre(a^.HI, cod1, cod2)
                + CantidadEntre(a^.HD, cod1, cod2);
        end;
    end;

    procedure ImprimirProductos(v: vector; cod1, cod2: integer);
    var i, cantidad: integer;
    begin 
        for i := 1 to 10 do begin
            cantidad := CantidadEntre(v[i], cod1, cod2);
            writeln('Rubro ', i, '. Productos entre los codigos ', cod1, ' y ', cod2, ': ', cantidad);
        end;
        writeln;
    end;


var 
    cod1, cod2: integer;
begin 
    writeln;
    writeln('----- Modulo D ----->');
    writeln;
    write('Ingrese primer codigo: ');
    readln(cod1);
    write('Ingrese segundo codigo: ');
    readln(cod2);
    ImprimirProductos(v, cod1, cod2);

end;


var 
    v: vector;
Begin
    ModuloA(v);
    ModuloB(v);
    ModuloC(v);
    ModuloD(v);

End.