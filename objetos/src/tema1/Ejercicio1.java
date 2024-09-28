/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package tema1;

/**
 *
 * @author Ernesto Ardenghi
 */

import PaqueteLectura.GeneradorAleatorio;

public class Ejercicio1 {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        GeneradorAleatorio.iniciar();
        
        int DF=12;  
        int [] tabla = new int[DF]; // indices de 0 a 10
        int i;
        for (i=0;i<DF;i++) 
            tabla[i]=2*i;
        
        int aleatorio = GeneradorAleatorio.generarInt(12);
        
        while (aleatorio != 11) {
            aleatorio = GeneradorAleatorio.generarInt(12);
            System.out.println("2 x " + aleatorio + " = " + tabla[aleatorio]);
        }  
    }
}
