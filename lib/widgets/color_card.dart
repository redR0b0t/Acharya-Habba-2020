import 'package:flutter/material.dart';

class ColorCard extends StatelessWidget {
  String title;
  Color color;
  Gradient gradient;
  ColorCard({this.title, this.color, this.gradient});
  @override
  Widget build(BuildContext context) {
    final textStyle = new TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w700,
      fontSize: 18.0,
    );

    return new Container(
      margin: const EdgeInsets.only(right: 10.0, left: 10.0, top: 8),
      // width: 150.0,
      decoration: new BoxDecoration(
          color: color,
          shape: BoxShape.rectangle,
          borderRadius: new BorderRadius.circular(10.0),
          boxShadow: <BoxShadow>[
            new BoxShadow(
                color: Colors.black38,
                blurRadius: 2.0,
                spreadRadius: 1.0,
                offset: new Offset(0.0, 1.0)),
          ],
          gradient: gradient),
      child:           new Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: new Text(
          title.replaceAll('\\n', '\n').trim(),
          style: textStyle,
        ),
      ),
    );
  }

}

