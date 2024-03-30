program ej5;
{
    La Dirección de Población Vulnerable del Ministerio de Salud y Desarrollo Social
solicita información a cada municipio indicando cantidad de niños y de adultos mayores
que están en situación de riesgo debido a la situación socioeconómica del país.

 Para ello se recibe un archivo indicando: partido, localidad, barrio, cantidad de niños y
cantidad de adultos mayores.

Se sabe que el archivo se encuentra ordenado por partido y localidad. Se pide imprimir
por pantalla con el siguiente formato:

Partido:

Localidad 1:
Cantidad niños: ____ Cantidad adultos: ____
Total niños localidad 1:----------- Total adultos localidad 1:----------

Localidad 2:
Cantidad niños: ____ Cantidad adultos: ____
Total niños localidad 2:----------- Total adultos localidad 2:----------

TOTAL NIÑOS PARTIDO:----------- TOTAL ADULTOS PARTIDO:------------

}
const valorAlto = '9999999';
type 

    info_municipal = record
        partido : string [12];
        localidad: string[12];
        barrio : string [12];
        cantNinos : integer;
        cantAdultos : integer;
    end;

    datos_archivo = file of info_municipal;

//VARIABLES----------
var
    archivo : datos_archivoarchivo;
    info : info_municipal;
    partido : string[12];
    totalNinos : integer;
    totalAdultos : integer;
    localidad : integer;
    contadorLocalidades : integer;
    totalNinosLoc : integer;
    totalAdutosLoc: integer;

// PROCEDIMIENTOS---------
procedure leer (var archivo: datos_archivo ; var dato : info_municipal );
begin
    if (not (EOF (archivo))) then
        read (archivo, dato)
    else 
        dato.partido = valorAlto;
end;


// PROGRAMA PRINCIPAL -----
begin

    assign (archivo, 'archivoMunicipal');

    leer (archivo, info); // leo un registro del archivo municipal

    while (info.partido <> valorAlto) do begin //mientras no se termine el archivo
        partido := info.partido;
        totalNinos := 0;
        totalAdultos:= 0;
        writeln ('Partido: ' + partido);
        contadorLocalidades :=0;
        while (info.partido = partido) do begin //PROCESAMIENTO POR PARTIDO

            localidad = info.localidad;
            contadorLocalidades := contadorLocalidades + 1;
            writeln ('Localidad ' + contadorLocalidades + ': ' localidad);
            totalNinosLoc:=0;
            totalAdutosLoc:=0;

            while (info.localidad = localidad) do begin //PROCESAMIENTO POR LOCALIDAD

                writeln ('Cantidad ninos: ' + info.cantNinos);
                writeln ('Cantidad adultos:' + info.cantAdultos);

                totalNinosLoc := totalNinosLoc + info.cantNinos;
                totalAdutosLoc := totalAdutosLoc + info.cantAdultos;
                leer (archivo, info);
            end;
            
            writeln ('Total ninos localidad ' + contadorLocalidades + ': ' + totalNinosLoc + 'Total adultos localidad ' + contadorLocalidades + ': ' + totalAdultosLoc);
            totalNinos := totalNinos + totalNinosLoc;
            totalAdultos := totalAdultos + totalAdutosLoc;

        end;

        writeln ('TOTAL NINOS PARTIDO: ' + totalNinos + 'TOTAL ADULTOS PARTIDO: ' + totalAdultos);
    end;
  
end.
