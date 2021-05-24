import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../models/paciente.dart';
import 'detail_bpm.dart';
import 'details_oxygen.dart';
import '../utils/const.dart';
import '../widgets/card_items.dart';
import '../widgets/card_main.dart';
import '../widgets/custom_clipper.dart';

class DatosDelPaciente extends StatefulWidget {
  final Paciente paciente;

  const DatosDelPaciente({Key key, this.paciente}) : super(key: key);
  @override
  _DatosDelPacienteState createState() => _DatosDelPacienteState();
}

class _DatosDelPacienteState extends State<DatosDelPaciente> {
  @override
  void initState() {
    super.initState();
    //TODO: Cargar los datos y mediciones del paciente
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
                // Header - Greetings and Avatar
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
                      onPressed: () {},
                      iconSize: 30,
                    ),
                  ],
                ),

                SizedBox(height: 50),

                // Main Cards - Heartbeat and Blood Pressure
                Container(
                  height: 140,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      CardMain(
                        image: AssetImage('assets/icons/heartbeat.png'),
                        title: "Ritmo\nCardiaco",
                        value: "--",
                        unit: "bpm",
                        color: Constants.lightGreen,
                        detailsScreen: DetailsBPMScreen(),
                      ),
                      CardMain(
                        image: AssetImage('assets/icons/blooddrop.png'),
                        title: "Saturación\nde Oxígeno",
                        value: "--",
                        unit: "%",
                        color: Constants.lightYellow,
                        detailsScreen: DetailsSpO2Screen(),
                      )
                    ],
                  ),
                ),

                SizedBox(height: 50),

                // Scheduled Activities
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
                      CardItems(
                        image: Image.asset(
                          'assets/icons/Walking.png',
                        ),
                        title: "Walking",
                        value: "750",
                        unit: "steps",
                        color: Constants.lightYellow,
                        progress: 30,
                      ),
                      CardItems(
                        image: Image.asset(
                          'assets/icons/Swimming.png',
                        ),
                        title: "Swimming",
                        value: "30",
                        unit: "mins",
                        color: Constants.lightBlue,
                        progress: 0,
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
