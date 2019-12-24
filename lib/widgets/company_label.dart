import 'package:flutter/material.dart';

class CompanyLabel extends StatelessWidget {
  Color color;
  CompanyLabel(this.color);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height* 0.05,
      //color: Colors.red,
      padding: EdgeInsets.only(bottom: 5),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Text(
          "Powered by Elixir Software Solutions",
          style: TextStyle(fontWeight: FontWeight.bold, color: color),
        ),
      ),
    );
  }
}
