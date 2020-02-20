import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:habba20/utils/style_guide.dart';
import 'package:habba20/widgets/background.dart';
import 'package:habba20/widgets/event_catagory_card.dart';

class EventCatagoryList extends StatefulWidget {
  @override
  _EventCatagoryListState createState() => _EventCatagoryListState();
}

class _EventCatagoryListState extends State<EventCatagoryList> {
  SwiperController Scontroller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        //  color: Colors.red,
        child: Stack(
          children: <Widget>[
            Background(),
            ListView(
              children: <Widget>[
                SizedBox(
                  height: 80,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 4, vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.transparent.withOpacity(0.45),
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        offset: Offset(0.0, 15.0),
                        blurRadius: 15.0,
                      ),
                      BoxShadow(
                        color: Colors.black12,
                        offset: Offset(0.0, -10.0),
                        blurRadius: 10.0,
                      ),
                    ],
                  ),
                  child: Text(
                    '  Event catagory',
                    style: title,
                    textAlign: TextAlign.left,
                  ),
                ),
                //Text('' , style: title,),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: MediaQuery.of(context).size.height * .6,
                  child: StreamBuilder(
                    stream:
                        Firestore.instance.collection('category').snapshots(),
                    builder: (context, snap) {
                      return snap.hasData
                          ? snap.data.documents.length != 0
                              ? Swiper(
                                  pagination: SwiperPagination(
                                    builder: SwiperPagination.fraction,
                                  ),
                                  itemCount: snap.data.documents.length,
                                  // controller: Scontroller,
                                  viewportFraction: 0.85,
                                  scale: 0.3,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    DocumentSnapshot docSnap =
                                        snap.data.documents[index];

                                    return EventCatagoryCard(
                                        name: docSnap['name'],
                                        img: docSnap['img'],
                                        docSnap: docSnap);
                                  },
                                  //control: new SwiperControl(),
                                )
                              : Center(
                                  child: CircularProgressIndicator(),
                                )
                          : Center(
                              child: CircularProgressIndicator(),
                            );
                    },
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
