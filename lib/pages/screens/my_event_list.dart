import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:habba20/data/data.dart';
import 'package:habba20/pages/delayed_animation.dart';
import 'package:habba20/utils/style_guide.dart';
import 'package:habba20/widgets/background.dart';
import 'package:habba20/widgets/empty_card.dart';
import 'package:habba20/widgets/timeline_card.dart';

class MyEventList extends StatefulWidget {
  @override
  _MyEventListState createState() => _MyEventListState();
}

class _MyEventListState extends State<MyEventList> {
  FirebaseUser _user;
  DocumentSnapshot eventSnap;
  List reg_events;

  //UserModel userLoc;
  bool fetched = false;

  void initState() {
    _fetchUser();
    super.initState();
  }

  void _fetchUser() async {
    _user = await FirebaseAuth.instance.currentUser();
    print("User: ${_user ?? "None"}");
    String eid = _user.email;
    print(eid);
    if (eid != null) {
      QuerySnapshot transactions = await Firestore.instance
          .collection('users')
          .where('mail', isEqualTo: _user.email)
          //.where('cat', isEqualTo: widget.event_cat).where('name',isEqualTo: widget.eKey)
          .getDocuments();
      print(transactions.documents.length);
      DocumentSnapshot docSnap = transactions.documents[0];
      //userLoc.fromFirestore()
      print("ID fetched=${docSnap['mail']}");
      print("ID fetched=${docSnap.data}");
      reg_events = List.from(docSnap['events_reg']);
//      reg_events = docSnap['events_reg'].map<String>((item) {
//        return List.from(item);
//      }).toList();
      print(docSnap['events_reg']);
      print(reg_events.length);

      if (reg_events != null)
        setState(() {
          fetched = true;
        });
    }
    //  return _user;
  }

  @override
  Widget build(BuildContext context) {
    return // fetched?
        Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: Text(
                "My Events",
                style: TextStyle(color: Colors.white),
              ),
              centerTitle: true,
              elevation: 0,
            ),
            body: //reg_events!=null?
            isGuest
                ? EmptyCard(
              type: "Events",
            )
                : Stack(
              children: <Widget>[
                Background(),
                ListView.builder(
                    itemCount:
                    reg_events == null ? 0 : reg_events.length,
                    itemBuilder: (context, index) {
                      _fetchEvent(index);

                      return eventSnap == null
                          ? Text("")
                          : TimelineCard(
                        docSnap: eventSnap,
                      );
                    })
              ],
            )        );
  }

  void _fetchEvent(int index) async {
    QuerySnapshot transactions = await Firestore.instance
        .collection('events')
        .where('Id', isEqualTo: reg_events[index])
        //.where('cat', isEqualTo: widget.event_cat).where('name',isEqualTo: widget.eKey)
        .getDocuments();
    print(transactions.documents.length);
    setState(() {
      eventSnap = transactions.documents[0];
    });

    print(reg_events);
  }
}
