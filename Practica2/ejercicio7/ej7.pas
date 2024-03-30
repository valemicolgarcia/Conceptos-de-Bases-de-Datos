program ej7;

{
    7. Se desea administrar el stock de los productos de un supermercado. Para ello se cuenta con un archivo maestro 
    donde figuran todos los productos que comercializa. 

    1 ARCHIVO MAESTRO --> PRODUCTOS
    De cada producto se almacena la siguiente información: código de producto, nombre comercial, descripción, 
    precio de venta, stock actual y stock mínimo. 

    10 ARCHIVOS DETALLE --> VENTAS
    Diariamente se generan 10 archivos detalle que registran todas las ventas de productos registradas por las cajas del supermercado. 
    De cada venta se almacena: código de producto y cantidad de unidades vendidas. 
    

    Se pide realizar un programa con opciones para:

    a) Crear el archivo maestro a partir de un archivo de texto llamado “productos.txt”. (RECORRO EL ARCHIVO DE TEXTO Y VOY GUARDANDO EN EL MAESTRO)
    b) Actualizar el archivo maestro con los archivos detalle, sabiendo que:

        - Todos los archivos están ordenados por código de producto.
        - Cada registro del maestro puede ser actualizado por 0, 1 ó más registros
        de los archivos detalle.
        - Los archivos detalle sólo contienen ventas de productos que están en el
        archivo maestro. Además, siempre hay stock suficiente para realizar las ventas
        de productos que aparecen en los archivos de detalle.

    Nota: deberá implementar programa principal, todos los procedimientos y los tipos de datos necesarios.

}
const 
    valorAlto = 99999;
    N = 10;
type 
    producto = record
        codProd : integer;
        nombre : String[12];
        descripcion : string [12];
        precio: integer;
        stockActual : integer;
        stockMinimo: integer;
    end;

    venta = record 
        codProd : integer;
        cantVendidas: integer;
    end;

    archivoDetalle = file of venta;
    vector_archivoDetalle = array [1..N] of archivoDetalle;
    vector_venta = array [1..N] of venta;

    archivoMaestro = file of producto;

//VARIABLES ---
var 

archMaestro : archivoMaestro;
vectorDetalles : vector_archivoDetalle;
opcion : integer;

//PROCEDIMIENTOS ---

procedure leerTexto (var archivoTexto : text; var prod : producto);
begin
    if (not (EOF (archivoTexto))) then begin
      readln (archivoTexto, prod.codProd, prod.nombre);
      readln (archivoTexto, prod.descripcion);
      readln (archivoTexto, prod.precio, prod.stockAnual, prod.stockMinimo);
    end else begin
        prod.codProd = valorAlto;
    end;
end;


procedure crearMaestro (var archMaestro: archivoMaestro);
var 
    archivoTexto : text;
    prod : producto;
begin
    assign (archMaestro, 'maestro');
    rewrite (archMaestro);
    assign (archivoTexto, 'productos.txt');
    reset (archivoTexto);

    //interpreto que el archivo productos.txt tiene la informacion del archivo maestro 
    //pero se quiere hacer un archivo de registros

    leerTexto (archivoTexto, prod); //leo un producto del archivo de textp

    while (prod.codProd <> valorAlto) do begin
        write (archMaestro, prod);
        leerTexto(archivoTexto, prod);
    end;

    close (archMaestro);
    close (archivoTexto);
end;

procedure leer (var arch : archivoDetalle ; var vent : venta);
begin
    if (not (EOF (arc))) then begin
      read (arch, venta);
    end else begin
        vent.codProd = valorAlto;
    end;
end;

procedure minimo (var vectorDetalles : vector_archivoDetalle ; var vectorVentas : vector_venta; var min : venta);
var
    i: integer;
    pos: integer;
begin
    pos := 1;
    min := vectorVentas[pos];
    for i:= 1 to N do begin
        if (min.codProd > vectorVentas[i].codProd) then begin
            min := vectorVentas[i];
            pos:= i;
        end;
    end;
    leer (vectorDetalles[pos], vectorVentas[pos]); //avanzo en el archivo detalle
end;

procedure actualizarMaestro (var archMaestro : archivoMaestro ; var vectorDetalles: vector_archivoDetalle);
var
    prod : producto;
    i: integer;
    vectorVentas : vector_venta;
    min : venta;
begin
    assign (archMaestro, 'maestro');
    for i:= 1 to N do begin
      assign (vectorDetalles[i], 'detalle' + i);
      reset (vectorDetalles[i]);
      leer (vectorDetalles[i], vectorVentas[i]); // de cada archivo detalle leo una venta
    end;

    //lectura del primer registro del archivo maestro
    if (not (EOF (arch))) then 
        read (archMaestro, prod);
    
    minimo (vectorDetalles, vectorVentas, min);

    while (min.codProd <> valorAlto) do begin
      
        //BUSQUEDA DE EMPLEADO MINIMO EN ARCHIVO MAESTRO
        while (min.codProd <> prod.codProd) do begin
            if (not (EOF (archMaestro))) then begin
                read (archMaestro, prod);
            end;
        end;

        aux := min.codProd; //me guardo el codigo del minimo en un auxiliar

        //PROCESO EL EMPLEADO MINIMO
        while (aux = min.codProd) do begin
            prod.stockActual := prod.stockActual - min.cantVendidas; //ACTUALIZO
        end;

        seek (archMaestro, filepos(archMaestro) - 1);
        write (archMaestro, prod);

    end;

    close (archMaestro);
    for i:=1 to N do begin
      close (archivoDetalle);
    end;


end;


//PROGRAMA PRINCIPAL ---
begin
  
    writeln ('Ingrese una opcion: ');
    writeln ('1: crear archivo maestro');
    writeln ('2: actualizar archivo maestro');

    readln (opcion);

    case opcion of :
        1: begin
            crearMaestro(archMaestro);
        end;
        2: begin
          actualizarMaestro(archMaestro, vectorDetalles);
        end;
        else begin
          writeln ('LA OPCION NO ES VALIDA!!!');
        end;
    end;


end.