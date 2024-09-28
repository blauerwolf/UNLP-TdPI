/*
    Utilizando la clase Persona. Realice un programa que almacene en un vector a lo sumo
    15 personas. La información (nombre, DNI, edad) se debe generar aleatoriamente hasta
    obtener edad 0. Luego de almacenar la información:
    - Informe la cantidad de personas mayores de 65 años.
    - Muestre la representación de la persona con menor DNI
 */
package tema2;

/**
 *
 * @author Ernesto Ardenghi
 */

import PaqueteLectura.GeneradorAleatorio;

public class Ejercicio2 {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        // Inicializo el generador aleatorio
        GeneradorAleatorio.iniciar();
        
        // Vector
        int DF = 15;
        int DL;
        Persona[] vector = new Persona[DF];
        
        DL = 0;
        
        int edad = GeneradorAleatorio.generarInt(120);
        while ((edad != 0) && (DL < 15)) {
            String nombre = GeneradorAleatorio.generarString(35);
            int dni = GeneradorAleatorio.generarInt(10000);
            
            vector[DL] = new Persona(nombre, dni, edad);
            DL++;            
            
            edad = GeneradorAleatorio.generarInt(120);
        }
        
        Persona menor = new Persona();
        int cantidadPersonas = 0;
        int min = 99999;        // DNI fuera de rango para buscar el min
        
        for(int i = 0; i < DL; i++) {
            if (vector[i].getEdad() > 65)
                cantidadPersonas++;
            
            if (vector[i].getDNI() < min) {
                min = vector[i].getDNI();
                menor = vector[i];
            }               
        }
        
        System.out.println("Hay " + cantidadPersonas + " personas mayores de 65 años");
        System.out.println();
        System.out.println("Persona con menor DNI:");
        System.out.println(menor.toString());
    }
    
}
