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
                  title: Text("${widget.cat_name}",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontFamily: "RobotoRegular"
                      )),
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
