program ej3;
{       CONTEXTO:
        Una tienda de indumentaria desea almacenar sus productos en un archivo de datos para la
    posterior actualización de stock con las compras y ventas de indumentario. 
    
    ARCHIVO DE TEXTO:
    Para ello cuenta con un archivo de texto donde tiene almacenada la siguiente información: 
    código de producto, nombre, descripción y stock.
    
    TRANSFORMAR A ARCHIVO BINARIO
    a. Deberá realizar un procedimiento que tomando como entrada el archivo de texto,
    genere el correspondiente archivo binario de datos.

    ELIMINAR DATOS UTILIZADNO MARCA DE BORRADO (VALOR NEGATIVO AL STOCK)
    b. Se reciben por pantalla códigos de indumentaria obsoletos, los cuales deben
    eliminarse del archivo de datos, utilizando una marca de borrado. La marca de
    borrado consiste en poner valor negativo al stock. Realice el procedimiento
    correspondiente

    AGREGAR INDUMENTARIA
    c. A continuación, se solicita realizar un procedimiento que permita realizar el alta de
    una nueva indumentaria con los valores obtenidos por teclado.

    TECNICA DE LISTA INVERTIDA, ELIMINAR
    d. Realice un nuevo procedimiento de baja, suponiendo que la creación del archivo
    supuso la utilización de la técnica de lista invertida para reutilización de espacio
    (dejó un registro obsoleto al comienzo del archivo como cabecera de lista).

    TECNICA DE LISTA IMVERTIDA, AGREGAR
    e. Re implemente c, sabiendo que se utiliza la técnica de lista en invertida.

    AGREGAR ARCHIVOS CON LISTA INVERTIDA
    f. Re implementa a, para poder utilizar la técnica de lista invertida.

    g. Enumere ventajas que encuentra entre agregar y eliminar indumentaria con o sin
    utilización de la técnica de recuperación de espacio libre

}

type 

    indumentaria = record
        codProd : integer;
        nombre: string[12];
        descripcion: string[50];
        stock: integer;
    end;

    arch_indumentaria = file of indumentaria;

//VARIABLES ---
var
    archIndumentaria : arch_indumentaria;
    archTexto : text;
    cod : integer;

//PROCEDIMIENTOS---

{a. Deberá realizar un procedimiento que tomando como entrada el archivo de texto,
    genere el correspondiente archivo binario de datos.}
procedure transformar_a_binario (var archTexto : text ; var archIndumentaria: arch_indumentaria);
var
    indu: indumentaria;
begin
    reset (archTexto);
    rewrite (archIndumentaria);

    while (not (EOF (archTexto))) do begin
      readln (indu.codProd, indu.nombre);
      readln (indu.descripcion);
      readln (indu.stock);
      write (archIndumentaria, indu);
    end;

    close (archIndumentaria);
    close (archTexto);
end;

{b. Se reciben por pantalla códigos de indumentaria obsoletos, los cuales deben
    eliminarse del archivo de datos, utilizando una marca de borrado. La marca de
    borrado consiste en poner valor negativo al stock. Realice el procedimiento
    correspondiente}
//BAJA LOGICA
procedure eliminar_marca_borrado (var archIndumentaria: arch_indumentaria; cod : integer);
var
    posBorrar : integer;
    indu : indumentaria;
begin
    reset (archIndumentaria);

    indu.codProd := 99999;

    while ((not (EOF (arch))) and (indu.codProd<> cod)) do begin
        read (arch, rp); //leo del archivo un registro hasta que encuentre el que quiero eliminar
    end; 

    if (indu.codProd = cod) then begin
      posBorrar := filepos (arch) - 1;
      indu.stock := -1; //VALOR NEGATIVO AL STOCK, MARCA DE BORRADO
      seek (archIndumentaria, posBorrar);
      write (arch, indu); 
    end;

    close (archIndumentaria);
end;

{ AGREGAR INDUMENTARIA
    c. A continuación, se solicita realizar un procedimiento que permita realizar el alta de
    una nueva indumentaria con los valores obtenidos por teclado.}

