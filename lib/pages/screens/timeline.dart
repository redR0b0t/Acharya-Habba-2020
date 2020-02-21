import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flux/flutter_flux.dart';
import 'package:habba20/data/data.dart';
import 'package:habba20/pages/delayed_animation.dart';
import 'package:habba20/utils/date_time_helper.dart';
import 'package:habba20/widgets/background.dart';
import 'package:habba20/widgets/empty_card.dart';
import 'package:habba20/widgets/timeline_card.dart';

class ScaffoldKeyChain {
  static final List<GlobalKey<ScaffoldState>> scaffoldKeyList = [
    GlobalKey<ScaffoldState>(debugLabel: 'key1'),
    GlobalKey<ScaffoldState>(debugLabel: 'key2'),
    GlobalKey<ScaffoldState>(debugLabel: 'key3'),
    GlobalKey<ScaffoldState>(debugLabel: 'key4')
  ];
}

class Timeline extends StatefulWidget {
  bool guest=false;
  Timeline({this.guest});
  @override
  _TimelineState createState() => _TimelineState();
}

class _TimelineState extends State<Timeline>
    with StoreWatcherMixin<Timeline>, SingleTickerProviderStateMixin<Timeline> {
  TextStyle _titleStyle = TextStyle(color: Colors.black, fontSize: 30);
  TextStyle _textStyle =
      TextStyle(color: Colors.black54, fontWeight: FontWeight.w100);
  bool isRegistering = false;

  String titleString = 'Acharya Habba';
  Timestamp d1, d2, d3;

  @override
  void initState() {
    super.initState();
    fetch_day();
    print("from initstate");
    tabController = TabController(length: 3, vsync: this);
    tabController.addListener(() async {
      QuerySnapshot transactions =
          await Firestore.instance.collection('days').getDocuments();

      DocumentSnapshot docSnap = transactions.documents[0];
      fetch_day();

      setState(() {
        switch (tabController.index) {
          case 0:
            titleString = 'Pre Habba';
            break;
          case 1:
            //ts=int.tryParse((docSnap["day1"]).toString();
            //DatetimeHelper date=new DatetimeHelper((ts));
            // titleString = '${( docSnap["day1"] as Timestamp).toDate().day}-${( docSnap["day1"] as Timestamp).toDate().month}';
            // titleString= DatetimeHelper(timestamp: (docSnap['day1'] as Timestamp).millisecondsSinceEpoch).getMonthName();
            titleString =
                '${(docSnap["day1"] as Timestamp).toDate().day}-${DatetimeHelper(timestamp: (docSnap['day1'] as Timestamp).millisecondsSinceEpoch).getMonthName()}';
            break;
          case 2:
            titleString =
                '${(docSnap["day2"] as Timestamp).toDate().day}-${DatetimeHelper(timestamp: (docSnap['day2'] as Timestamp).millisecondsSinceEpoch).getMonthName()}';
            break;
          case 3:
            titleString =
                '${(docSnap["day3"] as Timestamp).toDate().day}-${DatetimeHelper(timestamp: (docSnap['day3'] as Timestamp).millisecondsSinceEpoch).getMonthName()}';
            break;
        }
      });
    });
  }

  void fetch_day() async {
    QuerySnapshot transactions =
        await Firestore.instance.collection('days').getDocuments();

    DocumentSnapshot docSnap = transactions.documents[0];
    d1 = docSnap['day1'] as Timestamp;
    d2 = docSnap['day2'] as Timestamp;
    d3 = docSnap['day3'] as Timestamp;
    print({d1, d2, d3});
  }

  TabController tabController;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[Background(), _buildActual(context)],
    );
  }

  Widget _buildActual(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.transparent,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.blue,
        title: Text(titleString),
        bottom: TabBar(
          isScrollable: true,
          controller: tabController,
          indicatorSize: TabBarIndicatorSize.tab,
          indicator: new BubbleTabIndicator(
            indicatorHeight: 30.0,
            indicatorColor: Colors.black.withOpacity(0.5),
            tabBarIndicatorSize: TabBarIndicatorSize.tab,
          ),
          tabs: <Widget>[
            Tab(text: 'Pre Habba'),
            Tab(
              text: 'Day 1',
            ),
            Tab(
              text: 'Day 2',
            ),
//            Tab(
//              text: 'Day 3',
//            ),
          ],
        ),
      ),
      body: TabBarView(
        children: [
          _streamEvents(0),
          _streamEvents(1),
          _streamEvents(2),
         // _streamEvents(3),
        ],
        controller: tabController,
      ),
    );
  }

  Widget _streamEvents0() {
    return StreamBuilder(
        stream: Firestore.instance.collection('events').snapshots(),
        builder: (context, snap) {
          if (snap.hasData) {
            return snap.data.documents.length == 0
                ? Column(
              children: <Widget>[
                EmptyCard(
                  type: "Events",
                )
              ],
            )
                : ListView.builder(
                itemCount: snap.data.documents.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot docSnap = snap.data.documents[index];
                  return TimelineCard(
                    docSnap: docSnap,
                    guest: widget.guest,
                  );
                });
          } else {
            return Text("");
          }
        });
  }

  Widget _streamEvents(int d) {
    return StreamBuilder(
        stream: d == 1
            ? Firestore.instance
            .collection('events')
            .where('event_date', isGreaterThan: d1)
            .where('event_date', isLessThan: d2)
            .orderBy('event_date')
            .snapshots()
            : d == 2
            ? Firestore.instance
            .collection('events')
            .where('event_date', isGreaterThan: d2)
            .where('event_date', isLessThan: d3)
            .orderBy('event_date')
            .snapshots()
            : Firestore.instance
            .collection('events')
            .where('event_date', isLessThan: d3)
            .orderBy('event_date')
            .snapshots(),
//            stream: d==1? Firestore.instance
//                .collection('events')
//                .where('event_date', isGreaterThan: d1).where('event_date',isLessThan: (d as Timestamp).toDate().add(new Duration(days:1)))
//                .snapshots(),
        builder: (context, snap) {
          if (snap.hasData) {
            return snap.data.documents.length == 0
                ? Column(
              children: <Widget>[
                EmptyCard(
                  type: "Events",
                )
              ],
            )
                : ListView.builder(
                itemCount: snap.data.documents.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot docSnap = snap.data.documents[index];
                  return TimelineCard(docSnap: docSnap);
                });
          } else {
            return Text("");
          }
        });
  }
}
