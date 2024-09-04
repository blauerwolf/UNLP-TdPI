{
    Descargar el programa ImperativoEjercicioClase3.pas de la clase anterior e incorporar lo
    necesario para:
    i. Informar el número de socio más grande. Debe invocar a un módulo recursivo que
    retorne dicho valor.
    ii. Informar los datos del socio con el número de socio más chico. Debe invocar a un
    módulo recursivo que retorne dicho socio.
    iii. Leer un valor entero e informar si existe o no existe un socio con ese valor. Debe
    invocar a un módulo recursivo que reciba el valor leído y retornar verdadero o falso.
    iv. Leer e informar la cantidad de socios cuyos códigos se encuentran comprendidos
    entre los valores leídos. Debe invocar a un módulo recursivo que reciba los valores
    leídos y retorne la cantidad solicitada.
}


Program ImperativoClase3;

type 
  rangoEdad = 12..100;

  cadena15 = string [15];

  socio = record
    numero: integer;
    nombre: cadena15;
    edad: rangoEdad;
  end;

  arbol = ^nodoArbol;
  nodoArbol = record
    dato: socio;
    HI: arbol;
    HD: arbol;
  end;
     
procedure GenerarArbol (var a: arbol);
{ Implementar un modulo que almacene informacion de socios de un club en un arbol binario de busqueda. De cada socio se debe almacenar numero de socio, 
nombre y edad. La carga finaliza con el numero de socio 0 y el arbol debe quedar ordenado por numero de socio. La informacion de cada socio debe generarse
aleatoriamente. }

  Procedure CargarSocio (var s: socio);
  var vNombres:array [0..9] of string= ('Ana', 'Jose', 'Luis', 'Ema', 'Ariel', 'Pedro', 'Lena', 'Lisa', 'Martin', 'Lola'); 
  
  begin
    s.numero:= random (51) * 100;
    If (s.numero <> 0)
    then begin
           s.nombre:= vNombres[random(10)];
           s.edad:= 12 + random (79);
         end;
  end;  
  
  Procedure InsertarElemento (var a: arbol; elem: socio);
  Begin
    if (a = nil) 
    then begin
           new(a);
           a^.dato:= elem; 
           a^.HI:= nil; 
           a^.HD:= nil;
         end
    else if (elem.numero < a^.dato.numero) 
         then InsertarElemento(a^.HI, elem)
         else InsertarElemento(a^.HD, elem); 
  End;

var unSocio: socio;  
Begin
 writeln;
 writeln ('----- Ingreso de socios y armado del arbol ----->');
 writeln;
 a:= nil;
 CargarSocio (unSocio);
 while (unSocio.numero <> 0)do
  begin
   InsertarElemento (a, unSocio);
   CargarSocio (unSocio);
  end;
 writeln;
 writeln ('-------------------------------------------------');
 writeln;
end;

procedure InformarSociosOrdenCreciente (a: arbol);
{ Informar los datos de los socios en orden creciente. }
  
  procedure InformarDatosSociosOrdenCreciente (a: arbol);
  begin
    if ((a <> nil) and (a^.HI <> nil))
    then InformarDatosSociosOrdenCreciente (a^.HI);
    writeln ('Numero: ', a^.dato.numero, ' Nombre: ', a^.dato.nombre, ' Edad: ', a^.dato.edad);
    if ((a <> nil) and (a^.HD <> nil))
    then InformarDatosSociosOrdenCreciente (a^.HD);
  end;

Begin
 writeln;
 writeln ('----- Socios en orden creciente por numero de socio ----->');
 writeln;
 InformarDatosSociosOrdenCreciente (a);
 writeln;
 writeln ('-------------------------------------------------');
 writeln;
end;


procedure InformarNumeroSocioConMasEdad (a: arbol);
{ Informar el numero de socio con mayor edad. Debe invocar a un modulo recursivo que retorne dicho valor.  }

     procedure actualizarMaximo(var maxValor,maxElem : integer; nuevoValor, nuevoElem : integer);
	begin
	  if (nuevoValor >= maxValor) then
	  begin
		maxValor := nuevoValor;
		maxElem := nuevoElem;
	  end;
	end;
	procedure NumeroMasEdad (a: arbol; var maxEdad: integer; var maxNum: integer);
	begin
	   if (a <> nil) then
	   begin
		  actualizarMaximo(maxEdad,maxNum,a^.dato.edad,a^.dato.numero);
		  numeroMasEdad(a^.hi, maxEdad,maxNum);
		  numeroMasEdad(a^.hd, maxEdad,maxNum);
	   end; 
	end;

var maxEdad, maxNum: integer;
begin
  writeln;
  writeln ('----- Informar Numero Socio Con Mas Edad ----->');
  writeln;
  maxEdad := -1;
  NumeroMasEdad (a, maxEdad, maxNum);
  if (maxEdad = -1) 
  then writeln ('Arbol sin elementos')
  else begin
         writeln;
         writeln ('Numero de socio con mas edad: ', maxNum);
         writeln;
       end;
  writeln;
  writeln ('-------------------------------------------------');
  writeln;
