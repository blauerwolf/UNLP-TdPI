{
    Un sistema de gestión de correos electrónicos desea manejar los correos recibidos por cada cliente. 
    De cada cliente se conoce su código (1..1000), dirección de email y todos los mensajes 
    de correo que ha recibido. 
    De cada mensaje conoce la dirección del emisor, la fecha de envío, el asunto, el texto y si ya fue leído.

    Realizar un programa que invoque a módulos para:
        *   Leer y almacenar los correos electrónicos en una estructura de datos eficiente para 
            la búsqueda por código de cliente. La lectura finaliza al ingresar el cliente 0.
            De cada correo se leel el id del cliente, su dirección de correo y toda la información
            del mensaje. La información debe quedar agrupada por cliente.
        *   Leer un código de cliente e informar la cantidad de correos sin leer.
        *   Leer una dirección de correo e informar la cantidad de correos enviados
            desde dicha dirección.
}

program abb;
const 
    maxCod = 1000;

type
    rango_cod = 1..maxCod;

    mensaje = record    
        emisor: string;
        texto: string;
        asunto: string;
        fecha: string;
        leido: boolean;
    end;

    cliente = record 
        cod: rango_cod;
        email: string;
    end;

    mensajeLeido = record  
        msj: mensaje;
        cli: cliente;
    end;

    lista = ^nodo;
    nodo = record 
        dato: mensaje;
        sig: lista;
    end;

    datoCliente = record 
        cli: cliente;
        mensajes: lista;
    end;

    arbol = ^nodo;
    nodo = record 
        dato: datoCliente;
        hd: arbol;
        hi: arbol;
    end;


procedure leerMensaje(var m: mensajeLeido);
var i: integer;
begin 
    readln(m.cli.cod);
    readln(m.cli.email);
    readln(m.msg.emisor);
    readln(m.msg.texto);
    readln(m.msg.asunto);
    readln(m.msg.fecha);
    readln(i);
    writeln('Ingrese 1 para indicar que fue leido, o cualquier otro valor en caso contrario');
    m.msg.leido := (i = 1);
end;


procedure agregar(var a: arbol; m: mensajeLeido);
var 
    aux: arbol;
begin 
    if (a = nil) then begin // árbol vacío
        new(aux);
        aux^.dato.cli := nil;
        aux^.dato.mensajes := nil;
        agregarAdelante(aux^.dato.mensajes, m.msj);
        aux^.hi := nil;
        aux^.hd := nil;
        a := aux;
    end 
    else begin 
        if (a^.dato.cod = m.cli.cod) then // Cliente encontrado
            agregarAdelante(a^.dato.mensajes, m.msj)
        else
            if (a^.dato.cod > m.cli.cod) then
                agregar(a^.hi, m);
            else 
                agregar(a^.hd, m);
        
    end;
end;


{ Recorre una lista y retorna el valor de no leidos }
function contarSinLeer(l: lista): boolean;
begin 
    // TODO
end;



function cantidadDeCorreosSinLeer(cod: rango_cod; a: arbol): integer;
var 
    retorno: integer;
begin 
    if (a = nil) then // caso base
        retorno := 1;
    else begin 
        if (a^.dato.cli.cod = cod) then 
            retorno := contarSinLeer(a^.dato.mensajes);
        else if (a^.dato.cod > cod) then 
            retorno := cantidadDeCorreosSinLeer(cod, a^.hi)
        else 
            retorno := cantidadDeCorreosSinLeer(cod, a^.hd);
    end;
    cantidadDeCorreosSinLeer := retorno;
end;


function contarSinDesdeDir(l: lista; dir: string): integer;
begin 
    // TODO
end;

function contarCorreosDesdeDireccion(a: arbol; dir: string): integer;
begin 
    //
    if (n = nil) then 
        contarCorreosDesdeDireccion := 0
    else 
        contarCorreosDesdeDireccion := contarSinDesdeDir(a^.dato.mensajes)
            + contarCorreosDesdeDireccion(a^.hi, dir)
            + contarCorreosDesdeDireccion(a^.hd, dir);

    {
        // o también usando variables:
        else begin
            clienteActual := contarSinDesdeDir(a^.dato.mensajes.dir);
            subarbolIzq := contarCorreosDesdeDireccion(a^.hi, dir);
            subarbolDer := contarCorreosDesdeDireccion(a^.hd, dir);
            contarCorreosDesdedireccion := clienteActual + subarbolIzq + subarbolDer;
        end;
    }
end;


var 
    a: arbol;

Begin 

End.