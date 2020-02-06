import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:habba20/pages/screens/event.dart';
import 'package:habba20/utils/app_theme.dart';

class EventCard extends StatelessWidget {
  String title;
  Gradient gradient;

  //CallbackAction call;

  EventCard({this.title, this.gradient});
  String image = "assets/catagory/cyborg.png";
  @override
  Widget build(BuildContext context) {
    final textStyle = new TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w700,
      fontSize: 18.0,
    );
    return new Container(
      height: MediaQuery.of(context).size.height*.2,
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
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=> Event(image: image, title: title,)));
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
                title.replaceAll('\\n', '\n').trim(),
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
      '${image}',
      fit: BoxFit.fill,
      colorBlendMode: BlendMode.darken,
    );
  }

}
