import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:habba20/utils/date_time_helper.dart';

/*

class Event extends StatefulWidget {
  DocumentSnapshot docSnap;
  bool guest=false;
  Gradient gradient;

  //CallbackAction call;

  Event({this.docSnap,this.guest});


  @override
  _EventState createState() => _EventState();
}

class _EventState extends State<Event> with SingleTickerProviderStateMixin {
  double visiblity = 0;
  bool isVisible = true;
  bool isNotVisible = false;
  bool enabled = true;
  PanelController controller = PanelController();
  Animation<double> animation;
  AnimationController animationController;
  double temp = 8.0;

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(duration: const Duration(seconds: 1), vsync: this);
    animation = Tween<double>(begin: 200, end: 8).animate(animationController)
      ..addListener(() {
        setState(() {
          // The state that has changed here is the animation object’s value.
          temp = animation.value;
        });
      });
    animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: SlidingUpPanel(
          maxHeight: 425,
          controller: controller,
          onPanelSlide: (bop) {
            setState(() {
              visiblity = bop;
            });
          },
          parallaxEnabled: true,
          parallaxOffset: 0.5,
          renderPanelSheet: false,
          panel: Opacity(
            opacity: visiblity,
            child: Stack(
              children: <Widget>[
                Positioned(
                  top: 15,
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40)),
                    child: Container(
                      color: Colors.white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            height: 250,
                            color: Colors.white,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(
                                  height: 20,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 20.0),
                                  child: Text(
                                    'Maldives Tour',
                                    style: TextStyle(
                                        fontSize: 28,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 25.0),
                                  child: Text(
                                    'In paradise,you can wake up with the sunrise,\nfall asleep with the sound of the waves,and\nfeel asleep as if you are one with nature.',
                                    style: TextStyle(fontFamily: 'Roboto Bold',
                                        fontSize: 12,
                                        fontWeight: FontWeight.w800,
                                        color: Colors.grey[400]),
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 25.0, right: 25),
                                  child: Row(
                                    children: <Widget>[
                                      Icon(
                                        Icons.chat_bubble_outline,
                                        size: 15,
                                      ),
                                      Text('  24'),
                                      SizedBox(
                                        width: 42,
                                      ),
                                      Icon(
                                        Icons.favorite,
                                        color: Colors.red,
                                        size: 15,
                                      ),
                                      Text('  65'),
                                      SizedBox(
                                        width: 42,
                                      ),
                                      Icon(
                                        Icons.star_border,
                                        size: 15,
                                      ),
                                      Text('  17'),
                                      SizedBox(
                                        width: 42,
                                      ),
                                      Icon(
                                        Icons.history,
                                        size: 15,
                                      ),
                                      Text('  80'),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 25,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 25.0),
                                  child: Row(
                                    children: <Widget>[
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(15),
                                        child: Container(
                                            height: 45,
                                            width: 40,
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    image: AssetImage(
                                                      'assets/6.jpg',
                                                    ),
                                                    fit: BoxFit.fill))),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(15),
                                        child: Container(
                                            height: 45,
                                            width: 40,
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    image: AssetImage(
                                                      'assets/7.jpg',
                                                    ),
                                                    fit: BoxFit.fill))),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(15),
                                        child: Container(
                                            height: 45,
                                            width: 40,
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    image: AssetImage(
                                                      'assets/8.jpg',
                                                    ),
                                                    fit: BoxFit.fill))),
                                      ),
                                      SizedBox(
                                        width: 100,
                                      ),
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(15),
                                        child: Container(
                                          height: 45,
                                          width: 40,
                                          color: Colors.grey[200],
                                          child: Icon(Icons.more_horiz),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 100,
                            color: Colors.grey[100],
                            width: MediaQuery.of(context).size.width * 1.0,
                            child: Padding(
                              padding:
                              const EdgeInsets.only(left: 45.0, right: 45,bottom: 20,top: 10),
                              child: Container(
                                width: 280,

                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 1, color: Colors.white),
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white),
                                */
