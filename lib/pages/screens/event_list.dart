import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:habba20/widgets/background.dart';
import 'package:habba20/widgets/timeline_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:habba20/data/data.dart';
import 'package:habba20/widgets/empty_card.dart';

class EventList extends StatefulWidget {
  String cat_name;
  String img;

  //CallbackAction call;

  EventList({this.cat_name = '', this.img = ''});

  @override
  _EventListState createState() => _EventListState();
}

class _EventListState extends State<EventList> {
  void initState(){
    super.initState();
  }
  void dispose(){
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              backgroundColor: Colors.blue,
              expandedHeight: 200.0,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  title: Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.transparent.withOpacity(0.45),
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          offset: Offset(0.0, 15.0),
                          blurRadius: 15.0,
                        ),
                        BoxShadow(
                          color: Colors.black12,
                          offset: Offset(0.0, -10.0),
                          blurRadius: 10.0,
                        ),
                      ],
                    ),

                    child: Text("${widget.cat_name}",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                            shadows: [
                              Shadow(
                                blurRadius: 10.0,
                                color: Colors.black,
                                offset: Offset(5.0, 5.0),
                              ),
                            ],
                            fontFamily: "RobotoRegular"
                        )),
                  ),
                  background: CachedNetworkImage(
                    imageUrl: widget.img,
                    fit: BoxFit.cover,
                  )),
            ),
          ];
        },
        body: Stack(
          children: <Widget>[
            Background(),
            Container(
                height: MediaQuery.of(context).size.height,
                child: _streamEvents(),
            )
          ],
        ),
      ),
    );
  }
  Widget _streamEvents() {
    return StreamBuilder(
        stream: Firestore.instance.collection('events').where('cat',isEqualTo: widget.cat_name).snapshots(),
        builder: (context, snap) {
          if (snap.hasData) {
            return snap.data.documents.length == 0
                ? Column(
              children: <Widget>[
                EmptyCard(
                  type: "Events",
                )
              ],
            )
                : ListView.builder(
                itemCount: snap.data.documents.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot docSnap = snap.data.documents[index];
                  return TimelineCard(
                    docSnap: docSnap,
                    guest: isGuest,
                  );
                });
          } else {
            return Text("");
          }
        });
  }
}
