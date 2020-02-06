import 'package:flutter/material.dart';
import 'package:habba20/models/event_cat_model.dart';
import 'package:habba20/utils/style_guide.dart';
import 'package:habba20/widgets/event_card.dart';

class EventList extends StatefulWidget {
 EventCatModel eventCat;

 EventList({this.eventCat});

  @override
  _EventListState createState() => _EventListState();
}

class _EventListState extends State<EventList> {
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
                  title: Text("${widget.eventCat.Name}",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                      )),
                  background: Image.asset(widget.eventCat.BackgroundUrl)),
            ),
          ];
        },
        body: Container(height: 200, color: Colors.purpleAccent,),
      ),
    );
  }
}
