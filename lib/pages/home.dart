import 'package:flutter/material.dart';



class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);



  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {




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
              "Welcome to habba 2020 your data has been saved",
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


          ],
        ),
      ),
    );
  }
}
