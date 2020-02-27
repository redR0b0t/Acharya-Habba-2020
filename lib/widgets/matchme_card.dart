import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:habba20/pages/screens/dev_details.dart';
import 'package:habba20/utils/style_guide.dart';
import 'package:url_launcher/url_launcher.dart';

class MatchMeCard extends StatelessWidget {
  DocumentSnapshot docSnap;

  MatchMeCard({this.docSnap});

  @override
  Widget build(BuildContext context) {
    print("Deve card<><><><><>");
    return InkWell(
        onTap: () async {
      await launch(
          '${docSnap['link']}');
        },
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Stack(
            //alignment: AlignmentDirectional.topCenter,
              children: <Widget>[
                Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    elevation: 12.0,
                    margin: EdgeInsets.only(top: 10.0, bottom: 10.0, left: 55),
                    child: Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                                padding:
                                EdgeInsets.only(top: 10.0, bottom: 6.0),
                                child: Text(
                                  docSnap['name'],
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 25.0,
                                      fontFamily: 'Quicksand',
                                      fontWeight: FontWeight.bold),
                                )),
                            Text(
                              docSnap['about'],
                              style: TextStyle(
                                  fontSize: 16.0,
                                  fontFamily: 'Quicksand',
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context)
                                      .textTheme
                                      .caption
                                      .color),
                            ),
                            Padding(
                                padding: EdgeInsets.only(
                                    top: 10.0,
                                    bottom: 10.0,
                                    left: 30.0,
                                    right: 30.0),
                                child: Divider(
                                  indent: 10.0,
                                  thickness: 1.2,
                                )),
                            Container(
                              child: Text(
                                "Tap to know more",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w400),
                              ),
                            )
                          ],
                        ))),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 35),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Hero(
                      tag: "${docSnap['name']}",
                      child: CircleAvatar(
                        backgroundColor: notWhite,
                        backgroundImage:
                        CachedNetworkImageProvider(docSnap['img']),
                        maxRadius: 50.0,
                      ),
                    ),
                  ),
                ),
              ]),
        ));
  }

}
