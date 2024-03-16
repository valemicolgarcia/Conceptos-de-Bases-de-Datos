program ejemplo;
var
  nombre: string;
begin
  writeln('Escriba el nombre:');
  Read(nombre);
  writeln('El nombre ingresado es: ', nombre);
end.

{
  POR TERMINAL:
  COMPILAR --> fpc ejemplo.pas 
  EJECUTAR ./ ejemplo
}