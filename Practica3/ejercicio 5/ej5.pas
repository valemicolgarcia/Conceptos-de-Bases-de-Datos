program ej5;
{Se cuenta con un archivo de artículos deportivos a la venta. 

De cada artículo se almacena: nro de artículo, descripción, color, talle, stock disponible y precio del producto. 

Se reciben por teclado los nros de artículos a eliminar, ya que no se fabricarán más. 

BAJA LOGICA
Se deberá realizar la baja lógica de los artículos correspondientes. 
ARCHIVO TEXTO
Además, se requiere listar en un archivo de texto todos los artículos eliminados, para ello debe almacenar toda la información 
del artículo eliminado en el archivo de texto. 

(No debe recorrer nuevamente el archivo maestro, deberá hacerlo en simultáneo).

Escriba el programa principal con la declaración de tipos necesaria y realice un proceso que
reciba el archivo maestro y actualice el archivo maestro a partir de los códigos de artículos a
borrar. El archivo maestro se encuentra ordenado por el código de artículo.
}


type
    articulo = record 
        nroArticulo : integer;
        descripcion: string[50];
        color: string[12];
        talle : integer;
        stock: integer;
        precio: integer;
    end;

    arch_articulo = file of articulo;
var
    nro: integer;
    respuesta : string[5];
    arch: arch_articulo;


//PROCEDIMIENTOS
procedure procesar (nro: integer ; arch: arch_articulo);
var
    posBorrar : integer;
    art : articulo;
    archTexto : text;

begin

    reset (arch);
    assign (archTexto, 'texto.txt');
    rewrite (archTexto);

    art.nroArticulo = 9999;
    while (not (EOF (arch)) and (art.nroArticulo <> nro)) do begin
      read (arch, art); //leo registros hasta que encuentre el que quiero eliminar
    end;

    if (art.nroArticulo = nro) then begin
      writeln (archTexto, art.nroArticulo, art.descripcion);
      writlen (archTexto, art.color);
      writeln (archTexto, art.talle, art.stock, art.precio);
      posBorrar := filepos(arch) - 1; //guardo la posicion a borrar
      art.nroArticulo = -1;
      seek (arch, posBorrar); // me posiciono en donde quiero borrar
      write (arch, art); //escribo la marca en el registro del archivo
    end;

    close (archTexto);
    close (arch);
  
end;

//PROGRAMA PRINCIPAL
begin

assign (arch, 'archivoArticulo');

while (respuesta = 'si') do begin
  
writeln ('Ingrese numero de articulo a eliminar: (NO SE FABRICAN MAS)');
readln (nro);

    procesar (nro, arch);

writeln ('Desea eliminar otro articulo? si - no');
readln (respuesta);
end;


end.