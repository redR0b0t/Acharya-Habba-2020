import 'package:flutter/material.dart';

class TransparentChip extends StatelessWidget {
  String label;
  double size;

  TransparentChip({this.label = '', this.size = 25});

  @override
  Widget build(BuildContext context) {
    return new Container(
      //alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.7),
        borderRadius: BorderRadius.all(
          Radius.circular(20.0),
        ),
      ),
      child: new Text(
        label.trim(),
        style: TextStyle(
            fontSize: size, color: Colors.white,
            fontFamily: "RobotoRegular"
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
