import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:monitor/models/lectura.dart';
import 'package:monitor/models/paciente.dart';
import '../utils/const.dart';
import '../widgets/custom_clipper.dart';
import '../widgets/grid_item.dart';
import '../widgets/progress_vertical.dart';

class DetailsSpO2Screen extends StatefulWidget {
  final Paciente paciente;
  final List<Lectura> lecturas;

  DetailsSpO2Screen({this.paciente, this.lecturas});

  @override
  _DetailsSpO2ScreenState createState() => _DetailsSpO2ScreenState();
}

class _DetailsSpO2ScreenState extends State<DetailsSpO2Screen> {
  String spo2;
  Paciente paciente;
  List<Lectura> lecturas;

  @override
  void initState() {
    super.initState();
    spo2 = "--";
    paciente = widget.paciente;
    lecturas = widget.lecturas;
    if (lecturas.isNotEmpty) {
      spo2 = lecturas.last.ritmoCardiaco.toString();
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
              color: Constants.darkOrange,
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
                              "Saturación de O₂",
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
                                  spo2,
                                  style: TextStyle(
                                      fontSize: 48,
                                      fontWeight: FontWeight.w900,
                                      color: Colors.white),
                                ),
                                SizedBox(width: 10),
                                Text(
                                  "%",
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
                    padding: EdgeInsets.all(20.0),
                    height: 300,
                    child: Column(
                      children: <Widget>[
                        // Rest Active Legend
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.all(10.0),
                              width: 10,
                              height: 10,
                              decoration: BoxDecoration(
                                  color: Constants.lightYellow,
                                  shape: BoxShape.circle),
                            ),
                            Text("Rest"),
                            Container(
                              margin: EdgeInsets.only(left: 10.0, right: 10.0),
                              width: 10,
                              height: 10,
                              decoration: BoxDecoration(
                                  color: Constants.darkOrange,
                                  shape: BoxShape.circle),
                            ),
                            Text("Active"),
                          ],
                        ),
                        SizedBox(height: 20),
                        // Main Cards - Heartbeat and Blood Pressure
                        Container(
                          height: 100,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: <Widget>[
                              ProgressVertical(
                                value: 50,
                                date: "5/11",
                                isShowDate: true,
                              ),
                              ProgressVertical(
                                value: 50,
                                date: "5/12",
                                isShowDate: false,
                              ),
                              ProgressVertical(
                                value: 45,
                                date: "5/13",
                                isShowDate: false,
                              ),
                              ProgressVertical(
                                value: 30,
                                date: "5/14",
                                isShowDate: true,
                              ),
                              ProgressVertical(
                                value: 50,
                                date: "5/15",
                                isShowDate: false,
                              ),
                              ProgressVertical(
                                value: 20,
                                date: "5/16",
                                isShowDate: false,
                              ),
                              ProgressVertical(
                                value: 45,
                                date: "5/17",
                                isShowDate: true,
                              ),
                              ProgressVertical(
                                value: 67,
                                date: "5/18",
                                isShowDate: false,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                        // Line Graph
                        Expanded(
                          child: Container(
                              decoration: new BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                shape: BoxShape.rectangle,
                                color: Constants.darkOrange,
                              ),
                              child: ClipPath(
                                clipper: MyCustomClipper(
                                    clipType: ClipType.multiple),
                                child: Container(
                                    decoration: new BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                  shape: BoxShape.rectangle,
                                  color: Constants.lightYellow,
                                )),
                              )),
                        ),
                      ],
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
                              status: "SpO₂ Promedio",
                              time: "",
                              value: "--",
                              unit: "%",
                              color: Constants.darkOrange,
                              image: null,
                              remarks: "ok");
                          break;
                        case 1:
                          return GridItem(
                            status: "Fitness Level",
                            time: "",
                            value: "",
                            unit: "",
                            color: Constants.darkOrange,
                            image: AssetImage("assets/icons/Heart.png"),
                            remarks: "Fit",
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
