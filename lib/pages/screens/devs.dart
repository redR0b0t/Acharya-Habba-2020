import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:habba20/utils/style_guide.dart';
import 'package:habba20/widgets/dev_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';

import 'about_habba.dart';

class Devs extends StatefulWidget {
  @override
  _DevsState createState() => _DevsState();
}

class _DevsState extends State<Devs> {
  double sunSize = 60;
  double sunPosition = 125;
  double hillOnePosition = 150;
  double hillTwoPosition = 150;
  double hillThreePosition = 210;
  double placePosition = 210;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            hexToColor('#EC9F05'),
            hexToColor('#FF4E00'),
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
          elevation: 0,
          title: Text(
            'Developers',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: NotificationListener(
          onNotification: (notification) {
            if (notification is ScrollUpdateNotification == true) {
              setState(() {
                sunPosition -= notification.scrollDelta / 5;
                sunSize -= notification.scrollDelta / 8;
                hillOnePosition -= notification.scrollDelta / 4;
                hillTwoPosition -= notification.scrollDelta / 3;
                hillThreePosition -= notification.scrollDelta / 2.8;
                placePosition -= notification.scrollDelta / 1;
              });
            }
            // just to avoid the jittery line
            return true;
          },
          child: Stack(
            children: <Widget>[
              ParalaxWidget(
                left: MediaQuery.of(context).size.width / 2 + 30,
                position: this.sunPosition,
                image: SvgPicture.asset(
                  'assets/svgs/sun.svg',
                  width: this.sunSize,
                  color: hexToColor('#f9e6bf'),
                ),
              ),
              ParalaxWidget(
                left: 0,
                position: this.hillOnePosition,
                image: SvgPicture.asset(
                  'assets/svgs/hill1.svg',
                  width: MediaQuery.of(context).size.width,
                ),
              ),
              ParalaxWidget(
                left: 0,
                position: this.hillTwoPosition,
                image: SvgPicture.asset(
                  'assets/svgs/hill2.svg',
                  width: MediaQuery.of(context).size.width,
                ),
              ),
              ParalaxWidget(
                left: 0,
                position: this.hillThreePosition,
                image: SvgPicture.asset(
                  'assets/svgs/hill3.svg',
                  width: MediaQuery.of(context).size.width,
                ),
              ),
              ParalaxWidget(
                left: 0,
                position: this.placePosition,
                image: SvgPicture.asset(
                  'assets/svgs/place.svg',
                  width: MediaQuery.of(context).size.width,
                ),
              ),
              ListView(
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                children: <Widget>[
                  Container(
                    height: 320,
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(20, 30, 20, 0),
                    color: hexToColor('#64147e'),
                    child: ListView(
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      children: <Widget>[
                        Divider(
                          color: Colors.white60,
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height,
                        )
                      ],
                    ),
                  ),
                ],
              ),

              StreamBuilder(
                  stream: Firestore.instance
                      .collection('devs')
                      .snapshots(),
                  builder: (context, snap) {
                    if (snap.hasData) {
                      return ListView.builder(

                        //scrollDirection: Axis.horizontal,
                          itemCount: snap.data.documents.length,
                          itemBuilder: (context, index) {
                            DocumentSnapshot docSnap = snap.data
                                .documents[index];
                            return DevCard(docSnap: docSnap);
                          });

                    }else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  }),


//              ListView(
//                children: <Widget>[
//                  DevCard(),
//                  DevCard(),
//                ],
//              )
            ],
          ),
        ),
      ),
    );
  }
}

class DevDetails extends StatelessWidget {
  DocumentSnapshot docSnap;
  DevDetails({this.docSnap});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            hexToColor('#EC9F05'),
            hexToColor('#FF4E00'),
          ],
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Text("About Dev"),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        backgroundColor: Colors.transparent,
        body: ListView(
          children: <Widget>[
            Stack(
                alignment: AlignmentDirectional.topCenter,
                children: <Widget>[
                  Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),
                      elevation: 12.0,
                      margin: EdgeInsets.only(
                          top: 82.0, bottom: 20.0, left: 20, right: 20),
                      child: Padding(
                          padding: EdgeInsets.all(18.0),
                          child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                    padding:
                                    EdgeInsets.only(
                                        top: 80.0,
                                        bottom: 6.0),
                                    child: Text(
                                      docSnap['name'],
                                      textAlign:
                                      TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 32.0, fontFamily: "Quicksand", fontWeight: FontWeight.w600),
                                    )),
                                Text(
                                  docSnap['about'],
                                  style: TextStyle(
                                      color:
                                      Theme.of(context)
                                          .textTheme
                                          .caption
                                          .color,
                                    fontSize: 20,
                                    fontFamily: "Quicksand"
                                  ),
                                ),
                                Chip(label:Text("Skills")),
                               Wrap(
                                 children: <Widget>[
                                   Card(child:Text(docSnap['skills'][0],textAlign: TextAlign.center,),),
                                   Card(child:Text(docSnap['skills'][1],textAlign: TextAlign.center,),),
                                   Card(child:Text(docSnap['skills'][2],textAlign: TextAlign.center,),),
                                   Card(child:Text(docSnap['skills'][3],textAlign: TextAlign.center,),),
                                 ],
                               ),
                                Chip(label:Text("Whats app: ${docSnap['wapp']}")),
                                Chip(label:Text("linkedin: ${docSnap['linkedin']}"),
                                  onDeleted: () async {
                                    await launch(
                                        docSnap['linkedin']);
                                  },),
                                Visibility(
                                  visible: docSnap['fb']!='',
                                  child: Chip(label:Text("Facebook: ${docSnap['fb']}"),
                                    onDeleted: () async {
                                      await launch(
                                          docSnap['fb']);
                                    },),
                                ),
                                Visibility(
                                  visible: docSnap['insta']!='',
                                  child: Chip(label:Text("instagram: ${docSnap['insta']}"),
                                    onDeleted: () async {
                                      await launch(
                                          docSnap['insta']);
                                    },),
                                ),
                                Padding(
                                    padding:
                                    EdgeInsets.only(
                                        top: 10.0,
                                        bottom: 10.0,
                                        left: 30.0,
                                        right: 30.0),
                                    child: Divider(
                                      indent: 10.0,
                                    )),
                              ]                )
                      )),
                  CircleAvatar(
                    backgroundImage: CachedNetworkImageProvider(docSnap['img']),
                    maxRadius: 80.0,
                  ),
                ])
          ],
        ),
      ),
    );
  }
}
