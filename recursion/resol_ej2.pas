{
    2.- Escribir un programa que:
    ✅ a. Implemente un módulo recursivo que genere y retorne una lista de números enteros
    “random” en el rango 100-200. Finalizar con el número 100.
    ✅ b. Un módulo recursivo que reciba la lista generada en a) e imprima los valores de la lista en el
    mismo orden que están almacenados.
    ✅ c. Implemente un módulo recursivo que reciba la lista generada en a) e imprima los valores de
    la lista en orden inverso al que están almacenados.
    ✅ d. Implemente un módulo recursivo que reciba la lista generada en a) y devuelva el mínimo
    valor de la lista.
    ✅ e. Implemente un módulo recursivo que reciba la lista generada en a) y un valor y devuelva
    verdadero si dicho valor se encuentra en la lista o falso en caso contrario.
}

program ejercicio2;

type 
    lista = ^nodo;
    nodo = record
        dato: integer;
        sig: lista;
    end;

procedure InicializarLista(var l: lista);
begin l := nil; end;


procedure AgregarAdelante(var l: lista; num: integer);
var nue: lista;
begin 
    new(nue); 
    nue^.dato := num; 
    nue^.sig := l;
    l := nue; 
end;


procedure GenerarLista(var l:lista);
var num: integer;
begin 
    num := random(101) + 100;       // Números entre 100 y 200
    AgregarAdelante(l, num);

    if (num <> 100) then
        GenerarLista(l^.sig);
end;


procedure ImprimirLista(l: lista);
    procedure imprimir(pri: lista);
    begin 
        if (pri <> nil) then begin 
            write('| ', pri^.dato, ' ');
            imprimir(pri^.sig);
        end;
    end;

begin 
    imprimir(l);
    write('|');
    writeln;
    writeln;
end;


procedure ImprimirListaReverso(l:lista);
procedure imprimir(pri: lista);
    begin 
        if (pri <> nil) then begin
            
            imprimir(pri^.sig); 
            write('| ', pri^.dato, ' ');
        end;
    end;

begin 
    imprimir(l);
    write('|');
    writeln;
    writeln;
end;


function Min(a, b: integer): integer;
begin
if (a > b) then
    Min := b
else
    Min := a;
end;


function ObtenerMinimo(l: lista): integer;
begin 
    if (l <> nil) then begin 
        ObtenerMinimo := Min(ObtenerMinimo(l^.sig), l^.dato);
    end;
end;

function BuscarValor(l: lista; valor: integer): boolean;
begin 
  if (l = nil) then 
    BuscarValor := false
  else if (l^.dato = valor) then
    BuscarValor := true
  else
    BuscarValor := BuscarValor(l^.sig, valor);
end;


Var 
    l: lista;
    valor: integer;
Begin 
    //randomize;
    InicializarLista(l);
    GenerarLista(l);
    writeln;
    writeln('Imprime lista orden directo: ');
    ImprimirLista(l);
    writeln;
    writeln('Imprime lista orden reverso: ');
    ImprimirListaReverso(l);
    writeln('El mínimo es: ', ObtenerMinimo(l));
    writeln;
    write('Ingrese un valor a buscar: ');
    readln(valor);
    if (BuscarValor(l, valor)) then
      writeln('El valor ', valor, ' se encuentra en la lista')
    else 
      writeln('El valor ', valor, ' NO se encuentra en la lista');
End.