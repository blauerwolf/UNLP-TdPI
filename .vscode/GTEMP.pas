{
    Un sistema de gestión de correos electrónicos desea manejar los correos
    recibidos por cada cliente. De cada cliente se conoce su código (1..1000), dirección
    de email y la cantidad de correos sin leer.

    Realizar un programa que invoque a módulos para:
    * Leer y almacenar los clientes en una estructura de datos eficiente parala
    búsqueda por código de cliente. La lectura finaliza al ingresar el cliente 1000.
    * Leer un código de cliente e informar la cantidad de correos sin leer.
    * Imprimir todos los códigos de cliente de mayor a menor.
    * Leer una dirección de correo e informar si existe un cliente con esa dirección.
}

program arboles;
const 
    maxCod = 1000;

type
    rango_cod = 1..maxCod;

    cliente = record 
        cod: integer;
        email: string;
        sin_leer: integer;
    end;

    arbol = ^nodo;
    nodo = record 
        dato: cliente;
        hd: arbol;
        hi: arbol;
    end;


procedure leerCliente(var c: cliente);
begin
    writeln('Ingrese el código entre 1 y 1000 (Fin = 1000'); readln(c.cod);
    writeln('Ingrese el email'); readln(c.email);
    writeln('Ingrese la cant. de mesajes sin leer'); readln(c.sin_leer);
end;


procedure agregar(var a: arbol; c: cliente);
var 
    aux: arbol;
begin 
    // Caso base: arbol vacío
    if (a = nil) then begin
        new(aux); 
        aux^.dato := c; 
        aux^.hd := nil; 
        aux^.hi := nil;
        a := aux;
    end
    else begin 
        if (a^.dato.cod > c.cod) then 
            agregar(a^.hi, c)
        else  agregar(a^.hd, c);
    end;
end;


procedure almacenarClientes(var a: arbol);
var 
    c: cliente;
begin 
    repeat
        leerCliente(c);
        agregar(a, c);
    until (c.cod = 1000);
end;

function cantidadDeCorreosSinLeer(cod: rango_cod; a: arbol): integer;
begin 
    // Arbol vacío (no existe cliente)
    if (a = nil) then 
        cantidadDeCorreosSinLeer := -1
    else begin 
        // Arbol no vacío.
        if (a^.dato.cod = cod) then 
            cantidadDeCorreosSinLeer := a^.dato.sin_leer
        else if (a^.dato.cod > cod) then
            cantidadDeCorreosSinLeer := cantidadDeCorreosSinLeer(cod, a^.hi)
        else cantidadDeCorreosSinLeer := cantidadDeCorreosSinLeer(cod, a^.hd);

    end;
end;


procedure imprimirDeMayorAMenor(a: arbol);
begin
    // Si es nil, no hago nada
    if (a <> nil) then begin
        imprimirDeMayorAMenor(a^.hd);
        writeln(a^.dato.cod);
        imprimirDeMayorAMenor(a^.hi);
    end;
end;


function existeEmail(a: arbol; email: string): boolean;
var 
    existe: boolean;
begin 
    if (a = nil) then 
        existeEmail := false
    else begin 
        if (a^.dato.email = email) then 
            existeEmail := true
        else begin 
            existe := existeEmail(a^.hi, email);
            if (not existe) then 
                existe := existeEmail(a^.hd, email);
            
            existeEmail := existe;
        end;
    end;
end;

var
    a: arbol;
    cod: rango_cod;
    email: string;
begin 
    almacenarClientes(a);
    writeln('Ingrese un código de cliente'); readln(cod);
    writeln('Correos sin leer: ', cantidadDeCorreosSinLeer(cod, a));
    imprimirDeMayorAMenor(a);
    writeln('Ingrese un email'); readln(email);
    if (existeEmail(a, email)) then 
        writeln('Existe!') else writeln('No existe');

end.



