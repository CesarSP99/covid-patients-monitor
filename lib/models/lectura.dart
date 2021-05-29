import 'dart:convert';

List<Lectura> lecturasFromJson(String str) =>
    List<Lectura>.from(json.decode(str).map((x) => Lectura.fromJson(x)));

String lecturasToJson(List<Lectura> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Lectura {
  Lectura({
    this.idLectura,
    this.idPaciente,
    this.ritmoCardiaco,
    this.saturacionOxigeno,
    this.fechaMedicion,
    this.idPacienteNavigation,
  });

  int idLectura;
  int idPaciente;
  double ritmoCardiaco;
  int saturacionOxigeno;
  DateTime fechaMedicion;
  dynamic idPacienteNavigation;

  factory Lectura.fromJson(Map<String, dynamic> json) => Lectura(
        idLectura: json["idLectura"],
        idPaciente: json["idPaciente"],
        ritmoCardiaco: json["ritmoCardiaco"].toDouble(),
        saturacionOxigeno: json["saturacionOxigeno"],
        fechaMedicion: DateTime.parse(json["fechaMedicion"]),
        idPacienteNavigation: json["idPacienteNavigation"],
      );

  Map<String, dynamic> toJson() => {
        "idLectura": idLectura,
        "idPaciente": idPaciente,
        "ritmoCardiaco": ritmoCardiaco,
        "saturacionOxigeno": saturacionOxigeno,
        "fechaMedicion": fechaMedicion.toIso8601String(),
        "idPacienteNavigation": idPacienteNavigation,
      };
}
