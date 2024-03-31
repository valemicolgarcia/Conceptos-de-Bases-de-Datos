program ej4;
{
    Una cadena de cines de renombre desea administrar la asistencia del público a las diferentes películas que se exhiben actualmente. 

Para ello cada cine genera semanalmente un archivo indicando: 
código de película, nombre de la película, género, director, duración, fecha y cantidad de asistentes a la función. 
Se sabe que la cadena tiene 20 cines. 

Escriba las declaraciones necesarias y un procedimiento que reciba los 20 archivos y un String indicando la ruta del archivo maestro 
y genere el archivo maestro de la semana a partir de los 20 detalles 
(cada película deberá aparecer una vez en el maestro con los datos propios de la película y el total de asistentes que tuvo
durante la semana). 

Todos los archivos detalles vienen ordenados por código de
película. Tenga en cuenta que en cada detalle la misma película aparecerá tantas
veces como funciones haya dentro de esa semana.

}
const 
    valorAlto = 99999;
    N = 20;
type 
    pelicula = record
        cod : integer;
        nombre: string[15];
        genero : string[15];
        director: string[15];
        duracion : integer;
        fecha: string[10];
        cantAsistentes : integer;
    end;

    pelimaestro = record
        cod : integer;
        nombre: string[15];
        genero : string[15];
        director: string[15];
        duracion : integer;
        totalAsistentes : integer;
    end;

    detalle = file of pelicula;
    maestro = file of pelimaestro;

    archivos_detalle = array [1..N] of detalle;
    vector_peliculas = array [1..N] of pelicula;

var

    archMaestro : maestro;
    archivosDetalle : archivos_detalle; //vector de 20 archivos detalle
    ruta : string;
    i : integer;

procedure leer (var archivo: detalle ; peli : pelicula);
begin
  if (not (EOF (archivo))) then begin
        read (archivo, peli)
  end else 
  begin
        peli.cod = valorAlto;
  end;
end;

procedure minimo (archivosDetalle : archivos_detalle ; peliculas : vector_peliculas ; min : pelicula);
var 
    pos : integer;
    i: integer;
begin
    pos := 1;
    min = peliculas [pos];

    for i:= 1 to N do begin
        if (min.cod > vector_peliculas[i].cod) then begin
          min := peliculas[i];
          pos := i;
        end;
    end;

    leer (archivosDetalle[pos], peliculas [pos] );

end;

procedure generarArchivoMaestro (var archivosDetalle : archivos_detalle ; var ruta : string);
var
i : integer;
peliculas : vector_peliculas;
archMaestro : maestro;
aux: integer;
min : pelicula;
peliM : pelimaestro;

begin
    //se preparan los archivos detalle
    for i:=1 to N do begin
        assign (archivosDetalle[i], 'archivoDetalle' + i); //asigno
        reset (archivosDetalle[i]); //abro archivo
        leer (archivosDetalle[i], peliculas [i]); //me guardo una pelicula de cada archivo detalle en un vector 
    end;

    //se prepara el archivo maestro
    assign (archMaestro, ruta);
    rewrite (archMaestro);

    // se determina cual es la pelicula con menor codigo
    minimo (archivosDetalle, peliculas, min);

    while (min.cod <> valorAlto) do begin

        aux := min.cod;
        peliM.cod = min.cod;
        peliM.nombre = min.nombre;
        peliM.genero = min.genero;
        peliM.director = min.director;
        peliM.duracion = min.duracion;

        while (aux = min.cod) do begin
            
            peliM.totalAsistentes := peliM.totalAsistentes + min.cantAsistentes;
            minimo (archivosDetalle, peliculas, min);
        end;
        write (archMaestro, peliM);
    end;

    close (archMaestro);
    for i:=1 to N do begin
      close (archivosDetalle[i]);
    end;




end;


begin

ruta = 'C:\Users\VICTUS\Documents\2024\CBD\Practica2\ejercicio 4\archMaestro.txt';
generarArchivoMaestro (archivosDetalle, ruta);

end.