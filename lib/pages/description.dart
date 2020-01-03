import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



class Description extends StatefulWidget {
  Description({Key key, this.title}) : super(key: key);



  final String title;

  @override
  _DescriptionState createState() => _DescriptionState();
}

class _DescriptionState extends State<Description> {


  void navigationPage(String uid1,String name) {
    //Navigator.of(context).pushReplacementNamed('/next');
    Navigator.of(context).pushReplacement( //new
        new MaterialPageRoute( //new
            settings: const RouteSettings(name: '/next'), //new
           // builder: (context) => new Description(uid1: uid1, name: name) //new
        ) //new
    );
  }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
          appBar: AppBar(

            title: Text(widget.title),
          ),
          backgroundColor: Colors.black,
          body: Center(

              child: Column(

                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new Text(
              "The desription of the event,volunteer option and participationg fee will be displayed here",
              textAlign: TextAlign.center,
              style: new TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 36.0,
                fontFamily: 'cursive',
                color: Colors.yellow,

                shadows: [
                  Shadow(
                    color: Colors.blue,
                    blurRadius: 10.0,
                    offset: Offset(5.0, 5.0),
                  ),
                  Shadow(
                    color: Colors.red,
                    blurRadius: 10.0,
                    offset: Offset(-5.0, 5.0),
                  ),
                ],
              ),),

                  ]
              )
          )
      );
    }
  }