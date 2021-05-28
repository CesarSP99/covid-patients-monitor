import 'dart:convert';

List<Paciente> pacienteFromJson(String str) =>
    List<Paciente>.from(json.decode(str).map((x) => Paciente.fromJson(x)));

String pacienteToJson(List<Paciente> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Paciente {
  Paciente({
    this.idPaciente,
    this.nombre,
    this.apellidoPat,
    this.apellidoMat,
    this.direccion,
    this.telefono,
    this.lecturas,
  });

  int idPaciente;
  String nombre;
  String apellidoPat;
  String apellidoMat;
  String direccion;
  String telefono;
  List<dynamic> lecturas;

  factory Paciente.fromJson(Map<String, dynamic> json) => Paciente(
        idPaciente: json["idPaciente"],
        nombre: json["nombre"],
        apellidoPat: json["apellidoPat"],
        apellidoMat: json["apellidoMat"],
        direccion: json["direccion"],
        telefono: json["telefono"],
        lecturas: List<dynamic>.from(json["lecturas"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "idPaciente": idPaciente,
        "nombre": nombre,
        "apellidoPat": apellidoPat,
        "apellidoMat": apellidoMat,
        "direccion": direccion,
        "telefono": telefono,
        "lecturas": List<dynamic>.from(lecturas.map((x) => x)),
      };
}
