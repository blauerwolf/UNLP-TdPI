/*
    Escriba un programa que lea las alturas de los 15 jugadores de un equipo de
    básquet y las almacene en un vector. Luego informe:
    - la altura promedio
    - la cantidad de jugadores con altura por encima del promedio
    NOTA: Dispone de un esqueleto para este programa en Ej02Jugadores.java
 */
package tema1;

/**
 *
 * @author Ernesto Ardenghi
 */

//Paso 1: Importar la funcionalidad para lectura de datos
import PaqueteLectura.Lector;

public class Ejercicio2 {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        
        //Paso 2: Declarar la variable vector de double 
        int DF = 15, cantidad = 0;  
        double [] tabla;
        
        //Paso 3: Crear el vector para 15 double 
        tabla = new double[DF]; // indices de 0 a 14
          
        //Paso 4: Declarar indice y variables auxiliares a usar
        int i;
        double altura = 0, sumaAlturas = 0, promedio = 0;
                
        //Paso 6: Ingresar 15 numeros (altura), cargarlos en el vector, ir calculando la suma de alturas
        for (i = 0; i < 15; i++) {
            System.out.print("Ingrese altura #" + i + ": ");
            altura = Lector.leerDouble();
            tabla[i] = altura;
            sumaAlturas += altura;
        }
        
        //Paso 7: Calcular el promedio de alturas, informarlo
        promedio = sumaAlturas / DF;
        System.out.println("El promedio de alturas es: " + String.format("%.2f", sumaAlturas / DF));
        
        //Paso 8: Recorrer el vector calculando lo pedido (cant. alturas que están por encima del promedio)
        for (i = 0; i < 15; i++) {
            if (tabla[i] > promedio) {
                cantidad += 1;
            }
        }
        
        //Paso 9: Informar la cantidad.
        System.out.println(cantidad + " jugadores exceden la altura promedio (" + String.format("%.2f", promedio) + ")");
    }
}