/*color:Colors.white,*/ /*

                                child: Row(
                                  children: <Widget>[
                                    SizedBox(width: 10,),
                                    CircleAvatar(radius: 20,
                                      backgroundColor: Colors.grey[300],
                                      child: Icon(
                                        Icons.location_on,
                                        size: 27,
                                        color: Colors.purple[200],
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                      children: <Widget>[
                                        SizedBox(height: 20),
                                        Text('From',
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontWeight: FontWeight.w700)),
                                        Text(
                                          'Biejing',
                                          style: TextStyle(
                                              color: Colors.black87,
                                              fontWeight: FontWeight.w700,fontSize: 16),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      width: 50,
                                    ),
                                    Column(
                                      children: <Widget>[
                                        SizedBox(height: 20),
                                        Text(
                                          'To',
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontWeight: FontWeight.w700),
                                        ),
                                        Text(
                                          'Maldives',
                                          style: TextStyle(
                                              color: Colors.black87,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 16),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 0,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                right: 30.0, left: 30, bottom: 20),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: MaterialButton(
                                minWidth: 300,
                                height: 55,
                                onPressed: () {},
                                color: Colors.blue[900],
                                padding: EdgeInsets.all(16.0),
                                child: Center(
                                  child: Text(
                                    'Commence the Tour',
                                    style: TextStyle(
                                      fontSize: 17.0,
                                      color: Colors.white,

                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: 25,
                  top: -2,
                  child: Card(
                    elevation: 20,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.near_me, size: 30, color: Colors.green),
                    ),
                  ),
                ),
              ],
            ),
          ),
          body: Stack(
            children: <Widget>[
              Hero(
                tag: "image",
                child: GestureDetector(
                  onTap: openBotoonsheet,
                  child: Container(
                    color: Colors.green
*/
/*                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                              'assets/logo.png',
                            ),
                            fit: BoxFit.fill))*/ /*
,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 58.0, right: 20, left: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        InkWell(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.keyboard_backspace,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Icon(
                          Icons.more_vert,
                          color: Colors.white,
                        )
                      ],
                    ),
                    SizedBox(
                      height: 100,
                    ),

                    Visibility(visible: isNotVisible,
                      child: Padding(
                        padding: const EdgeInsets.only(left:20.0,top:200),
                        child: Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Icon(
                                  Icons.access_time,
                                  color: Colors.white,
                                  size: 18,
                                ),
                                Text(
                                  ' 30 DAYS  ',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                            SizedBox(height: 10,),
                            Row(
                              children: <Widget>[
                                Icon(
                                  Icons.outlined_flag,
                                  color: Colors.white,
                                  size: 18,
                                ),
                                Text(
                                  ' 862 KM',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            )

                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: temp),
                      child: Visibility(visible: isVisible,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[

                            Text(
                              'Maldives',
                              style: TextStyle(color: Colors.white, fontSize: 30,fontFamily: 'Roboto Bold',),
                            ),
                            Text(
                              'tour',
                              style: TextStyle(color: Colors.white, fontSize: 30,fontFamily: 'Roboto Bold',),
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            Row(
                              children: <Widget>[
                                Icon(
                                  Icons.access_time,
                                  color: Colors.white,
                                  size: 18,
                                ),
                                Text(
                                  ' 30 DAYS  ',
                                  style: TextStyle(
                                      color: Colors.white,fontFamily: 'Roboto Medium',
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Icon(
                                  Icons.outlined_flag,
                                  color: Colors.white,
                                  size: 18,
                                ),
                                Text(
                                  ' 862 KM',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,fontFamily: 'Roboto Medium',
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
//                MaterialButton(
//                  shape: RoundedRectangleBorder(
//                      borderRadius: BorderRadius.all(Radius.circular(5.0))),
//                  height: 50,focusColor: Colors.yellow,
//                  minWidth: 50,
//                  focusElevation: 50,
//                  color: Colors.yellow,
//                  child: Text('Book',
//                      style: TextStyle(
//                        fontSize: 15.0,
//                        fontFamily: 'GilroyLight',
//                        color: Colors.white,
//                      )),
//
//                ),
                            Visibility(visible: isVisible,
                              child: Text(
                                "One of the largest artificial islands \nin the world.it is also acessible\nby monorail,which runs down a tree\ntrunk to connect the mainland rail \nsystem.",
                                style: TextStyle(fontFamily: 'Roboto Medium',
                                    fontSize: 12,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            Visibility(visible: isVisible,
                              child: ShakeAnimatedWidget(
                                enabled: enabled,
                                duration: Duration(milliseconds: 2000),
                                shakeAngle: Rotation.deg(y:20,
                                ),
                                curve: Curves.slowMiddle,
                                child:Padding(
                                  padding: const EdgeInsets.only(left:58.0),
                                  child: Opacity(opacity: .9,
                                    child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.white30),
                                      child: Row(mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget>[
                                          Icon(
                                            Icons.favorite_border,
                                            color: Colors.white,
                                            size: 16,
                                          ),
                                          Text(' 295',style: TextStyle(color: Colors.white),),
                                        ],
                                      ),
                                      width: 60,height: 30,),
                                  ),
                                ),
                              ),
                            ),


                            SizedBox(
                              height: 160,
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 18.0, left: 30),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.20,
                    width: MediaQuery.of(context).size.width * 1,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.all(6),
                            decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.all(Radius.circular(20)),
                                image: DecorationImage(
                                    image: AssetImage(
                                      'assets/' +
                                          (index + 1).toString() +
                                          '.jpg',
                                    ),
                                    fit: BoxFit.fill)),
                            height: 110,
                            width: 120,
                          );
                        }),
                  ),
                ),
              ),
              Visibility(visible: isVisible,
                child: Positioned(top:180,right:60,
                  child: ShakeAnimatedWidget(
                    enabled: enabled,
                    duration: Duration(milliseconds: 2000),
                    shakeAngle: Rotation.deg(y:30,
                    ),
                    curve: Curves.slowMiddle,
                    child:Padding(
                      padding: const EdgeInsets.only(left:58.0),
                      child: Opacity(opacity: .9,
                        child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.white30),
                          child: Row(mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.favorite_border,
                                color: Colors.white,
                                size: 16,
                              ),
                              Text(' 36',style: TextStyle(color: Colors.white),),
                            ],
                          ),
                          width: 60,height: 30,),
                      ),
                    ),
                  ),
                ),
              ),
              Visibility(visible: isVisible,
                child: Positioned(top:390,right:60,
                  child: ShakeAnimatedWidget(
                    enabled: enabled,
                    duration: Duration(milliseconds: 2000),
                    shakeAngle: Rotation.deg(y:30,
                    ),
                    curve: Curves.slowMiddle,
                    child:Padding(
                      padding: const EdgeInsets.only(left:58.0),
                      child: Opacity(opacity: .9,
                        child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.white30),
                          child: Row(mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.favorite_border,
                                color: Colors.white,
                                size: 16,
                              ),
                              Text(' 207',style: TextStyle(color: Colors.white),),
                            ],
                          ),
                          width: 60,height: 30,),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  void openBotoonsheet() {
    print("jdhgfgkj");
    if (controller.isPanelClosed){
      controller.open();
      setState(() {
        isVisible = false;
        isNotVisible=true;
      });
    }
    else {
      controller.close();
      setState(() {
        isVisible = true;
        isNotVisible=false;
      });
    }
  }
}


*/

