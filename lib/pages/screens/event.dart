import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Event extends StatefulWidget {
  DocumentSnapshot docSnap;

  Event({this.docSnap});

  @override
  _EventState createState() => _EventState();
}

class _EventState extends State<Event> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: 200.0,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  title: Text("${widget.docSnap['name']}",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                      )),
                //  background: Image.network(widget.docSnap['image'])
              ),
            ),
            Card(
              margin: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
              elevation: 15,
              shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 25, horizontal: 20),
                child: RaisedButton(
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                  elevation: 25,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30))),
                  //color: AppTheme.primaryBtnColor,
                  color: Colors.red,
                  onPressed: () {

                    // continueTap();
                    //  _registerUser();
                  },
                  child: Text(
                    'Reset',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),

                ),
              ),
            ),
          ];
        },
        body: Text("SDNkknknk"),
      ),
    );
  }
}
