import 'lectura.dart';

class Paciente {
  int idPaciente;
  String nombre;
  String apellidoPaterno;
  String apellidoMaterno;
  int telefono;
  String direccion;
  List<Lectura> lecturas;
  Paciente({
    this.idPaciente,
    this.nombre,
    this.apellidoPaterno,
    this.apellidoMaterno,
    this.telefono,
    this.direccion,
    this.lecturas,
  });
}
