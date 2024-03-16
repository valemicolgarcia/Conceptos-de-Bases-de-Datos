Program ej1;

type
  archivo = file of String;

var
  archLogico : archivo;
  nombreArchivo: String[12];
  material: String[12];

begin
  writeln('  ');
  writeln('Ejercicio n1');

  writeln ('Ingrese nombre del archivo');
  readln (nombreArchivo);
  assign(archLogico, nombreArchivo); //correspondencia entre el nombre fisico y el nombre logico
  rewrite(archLogico); //creo el archivo

  writeln('Ingrese un material de construccion');
  readln (material);
  writeln('El material de construccion es: ', material);
  

  while (material <> 'cemento') do begin
    write (archLogico, material);
    writeln ('Ingrese un material de construccion');
    readln(material);
  end;
  

  close(archLogico);

end.