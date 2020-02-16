import 'package:flutter/material.dart';
import 'package:habba20/utils/app_theme.dart';
import 'package:habba20/widgets/background.dart';

class MyEventList extends StatefulWidget {
  @override
  _MyEventListState createState() => _MyEventListState();
}

class _MyEventListState extends State<MyEventList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Events", style: TextStyle(color: Colors.black),),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent.withOpacity(0.02),
      ),
      body: Stack(
        children: <Widget>[
          Background(),

        ],
      ),
    );
  }

}
