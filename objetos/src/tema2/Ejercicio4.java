/*
    Se realizará un casting para un programa de TV. El casting durará a lo sumo 5 días y en
    cada día se entrevistarán a 8 personas en distinto turno.

    a) Simular el proceso de inscripción de personas al casting. A cada persona se le pide
    nombre, DNI y edad y se la debe asignar en un día y turno de la siguiente manera: las
    personas primero completan el primer día en turnos sucesivos, luego el segundo día y así
    siguiendo. La inscripción finaliza al llegar una persona con nombre “ZZZ” o al cubrirse los
    40 cupos de casting.

    Una vez finalizada la inscripción:
    b) Informar para cada día y turno asignado, el nombre de la persona a entrevistar.
    NOTA: utilizar la clase Persona. Pensar en la estructura de datos a utilizar. Para comparar
    Strings use el método equals.
 */
package tema2;

/**
 *
 * @author Ernesto Ardenghi
 */

import PaqueteLectura.*;

public class Ejercicio4 {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        int maxTurnos = 40; // cantidad de turnos de cada día del casting.
        
        // Lo uso para pruebas, para acotar la generacion de nombres, etc
        int nombreLength = 3;
        String nombreCorte = "ZZZ";
        
        
        // Matriz para almacenar los turnos del casting
        Persona[][] matriz = new Persona[5][8];
        
        // Uso un vector auxiliar para registrar las dimL usadas.
        int[] vDimL = new int[5];
        
        
        // Inicializo el generador aleatorio
        GeneradorAleatorio.iniciar();   
        
        // Inicializo el vector de dimL's. -1 es que está vacio. 0 ya es la primer posicion.
        for (int i = 0; i < 5; i++) 
            vDimL[i] = -1;
        
        // Leo el primer nombre
        String nombre = GeneradorAleatorio.generarString(nombreLength);
        
        // Se simula el ingreso del día deseado
        int dia = GeneradorAleatorio.generarInt(5);
        int dimL = 0;
        
        while (!nombre.equals(nombreCorte) && dimL < maxTurnos) {
            
            System.out.println("Turnos asignados: " + dimL);
            
            int dni = GeneradorAleatorio.generarInt(10000);
            int edad = GeneradorAleatorio.generarInt(120);
            
            if (vDimL[dia] < (8 - 1)) {
                // Hay lugar. Ingremento la dimL de ese dia.
                vDimL[dia]++;
                
                // Agrego a la matriz
                matriz[dia][vDimL[dia]] = new Persona(nombre, dni, edad);
                
                // Incremento el contados de cupos asignados
                dimL++;
                
            } else {
                System.out.println("Estimado " + nombre + ": NO HAY TURNOS DISPONIBLES PARA EL DÍA " + (dia + 1));
            }
            
            // Consulto el siguiente nombre y día
            nombre = GeneradorAleatorio.generarString(nombreLength);
            dia = GeneradorAleatorio.generarInt(5);
            
                                               
        }
        
        System.out.println("dimL turnos: " + dimL + ". Ultimo nombre: " + nombre );
        System.out.println();
          

        // b - Informo
        for (int i = 0; i < 5; i++) {
            
            System.out.println("Dia: " + (i + 1) + ". Turnos: " + (vDimL[i] + 1));
            System.out.println("----------------------");
                        
            for (int j = 0; j <= vDimL[i]; j++) {
                System.out.println("Turno " + j + ". Sr/Sra: " + matriz[i][j].getNombre());
                  
            }
            System.out.println();
        }
    }
}
