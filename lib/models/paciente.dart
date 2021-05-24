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

class Lectura {
  int idLectura;
  DateTime fecha;
  int ritmoCardiaco;
  int saturacionOxigeno;
  int idPaciente;
  Paciente paciente;
  Lectura({
    this.idLectura,
    this.fecha,
    this.ritmoCardiaco,
    this.saturacionOxigeno,
    this.idPaciente,
    this.paciente,
  });
}
