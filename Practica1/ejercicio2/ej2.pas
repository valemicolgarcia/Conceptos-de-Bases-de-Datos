Program ej2;

    {
    Desarrollar un programa que permita la apertura de un archivo de números enteros
    no ordenados. La información del archivo corresponde a la cantidad de votantes
    de cada ciudad de la provincia de buenos aires en una elección presidencial.
    Recorriendo el archivo una única vez, informe por pantalla la cantidad mínima y
    máxima de votantes. Además durante el recorrido, el programa deberá listar el
    contenido del archivo en pantalla. El nombre del archivo a procesar debe ser
    proporcionado por el usuario.
    }

type
    archivo = file of integer;
var
    fileLogico : archivo;
    nombreArchivo: String[12];
    num: integer;
    i: integer;
    min: integer;
    max: integer;
    numLeido: integer;

begin


    writeln (' ');
    writeln('Ejercicio 2');
    writeln('----');

    //Creacion del archivo de numeros para despues poder leer
    writeln ('Ingrese el nombre del archivo: ');
    readln(nombreArchivo);
    assign(fileLogico,nombreArchivo);
    rewrite(fileLogico);
    
    //Escritura sobre el archivo
    Randomize; //inicaliza el generador de numeros aleatorios con una semilla
    num:= Random(100) + 1 ; // genera un nro aleatorio entre 1 y 100
    writeln('El numero random es: ' , num); 
    for i := 1 to 50 do begin
        write(fileLogico, num);
        num:= Random(100) + 1 ; // genera un nro aleatorio entre 1 y 100
        writeln('El numero random es: ' , num); 
    end;

    close(fileLogico);

    //inicializacion de variables max y min
    min:= 9000;
    max:= -1;

    //Apertura del archivo
    writeln ('Ingrese nombre del archivo a procesar: ');
    readln (nombreArchivo); // el usuario proporciona el nombre del archivo a procesar
    assign(fileLogico,nombreArchivo);
    reset(fileLogico); //Apertura del archivo

    //Lectura y analisis de minimos o maximos
    while (not eof(fileLogico)) do begin

        read(fileLogico, numLeido ); //obtengo un elemento desde el archivo
        writeln('El numero leido es: ', numLeido); // listo el contenido en pantalla
        if (numLeido > max) then begin
        max:= numLeido;
        end 
        else begin
            if (numLeido < min) then begin
                min:= numLeido;
            end;
        end;

    end;

    //Cantidad minima y maxima de votantes
    writeln('La cantidad minima de votantes es: ' , min);
    writeln ('La cantidad maxima de votantes es: ', max);


    close(fileLogico);
    




end.