end;

procedure AumentarEdadNumeroImpar (a: arbol);
{Aumentar en 1 la edad de los socios con edad impar e informar la cantidad de socios que se les aumento la edad.}
  
  function AumentarEdad (a: arbol): integer;
  var resto: integer;
  begin
     if (a = nil) 
     then AumentarEdad:= 0
     else begin
            resto:= a^.dato.edad mod 2;
            if (resto = 1) then a^.dato.edad:= a^.dato.edad + 1;
            AumentarEdad:= resto + AumentarEdad (a^.HI) + AumentarEdad (a^.HD);
          end;  
  end;

begin
  writeln;
  writeln ('----- Cantidad de socios con edad aumentada ----->');
  writeln;
  writeln ('Cantidad: ', AumentarEdad (a));
  writeln;
  writeln;
  writeln ('//////////////////////////////////////////////////////////');
  writeln;
end;


procedure InformarSociosOrdenDecreciente(a: arbol);
begin 
    // Si es nil, no hago nada
    if (a <> nil) then begin
        InformarSociosOrdenDecreciente(a^.HD);
        writeln(a^.dato.numero);
        InformarSociosOrdenDecreciente(a^.HI);
    end;
end;


function InformarExistenciaNombreSocio(a: arbol; nombre: cadena15): boolean;
var 
    existe: boolean;
begin 
    if (a = nil) then 
        InformarExistenciaNombreSocio := false
    else begin 
        if (a^.dato.nombre = nombre) then 
            InformarExistenciaNombreSocio := true
        else begin 
            existe := InformarExistenciaNombreSocio(a^.HI, nombre);
            if (not existe) then 
                existe := InformarExistenciaNombreSocio(a^.HD, nombre);
            
            InformarExistenciaNombreSocio := existe;
        end;
    end;
end;


function InformarCantidadSocios(a: arbol): integer;
begin 

    if (a = nil) then InformarCantidadSocios := 0    // Caso base
    else 
      InformarCantidadSocios := 1 + InformarCantidadSocios(a^.HI) 
                                + InformarCantidadSocios(a^.HD);

end;


function sumarEdades(a: arbol): integer;
begin 
  if (a = nil) then sumarEdades := 0
  else sumarEdades := a^.dato.edad + sumarEdades(a^.HI)
                      + sumarEdades(a^.HD);
end;


function InformarPromedioDeEdad(suma, total: integer): real;
begin InformarPromedioDeEdad := suma / total; end;


// Informar el número de socio más grande. Debe invocar a un módulo recursivo que
// retorne dicho valor.
procedure ModuloA(a: arbol);
    procedure MaxCodigo (a: arbol; var maxCod: integer);
		procedure ActualizarMaximo (c: integer; var maxCod: integer);
		begin
			if (c > maxCod) then maxCod := c;
		end;
	
	begin
		if (a <> nil) then begin
			if (a^.HI <> nil) then 
				MaxCodigo(a^.HI, maxCod);
			ActualizarMaximo (a^.dato, maxCod);
			if (a^.HD <> nil) then
				MaxCodigo(a^.HD, maxCod);
		end;
	end;


    function ObtenerCodigoMasGrande(a: arbol): integer;
    var maxCod: integer;
    begin 
        // Caso base: el árbol está vacío.
        if (a = nil) then ObtenerCodigoMasGrande := 0
        else begin 
            maxCod := a^.dato.numero;
        end;
    end;


var maxCodigo: integer;
begin 
    writeln;
    writeln ('----- Modulo A ----->');
    writeln;
    maxCodigo := ObtenerCodigoMasGrande(a);

    maxVentas:= -1;
	MaxCodigo(a, maxCod, maxVentas);
	GetCodigoTopProducto := maxCod;

end;


procedure ModuloB(a: arbol);
begin 
end;


procedure ModuloC(a: arbol);
begin 
end;


procedure ModuloD(a: arbol);
begin 
end;

{ PROGRAMA PRINCIPAL }
var 
  a: arbol; 
  nom: cadena15;
  sumaEdades, totSocios: integer;
Begin
  randomize;
  GenerarArbol (a);
  InformarSociosOrdenCreciente (a);
  InformarSociosOrdenDecreciente (a); 
  InformarNumeroSocioConMasEdad (a);
  AumentarEdadNumeroImpar (a);

  // Informo la existencia de un nombre de socio:
  write('Ingrese un nombre de socio: '); readln(nom);
  if (InformarExistenciaNombreSocio(a, nom)) then 
    writeln('El socio ', nom, ' se encuentra registrado.')
  else 
    writeln('El socio ', nom, ' NO se encuentra registrado.');

  totSocios := InformarCantidadSocios(a);
  writeln;
  writeln('Total de Socios: ', totSocios);
  writeln;
  sumaEdades := sumarEdades(a);
  writeln('Promedio de edades: ', InformarPromedioDeEdad(sumaEdades, totSocios):0:2);

  ModuloA(a);
  ModuloB(a);
  ModuloC(a);
  ModuloD(a);
  
End.

