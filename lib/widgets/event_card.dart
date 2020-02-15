import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:habba20/pages/screens/event.dart';
import 'package:habba20/utils/app_theme.dart';
class EventCard extends StatelessWidget {
  DocumentSnapshot docSnap;
  Gradient gradient;

  //CallbackAction call;

  EventCard({this.docSnap});

  String t_image = "assets/catagory/cyborg.png";

  Future _regUser() async{

    FirebaseUser _user = await FirebaseAuth.instance.currentUser();
    print("User: ${_user ?? "None"}");
    String eid=_user.email;



    var documentReference = Firestore.instance
        .collection('users')
        .document(eid);


    Firestore.instance.runTransaction((transaction) async {
      await transaction.update(documentReference, {

        'events_reg': docSnap.documentID

      });


    });
  }
  @override
  Widget build(BuildContext context) {
    final textStyle = new TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w700,
      fontSize: 18.0,
    );
    return new Container(
      height: MediaQuery
          .of(context)
          .size
          .height * .2,
      margin: const EdgeInsets.only(right: 10.0, left: 10.0, top: 15),
      // width: 150.0,
      decoration: new BoxDecoration(
        //color: color,
          shape: BoxShape.rectangle,
          borderRadius: new BorderRadius.circular(10.0),
          boxShadow: <BoxShadow>[
            new BoxShadow(
                color: Colors.black38,
                blurRadius: 2.0,
                spreadRadius: 1.0,
                offset: new Offset(0.0, 1.0)),
          ],
          gradient: gradient),
      child: InkWell(
        onTap: () {
          _regUser();

//          Navigator.push(context, MaterialPageRoute(
//              builder: (context) => Event(docSnap: docSnap,)));
        },
        child: Stack(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  topRight: Radius.circular(10.0),
                  bottomRight: Radius.circular(10.0),
                  bottomLeft: Radius.circular(10)),
              child: background(),
            ),
            new Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),

              child: new Text(docSnap['name']),
//              Card(
//                margin: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
//                elevation: 15,
//                shape:
//                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//                child: Padding(
//                  padding: EdgeInsets.symmetric(vertical: 25, horizontal: 20),
//                  child: RaisedButton(
//                    padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
//                    elevation: 25,
//                    shape: RoundedRectangleBorder(
//                        borderRadius: BorderRadius.all(Radius.circular(30))),
//                    //color: AppTheme.primaryBtnColor,
//                    color: Colors.red,
//                    onPressed: () {
//                      Navigator.push(context, MaterialPageRoute(builder: (context)=>Event(docSnap: docSnap,)));
//                      // continueTap();
//                      //  _registerUser();
//                    },
//                    child: Text(
//                      'Reset',
//                      style: TextStyle(
//                          color: Colors.white, fontWeight: FontWeight.bold),
//                    ),
//
//                  ),
//                ),
//              ),
            )
          ],
        ),
      ),
    );
  }

  Widget background() {
    return docSnap['image']==null?
    Image.asset(
      '${docSnap['image']}',
      fit: BoxFit.fill,
      colorBlendMode: BlendMode.darken,
    ):
    Image.network(docSnap['image']);
  }
}