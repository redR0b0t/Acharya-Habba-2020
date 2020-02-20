import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:habba20/pages/screens/devs.dart';
import 'package:url_launcher/url_launcher.dart';

class DevCard extends StatelessWidget {
  DocumentSnapshot docSnap ;
  DevCard({this.docSnap});
  @override
  Widget build(BuildContext context) {
    return Container(
      child:InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context)=> DevDetails(docSnap: docSnap,)));
    },child:
          Column(
            children: <Widget>[


              ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: CachedNetworkImage(
                    imageUrl: docSnap['img'],
                  )
              ),

              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          child: Text(docSnap['name']),
                        ),
                      ),
                    ],
                  ),
                ],
              ),

//              Expanded(
//                child: GestureDetector(
//                  onTap: () {
//                     Navigator.push(context, MaterialPageRoute(builder: (context)=> DevDetails(docSnap: docSnap,)));
//                  },
//                ),
//              )
            ],
          )
        ,

    ));
  }

}
