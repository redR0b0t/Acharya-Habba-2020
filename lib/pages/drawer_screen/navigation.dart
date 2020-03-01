import 'package:flutter/material.dart';
import 'package:habba20/pages/screens/about_habba.dart';
import 'package:habba20/pages/screens/devs.dart';
import 'package:habba20/pages/screens/event_catagory_list.dart';
import 'package:habba20/pages/screens/insta_screen.dart';
import 'package:habba20/pages/screens/my_event_list.dart';
import 'package:habba20/pages/screens/timeline.dart';
import 'package:habba20/pages/screens/welcome.dart';
import 'package:habba20/utils/app_theme.dart';

import 'appDrawer.dart';
import 'drawerUserController.dart';

class Navigation extends StatefulWidget {
  @override
  _NavigationState createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  Widget screenView;
  DrawerIndex drawerIndex;
  AnimationController sliderAnimationController;


  @override
  void initState() {
    super.initState();
    drawerIndex = DrawerIndex.HOME;
    screenView = Welcome();
    //screenView= Timeline();

  }

  Future<bool> _onBackPressed() {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Exit App"),
          content: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text("Are you sure you want to  leave ?\n"),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  GestureDetector(
                    child: Text(
                      "No",
                      style: TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.w700),
                    ),
                    onTap: () {
                      Navigator.of(context).pop(false);
                    },
                  ),
                  SizedBox(width: 25.0),
                  GestureDetector(
                    child: Text(
                      "Yeah",
                      style: TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.w700),
                    ),
                    onTap: () {
                      //signOutGoogle();
                      Navigator.of(context).pop(true);
                    },
                  )
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.nearlyWhite,
      child: SafeArea(
        top: false,
        bottom: false,
        child: WillPopScope(
          onWillPop: _onBackPressed,
          child: Scaffold(
            backgroundColor: AppTheme.nearlyWhite,
            body:
            DrawerUserController(
              screenIndex: drawerIndex,
              drawerWidth: MediaQuery.of(context).size.width * 0.75,
              animationController: (AnimationController animationController) {
                sliderAnimationController = animationController;
              },
              onDrawerCall: (DrawerIndex drawerIndexdata) {
                changeIndex(drawerIndexdata);
              },
              screenView: screenView,
            ),
          ),
        ),
      ),
    );
  }

  void changeIndex(DrawerIndex drawerIndexdata) {
    if (drawerIndex != drawerIndexdata) {
      drawerIndex = drawerIndexdata;
      if (drawerIndex == DrawerIndex.HOME) {
        setState(() {
          screenView = Welcome();
        });
      } else if (drawerIndex == DrawerIndex.EventList) {
        setState(() {
          screenView = EventCatagoryList();
        });
      } else if (drawerIndex == DrawerIndex.Timeline) {
        setState(() {
          screenView = Timeline(guest: false);
        });
      } else if (drawerIndex == DrawerIndex.MyEventList) {
        setState(() {
          screenView = MyEventList();
        });
      } else if (drawerIndex == DrawerIndex.Instagram) {
        setState(() {
          screenView = InstaScreen();
        });
      } else if (drawerIndex == DrawerIndex.Devs) {
        setState(() {
          screenView = Devs();
        });
      } else if (drawerIndex == DrawerIndex.About) {
        setState(() {
          screenView = AboutHabba();
        });
      } else {
        //do in your way......
      }
    }
  }
}
