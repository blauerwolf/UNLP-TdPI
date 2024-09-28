{
    * RECURSANTES *
    El supermercado HayDeTodo necesita un sistema para procesar la información de sus ventas.
    De cada venta se conoce el DNI del cliente, código de sucursal (1 a 10), número de
    factura y monto.

        d) Implementar un módulo que lea la información de las ventas (la lectura finaliza al
        ingresar el código de cliente 0) y retorne:

           i. Una estructura de datos eficiente para la búsqueda por DNI de cliente. Para cada
           DNI debe almacenarse una lista de todas sus compras (número de factura y monto).
           ii. Una estructura de datos que almacene la cantidad de ventas de cada sucursa.

        e) Realizar un módulo que reciba la estrucutra generada en el inciso a) i., un monto y un DNI.
        El módulo debe retornar la cnatidad de facturas cuyo monto supera al monto recibido para el 
        DNI recibido.

        f) Realizar un módulo recursivo que reciba la estructura generada en el inciso a) ii., y retorne
        el código de sucursal con mayor cantidad de ventas.

    NOTA: Implementar el programa principal, que invoque a los incisos a, b y c.
}