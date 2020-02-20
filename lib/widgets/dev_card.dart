import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:habba20/pages/screens/devs.dart';
import 'package:habba20/utils/style_guide.dart';

class DevCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => DevDetails()));
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
                                  "Name",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 25.0, fontFamily: 'Quicksand', fontWeight: FontWeight.bold),
                                )),
                            Text(
                              "About",
                              style: TextStyle(fontSize: 16.0, fontFamily: 'Quicksand', fontWeight: FontWeight.bold, color: Theme.of(context)
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
                                )
                            ),
                            buildSocialLinks()
                          ],
                        ))),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 35),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: CircleAvatar(
                      backgroundImage: CachedNetworkImageProvider(""),
                      maxRadius: 50.0,
                    ),
                  ),
                ),
              ]),
        ));
  }


  Widget buildSocialLinks(){
     return Container();
  }
}
