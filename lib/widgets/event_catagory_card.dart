import 'package:flutter/material.dart';
import 'package:habba20/models/event_cat_model.dart';
import 'package:habba20/models/event_model.dart';
import 'package:habba20/pages/screens/event_list.dart';
import 'package:habba20/utils/app_theme.dart';

class EventCatagoryCard extends StatelessWidget {
   //EventCatagory cat;
   EventCatModel eventCat;

  //CallbackAction call;

  EventCatagoryCard({this.eventCat});
String image = "assets/catagory/cyborg.png";
  @override
  Widget build(BuildContext context) {
    final textStyle = new TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w700,
      fontSize: 18.0,
    );
    return new Container(
      margin: const EdgeInsets.only(right: 10.0, left: 10.0, top: 8),
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
          //gradient:
      ),
      child: InkWell(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=> EventList(eventCat: eventCat,)));
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
              child: new Text(
                eventCat.Name.replaceAll('\\n', '\n').trim(),
                style: AppTheme.title,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget background() {
    return Image.asset(
      '${eventCat.BackgroundUrl}',
      fit: BoxFit.fill,
      colorBlendMode: BlendMode.darken,
    );
  }
}
