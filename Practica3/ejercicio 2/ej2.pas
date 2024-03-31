program ej2;
{   
    TECNICA DE LISTA INVERTIDA
    Se dispone de un archivo que contiene información de autos en alquiler de una rentadora. Se
sabe que el archivo utiliza la técnica de lista invertida para aprovechamiento de espacio. Es
decir las bajas se realizan apilando registros borrados y las altas reutilizando registros
borrados. El registro en la posición 0 del archivo se usa como cabecera de la pila de registros
borrados.

Nota: El valor ‘0’ en el campo descripción significa que no existen registros borrados, y ‘N’
indica que el próximo registro a reutilizar es el N, siendo éste un número relativo de registro
válido.

Se solicita implementar los siguientes módulos:

Abre el archivo y agrega un vehículo para alquiler, el mismo se recibe como parámetro y
debe utilizar la política descripta anteriormente para recuperación de espacio

    Procedure agregar (var arch: tArchivo; vehiculo: tVehiculo);

Abre el archivo y elimina el vehículo que posea el código recibido como parámetro
manteniendo la política descripta anteriormente

    Procedure eliminar (var arch: tArchivo; codigoVehiculo: integer);

}

Type

    tVehiculo= Record
        codigoVehiculo:string[50];
        patente: String;
        motor:String;
        cantidadPuertas: integer;
        precio:real;
        descripcion:String
    end;
    tArchivo = File of tVehiculo;

//VARIABLES
var
    vehiculo : tVehiculo;
    arch : tArchivo;

//PROCEDIMIENTOS
procedure agregar (var arch: tArchivo; vehiculo: tVehiculo);
var
    sLibre : string[50]; //string con el proximo registro libre
    nLibre : integer; //numero del proximo registro libre
    cod : integer;
    r: tVehiculo; 


begin
    reset (arch);
    read (arch, sLibre); //leo la cabecera
    val (sLibre,nLibre, cod); //convierte de string a number y se guarda en sLibre

    if (nLibre = -1) then begin
        seek (arch, FileSize(arch));
    end else begin
        seek (arch, nLibre); //me posiciono en el registro libre a reutilizar
        read (arch, sLibre); //leo la posicion libre a reutilizar

        seek (arch, 0); //me posiicono en la cabecera
        write (arch, sLibre); //actualizo la cabecera

        seek (arch, nLibre); //me posiciono en el registro libre nuevamente
    end;

    writeln ('Vehiculo');
    readln (r); //leo vehiuclo de teclado
    write (arch, r); //lo escribo en el archivo
    close (arch);

end;


procedure eliminar (var arch: tArchivo; codigoVehiculo: string[50]);
var
    sLibre : string[50]; //string con el proximo registro libre
    r : tVehiculo;
    nLibre : integer ; //numero del proximo registro libre
begin
    reset (arch);
    read (arch, sLibre); //leo la cabecera en sLibre
    r = 'zzz';

    while (not (r=codigoVehiculo) or (EOF (arch))) do begin
      read (arch, r); //leo un registro del archivo hasta encontrar el codigo a eliminar o terminar el archivo
    end;

    if (r = codigoVehiculo) then begin //encontre el codigo de vehiculo a eliminar

        nLibre := filepos(arch) - 1; //me guardo la posicion a eliminar
        seek (arch, nLibre); // me posiciono en el registro a eliminar
        
        write (arch, sLibre) ; // grabamos el contenido de la cabecera (sobreescribo el resgitro a eliminar)

        str (nLibre, sLibre); //convierto de number a string (transformo la posicion)

        seek (arch, 0); //me posiciono al principio del archivo
        write (arch, sLibre); // se actualiza la cabecera


    end else begin

        writeln ('no se encontro el vehiculo');

    end;

    close (arch);
end;


//PROGRAMA PRINCIPAL
begin
    assign (arch, 'archVehiculo');
end.