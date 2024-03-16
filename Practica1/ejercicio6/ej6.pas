Program ej6;

{
    6. Realizar un programa que permita:
    a. Crear un archivo binario a partir de la información almacenada en un archivo de texto. El nombre del archivo de texto es: “libros.txt”
    b. Abrir el archivo binario y permitir la actualización del mismo. Se debe poder agregar un libro y modificar uno existente. 
    Las búsquedas se realizan por ISBN.

}

type
    libro = record
        ISNB: integer;
        titulo: string;
        genero: string;
        editorial: string;
        anioEdicion: integer;
    end;

    archivoLibro =  file of libro;

var
    archivoTexto: text;
    archivoBinario: archivoLibro;
    nombreArchivoBinario: String;
    lib : libro;
    respuesta: String;
    opcion: String;

//--------------------------------------------------------------
procedure agregarLibro (var arch: archivoLibro);
var
lib: libro;
begin
    //Apertura de archivo
    reset(arch);
    seek (arch, FileSize(arch)); //me posiciono al final

    //Lectura de informacion
    writeln ('Ingrese ISBN del libro - integer');
    readln (lib.ISNB);
    writeln ('Ingrese titulo del libro');
    readln (lib.titulo);
    writeln ('Ingrese genero del libro');
    readln (lib.genero);
    WriteLn('Ingrese editorial del libro');
    readln (lib.editorial);
    writeln('ingrese anio de edicion del libro');
    readln (lib.anioEdicion);

    //Escritura en archivo binario
    write(arch, lib);
    //Cierre de archivo
    close (arch);
end;
//----------------------------------------------------
procedure modificarLibro (var arch: archivoLibro);
var
modificacion: string;
respuesta: string;
lib: libro;
ISBN: integer;
begin
    writeln ('Ingrese ISBN del libro que desea modificar');
    readln (ISBN);

    while (not eof (arch)) do begin
      read (arch,lib);
      if(lib.ISNB = ISBN) then begin


            respuesta:= 'si';
            while (respuesta = 'si') do begin

                writeln ('Que desea modificar? ISBN - EDITORIAL - GENERO - ANIO - TITULO');
                readln(modificacion);

                case modificacion of 
                    'ISBN': begin
                    writeln ('Ingrese nuevo ISBN');
                    readln (lib.ISNB);
                    end;
                    'EDITORIAL': begin
                    writeln ('Ingrese editorial');
                    readln (lib.editorial);
                    end;
                    'GENERO': begin
                    writeln ('Ingrese genero');
                    readln (lib.genero);
                    end;
                    'ANIO': begin
                    writeln ('Ingrese anio de edicion');
                    readln (lib.anioEdicion);
                    end;
                    'TITULO':begin
                    writeln ('Ingrese titulo');
                    readln (lib.titulo);
                    end;
                    else begin
                    writeln ('OPCION NO VALIDA');
                    end;
                end;

                writeln ('Desea realizar otra modificacion?');
                writeln (respuesta);

            end;
            seek (arch, filepos(arch - 1));
            write (arch, lib);
            writeln ('Libro modificado!!!!');
      end;
    end;

    
end;
//--------------------------------------------

begin 

    //Creacion del archivo binario
    writeln('Ingrese nombre del archivo binario');
    read(nombreArchivoBinario);
    assign (archivoBinario, nombreArchivoBinario);
    rewrite(archivoBinario);

    //Lectura del archivo de texto
    assign(archivoTexto, 'libros.txt');
    reset (archivoTexto);

    while (not eof (archivoTexto)) do begin
      readln(archivoTexto, lib.ISNB, lib.titulo);
      readln(archivoTexto, lib.anioEdicion, lib.editorial);
      readln(archivoTexto, lib.genero);
      write(archivoBinario, lib);
    end;

    writeln ('Desea actualizar el archivo binario? si - no');
    readln (respuesta);
    while (respuesta = 'si') do begin
      
        writeln ('OPCIONES DE PROGRAMA');
        writeln ('Seleccione una opcion: ');
        writeln ('A: modificar libro');
        writeln ('B: agregar libro');
        readln (opcion);

        case opcion of
            'A': begin
                writeln('OPCION A');
                modificarLibro(archivoBinario);
            end; 
            'B': begin
                writeln('OPCION B');
                agregarLibro (archivoBinario);
            end;
            else begin
            writeln ('Opcion NO VALIDA.');
            end;
        end;

    
    end;


    close(archivoTexto);
    close(archivoBinario);

end.