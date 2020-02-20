import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:habba20/utils/style_guide.dart';
import 'package:habba20/widgets/dev_card.dart';
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
   return Scaffold(
        backgroundColor: Colors.transparent,
//        appBar: AppBar(
//          backgroundColor: Colors.transparent,
//          automaticallyImplyLeading: false,
//          elevation: 0,
//          title: Text(
//            'Developers',
//            style: TextStyle(fontWeight: FontWeight.bold),
//          ),
//          centerTitle: true,
//        ),
        body:


              Container(
//                width: 500,
//                decoration: BoxDecoration(
//                    gradient: LinearGradient(
//                      begin: Alignment.topCenter,
//                      end: Alignment.bottomCenter,
//                      colors: [Color(0xFFf45d27), Color(0xFFf5851f)],
//                    ),
//                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(90))),
                child: StreamBuilder(
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

                // color: Colors.deepOrange,
              ),

//              GridView.count(
//                shrinkWrap: true,
//                crossAxisCount: 2,
//                children: <Widget>[
//                  DevCard(),
//                  DevCard(),
//                ],
//
//              )

   );
  }
}

class DevDetails extends StatelessWidget {
  DocumentSnapshot docSnap;
  DevDetails({this.docSnap});
  List skills;
  void initState(){
    //super.initState();
    skills = List.from(docSnap['skills']);

  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(

        backgroundColor: Colors.transparent,
        body: Container(

          child: ListView(



            children: <Widget>[
              Text("\n\n\n"),
              SizedBox(height: 10,),
              Chip(
                  label:  Text("Name: ${docSnap['name']}"),),

              Chip(label:Text("About: ${docSnap['about']}")),
              Text("Skills"),
//              Container(
//
//                child:
//              ListView.builder(
//                  itemCount: docSnap['skills'].length,
//                  itemBuilder:(context, index) {
//
//
//                return Text(docSnap['skills'][index]);
//
//              }

 //       ),),
              Chip(label:Text("Skills")),
            Card(child:Text(docSnap['skills'][0],textAlign: TextAlign.center,),),
              Card(child:Text(docSnap['skills'][1],textAlign: TextAlign.center,),),
              Card(child:Text(docSnap['skills'][2],textAlign: TextAlign.center,),),
              Card(child:Text(docSnap['skills'][3],textAlign: TextAlign.center,),),
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


            ],

    ),)
    );


















    //return Container();
    /*showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: Text(
              dev.name,
              textAlign: TextAlign.center,
            ),
            children: <Widget>[
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8.0),
                  child: Text(
                    dev.role,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.email),
                      onPressed: () async {
                        String url = "mailto:${dev.email}";
                        if (await canLaunch(url)) {
                          await launch(url);
                        } else
                          Scaffold.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Cannot open mail'),
                            ),
                          );
                      },
                    ),
                    IconButton(
                      icon: Icon(FontAwesomeIcons.whatsapp),
                      onPressed: () async {
                        String phoneNumber =
                            '91' + dev.phoneNumber;
                        String url =
                            "https://api.whatsapp.com/send?phone=$phoneNumber&text=Hey_dev";
                        if (await canLaunch(url)) {
                          await launch(url);
                        } else
                          Scaffold.of(context).showSnackBar(
                            SnackBar(
                              content:
                              Text('Cannot open whatsapp'),
                            ),
                          );
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.phone),
                      onPressed: () async {
                        String phoneNumber =
                            '91' + dev.phoneNumber;
                        String url = "tel:$phoneNumber";
                        if (await canLaunch(url)) {
                          await launch(url);
                        } else
                          Scaffold.of(context).showSnackBar(
                              SnackBar(
                                  content: Text(
                                      'Cannot open dialer')));
                      },
                    ),
                  ],
                ),
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 8.0),
                child: RichText(
                  text: TextSpan(children: <TextSpan>[
                    TextSpan(
                        text: 'Technologies: ',
                        style: TextStyle(color: Colors.black)),
                    TextSpan(
                      text: dev.technologies,
                      style: TextStyle(
                          color: Colors.black54, fontSize: 12),
                    )
                  ]),
                ),
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 8.0),
                child: RichText(
                  text: TextSpan(children: <TextSpan>[
                    TextSpan(
                        text: 'Insights: ',
                        style: TextStyle(color: Colors.black)),
                    TextSpan(
                      text: dev.about,
                      style: TextStyle(
                          color: Colors.black54, fontSize: 12),
                    )
                  ]),
                ),
              )
            ],
          );
        });*/
  }
}
