import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:habba20/pages/screens/event.dart';
import 'package:habba20/widgets/transparent_chip.dart';

class TimelineCard extends StatelessWidget {
  DocumentSnapshot docSnap;
  bool guest = false;

  TimelineCard({this.docSnap, this.guest});

  String time_rem() {
    int days = -1 *
        DateTime.now()
            .difference((docSnap['event_date'] as Timestamp).toDate())
            .inDays
            .toInt();
    int hrs = -1 *
        DateTime.now()
            .difference((docSnap['event_date'] as Timestamp).toDate())
            .inHours
            .toInt();
    int min = -1 *
        DateTime.now()
            .difference((docSnap['event_date'] as Timestamp).toDate())
            .inMinutes
            .toInt();
    int sec = -1 *
        DateTime.now()
            .difference((docSnap['event_date'] as Timestamp).toDate())
            .inSeconds
            .toInt();
    // int cDays=DateTime.now().add;
    //return "$days Days:$hrs Hours:$min Minutes:$sec Seconds remaining";
    // return days>=1?"$days Days ":hrs>1?"$hrs Hours" :min>1?"$min Minutes":sec>60?"$sec Seconds ":"Starting soon";
    // return "$days days";
    if (days > 1)
      return "$days Days";
    else if (hrs > 1)
      return "$hrs Hours";
    else if (min > 1)
      return "$min Minutes";
    else if (sec > 1)
      return "$sec Seconds";
    else
      return "0";
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      height: MediaQuery.of(context).size.height * .3,
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
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Event(docSnap: docSnap, guest: guest)));
        },
        child: ClipRRect(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.0),
              topRight: Radius.circular(10.0),
              bottomRight: Radius.circular(10.0),
              bottomLeft: Radius.circular(10)),
          child: Stack(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                color: Colors.black,
              ),
              background(),
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      // Colors.black87,
                      Colors.black54,
                      Colors.transparent
                    ],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: TransparentChip(
                  label: docSnap['name'].trim(),
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: TransparentChip(
                  label: docSnap['status'] == 0
                      ? "Status:${time_rem() == "0" ? "Starting soon" : " ${time_rem()} to go"}"
                      : docSnap['status'] == 1
                          ? "Event started"
                          : "Event ended",
                  size: 16,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget background() {
    return CachedNetworkImage(
      imageUrl: docSnap['img'],
      placeholder: (context, url) => Center(
        child: Image(
          image: AssetImage("assets/logo.png"),
        ),
      ),
    );
  }
}
