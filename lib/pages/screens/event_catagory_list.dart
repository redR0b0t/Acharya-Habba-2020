import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:habba20/models/event_cat_model.dart';
import 'package:habba20/utils/app_theme.dart';
import 'package:habba20/utils/style_guide.dart';
import 'package:habba20/widgets/color_card.dart';
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
        color: Colors.red,
        child: ListView(
          children: <Widget>[
            SizedBox(
              height: 80,
            ),
            Text('  Event catagory' , style: AppTheme.headline,),
            SizedBox(height: 20,),
            Container(
              height: MediaQuery.of(context).size.height * .6,
              child: Swiper(
                pagination: SwiperPagination(
                  builder: SwiperPagination.fraction
                ),
               // controller: Scontroller,
                viewportFraction: 0.85,
                scale: 0.3,
                itemBuilder: (BuildContext context, int index) {
                  return EventCatagoryCard(eventCat: EventCatMap[EventCatagory.Sports],);
                },
                itemCount: 3,
                //control: new SwiperControl(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
