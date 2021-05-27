import 'paciente.dart';

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
