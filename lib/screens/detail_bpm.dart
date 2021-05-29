import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../utils/const.dart';
import '../widgets/custom_clipper.dart';
import '../widgets/grid_item.dart';
import '../models/paciente.dart';
import '../models/lectura.dart';

class DetailsBPMScreen extends StatefulWidget {
  final Paciente paciente;
  final List<Lectura> lecturas;

  DetailsBPMScreen({this.paciente, this.lecturas});

  @override
  _DetailsBPMScreenState createState() => _DetailsBPMScreenState();
}

class _DetailsBPMScreenState extends State<DetailsBPMScreen> {
  String bpm;
  Paciente paciente;
  List<Lectura> lecturas;
  double promedio;

  @override
  void initState() {
    super.initState();
    bpm = "--";
    paciente = widget.paciente;
    lecturas = widget.lecturas;
    promedio = 0;
    if (lecturas.isNotEmpty) {
      bpm = lecturas.last.ritmoCardiaco.toStringAsFixed(2);
      double acumulador = 0;
      lecturas.forEach((element) {
        acumulador += element.ritmoCardiaco;
      });
      promedio = acumulador / lecturas.length;
    }
  }

  @override
  Widget build(BuildContext context) {
    double statusBarHeight = MediaQuery.of(context).padding.top;

    // For Grid Layout
    double _crossAxisSpacing = 16, _mainAxisSpacing = 16, _cellHeight = 150.0;
    int _crossAxisCount = 2;

    double _width = (MediaQuery.of(context).size.width -
            ((_crossAxisCount - 1) * _crossAxisSpacing)) /
        _crossAxisCount;
    double _aspectRatio =
        _width / (_cellHeight + _mainAxisSpacing + (_crossAxisCount + 1));

    return Scaffold(
      backgroundColor: Constants.backgroundColor,
      body: Stack(
        children: <Widget>[
          ClipPath(
            clipper: MyCustomClipper(clipType: ClipType.bottom),
            child: Container(
              color: Constants.darkGreen,
              height: Constants.headerHeight + statusBarHeight,
            ),
          ),

          Positioned(
            right: -45,
            top: -30,
            child: ClipOval(
              child: Container(
                color: Colors.black.withOpacity(0.05),
                height: 220,
                width: 220,
              ),
            ),
          ),

          // BODY
          Padding(
            padding: EdgeInsets.all(Constants.paddingSide),
            child: ListView(
              scrollDirection: Axis.vertical,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        // Back Button
                        SizedBox(
                          width: 34,
                          child: RawMaterialButton(
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Icon(Icons.arrow_back_ios,
                                size: 15.0, color: Colors.white),
                            shape: CircleBorder(
                              side: BorderSide(
                                  color: Colors.white,
                                  width: 2,
                                  style: BorderStyle.solid),
                            ),
                          ),
                        ),
                        SizedBox(width: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Ritmo Cardiaco",
                              style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.white),
                            ),
                            SizedBox(height: 10),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.baseline,
                              mainAxisAlignment: MainAxisAlignment.start,
                              textBaseline: TextBaseline.alphabetic,
                              children: <Widget>[
                                Text(
                                  bpm,
                                  style: TextStyle(
                                      fontSize: 48,
                                      fontWeight: FontWeight.w900,
                                      color: Colors.white),
                                ),
                                SizedBox(width: 10),
                                Text(
                                  "bpm",
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white),
                                ),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                    Spacer(),
                    Image(
                        fit: BoxFit.cover,
                        image: AssetImage('assets/icons/heartbeatthin.png'),
                        height: 73,
                        width: 80,
                        color: Colors.white.withOpacity(1)),
                  ],
                ),
                SizedBox(height: 30),
                // Chart
                Material(
                  shadowColor: Colors.grey.withOpacity(0.01), // added
                  type: MaterialType.card,
                  elevation: 10, borderRadius: new BorderRadius.circular(10.0),
                  child: Container(
                    padding: EdgeInsets.all(10.0),
                    height: 300,
                    child: lecturas.length >= 5
                        ? Padding(
                            padding: EdgeInsets.only(
                              bottom: 10,
                              top: 20,
                              left: 20,
                              right: 20,
                            ),
                            child: LineChart(
                              LineChartData(
                                minX: 0,
                                maxX: 6,
                                minY: 60,
                                maxY: 120,
                                borderData: FlBorderData(
                                  show: false,
                                ),
                                titlesData: getTitleData(),
                                gridData: getGridData(),
                                lineBarsData: [
                                  LineChartBarData(
                                    isCurved: true,
                                    belowBarData: BarAreaData(
                                      show: true,
                                      colors: [
                                        Constants.lightGreen.withOpacity(0.3)
                                      ],
                                    ),
                                    colors: [Constants.darkGreen],
                                    spots: [
                                      FlSpot(
                                        1,
                                        lecturas[lecturas.length - 5]
                                            .ritmoCardiaco
                                            .toDouble(),
                                      ),
                                      FlSpot(
                                        2,
                                        lecturas[lecturas.length - 4]
                                            .ritmoCardiaco
                                            .toDouble(),
                                      ),
                                      FlSpot(
                                        3,
                                        lecturas[lecturas.length - 3]
                                            .ritmoCardiaco
                                            .toDouble(),
                                      ),
                                      FlSpot(
                                        4,
                                        lecturas[lecturas.length - 2]
                                            .ritmoCardiaco
                                            .toDouble(),
                                      ),
                                      FlSpot(
                                        5,
                                        lecturas[lecturas.length - 1]
                                            .ritmoCardiaco
                                            .toDouble(),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          )
                        : Center(
                            child: Text(
                              "No hay datos suficientes para hacer el gráfico",
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w900,
                                color: Colors.black,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                  ), // added
                ),
                SizedBox(height: 30),
                Container(
                  child: new GridView.builder(
                    shrinkWrap: true,
                    primary: false,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: _crossAxisCount,
                      crossAxisSpacing: _crossAxisSpacing,
                      mainAxisSpacing: _mainAxisSpacing,
                      childAspectRatio: _aspectRatio,
                    ),
                    itemCount: 2,
                    itemBuilder: (BuildContext context, int index) {
                      switch (index) {
                        case 0:
                          return GridItem(
                              status: "BPM Promedio",
                              time: "",
                              value: promedio != 0
                                  ? promedio.toInt().toString()
                                  : '--',
                              unit: "bpm",
                              color: Constants.darkGreen,
                              image: null,
                              remarks: "ok");
                          break;
                        case 1:
                          return GridItem(
                            status: "Prediagnóstico",
                            time: "",
                            value: "",
                            unit: "",
                            color: Constants.darkOrange,
                            image: lecturas.isNotEmpty
                                ? lecturas.last.ritmoCardiaco >= 60
                                    ? AssetImage("assets/icons/Heart.png")
                                    : AssetImage("assets/icons/Sick.png")
                                : AssetImage("assets/icons/Unknown.png"),
                            remarks: "",
                          );
                          break;
                        default:
                          return GridItem(
                            status: "Rest",
                            time: "4h 45m",
                            value: "76",
                            unit: "avg bpm",
                            image: null,
                            remarks: "ok",
                            color: Constants.darkOrange,
                          );
                          break;
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

FlGridData getGridData() {
  return FlGridData(
    show: true,
    getDrawingHorizontalLine: (value) {
      return FlLine(
        color: Constants.darkGreen,
        strokeWidth: value % 5 == 0 ? 1 : 0,
      );
    },
    drawVerticalLine: true,
    getDrawingVerticalLine: (value) {
      return FlLine(
        color: Constants.darkGreen,
        strokeWidth: 1,
      );
    },
  );
}

FlTitlesData getTitleData() {
  return FlTitlesData(
    show: true,
    bottomTitles: SideTitles(
      showTitles: true,
      reservedSize: 22,
      getTextStyles: (value) => const TextStyle(
        color: Colors.blueGrey,
        fontSize: 15,
      ),
      getTitles: (value) {
        return value == 0 || value == 6 ? '' : '${value.toInt()}';
      },
      margin: 8,
    ),
    leftTitles: SideTitles(
      showTitles: true,
      reservedSize: 22,
      getTextStyles: (value) => TextStyle(
        color: Colors.blueGrey,
        fontSize: 15,
      ),
      getTitles: (value) {
        return value % 10 == 0 ? '${value.toInt()}' : '';
      },
      margin: 8,
    ),
  );
}