procedure agregar_indumentaria (archIndumentaria : arch_indumentaria; indu : indumentaria);
begin
    reset (archIndumentaria);
    seek (archIndumentaria, FileSize(arch)); //me posiciono al final del archivo
    write (archIndumentaria, indu);
    close (archIndumentaria);

end;

{TECNICA DE LISTA INVERTIDA, ELIMINAR
    d. Realice un nuevo procedimiento de baja, suponiendo que la creación del archivo
    supuso la utilización de la técnica de lista invertida para reutilización de espacio
    (dejó un registro obsoleto al comienzo del archivo como cabecera de lista).}

procedure eliminar_lista_invertida (var archIndumentaria : arch_indumentaria; cod: integer);
var
    sLibre: string[50];
    indu : indumentaria;
    nLibre: integer;
begin
    reset (archIndumentaria);

    read (archIndumentaria, sLibre);
    induCod := 9999;

    while (not (indu.codProd = cod) or (EOF(arch))) do begin
      read (archIndumentaria, indu); //leo un reg del archivo hasta que encuentre el codigo a eliminar o terminar el archivo
    end;

    if (indu.cod = cod) then begin
        nLibre := filepos(archIndumentaria) - 1; //me guardo la pos a eliminar
        seek (archIndumentaria, nLibre); //me posiciono en el registro a eliminar
        write (archIndumentaria, sLibre); //grabo el contenido de la cabecera en esa posicion (sobreescribo el registro a eliminar)
        str (nLibre, sLibre); 
        seek (archIndumentaria, 0); //me posiciono al principio del archivo
        write (archIndumentaria, sLibre); //se actualiza la cabecera

    end else begin
      writeln ('No se encontro el codigo de indumentaria')
    end;

    close (archIndumentaria);
end;

{TECNICA DE LISTA IMVERTIDA, AGREGAR
    e. Re implemente c, sabiendo que se utiliza la técnica de lista en invertida.}
procedure agregar_lista_invertida (var archIndumentaria : arch_indumentaria; indu: indumentaria);
var
    sLibre : string[50]; //string con el proximo registro libre NO SE SI DEBERIA SER STRING
    nLibre: integer; //numero del proximo registro libre
    cod: integer;
    indu : indumentaria;
begin
    reset (archIndumentaria);

    read (archIndumentaria, sLibre); //leo la cabecera
    val (sLibre, nLibre, cod);

    if (nLibre = -1) then begin
      seek (archIndumentaria, filesize(arch)); //si no hay registros libre voy al final
    end else begin

      seek (archIndumentaria, nLibre); //me posiciono en el registro libre a utilizar
      read (arch, sLibre); //leo la posicion libre a reutilizar

      seek (archIndumentaria, 0); //me posiciono en la cabecera
      write (archIndumentaria, sLibre); //actualizo la cabecera

      seek (archIndumentaria, nLibre); //me posiciono en el registro libre nuevamente

    end;


    writeln ('Indumentaria');
    write (archIndumentaria, indu);

    close (archIndumentaria);
end;

{AGREGAR ARCHIVOS CON LISTA INVERTIDA - LEER DEL ARCH TEXTO
    f. Re implementa a, para poder utilizar la técnica de lista invertida.}

procedure transformar_binario_lista_invertida (var archTexto : text ; var archIndumentaria: arch_indumentaria);
begin
  
    while (not (EOF (archTexto))) do begin
      readln (indu.codProd, indu.nombre);
      readln (indu.descripcion);
      readln (indu.stock);
      
      agregar_lista_invertida (archIndumentaria, indu);

    end;
end;

//PROGRAMA PRINCIPAL

begin
  
    assign (archTexto, 'archTexto.txt');
    assign (archIndumentaria, 'archIndumentaria');
    transformar_a_binario (archTexto, archIndumentaria);
    eliminar_marca_borrado (archIndumentaria, cod);    //le mando codigos de indumentaria que quiero borrar




end.