import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../utils/const.dart';
import '../widgets/custom_clipper.dart';

class CardPersonalData extends StatelessWidget {
  final String title;
  final Icon icon;
  final Color color;
  final String detail;

  CardPersonalData({
    Key key,
    @required this.title,
    @required this.icon,
    @required this.color,
    @required this.detail,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      height: 100,
      decoration: new BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        shape: BoxShape.rectangle,
        color: Colors.white,
      ),
      child: Stack(
        children: <Widget>[
          Positioned(
            child: ClipPath(
              clipper: MyCustomClipper(clipType: ClipType.halfCircle),
              child: Container(
                decoration: new BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  color: color.withOpacity(0.1),
                ),
                height: 100,
                width: 100,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                // Icon and Hearbeat
                icon,
                SizedBox(width: 30),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        '$title',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Constants.textPrimary),
                      ),
                      SizedBox(height: 15),
                      Text(
                        detail,
                        style: TextStyle(
                            fontSize: 15, color: Constants.textPrimary),
                      ),
                    ],
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
