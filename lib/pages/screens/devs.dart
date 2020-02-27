import 'package:animated_widgets/widgets/translation_animated.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:habba20/utils/style_guide.dart';
import 'package:habba20/widgets/dev_card.dart';
import 'package:habba20/widgets/matchme_card.dart';

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
    print("devs<><><> Card");
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
        body: Stack(
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
                stream: Firestore.instance.collection('devs').snapshots(),
                builder: (context, snap) {
                  if (snap.hasData) {
                    return ListView.builder(

                        //scrollDirection: Axis.horizontal,
                        itemCount: snap.data.documents.length,
                        itemBuilder: (context, index) {
                          DocumentSnapshot docSnap = snap.data.documents[index];
                          return TranslationAnimatedWidget(
                            //enabled: viewState.buttonVisible, //will forward/reverse the animation
                            curve: Curves.easeIn,
                            duration: Duration(seconds: 1),
                            values: [
                              Offset(0, 200),
                              Offset(0, -50),
                              Offset(0, 0),
                            ],
                            child: index != 2
                                ? DevCard(
                                    docSnap: docSnap,
                                  )
                                : docSnap['is_shown']==1?MatchMeCard(
                              docSnap: docSnap,
                            ):Container(),
                          );
                        });
                  } else {
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
    );
  }
}
