/*
    Un edificio de oficinas está conformado por 8 pisos (1..8) y 4 oficinas por piso
    (1..4). 

    Realice un programa que permita informar la cantidad de personas que
    concurrieron a cada oficina de cada piso. 

    Para esto, simule la llegada de personas al edificio de la siguiente manera: 
    a cada persona se le pide el nro. de piso y nro. de oficina a la cual 
    quiere concurrir. 

    La llegada de personas finaliza al indicar un nro. de piso 9. 
    Al finalizar la llegada de personas, informe lo pedido.
 */
package tema1;

/**
 *
 * @author Ernesto Ardenghi
 */

import PaqueteLectura.GeneradorAleatorio;


public class Ejercicio4 {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        int DFi = 8, DFj = 4;
        int i = 0, j = 0;
        
        int[][] edificio = new int[DFi][DFj];
        
        for (i = 0; i < DFi; i++) {
            for (j = 0; j < DFj; j++)
                edificio[i][j] = 0;
        }
        
        GeneradorAleatorio.iniciar();        
        i = GeneradorAleatorio.generarInt(9) + 1;      // Genera numeros entre 1 y 9
        while (i != 9) {
            j = GeneradorAleatorio.generarInt(4);
            
            edificio[i - 1][j] += 1;
            i = GeneradorAleatorio.generarInt(9) + 1;
        }  
        
        for (i = 0; i < DFi; i++) {
            System.out.println("Piso " + (i+1));
            for (j = 0; j < DFj; j++) {
                System.out.println("Oficina " + (j + 1) + ": " + edificio[i][j]);
            }
            System.out.println();
        }
        
        
    }
    
}
