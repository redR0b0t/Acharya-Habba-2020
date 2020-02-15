import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flux/flutter_flux.dart';
import 'package:habba20/utils/date_time_helper.dart';
import 'package:habba20/widgets/empty_card.dart';
import 'package:habba20/widgets/event_card.dart';
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
    tabController = TabController(length: 4, vsync: this);
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
      children: <Widget>[
        Container(
          color: Colors.white,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Image.asset(
            'assets/kaala.png',
            fit: BoxFit.cover,
          ),
        ),
        _buildActual(context)
      ],
    );
  }

  Widget _buildActual(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text(titleString),
        bottom: TabBar(
          isScrollable: true,
          controller: tabController,
          indicatorSize: TabBarIndicatorSize.tab,
          indicator: new BubbleTabIndicator(
            indicatorHeight: 30.0,
            indicatorColor: Colors.red,
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
            Tab(
              text: 'Day 3',
            ),
          ],
        ),
      ),
      body: TabBarView(
        children: [
          _streamEvents0(),
          _streamEvents(1),
          _streamEvents(2),
          _streamEvents(3),

//          _buildEvents(0, store.day0Events),
//          _buildEvents(1, store.day1Events),
//          _buildEvents(2, store.day2Events),
//          _buildEvents(3, store.day3Events),
        ],
        controller: tabController,
      ),
    );
  }

  Widget _streamEvents0() {
    return Scaffold(
      appBar: AppBar(
        title: Text("Event List"),
        backgroundColor: Colors.deepOrange,
      ),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFFf45d27), Color(0xFFf5851f)],
            ),
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(90))),
        child: StreamBuilder(
            stream: Firestore.instance.collection('events').snapshots(),
            builder: (context, snap) {
              if (snap.hasData) {
                return snap.data.documents.length == 0
                    ? Column(
                  children: <Widget>[
                    EmptyCard(type: "Events",)
                  ],
                )
                    : ListView.builder(
                        itemCount: snap.data.documents.length,
                        itemBuilder: (context, index) {
                          DocumentSnapshot docSnap = snap.data.documents[index];
                          return TimelineCard(
                            docSnap: docSnap,
                          );
                        });
              } else {
                return Text("");
              }
            }),

        // color: Colors.deepOrange,
      ),
    );
  }

  Widget _streamEvents(int d) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFf45d27), Color(0xFFf5851f)],
          ),
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(90))),
      child: StreamBuilder(
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
                      .where('event_date', isGreaterThan: d3)
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
          }),

      // color: Colors.deepOrange,
    );
  }

/* Widget _buildEvents(int keyIndex, List<Event> events) {
    return Scaffold(
      backgroundColor: Colors.transparent,
//      key: ScaffoldKeyChain.scaffoldKeyList[keyIndex],
      body: ListView(
        children: events.map((Event event) {
          return EventContent(keyIndex, event);
        }).toList(),
      ),
    );
  }*/

// Widget buildContent(Event event, int keyIndex) {}

//

}
/*
class EventContent extends StatelessWidget {
  int keyIndex;
  Event event;
  EventContent(this.keyIndex, this.event);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.4),
              blurRadius: 10.0, // has the effect of softening the shadow
              spreadRadius: 0.0, // has the effect of extending the shadow
              offset: Offset(
                0.0, // horizontal, move right 10
                5.0, // vertical, move down 10
              ),
            )
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    event.name,
                    style: TextStyle(fontSize: 25),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text('Description: '),
                  ),
                  Text(
                    event.description ?? ' ',
                    style: TextStyle(color: Colors.black54),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text('Rules: '),
                  ),
                  Text(
                    event.rules ?? ' ',
                    style: TextStyle(color: Colors.black54),
                  ),
                  Row(
                    children: <Widget>[
                      Text('Contact ${event.organizerName}: '),
                      IconButton(
                        icon: Icon(
                          FontAwesomeIcons.whatsapp,
                          size: 18,
                        ),
                        onPressed: () async {
                          String phoneNumber = '+91' + event.organizerPhone;
                          String url =
                              "https://api.whatsapp.com/send?phone=$phoneNumber&text=Hey%21+I+just+registered+to+your+event%2";
                          if (await canLaunch(url)) {
                            await launch(url);
                          } else
                            Scaffold.of(context).showSnackBar(SnackBar(
                                content: Text('Cannot open whatsapp')));
                        },
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.phone,
                          size: 18,
                        ),
                        onPressed: () async {
                          String phoneNumber = '+91' + event.organizerPhone;
                          String url = "tel://$phoneNumber";
                          if (await canLaunch(url)) {
                            await launch(url);
                          } else
                            Scaffold.of(context).showSnackBar(
                                SnackBar(content: Text('Cannot open dialer')));
                        },
                      )
                    ],
                  ),
                  Text(
                    'Starts On: ${DateTime.parse(event.startDate).day} March, ${DateTime.parse(event.startDate).hour}:${DateTime.parse(event.startDate).minute}',
                    style: TextStyle(color: Colors.black54),
                  ),
                  Text(
                    'Ends On: ${DateTime.parse(event.endDate).day} March, ${DateTime.parse(event.endDate).hour}:${DateTime.parse(event.endDate).minute}',
                    style: TextStyle(color: Colors.black54),
                  ),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                          padding: EdgeInsets.all(8),
                          child: Text(
                            event.fee.trim() == ''
                                ? 'Free Event'
                                : 'Fee: ₹${event.fee}',
                          )),
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            event.fee.trim() == ''
                                ? 'You get Bragging Rights'
                                : 'Winner gets: ₹${event.prize}',
                          ),
                        ),
                      ),
                      FlatButton(
                        textColor: Themex.CustomColors.iconInactiveColor,
                        child: Text('REGISTER'),
                        onPressed: () =>
                            _handleRegister(keyIndex, event, context),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}*/
