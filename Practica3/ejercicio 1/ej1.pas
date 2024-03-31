program ej1;

{   INFORMACION
    . Se cuenta con un archivo que almacena información sobre especies de plantas originarias de
    Europa, de cada especie se almacena: código especie, nombre vulgar, nombre científico, altura
    promedio, descripción y zona geográfica. 
    
    ORDEN
    El archivo no está ordenado por ningún criterio.

    HACER:
    Realice un programa que elimine especies de plantas trepadoras. Para ello se recibe por
    teclado los códigos de especies a eliminar.

        BAJA LOGICA
        a. Implemente una alternativa para borrar especies, que inicialmente marque los
        registros a borrar y posteriormente compacte el archivo, creando un nuevo archivo
        sin los registros eliminados.

        BAJA FISICA
        b. Implemente otra alternativa donde para quitar los registros se deberá copiar el
        último registro del archivo en la posición del registro a borrar y luego eliminar del
        archivo el último registro de forma tal de evitar registros duplicados.

    Nota: Las bajas deben finalizar al recibir el código 100000
}

type    
    especie = record 
        codEspecie : string[10];
        nombre : string[12];
        nombreCientifico : string[12];
        altura: integer;
        descripcion : string[20];
        zona: string[12];
    end;

    archivo_especie = file of especie;

//VARIABLES ---
var
    archEspecie : archivo_especie;
    N : integer;
    codEliminar : string[10];
    baja: string[12];
    respuesta : string[5];

//PROCEDIMIENTOS ---

//BAJA FISICA
procedure bajaFisica (var arch : archivo_especie ; cod : string[10]);
var 
    posBorrar : integer;
    rp : especie;
    aux : especie;
begin
    reset (arch);
    rp.codEspecie = 'zzzzzz';
    while ( (not (EOF (arch)) ) and (rp.codEspecie <> cod)) do begin
        read (arch, rp); //leo un registro del archivo de especie hasta encontrar la que quiero eliminar
    end;

    if (rp.codEspecie = cod) then begin
        posBorrar := filepos(arch) - 1; //guardo la posicion a borrar
        seek (arch, filesize (a-1)); // me posiciono al final del archivo
        read (arch, aux); //leo el registro de la ultima posicion
        seek (arch, posBorrar); //me posiciono en la posicion a borrar
        write (arch, aux); //escribo el ultimo registro del archivo en la posicion donde estaba el dato a borrar
        seek (arch, filesize(arch) - 1); //me vuelvo a posicionar al final del archivo
        truncate (arch); 


    end;

    close (arch);
end;

//BAJA LOGICA
procedure bajaLogica (var arch : archivo_especie ; cod : string[10]);

var
    posBorrar : integer;
    rp: especie;
begin
    reset (arch);

    rp.codEspecie = 'zzzzz';
    while ((not (EOF (arch))) and (rp.codEspecie <> cod)) do begin
        read (arch, rp); //leo del archivo un registro hasta que encuentre el que quiero eliminar
    end;   
    if (rp.codEspecie = cod) then begin
        posBorrar = filepos(arch) - 1; //guardo la posicion a borrar
        rp.codEspecie = '@';
        seek (arch, posBorrar); //me posiciono en donde quiero borrar
        write (arch, rp); //escribo @ en ese registro
    end;

    close (arch);
end;

//PROGRAMA PRINCIPAL ---
begin

    assign (archEspecie, 'archivoEspecie');
    respuesta = 'si';

    while (respuesta = 'si') do begin
    
        writeln ('Ingrese codigo de especie que desea eliminar');
        readln (codEliminar);

        writeln ('Ingrese tipo de baja que quiere realizar ( fisica - logica )');
        readln (baja);

        case baja of   
            'fisica' : begin
                    writeln ('BAJA FISICA');
                    bajaFisica (archEspecie, codEliminar);
            end;
            'logica' : begin
                    writlen ('BAJA LOGICA');
                    bajaLogica (archEspecie, codEliminar);
            end;
            else begin
            writeln ('LA OPCION NO ES VALIDA');
            end;
        end;

        writeln ('Desea eliminar otra especie? si - no');
        readln (respuesta);

    end;
  
end.