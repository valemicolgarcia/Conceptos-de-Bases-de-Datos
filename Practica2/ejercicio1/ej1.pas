{
INTRO: El área de recursos humanos de un ministerio administra el personal del mismo distribuido en 10 direcciones generales.
Entre otras funciones, recibe periódicamente un archivo detalle de cada una de las direcciones conteniendo información de las licencias solicitadas por el personal.

1 ARCHIVO MAESTRO --> 10 ARCHIVOS DETALLE

Cada ARCHIVO DETALLE contiene información que indica: código de empleado, la fecha y la cantidad de días de licencia solicitadas. 
El ARCHIVO MAESTRO tiene información de cada empleado: código de empleado, nombre y apellido, fecha de nacimiento, dirección, 
cantidad de hijos, teléfono, cantidad de días que le corresponden de vacaciones en ese periodo. 

Tanto el maestro como los detalles están ORDENADOS por código de empleado. 

HACER:
1. Escriba el programa principal con la declaración de tipos necesaria 

2. realice un proceso que reciba los detalles y actualice el archivo maestro con la información proveniente de los archivos detalles. 
Se debe actualizar la cantidad de días que le restan de vacaciones. : ACTUALIZACION DE ARCHIVOS MAESTRO/DETALLE

3. Si el empleado tiene menos días de los que solicita deberá informarse en un archivo de texto indicando: código de empleado,
nombre y apellido, cantidad de días que tiene y cantidad de días que solicita.
}


program ej1;
const valorAlto = '9999';
type
    empleado_maestro = record
        cod: string;
        nombreApellido: string[20];
        fechaNacimiento: string[20];
        direccion: string[20];
        cantHijos: integer;
        telefono: integer;
        cantDiasVacaciones: integer;
    end;

    empleado_detalle = record
        cod: string;
        fecha: string[20];
        cantDiasLicencia: integer;
    end;

    detalle = file of empleado_detalle;
    maestro =  file of empleado_maestro;

    vector = array [1..10] of detalle; //vector de 10 archivos detalle

var
    mae: maestro;
    det: detalle;
    vec: vector;
    i: integer; 

procedure leer (var archivo: detalle ; var dato: empleado_detalle);
begin

    //Leo un dato del archivo detalle y verifico que no se haya terminado el archivo
    if (not (EOF(archivo))) then
        read (archivo, dato)
    else begin
        dato.cod := valorAlto;
    end;

end;


procedure actualizarMaestro (var archMaestro: maestro ;  var vec: vector );
var
    i: integer;
    empDetalle: empleado_detalle;
    empMaestro: empleado_maestro;
    aux: string;
    licencia: integer;
    archivoTexto: text;
begin
   
    for i:=1 to 10 do begin  //recorro todos los archivos detalles y voy leyendo

        leer (vec[i], empDetalle); //leo el primer empleado del archivo detalle

        while (empDetalle.cod <> valorAlto) do begin //proceso todos los empleados del archivo detalle

            //proceso detalle
            aux := empDetalle.cod; //codigo del empleado
            licencia := empDetalle.cantDiasLicencia; // me traigo la licencia del empleado actual
            
            //proceso maestro
            while (empMaestro.cod<> aux) do begin //Busco el empleado en el archivo maestro
                if (not (EOF (archMaestro))) then begin 
                    read (archMaestro, empMaestro); 
                end;
            end;
            
            // verificacion si el empleado tiene los dias que solicita, sino archivo de texto informando
            if (empMaestro.cantDiasVacaciones < licencia) then begin
                assign (archivoTexto, 'archivoTexto');
                rewrite(archivoTexto);
                writeln (archivoTexto, empMaestro.cod, empMaestro.nombreApellido);
                writeln(archivoTexto, empMaestro.cantDiasVacaciones, licencia);
                close(archivoTexto);
            end;

            empMaestro.cantDiasVacaciones := empMaestro.cantDiasVacaciones - licencia; //realizo la modificacion en una variable
            seek (archMaestro, filepos(archMaestro)-1); //reubico el puntero en el maestro
            write(archMaestro, empMaestro); // actualizo el maestro (dias que le quedan de vacaciones)
            

            //proceso detalle
            leer (vec[i], empDetalle); //leo el proximo empleado del archivo detalle
        end;

    end;


end;


begin

    //ARCHIVO MAESTRO
    assign (mae, 'maestro');
    reset (mae);

    //ARCHIVOS DETALLE
    for i:= 1 to 10 do begin
        assign (vec[i], 'detalle');
        reset (vec[i]);
    end;


    actualizarMaestro(mae,vec); //le mando el archivo maestro y el vector de todos los archivos detalles

    
    //CIERRE DE ARCHIVOS MAESTRO Y DETALLE
    close (mae);
    for i:= 1 to 10 do begin
        close (vec[i]);
    end;

//---fin
end.