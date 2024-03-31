program ej4;
    {CONTEXTO
    Una disquera cuenta con un archivo conteniendo la información de discos(cd) que posee a la
    venta. 
    
    INFO CD
    De cada cd se conoce: un código único, nombre álbum, género,artista una descripción
    asociada, año de edición y cantidad de copias en stock. 

    ORDEN
    Al archivo no tiene orden.


    Trimestralmente la disquera actualiza el archivo modificando los discos de los que ya no posee
    stock. 
    
    MODIFICACION REGISTRO
    Implementar un procedimiento que modifique el stock a 0 de los discos obsoletos e informe
    por pantalla nombre de álbumes que quedaron sin stock. Se deberá además declarar los tipos de
    datos necesarios y la llamada al procedimiento de modificación. 
    
    USUARIO INGRESA POR TECLADO LOS CODIGOS DE LOS CD QUE NO TIENEN STOCK
    Para ello el usuario ingresará por teclado los códigos de cd que ya no tienen stock.

    BAJA FISICA
    Además, se deberá implementar la compactación del archivo, es decir un procedimiento que
    reciba el archivo de discos y elimine físicamente los discos que no tienen stock.
    }
type
    cd = record 
        cod: integer;
        nombre: string[12];
        genero: string[12];
        artista: string[12];
        descripcion: string [50];
        anio : integer;
        stock: integer;
    end;

    archivo_cd = file of cd;

procedure modificarStock (var arch: archivo_cd ; cod : integer);
var
    
    dato : cd;
begin
    reset (arch);
    dato.cod = 9999;
    while (not (EOF (arch)) and (dato.cod <> cod)) do begin
      read (arch, dato);
    end;
    if (dato.cod = cod) then begin
      dato.stock = 0;
      writeln ('ALBUM SIN STOCK: ' + dato.nombre); //informo por pantalla el album del cd que se quedo sin stock
    end;


    close (arch);
end;

procedure eliminarDisco (var arch : archivo_cd ; cod : integer);
var
    disco : cd;
    posBorrar : integer;
    aux: cd;
begin
    reset (arch);

    disco.cod = 999999;

    while (not (EOF (arch)) and (disco.cod <> cod)) do begin
      read (arch, disco);
    end;

    if (disco.cod = cod) then begin
      posBorrar := filepos (arch) - 1; //guardo la posicion a borrar
      seek (arch, FileSize(arch) - 1); //me posiciono al final del archivo
      read (arch, aux); //leo el registro de la ultima posicion
      seek (arch, posBorrar); //me posiciono en la posicion a borrar
      write (arch, aux); //escribo el ultimo registro en la posicion donde estaba el dato a borrar
      seek (arch, FileSize(arch) - 1); //me vuelvo a posicionar al final del archivo
      truncate (arch);
    end;


    close (arch);
end;

var
    arch : archivo_cd;
    cod : integer;
    respuesta: string[10];

begin
  
    while (respuesta = 'si') do begin
      
        writeln ('Ingrese codigo obsoleto de cd que no haya stock');
        readln (cod);

        modificarStock(arch, cod);

        eliminarDisco (arch, cod);

        writeln ('Desea ingresar otro? si - no');
        readln (respuesta);
    end;

end.