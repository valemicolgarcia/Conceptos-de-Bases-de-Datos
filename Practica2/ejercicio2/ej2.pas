program ej2;
{
    Se necesita contabilizar los CD vendidos por una discográfica. 

 INFORMACION DEL ARCHIVO   
    Para ello se dispone de un archivo con la siguiente información: 
    código de autor, nombre del autor, nombredisco, género y la cantidad vendida de ese CD. 

hacer:
    Realizar un programa que muestre un listado como el que se detalla a continuación. 
    Dicho listado debe ser mostrado en pantalla y además listado en un archivo de texto. 
    En el archivo de texto se debe listar nombre del disco, nombre del autor y cantidad vendida. 
    El archivo origen está ordenado por código de autor, género y nombre disco.


}

const valorAlto = 1000000;

type

    cdVendido = Record
        codAutor: integer;
        nombreAutor: string[20];
        nombreDisco : string[20];
        genero: string[20];
        cantVendida: integer;
    end;

    archivo = file of cdVendido;

var
    arch: archivo;
    cd : cdVendido;
    cdActual: cdVendido;
    cantDiscos : integer;
    cantGenero: integer;
    cantAutor: integer;
    cantTotal: integer;

    archivoTexto: text;
   texto: string;
    

procedure leer (var arch: archivo; var cd: cdVendido);
begin
    if (not (EOF (arch))) then
      read (arch, cd) 
    else
        cd.codAutor := valorAlto;
end;

begin

    assign (arch, 'archivoCd');
    assign (archivoTexto, 'archivoTexto');
    rewrite (archivoTexto);
    reset (arch);
    cantTotal := 0;

    leer (arch, cd); // leo el primer cd vendido del archivo
    while (cd.codAutor <> valorAlto) do begin //mientras no se termine el archivo

      cdActual.codAutor:= cd.codAutor; //CODIGO DEL AUTOR
      texto := 'Autor: ' + cdActual.codAutor;
      writeln (texto); // imprimo por pantalla
      writeln (archivoTexto, texto);
      cantAutor := 0;

        while (cd.codAutor = cdActual.codAutor) do begin //PROCESAMIENTO POR CODIGO DE AUTOR
            cdActual.genero := cd.genero;

            texto := 'Genero: ' + cdActual.genero;
            writeln (texto); // imprimo por pantalla
            writeln (archivoTexto, texto); // listo en el archivo de texto

            cantGenero := 0;
            while (cdActual.genero = cd.genero) do begin //PROCESAMIENTO POR GENERO

                cdActual.nombreDisco := cd.nombreDisco;
                cantDiscos = 0;

                while (cdActual.nombreDisco = cd.nombreDisco) do begin //PROCESAMIENTO POR NOMBRE DE DISCO
                    cantDiscos := cantDiscos + 1; 
                end;

                texto:+ 'Nombre Disco: ' + cdActual.nombreDisco + 'cantidad vendida: ' + cantDiscos;
                writeln (texto); // imprimo por pantalla
                writeln (archivoTexto, texto); //listo en el archivo de texto
                cantGenero := cantGenero + cantDiscos;

            end;
            texto:= 'Total Genero: ' + cantGenero;
            writeln (texto); // imprimo por pantalla
            writeln (archivoTexto, texto); //listo en el archivo de texto

            cantAutor: cantAutor + cantGenero;
        end;
      texto := 'Total Autor: ' + cantAutor;
      writeln (texto); // imprimo por pantalla
      writeln (archivoTexto, texto); //listo en el archivo de texto
      
      cantTotal := cantTotal + cantAutor;
      
    end;

    writeln ('Total Discografica: ', cantTotal);


    close(arch);
    close (archivoTexto);
  
end.