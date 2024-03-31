program ej8;

{  CONTEXTO:
    La municipalidad de la Plata, en pos de minimizar los efectos de posibles inundaciones,
construye acueductos que permitan canalizar rápidamente el agua de la ciudad hacia
diferentes arroyos que circundan la misma. La construcción está dividida por zonas.
Los arquitectos encargados de las obras realizan recorridos diariamente y guardan
información de la zona, fecha y cantidad de metros construidos. 

INFO ZONA
Cada arquitecto envía mensualmente un archivo que contiene la siguiente información: 
cod_zona, nombre de
la zona, descripción de ubicación geográfica, fecha, cantidad de metros construidos ese día. 

Se sabe que en la obra trabajan 15 arquitectos y que durante el mes van rotando de zona.

15 ARCHIVOS DETALLE --> 1 ARCHIVO MAESTRO
Escriba un procedimiento que reciba los 15 archivos correspondiente y genere un archivo maestro 
indicando para cada zona: cod_zona, nombre de zona y cantidad de
metros construidos. 

ARCHIVO DE TEXTO
Además se deberá informar en un archivo de texto, para cada zona, la cantidad de metros construidos 
indicando: cod_zona, nombre, ubicación y metros construidos. 

Nota: todos los archivos están ordenados por cod_zona.-- ORDENADOS (usar el minimo)

}
const 
    N = 15;
    valorAlto = 99999;
type 

    zona = record
        codZona: integer;
        nombreZona: string[12];
        descripcion: string[20];
        fecha: string[12];
        cantMetrosDia: integer;
    end;

    info_maestro = record
        codZona: integer;
        nombreZona: string[12];
        cantMetros: integer;
    end;

    archivo_detalle = file of zona;
    vector_archivos_detalle = array [1..N] of archivo_detalle;
    vector_detalle = array [1..N] of zona;

    archivo_maestro = file of info_maestro;

//PROCEDURES

procedure leer (var archivo : archivo_detalle ; dato : zona);
begin
    if (not (EOF (archivo))) then begin
      read (archivo, dato);
    end else begin
      dato.codZona = valorAlto;
    end;
end;


procedure minimo (vectorArchivosDetalle : vector_archivos_detalle ; vectorDetalle : vector_detalle ; min : zona);
var
    pos : integer;
    i: integer;
begin
    pos:=1;
    min: vectorDetalle[pos];

    for i:=1 to N do begin
        if (min.codZona > vectorDetalle[i].codZona) then begin
            min := vectorDetalle[i];
            pos:= i;
        end;
    end;

    leer (vectorArchivosDetalle[pos], vectorDetalle[pos]); // avanzo

end;


procedure generarArchivoMaestro (vectorArchivosDetalle : vector_archivos_detalle);
var
    archMaestro : archivo_maestro;
    i : integer;
    vectorDetalle : vector_detalle;
    min : zona;
    infoMaestro: info_maestro;

begin

    //se preparan los archivos detalle
    for i:=1 to N do begin
        reset (vectorArchivosDetalle[i]); 
        leer (vectorArchivosDetalle[i], vectorDetalle[i]); //me guardo una zona de cada archivo detalle en un vector
    end;

    // se prepara el archivo maestro
    assign (archMaestro, 'maestro');
    rewrite (archMaestro);

    //se determina cual es la zona con menor codigo
    minimo (vectorArchivosDetalle, vectorDetalle, min);

    while (min.codZona <> valorAlto) do begin
        aux := min.codZona;
        infoMaestro.codZona = min.codZona;
        infoMaestro.nombreZona = min.nombreZona;
        while (aux = min.codZona) do begin
            infoMaestro.cantMetros = infoMaestro.cantMetros + min.cantMetrosDia;
            minimo (vectorArchivosDetalle, vectorDetalle, min);
          
        end;
    end;




end;


// VARIABLES ---
var

i : integer;
vectorArchivosDetalle : vector_archivos_detalle;

// PROGRAMA PRINCIPAL ---
begin

    for i:=1 to N do begin
        assign (vector_archivos_detalle[i], 'Detalle' + i);
    end;

    generarArchivoMaestro(vectorArchivosDetalle);

  
end.