class Event extends StatefulWidget {
  DocumentSnapshot docSnap;
  bool guest = false;
  Gradient gradient;

  //CallbackAction call;

  Event({this.docSnap, this.guest});

  @override
  _EventState createState() => _EventState();
}

class _EventState extends State<Event> {
  String t_image = "assets/catagory/cyborg.png";

  Future _regUser() async {
    FirebaseUser _user = await FirebaseAuth.instance.currentUser();
    print("User: ${_user ?? "None"}");
    String eid = _user.email;

    var documentReference =
        Firestore.instance.collection('users').document(eid);

    Firestore.instance.runTransaction((transaction) async {
      await transaction.update(documentReference, {
        'events_reg': FieldValue.arrayUnion([widget.docSnap.documentID])
      });

      documentReference = Firestore.instance.collection('events').document(eid);

      Firestore.instance.runTransaction((transaction) async {
        await transaction.update(documentReference, {
          'users_reg': FieldValue.arrayUnion([eid])
        });
      });
    });
  }

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
                  title: Text("${widget.docSnap['name']}",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                      )),
                  background: background()),
            ),
          ];
        },
        body: Container(
          height: MediaQuery.of(context).size.height,
          color: Colors.red,
          child: ListView(
            children: <Widget>[
              decriptionCard('Description', '${widget.docSnap['description']}'),
              decriptionCard('Rules', '${widget.docSnap['description']}'),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Chip(
                      backgroundColor: Colors.green,
                      label: Text(
                        "fee : ₹${widget.docSnap['fee']}",
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      )),
                  SizedBox(
                    width: 15,
                  ),
                  Chip(
                      backgroundColor: Colors.green,
                      label: Text(
                        "Reward : ₹${widget.docSnap['fee']}",
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      )),
                ],
              ),
              Chip(
                label: Text(
                  'Event Date:${(widget.docSnap["event_date"] as Timestamp).toDate().day}-${DatetimeHelper(timestamp: (widget.docSnap['event_date'] as Timestamp).millisecondsSinceEpoch).getMonthName()}',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  textAlign: TextAlign.center,
                ),
              ),
              Chip(
                label: Text(
                  "closing time:${DatetimeHelper(timestamp: (widget.docSnap['closing_date'] as Timestamp).millisecondsSinceEpoch).getTime()}",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  textAlign: TextAlign.center,
                ),
              ),
              Chip(
                label: widget.docSnap['status'] == 0
                    ? new Text(
                        "status:${DateTime.now().difference((widget.docSnap['event_date'] as Timestamp).toDate()).inDays} days to start")
                    : widget.docSnap['status'] == 1
                        ? new Text("event started")
                        : new Text("Event ended"),
              ),
              SizedBox(height: 15,),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                //width: MediaQuery.of(context).size.width * 0.5,
                child: RaisedButton(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  color: Colors.deepPurple,
                  onPressed: () {
                    if (widget.guest) {
                      Fluttertoast.showToast(
                          msg:
                              "You need to be registered for registering in the events",
                          toastLength: Toast.LENGTH_LONG,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIos: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    } else {
                      _regUser();
                    }
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30))),
                  child: Center(
                    child: Text(
                      'Register',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget decriptionCard(String title, String desc) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 15),
      elevation: 15,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        child: Column(
          children: <Widget>[
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                '${title}:',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
            new Text(
              desc.replaceAll('\\n', '\n').trim(),
              style: TextStyle(color: Colors.black, fontSize: 16),
            )
          ],
        ),
      ),
    );
  }

  Widget background() {
    return CachedNetworkImage(
      imageUrl: widget.docSnap['img'],
      placeholder: (context, url) => Center(
        child: Image(
          image: AssetImage("assets/logo.png"),
          height: 130,
        ),
      ),
    );
  }
}
