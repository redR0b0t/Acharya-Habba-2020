import 'package:flutter/material.dart';

class Event extends StatefulWidget {
  String image;
  String title;
  Event({this.image = '', this.title = ''});
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
                  title: Text("${widget.title}",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                      )),
                  background: Image.asset(widget.image)),
            ),
          ];
        },
        body: Text("SDNkknknk"),
      ),
    );
  }
}
