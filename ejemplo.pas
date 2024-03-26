program ejemplo;
    const nro_detalle = 500;
    const valor_alto = '99999';
type
    detalle = record
        localidad: integer;
        prov: integer;
        validos: integer;
        anulados: integer;
        blanco: integer;
    end;

    Maestro = record
        prov: string[50];
        cod_prov:integer;
        validos: integer;
        blancos: integer;
        anulados: integer;
    end;

    det = file of detalle;
    Mae = file of Maestro;

    detA = Array [1..nro_detalle] of Detalle;
    detR = Array [1..nro_detalle] of Detalle;

var
    M: Mae;
    regm: Maestro;
    min: Detalle;
    Aux: integer;
    ArchivosD: detA;
    RegistrosD: detR;
    votos : Text;
    totalB, totalV, totalA, : integer;
    cantB, cantV, cantA: integer;
    i: integer;

procedure leer (var Det: ArchDet ; var D: Detalle);
var
begin
    if (not (eof(ArchDet)))
        read (ArchDet, D)
    else 
        D.prov := valor_alto
end;

procedure Minimo (var DetR: DetalleR; var DetA: DetalleA; var min: Detalle);
var
    Pos: integer;
begin
  Pos:= 1 ;
  min := DetR [pos];
  for (i:=o to nro_detalle) do begin
        if (min.codProv > DetR[i].codProv ) then begin
        min:= DetR[i];
        Pos:= i;
        end;
  end;
  leer (DetA[pos], DetR[pos]);
end;


begin
    
    Assign (m, 'maestro.txt');
    reset (m);
    for i:= 0 to nro_detalle do begin
      Assign (ArchivosD[i], 'Detalle ' + i);
      leer (Archivos[i], RegistrosD[i]);
    end;

    Assign (votos, 'cantidadVotos.txt');
    rewrite (votos);

    minimo (registrosD, ArchivosD, min);
    if (not (EOF (M))) 
        read (M, regM);
    totalB:= 0;
    totalV:=0;
    totalA:=0;

    while (min.codProv <> valor_alto) do begin
      while (regM.Provincia <> min.codProv) do begin
        read (M, regM);
      aux := min.codProv;
      while (aux:= min.codProv) do begin
        regM.validos := regM.validos + min.validos;
        regM.anulados := regM.anulados + min.anulados;
        reg.blanco := reg.blanco + min.blanco;
      end;

    totalB:= totalB + min.Blanco;
    totalV:= totalV + min.validos;
    total A := totalA + min.anulados;
    minimo (RegistrosD, ArchivosD, min);
      end;
    seek (m, filePos(n-1));
    write (m, regM);
    end;

    writeln (texto, 'Cantidad de archivos detalle procesados: ' + nroDetalle);
    writeln (texto, 'total Votos' + (totalB + totalV + totalA));

    close (m);
    close (texto);
    close (votos);
    for i:= 1 to nro_detalle do begin
      close (ArchivosD[i]);
    end;


end.