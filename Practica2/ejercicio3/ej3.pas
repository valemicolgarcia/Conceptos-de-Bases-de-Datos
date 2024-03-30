program ej3;

{
 Una zapatería cuenta con 20 locales de ventas. Cada local de ventas envía un listado con los calzados vendidos indicando: código de calzado, número y cantidad vendida
del mismo.

El archivo maestro almacena la información de cada uno de los calzados que se venden, para ello se registra el código de calzado, número, descripción, precio unitario, color, el stock de cada producto y el stock mínimo.

ACTUALIZAR MAESTRO CON INFO DE ARCHIVO DETALLE
Escriba el programa principal con la declaración de tipos necesaria y realice un proceso que reciba los 20 detalles y actualice el archivo maestro con la información
proveniente de los archivos detalle. 

Tanto el maestro como los detalles se encuentran ordenados por el código de calzado y el número. ORDENADOS (hay que usar la funcion minimo)

Además, se deberá informar qué calzados no tuvieron ventas y cuáles quedaron por debajo del stock mínimo. 
Los calzados sin ventas se informan por pantalla, mientras que los calzados que quedaron por debajo del stock mínimo se deben informar en un
archivo de texto llamado calzadosinstock.txt.
Nota: tenga en cuenta que no se realizan ventas si no se posee stock.

}

const valorAlto = 9999999;
const num_detalle = 20;
type 

//ARCHIVO MAESTRO
info_maestro = record 
    codCalzado : integer;
    numero : integer;
    descripcion : string[15];
    precio : integer;
    color: string[10];
    stockProd: integer;
    stockMin : integer;
end;

//ARCHIVO DETALLE
info_detalle = record
    codCalzado: integer;
    numero: integer;
    cantVendida: integer;
end;

//ARCHIVOS
detalle = file of info_detalle;
maestro = file of info_maestro;

//20 ARCHIVOS DETALLE - 1 ARCHIVO MAESTRO
vector_detalles = array [1 .. num_detalle] of detalle; //vector de 20 archivos detalle
vector_calzadosDetalle = array [1..num_detalle] of info_detalle;

var
archMaestro : maestro;
archDetalle : detalle;
archivos_detalle : vector_detalles // vector de 20 archivos detalle
i : integer;
calzadoMaestro : info_maestro;
calzadosDetalle : vector_calzadosDetalle;

procedure leer (var archivoDetalle : detalle ; var dato : info_detalle );
begin
    if not (EOF (archivoDetalle)) then
      read (archivoDetalle, dato)
    else begin
      dato.codCalzado := valorAlto; // si ya llego al final del archivo 
    end;
end; 

procedure minimo (archivos_detalle : vector_detalles ; min: info_detalle ; calzadosDetalle : vector_calzadosDetalle );
var
i : integer;
pos: integer;
minimoCod: integer;
begin
    pos := 1;
    min = calzadosDetalle[pos];
    for i:=1 to num_detalle do begin
        if (min.codCalzado > calzadosDetalle[i].codCalzado) then begin
          min := calzadosDetalle[i];
          pos := i;
        end;
    end;
    leer (archivos_detalle[i], calzadosDetalle[i]); //avanzo en el archivo detalle correspondiente al minimo
end;

//-----------------
procedure actualizarMaestro (archMaestro: maestro ; archivos_detalle : vector_detalles);
var
min : info_detalle;
calzadoMaestro : info_maestro;
aux : integer;
archivoTexto : text;
noticia : string;
begin
    //lectura del primer registro en el archivo maestro
    if (not (EOF (archMaestro))) then
      read (archMaestro, calzadoMaestro );

    //lectura de un calzado de cada archivo detalle y guardado en el vector de calzados
    for i:= 1 to num_detalle do begin
        leer (archivos_detalle[i], calzadosDetalle[i]);
    end;

    minimo (archivos_detalle, min, calzadosDetalle );

    while (min.codCalzado <> valorAlto) do begin //proceso todos los empleados de todos los archivos detalle en orden minimo al maximo

        //BUSQUEDA DE EMPLEADO MINIMO EN ARCHIVO MAESTRO
        while (calzadoMaestro.codCalzado <> min.codCalzado) do begin
            if (not (EOF (archMaestro))) then begin
                read (archMaestro, calzadoMaestro); //leo un calzado hasta encontrar el codigo que busco
            end;
        end;

        aux := min.codCalzado; //me guardo el codigo del minimo en un auxiliar

        //PROCESO EL EMPLEADO MINIMO
        while (aux = min.codCalzado) do begin
            ventas = min.cantVendida;
            if (ventas = 0) then begin
              writeln('Este calzado no tuvo ventas!!!!!');
            end
            else begin
            calzadoMaestro.stockProd := calzadoMaestro.stockProd - ventas; //actualizo el stock
            end;

            if (calzadoMaestro.stockProd < calzadoMaestro.stockMin) then begin
              //INFORMO POR ARCHIVO DE TEXTO
                assign (archivoTexto, 'texto.txt');
                rewrite (archivoTexto);
                noticia = 'El calzado con codigo ' + min.codCalzado + 'esta por debajo del stock minimo'
                writeln (archivoTexto, noticia);
                close (archivoTexto);
            end;

        end;



    end;



end;
//-----------------


begin

assign (archMaestro, 'maestro');
reset (archMaestro);
for i := 1 to num_detalle do begin
  assign (archivos_detalle[i], 'Detalle' + i);
  reset (archivos_detalle[i]);
end;
//----------------------


actualizarMaestro (archMaestro, archivos_detalle);

//-----------------
close (archMaestro);
for i := 1 to num_detalle do begin
  close (archivos_detalle[i]);
end;

  
end.