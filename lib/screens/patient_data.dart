import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:monitor/models/lectura.dart';
import 'package:monitor/widgets/card_personal_data.dart';
import '../models/paciente.dart';
import 'detail_bpm.dart';
import 'details_oxygen.dart';
import '../utils/const.dart';
import '../widgets/card_main.dart';
import '../widgets/custom_clipper.dart';
import 'package:http/http.dart' as http;

class DatosDelPaciente extends StatefulWidget {
  final Paciente paciente;

  const DatosDelPaciente({Key key, this.paciente}) : super(key: key);
  @override
  _DatosDelPacienteState createState() => _DatosDelPacienteState();
}

class _DatosDelPacienteState extends State<DatosDelPaciente> {
  Paciente paciente;
  String bpm;
  String spo2;
  List<Lectura> lecturas;

  @override
  void initState() {
    super.initState();
    paciente = widget.paciente;
    bpm = "--";
    spo2 = "--";
    cargarLecturas();
  }

  Future<void> cargarLecturas() async {
    Uri uri = Uri.http(
        '52.152.220.15:8080', '/api/Lecturas/${paciente.idPaciente}', {});
    var response = await http.get(uri);
    setState(() {
      lecturas = lecturasFromJson(response.body);
      if (lecturas.isNotEmpty) {
        bpm = lecturas.last.ritmoCardiaco.toStringAsFixed(2);
        spo2 = lecturas.last.saturacionOxigeno.toString();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double statusBarHeight = MediaQuery.of(context).padding.top;

    return Scaffold(
      backgroundColor: Constants.backgroundColor,
      body: Stack(
        children: <Widget>[
          ClipPath(
            clipper: MyCustomClipper(clipType: ClipType.bottom),
            child: Container(
              color: Theme.of(context).accentColor,
              height: Constants.headerHeight + statusBarHeight,
            ),
          ),
          Positioned(
            right: -45,
            top: -30,
            child: ClipOval(
              child: Container(
                color: Colors.black.withOpacity(0.05),
                height: 175,
                width: 175,
              ),
            ),
          ),

          // BODY
          Padding(
            padding: EdgeInsets.all(Constants.paddingSide),
            child: ListView(
              children: <Widget>[
                // Header
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        "Datos sobre el paciente",
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w900,
                            color: Colors.white),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.refresh_rounded),
                      onPressed: () => cargarLecturas(),
                      iconSize: 30,
                    ),
                  ],
                ),

                SizedBox(height: 50),

                // Main Cards
                Container(
                  height: 140,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      CardMain(
                        image: AssetImage('assets/icons/heartbeat.png'),
                        title: "Ritmo\nCardiaco",
                        value: bpm,
                        unit: "bpm",
                        color: Constants.lightGreen,
                        detailsScreen: DetailsBPMScreen(
                          paciente: paciente,
                          lecturas: lecturas,
                        ),
                      ),
                      CardMain(
                        image: AssetImage('assets/icons/blooddrop.png'),
                        title: "Saturación\nde Oxígeno",
                        value: spo2,
                        unit: "%",
                        color: Constants.lightYellow,
                        detailsScreen: DetailsSpO2Screen(
                          paciente: paciente,
                          lecturas: lecturas,
                        ),
                      )
                    ],
                  ),
                ),

                SizedBox(height: 50),

                // DATOS PERSONALES
                Text(
                  "DATOS PERSONALES",
                  style: TextStyle(
                      color: Constants.textPrimary,
                      fontSize: 13,
                      fontWeight: FontWeight.bold),
                ),

                SizedBox(height: 20),

                Container(
                  child: ListView(
                    scrollDirection: Axis.vertical,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    children: <Widget>[
                      CardPersonalData(
                        title: "Nombre",
                        icon: Icon(Icons.contact_page),
                        color: Colors.cyan,
                        detail:
                            '${paciente.nombre} ${paciente.apellidoPat} ${paciente.apellidoMat}',
                      ),
                      CardPersonalData(
                        title: "Telefono",
                        icon: Icon(Icons.phone),
                        color: Colors.cyan,
                        detail: paciente.telefono,
                      ),
                      CardPersonalData(
                        title: "Direccion",
                        icon: Icon(Icons.map),
                        color: Colors.cyan,
                        detail: paciente.direccion,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
