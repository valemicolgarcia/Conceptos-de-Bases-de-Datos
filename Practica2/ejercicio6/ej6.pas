program ej6;
{Un restaurante posee un archivo con información de los montos por servicios cobrados por cada mozo durante la semana. 
    1 archivo -- MUCHOS MOZOS
    cada mozo --- MUCHOS SERVICIOS 

    UNICO ARCHIVO
    mozo 1 : serv 1, serv 2, serv 3
    mozo 2: serv 1, serv 15
    mozo n: EOF

De cada servicio se conoce: código de mozo, fecha y monto del servicio. 

La información del archivo se encuentra ordenada por código de mozo y cada mozo puede tener n servicios cobrados en diferentes fechas. 
No se conoce la cantidad de mozos del restaurante.

Realice un procedimiento que reciba el archivo anterior y lo compacte. 

Enconsecuencia, deberá generar un nuevo archivo en el cual, cada mozo aparezca una 
única vez con el valor total cobrado por los servicios. El archivo debe recorrerse una
única vez.
}
const 
valorAlto = 99999;
type 
    servicio = record
        codMozo: integer;
        fecha: string[12];
        monto: integer;
    end;

    mozo = record
        codMozo : integer;
        totalCobrado : integer;
    end;

    archivoServicios = file of servicio;
    archivoMaestro = file of mozo;
   

//VARIABLES ----
var
    archServicios : archivoServicios;
    archMaestro: archivoMaestro;
    serv : servicio;
    mozoCod : integer;
    moz : mozo;

//PROCEDIMIENTOS ---

procedure leer (var archServicios : archivoServicios; var serv: servicio);
begin
  if (not (EOF (archServicios))) then begin
        read (archServicios, serv);
  end else begin
        serv.codMozo = valorAlto;
  end;
end;

//PROGRAMA PRINCIPAL ---
begin

    assign (archServicios, 'archivoServivios');
    assign (archMaestro, 'archivoMaestro');
    reset (archServicios);
    reset (archMaestro);

    leer (archServicios, serv); //leo un servicio del archivo con informacion de mozos 

    while (serv.codMozo <> valorAlto) do begin

        mozoCod = serv.codMozo;
        moz.totalCobrado = 0; // inicializacion del monto total
        moz.codMozo = mozoCod ; //me guardo el codigo del mozo 

        while (serv.codMozo = mozoCod) do begin // PROCESAMIENTO POR MOZO
            moz.totalCobrado := moz.totalCobrado + serv.monto;
            leer (archServicios, serv);
        end;

        write (archivoMaestro, moz); //guardo la informacion en el archivo maestro

    end;

    close (archServicios);
    close (archMaestro);
    
  
end.