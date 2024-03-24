Program ej4;

{
    Crear un procedimiento que reciba como parámetro el archivo del punto 2, y
    genere un archivo de texto con el contenido del mismo.
}
type
    archivo = file of integer;
    
var
    archivoTexto: Text;
    archivoInteger: archivo;
    nombreArchivo: String[12];
    numLeido: integer;

Procedure DuplicarATexto (Var archivoInteger : archivo);
Begin
    //Apertura del archivo de integer
   // writeln('Ingrese nombre del archivo de integer a procesar (del ejercicio 2)');
    //readln(nombreArchivo);
    assign(archivoInteger,'C:\Users\VICTUS\Documents\2024\CBD\Practica1\ejercicio2\dolores');
    reset (archivoInteger); 

    //Creacion del archivo de texto
    writeln ('Ingrese nombre del archivo de texto que vamos a pasar los datos');
    readln(nombreArchivo);
    assign(archivoTexto, nombreArchivo);
    rewrite(archivoTexto);

    //Lectura del archivo integer, y traspaso de info al archivo de texto
    while (not eof (archivoInteger)) do begin
        read (archivoInteger, numLeido );
        writeln('El numero leido es: ', numLeido);
        writeln (archivoTexto, numLeido); 
    end;

    //Cierre de archivos
    close(archivoInteger);
    close(archivoTexto);

end;


begin


DuplicarATexto(archivoInteger);

end.