program ej7;
type
alumno = record
    dni: integer;
    legajo: string;
    nombreApellido:string;
    direccion: string;
    anio: integer;
    fechaNacimiento: longint;
end;
archivoAlumnos = file of alumno;

var
arch: archivoAlumnos;
respuesta : String;
opcion : String;
archivoTexto: Text;

//--------
procedure crearArchivo (var arch: archivoAlumnos; var archivoTexto: Text);
var
nombreArchivo: string[12];
alu : alumno;
begin
    //Creacion del archivo binario
    writeln ('Ingrese nombre del archivo');
    readln(nombreArchivo);
    assign (arch, nombreArchivo);
    //Lectura del archivo de texto
    assign (archivoTexto, 'alumnos.txt');
    reset (archivoTexto);
    while (not eof (archivoTexto)) do begin
      readln(archivoTexto, alu.dni, alu.legajo);
      readln (archivoTexto, alu.nombreApellido);
      readln (archivoTexto, alu.direccion, alu.anio, alu.fechaNacimiento);

      write(arch, alu);
    end;

    close (arch);
    close(archivoTexto);

end;
//--------------

procedure listarAlumnos (var arch: archivoAlumnos);
var
caracter: Char;
nombre: String;
alu: alumno;
begin
    writeln ('ingrese caracter por el que quiere listar');
    readln(caracter);
    reset (arch);
    while (not eof (arch)) do begin
      readln (arch, alu);
      if (alu.nombreApellido[1] = caracter) then begin
        writeln ('El dni del alumno es:', alu.dni );
        writeln ('El legajo del alumno es: ', alu.legajo);
        writeln ('El nombre del alumno es: ', alu.nombreApellido);
        writeln ('La direccion del alumno es : ', alu.direccion);
        writeln ('El anio que cursa el alumno es : ', alu.anio);
        writeln ('La fecha de nacimiento del alumno es: ', alu.fechaNacimiento);
      end;
    end;
    close(arch);
end;

//--------------

procedure crearArchivoTexto5toAnio (var arch: archivoAlumnos);
var
    archTexto : Text;
    alu: alumno;
begin
    reset (arch);
    assign(archTexto, 'alumnosAEgresar.txt');
    rewrite (archTexto);
    while (not eof (arch)) do begin
      readln (arch, alu);
      if (alu.anio = 5) then begin
        writeln(archTexto, alu.dni, alu.legajo);
        writeln (archTexto, alu.nombreApellido, alu.anio);
        writeln(archTexto, alu.direccion, alu.fechaNacimiento);
      end;
    end;

    close (archTexto);
    close(arch);
end;

//------------------
procedure agregarAlumno (var arch: archivoAlumnos);
var
alu:alumno;
begin
    //Apertura de archivo
    reset (arch);
    seek (arch, FileSize(arch));
    //Lectura de informacion
    writeln ('Ingrese dni');
    readln (alu.dni);
    writeln('Ingrese legajo ');
    readln (alu.legajo);
    writeln('Ingrese nombre y apellido');
    readln (alu.nombreApellido);
    writeln('Ingrese direccion ');
    readln (alu.direccion);
    writeln('Ingrese anio que cursa');
    readln (alu.anio);
    writeln('Ingrese fecha de nacimiento ');
    readln (alu.fechaNacimiento);
    //Escritura en archivo binario
    write (arch, alu);
    //Cierre de archivo
    close (arch);
end;
//-------------------

procedure modificarAnio(var arch: archivo);
var
legajo: String
alu: alumno;
begin

    writeln('Ingrese legajo del alumno que queire modificar');
    readln (legajo);
    while (not eof (arch)) do begin
      readln (arch, alu);
      if (alu.legajo = legajo) then begin
        alu.anio = alu.anio + 1; // paso de anio de cursada
      seek (arch, filepos(arch - 1));
      write(arch, alu);
      break
      end;
    end;

    close (arch);

end;


begin

writeln ('OPCIONES DE PROGRAMA');

writeln ('OPCION A: Crear un archivo de registros no ordenados con la información correspondiente a los alumnos de la facultad de ingeniería y cargarlo con datos obtenidos a partir de un archivo de texto denominado “alumnos.txt”.');
writeln ('OPCION B: listar en pantalla la informacion de alumnos cuyo nombre comiencen con un caracter proporcionado por el usuario');
writeln ('OPCION C: Listar en un archivo de texto denominado “alumnosAEgresar.txt” todos los registros del archivo de alumnos que cursen 5º año.');
writeln('OPCION D: Añadir uno o más alumnos al final del archivo con sus datos obtenidos por teclado.');
writeln('OPCION E: Modificar el año que cursa un alumno dado. Las búsquedas son por legajo del alumno.');

respuesta := 'si';
while (respuesta = 'si') do begin
    writeln ('Seleccionar opcion');
    readln (opcion);
    case opcion of  
        'A': begin
            crearArchivo(arch, archivoTexto);
        end;
        'B': begin
            listarAlumnos(arch);
        end;
        'C': begin
            crearArchivoTexto5toAnio (arch);
        end;
        'D': begin
          agregarAlumno(arch);
        end;
        'E': begin
          modificarAnio(arch);
        end;
        else begin
            writeln ('Opcion NO VALIDA');
        end;
    end;

    writeln ('Desea solicitar otra opcion? si - no');
    readln (respuesta);


end;


end.