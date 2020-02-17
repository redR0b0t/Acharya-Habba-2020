import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:habba20/pages/screens/event.dart';
import 'package:habba20/utils/app_theme.dart';
import 'package:flutter_flux/flutter_flux.dart';
import 'package:habba20/utils/date_time_helper.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:habba20/data/data.dart';
class EventCard extends StatelessWidget {
  DocumentSnapshot docSnap;
  bool guest=false;
  Gradient gradient;

  //CallbackAction call;

  EventCard({this.docSnap,this.guest});

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

        'events_reg': FieldValue.arrayUnion([docSnap.documentID])

      });

      documentReference = Firestore.instance
          .collection('events')
          .document(eid);


      Firestore.instance.runTransaction((transaction) async {
        await transaction.update(documentReference, {

          'users_reg': FieldValue.arrayUnion([eid])
        });
      });




    });
  }
  @override
  Widget build(BuildContext context) {

    return Container(
      // height: MediaQuery.of(context).size.height * 0.6,
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        elevation: 12,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 35),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
             child: background(),
              ),
//              Icon(
//                Image.network(src),
//                size: 80,
//                color: Colors.green,
//              ),
              SizedBox(
                height: 30,
              ),
              Text(
                "name:${docSnap['name']}",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                "description:${docSnap['description']}",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                "fee:${docSnap['fee']}",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                'Event Date:${(docSnap["event_date"] as Timestamp).toDate().day}-${DatetimeHelper(timestamp: (docSnap['event_date'] as Timestamp).millisecondsSinceEpoch).getMonthName()}',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                "closing time:${DatetimeHelper(timestamp:(docSnap['closing_date'] as Timestamp).millisecondsSinceEpoch).getTime()}",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 30,
              ),
              docSnap['status']==0? new Text("status:${DateTime.now().difference((docSnap['event_date'] as Timestamp).toDate()).inDays} days to start"):
      docSnap['status']==1?new Text("event started"):new Text("Event ended"),
              SizedBox(
                height: 15,
              ),
              RaisedButton(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                color: Colors.deepPurple,
                onPressed: () {
                  if(isGuest) {
                    Fluttertoast.showToast(
                        msg: "You need to be registered for registering in the events",
                        toastLength: Toast.LENGTH_LONG,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIos: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0);
                  }
                  else {
                    _regUser();
                  }
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30))),
                child: Center(
                  child: Text(
                    'Register for event',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );



//   return new Container(
//
//       child:Column(
//    children: <Widget>[
//
//      new Text("name:$docSnap['name']"),
//      new Text("description:$docSnap['description']"),
//      new Text("fee:$docSnap['fee']"),
//      new Text("event date:$docSnap['event_date']"),
//      new Text("closing time:$docSnap['close_date']"),
//      docSnap['status']==0? new Text("status:${DateTime.now().difference((docSnap['event_date'] as Timestamp).toDate())} to start"):
//      docSnap['status']==1?new Text("event started"):new Text("Event ended"),
//
//      new Text("\n\n\n\n\n\nRegister for event"),
//    new MaterialButton(
//                child: Text("Register"),
//    onPressed:_regUser
//            ),
//
//
//
//  ]
//       )
//);


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

  }

  Widget background() {
    return CachedNetworkImage(
      imageUrl: docSnap['img'],
      placeholder: (context, url) => Center(
        child: Image(
          image: AssetImage("assets/logo.png"),height: 130,
        ),
      ),
    );
  }

}