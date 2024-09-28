/*
    Se dispone de la clase Partido (en la carpeta tema2). Un objeto partido representa un
    encuentro entre dos equipos (local y visitante). 

    Un objeto partido puede crearse sin valores iniciales o enviando en el 
    mensaje de creación el nombre del equipo local, el nombre del visitante, 
    la cantidad de goles del local y del visitante (en ese orden). 

    Un objeto partido sabe responder a los siguientes mensajes:
    getLocal() retorna el nombre (String) del equipo local
    getVisitante() retorna el nombre (String) del equipo visitante
    getGolesLocal() retorna la cantidad de goles (int) del equipo local
    getGolesVisitante() retorna la cantidad de goles (int) del equipo visitante
    setLocal(X) modifica el nombre del equipo local al “String” X
    setVisitante(X) modifica el nombre del equipo visitante al “String” X
    setGolesLocal(X) modifica la cantidad de goles del equipo local al “int” X
    setGolesVisitante(X) modifica la cantidad de goles del equipo visitante al “int” X
    hayGanador() retorna un boolean que indica si hubo (true) o no hubo (false) ganador
    getGanador() retorna el nombre (String) del ganador del partido (si no hubo retorna
    un String vacío).
    hayEmpate() retorna un boolean que indica si hubo (true) o no hubo (false) empate
    
    Implemente un programa que cargue un vector con a lo sumo 20 partidos disputados en
    el campeonato. La información de cada partido se lee desde teclado hasta ingresar uno con
    nombre de visitante “ZZZ” o alcanzar los 20 partidos. Luego de la carga:
    - Para cada partido, armar e informar una representación String del estilo:
    {EQUIPO-LOCAL golesLocal VS EQUIPO-VISITANTE golesVisitante }
    - Calcular e informar la cantidad de partidos que ganó River.
    - Calcular e informar el total de goles que realizó Boca jugando de local.
 */
package tema2;

/**
 *
 * @author dunkelwolf
 */

import PaqueteLectura.Lector;

public class Ejercicio5 {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        String corte = "ZZZ";
        int dimL = -1;
        int maxPartidos = 20;
        int totalesRiver = 0, totalGolesBocaLocal = 0;
        
        // Vector para almacenar hasta maxPartidos
        Partido[] vector = new Partido[maxPartidos];
        
        System.out.print("Equipo visitante: ");
        String visitante = Lector.leerString();
        
        while (!visitante.equals(corte) && dimL < 20) {
            
            System.out.print("Equipo local: ");
            String local = Lector.leerString();
            
            System.out.print("Goles Local: ");
            int golesLocal = Lector.leerInt();
            
            System.out.print("Goles visitante: ");
            int golesVisitante = Lector.leerInt();
            
            // Hay lugar para un partido. Incremento dimL
            dimL++;
            
            // Creo y asigno el partido
            vector[dimL] = new Partido(local, visitante, golesLocal, golesVisitante);
                    
            // Leo el siguiente visitante para continuar o no el loop  
            System.out.println();
            System.out.print("Equipo visitante: ");
            visitante = Lector.leerString();
        }
        
        // Imprimo los resultados de cada partido
        for (int i = 0; i < dimL + 1;  i++) {
            System.out.println("EQUIPO-LOCAL " + vector[i].getLocal().toUpperCase() + " (" + vector[i].getGolesLocal() + ") <- VS -> EQUIPO-VISITANTE " + vector[i].getVisitante().toUpperCase() + " (" + vector[i].getGolesVisitante() + ")");
            System.out.println("----------------------------");
            
            
            Partido p = vector[i];
            
            // Cuento los partidos que ganó River
            if (p.hayGanador() && p.getGanador().equals("River"))
                totalesRiver++;
            
            
            // Cuento el total de goles de Boca de local
            if (p.getLocal().equals("Boca"))
                totalGolesBocaLocal += p.getGolesLocal();
              
        }
        
        // Informo
        System.out.println("River ganó " + totalesRiver + " partidos.");
        System.out.println("Boca convirtio " + totalGolesBocaLocal + (totalGolesBocaLocal > 1? " goles " : " gol ") + "de local.");
    }  
}
