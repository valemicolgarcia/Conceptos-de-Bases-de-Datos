Program ej3;

    {
    Realizar un programa que permita crear un archivo de texto. El archivo se debe
    cargar con la información ingresada mediante teclado. La información a cargar
    representa los tipos de dinosaurios que habitaron en Sudamérica. La carga finaliza
    al procesar el nombre ‘zzz’ que no debe incorporarse al archivo.
    }
var
    archivoTexto: Text;
    nombreArchivo: String[12];
    dino: String;

begin
    writeln (' ');
    writeln ('Ejercicio 3');
    writeln('--');
    writeln('Ingrese el nombre del archivo: ');
    readln(nombreArchivo);
    assign (archivoTexto, nombreArchivo);
    rewrite(archivoTexto);

    writeln ('Ingrese un tipo de dinosaurio que habito en Sudamerica');
    readln(dino);
    writeln('El dinosaurio habitado es: ', dino);
    while (dino <> 'zzz') do begin
        write(archivoTexto, dino);
        writeln ('Ingrese un tipo de dinosaurio que habito en Sudamerica');
        readln(dino);
        writeln('El dinosaurio habitado es: ', dino);
    end;

    close(archivoTexto);
    
end.