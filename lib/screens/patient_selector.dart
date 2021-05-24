import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:monitor/models/paciente.dart';
import 'package:monitor/screens/patient_data.dart';
import '../utils/const.dart';
import '../widgets/custom_clipper.dart';
import 'dart:math' as math;

class PatientSelector extends StatefulWidget {
  @override
  _PatientSelectorState createState() => _PatientSelectorState();
}

class _PatientSelectorState extends State<PatientSelector> {
  List<Paciente> listaDePacientes;

  @override
  void initState() {
    super.initState();
    //TODO: Cargar los pacientes
    listaDePacientes = [
      Paciente(
        nombre: 'Cesar',
        apellidoPaterno: 'Salazar',
        apellidoMaterno: 'Pereira',
        telefono: 678789,
      ),
      Paciente(
        nombre: 'Sebastian',
        apellidoPaterno: 'M',
        apellidoMaterno: 'Y',
        telefono: 680329,
      ),
      Paciente(
        nombre: 'Laura',
        apellidoPaterno: 'M',
        apellidoMaterno: 'K',
        telefono: 837939,
      )
    ];
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
              height: 125 + statusBarHeight,
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
                // Header - Greetings and Avatar
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        "Listado de pacientes",
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w900,
                            color: Colors.white),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.refresh_rounded),
                      onPressed: () {},
                      iconSize: 30,
                    ),
                  ],
                ),

                SizedBox(height: 50),

                //Lista de pacientes

                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: listaDePacientes.length,
                    itemBuilder: (context, index) {
                      Paciente paciente = listaDePacientes[index];
                      var baseColor =
                          Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
                              .withOpacity(1.0);
                      return Card(
                        elevation: 5,
                        child: ListTile(
                          title: Text(
                              '${paciente.nombre} ${paciente.apellidoPaterno} ${paciente.apellidoMaterno}'),
                          subtitle: Text(paciente.telefono.toString()),
                          leading: CircleAvatar(
                            backgroundImage:
                                AssetImage('assets/icons/patient.png'),
                          ),
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    DatosDelPaciente(paciente: paciente)),
                          ),
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
