{
    * RECURSANTES *
    Una empresa de gastronomía desea progesar las entregas de comida realizadas a sus clientes
    durante el año 2024.

        a) Implementar un módulo que lea las entregas de comida. De cada compra se lee el código de
        comida, código de cliente y categoría de la entrega (Full, Super, Media, Normal, Basica).
        La lectura finaliza con el código de cliente 0. Se deben retornar 2 estructuras de datos:

           i. Un árbol binario de búsqueda ordenadpo rpo código de comida. Para cada código de comida
           debe almacenarse la cantidad de entregas realizadas a ese código entre todos los clientes.
           ii. Un vector que almacene en cada posición el nombre de la categoría y la cantidad de
           entregas realizadas para esa categoría.

        b) Implementar un módulo que reciba el árbol generado en a) y un código de comida. El módulo
        debe retornar la cantidad de entregas realizadas al código de comida ingresado.

        c) Implementar un módulo que reciba el vector generado en a), lo rodene por cantidad de entregas
        de menor a mayor y retorne la categoría con mayor cantidad de entregas.

    NOTA: Implementar el progrma principal, que invoque a los incisos a, b y c.
}