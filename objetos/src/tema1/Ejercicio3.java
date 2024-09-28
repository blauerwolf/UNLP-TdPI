/*
    Escriba un programa que defina una matriz de enteros de tamaño 5x5. Inicialice
    la matriz con números aleatorios entre 0 y 30.
    Luego realice las siguientes operaciones:
    - Mostrar el contenido de la matriz en consola.
    - Calcular e informar la suma de los elementos de la fila 1
    - Generar un vector de 5 posiciones donde cada posición j contiene la suma
    de los elementos de la columna j de la matriz. Luego, imprima el vector.
    - Leer un valor entero e indicar si se encuentra o no en la matriz. En caso de
    encontrarse indique su ubicación (fila y columna) en caso contrario
    imprima “No se encontró el elemento”.
    NOTA: Dispone de un esqueleto para este programa en Ej03Matrices.java
 */
package tema1;

/**
 *
 * @author Ernesto Ardenghi
 */

//Paso 1. importar la funcionalidad para generar datos aleatorios
import PaqueteLectura.GeneradorAleatorio;
import PaqueteLectura.Lector;


public class Ejercicio3 {

    /**
     * @param args the command line arguments
     */
    
    // Método público para buscar un valor en la matriz
    public boolean buscarValor(int[][] m, int valor) {
    
        for (int i = 0; i < 5; i++) {
            for (int j = 0; j < 5; j++) {
                if (m[i][j] == valor) {
                    return true;  // Si se encuentra el valor, devolver true
                }
            }
        }
        return false;  // Si el valor no se encuentra, devolver false
    }
       
    public static void main(String[] args) {
        
        //Paso 2. iniciar el generador aleatorio
        GeneradorAleatorio.iniciar();
	 
        //Paso 3. definir la matriz de enteros de 5x5 e iniciarla con nros. aleatorios
        int dimFi = 5, dimFj = 5, i, j;
        int [][] matriz = new int[dimFi][dimFj]; 
        
        for (i = 0; i < dimFi; i++) {
            for (j = 0; j < dimFj; j++) {
                matriz[i][j] = GeneradorAleatorio.generarInt(100);
            }
        }
    
        //Paso 4. mostrar el contenido de la matriz en consola
        for (i= 0; i < dimFi; i++) {
            for (j = 0; j < dimFj; j++) {
                System.out.print(matriz[i][j] + "\t"
                );
            }
            System.out.println("\n");
        }
        
    
        //Paso 5. calcular e informar la suma de los elementos de la fila 1
        int suma = 0;
        for (j = 0; j < dimFj; j++) {
            suma += matriz[0][j];
        }
        
        System.out.println("La suma de la primera fila es: " + suma);
    
        //Paso 6. generar un vector de 5 posiciones donde cada posición j contiene la suma de los elementos de la columna j de la matriz. 
        //        Luego, imprima el vector.
        int[] vector = new int[dimFj];
        
        for (i = 0; i < dimFi; i++) {
            suma = 0;
            
            for (j = 0; j < dimFj; j++) {
                suma += matriz[i][j];
            }
            
            vector[i] = suma;            
        }
        
        System.out.println("Vector de suma de filas de la matriz:");
        
        for (i = 0; i < dimFi; i++) {
            System.out.print(vector[i] + " \t");
        }
        
        System.out.println();
        

        //Paso 7. lea un valor entero e indique si se encuentra o no en la matriz. En caso de encontrarse indique su ubicación (fila y columna)
        //   y en caso contrario imprima "No se encontró el elemento".
        System.out.print("Ingrese un valor a buscar: ");
        int valor = Lector.leerInt();
        
        i = 0;
        boolean seguir = true;
        
        while ((i < dimFi) && seguir) {
            
            j = 0;
            while ((j < dimFj) && seguir) {
                if (matriz[i][j] == valor)
                    seguir = false;
                
                j++;
            }
                        
            i++;
        }       

        
        if (!seguir) {
            System.out.println("Elemento " + valor + " encontrado en: (" + i + ", " + j +")");
        } else {
            System.out.println("No se encontró el elemento " + i + " " + j);
        }
    }    
}
