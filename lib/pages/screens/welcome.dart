import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:habba20/utils/app_theme.dart';
import 'package:habba20/utils/style_guide.dart';
import 'package:habba20/widgets/background.dart';
import 'package:habba20/widgets/glow_avatar.dart';

class Welcome extends StatefulWidget {
  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.green,
        child: Stack(
          children: <Widget>[
            Background(),
            SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 30,
                  ),
                  GlowAvatar(avatarUrl: "assets/icon.png",),
                  Text(
                    ' Welcome to Acharya Habba 2020',
                    style: title,
                    textAlign: TextAlign.center,
                  ),
                  Card(
                    margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    elevation: 15,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),

                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        SizedBox(width: 20.0, height: 100.0),
                        Text(
                          "Be",
                          style: TextStyle(fontSize: 40.0),
                        ),
                        SizedBox(width: 20.0, height: 100.0),
                        RotateAnimatedTextKit(
                            onTap: () {
                              print("Tap Event");
                            },
                            text: ["AWESOME", "OPTIMISTIC", "DIFFERENT"],
                            textStyle:
                            TextStyle(fontSize: 36.0, fontFamily: "Horizon"),
                            textAlign: TextAlign.start,
                            alignment: AlignmentDirectional
                                .topStart // or Alignment.topLeft
                        ),
                        SizedBox(width: 20.0, height: 100.0)
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
