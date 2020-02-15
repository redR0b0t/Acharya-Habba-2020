import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:habba20/models/event_cat_model.dart';
import 'package:habba20/utils/style_guide.dart';
import 'package:habba20/widgets/event_card.dart';

class EventList extends StatefulWidget {

  String name;
  String img;
  //CallbackAction call;

  EventList({this.name='',  this.img = ''});
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
                  title: Text("${widget.name}",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                      )),
                  background: CachedNetworkImage(imageUrl: widget.img, fit: BoxFit.fill,)),
            ),
          ];
        },
        body: Container(height: 200, color: Colors.purpleAccent,),
      ),
    );
  }
}
