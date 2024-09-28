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

public class Ejercicio3 {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        int dias = 0;       // días del casting
        int turnos = 0; // cantidad de turnos de cada día del casting.
        
        // Matriz para almacenar los turnos del casting
        Persona[][] matriz = new Persona[5][8];
        
        
        // Inicializo el generador aleatorio
        GeneradorAleatorio.iniciar();        
        
        // Leo el primer nombre
        String nombre = GeneradorAleatorio.generarString(3);
               
        
        // Carga de la matriz
        // Como máxmo da 5 loops X 8 loops = 40
        while ((dias < 5) && (!nombre.equals("ZZZ"))) {
            turnos = 0;            
            while((turnos < 8) && (!nombre.equals("ZZZ"))) {
                
                int dni = GeneradorAleatorio.generarInt(10000);
                int edad = GeneradorAleatorio.generarInt(120);
                matriz[dias][turnos] = new Persona(nombre, dni, edad);
                
                nombre = GeneradorAleatorio.generarString(3);
                turnos++;
            }
            
            nombre = GeneradorAleatorio.generarString(35);
            dias++;
        }

        
        // b - Informo
        for (int i = 0; i < dias; i++) {
                        
            System.out.println("Dia: " + (i + 1));
            System.out.println("----------");
            for (int j = 0; j < turnos; j++) {
                System.out.println("Turno " + turnos + ": " + matriz[i][j].getNombre());
            }
            System.out.println();
        }
    }
}
