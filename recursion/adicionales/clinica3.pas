{
    Una clínica necesita un sistema para el procesamiento de las atenciones realizadas
    a los pacientes durante el año 2024.

        a) Implementar un módulo que lea la información de las atenciones y retorn un vector
        donde se almacenen las atenciones agrupadas por mes. Las atenciones de cada mes deben quedar
        almacenadas en un árbol binario de búsqueda ordenado por DNI del paciente y sólo deben
        almacenarse el DNI del paciente y código de diagnóstico. De cada atención se lee:
        matrícula del médico, DNI del paciente, día y diagnóstico (valor entre la L y P). La lectura
        finaliza con la matrícula 0.

        b) Implementar un módulo recursivo que reciba el valor generado en a) y retorn el mes
        con mayor cantidad de atenciones.

        c) Implementar un módulo que reciba el vector generado en a) y un DNI del paciente, y retorne
        si fue atendido o no, el paciente con el DNI ingresado.

    NOTA: Implementar le programa principal, que invoque a los incisos a, b y c.

}