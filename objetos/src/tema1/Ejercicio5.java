/*
    El dueño de un restaurante entrevista a cinco clientes y les pide que califiquen
    (con puntaje de 1 a 10) los siguientes aspectos: (0) Atención al cliente (1) Calidad
    de la comida (2) Precio (3) Ambiente.
    Escriba un programa que lea desde teclado las calificaciones de los cinco clientes
    para cada uno de los aspectos y almacene la información en una estructura. Luego
    imprima la calificación promedio obtenida por cada aspecto.
 */
package tema1;

/**
 *
 * @author Ernesto Ardenghi
 */

import PaqueteLectura.Lector;

public class Ejercicio5 {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        int DFi = 5, DFj = 4;
        int i, j;
        
        // 5 filas, 4 columnas
        int [][] calificaciones = new int [DFi][DFj];
        String [] titulos = {"Atención al cliente", "Calidad de la Comida", "Precio", "Ambiente"};
        
        System.out.println("Ingrese calificaciones del 1 al 10: ");
        for (i = 0; i < DFi; i++) {
            System.out.println("Cliente " + (i + 1));
            System.out.println("-------------");
            
            for (j = 0; j < DFj; j++) {
                System.out.print(titulos[j] + ": ");
                calificaciones[i][j] = Lector.leerInt();
            }
            
            System.out.println();
        }
        
        // Recorro la matriz y calculo el primedio.
        double acum;
        System.out.println("Promedios: ");
        
        // Recorro por "tema"
        for (j = 0; j < DFj; j++) {
            acum = 0;
            
            for (i = 0; i < DFi; i++) {
                acum += calificaciones[i][j];
            }
            
            System.out.println(titulos[j] + ": " + String.format("%.2f", acum/DFi));
        }     
    } 
}
