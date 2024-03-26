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


program ej1mejorado;
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
    vector_empleados = array [1..10] of empleado_detalle; //vector de 10 empleados detalle

var
    mae: maestro;
    det: detalle;
    vec: vector;
    i: integer; 

procedure leer (var archivo: detalle ; var dato: empleado_detalle);
begin

    //Leo un dato del archivo detalle y verifico que no se haya terminado el archivo
    if (not (EOF(archivo))) then
        read (archivo, dato) // guardo un empleado del archivo en una variable
    else begin
        dato.cod := valorAlto;
    end;

end;

// procedure minimo (HACER LA FUNCION MINIMO)  
//minimo (vecEmpleados, min, vec); //HACER LA FUNCION MINIMO

procedure minimo (vecEmpleados: vectorEmpleados; min: empleado_detalle; vec: vector);
var
i: integer;
ind: integer;
minimoCod: integer;
begin
    minimo := vecEmpleados[1].cod;
    ind:=1;
    for i:= 2 to 10 do begin
        if (vecEmpleados[i].cod < min) then begin
          minimoCod:= vecEmpleados[i].cod; //me guardo el minimo codigo entre los empleados
          ind:= i; //me guardo el indice del vector de empleados
        end;
    end;
    min:= vecEmpleados[ind];
    //actualizo los minimos del vector de empleados
    leer (vec[ind], vecEmpleados[ind]); //avanzo en el archivo de donde saque el minimo

end;


procedure actualizarMaestro (var archMaestro: maestro ;  var vec: vector );
var
    i: integer;
    empMaestro: empleado_maestro;
    aux: string;
    licencia: integer;
    archivoTexto: text;
    vecEmpleados : vector_empleados;
    min: empleado_detalle;

begin

    if (not (EOF (archMaestro))) then
        read (archMaestro, empMaestro); //Leo un empleado del archivo MAESTRO
   
    for i:=1 to 10 do begin  //leo un empleado de cada archivo detalle
        leer (vec[i], vecEmpleados[i]); //leo el primer empleado del archivo detalle
    end;

    minimo (vecEmpleados, min, vec); //HACER LA FUNCION MINIMO

    while (min.cod <> valorAlto) do begin //proceso todos los empleados en orden por MINIMO

        //BUSQUEDA DE EMPLEADO MINIMO EN ARCHIVO MAESTRO
        while (empMaestro.cod <> min.cod) do begin //busco el minimo empleado encontrado antes en el archivo maestro
          if (not (EOF (archMaestro))) then
            read (archMaestro, empMaestro);
        end;

        
        aux := min.cod; //me guardo el codigo del minimo en un auxiliar
        licencia := min.cantDiasLicencia; // me traigo la licencia del empleado actual
        
        //PROCESO EL EMPLEADO MINIMO 
        while (aux = min.cod) do begin //procesando el empleado minimo
          if (empMaestro.cantDiasVacaciones < licencia) then begin
                
                // verificacion si el empleado tiene los dias que solicita, sino archivo de texto informando
                assign (archivoTexto, 'archivoTexto');
                rewrite(archivoTexto);
                writeln (archivoTexto, empMaestro.cod, empMaestro.nombreApellido);
                writeln(archivoTexto, empMaestro.cantDiasVacaciones, licencia);
                close(archivoTexto);
          end;
        
         minimo (vecEmpleados, min, vec); //HACER LA FUNCION MINIMO
          

        end;

        //ACTUALIZO EL ARCHIVO MAESTRO
        empMaestro.cantDiasVacaciones := empMaestro.cantDiasVacaciones - licencia; //realizo la modificacion en una variable
        seek (archMaestro, filepos(archMaestro)-1); //reubico el puntero en el maestro
        write(archMaestro, empMaestro); // actualizo el maestro (dias que le quedan de vacaciones)
        
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