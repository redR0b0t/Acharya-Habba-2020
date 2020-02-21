import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:habba20/data/data.dart';
import 'package:habba20/pages/delayed_animation.dart';
import 'package:habba20/pages/screens/about_habba.dart';
import 'package:habba20/utils/style_guide.dart';
import 'package:habba20/widgets/background.dart';
import 'package:habba20/widgets/glow_avatar.dart';

class Welcome extends StatefulWidget {
  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

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
                  GlowAvatar(
                    avatarUrl: "assets/icon.png",
                  ),
                  DelayedAnimation(
                    delay: delayedAmount,
                    child: Container(
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
                        ' Welcome to Acharya Habba \n2020',
                        style: title,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  DelayedAnimation(
                    delay: delayedAmount + 300,
                    child: Card(
                      margin:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      color: Colors.white.withOpacity(0.88),
                      elevation: 15,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          SizedBox(width: 20.0, height: 100.0),
                          Text(
                            "We",
                            style: TextStyle(
                                fontSize: ScreenUtil().setSp(62),
                                fontFamily: "RobotoMedium"),
                          ),
                          SizedBox(width: 20.0, height: 100.0),
                          RotateAnimatedTextKit(
                              totalRepeatCount: 60,
                              onTap: () {},
                              text: ["ARE ACHARYANS", "❤ HABBA", "ARE GEN-Z"],
                              textStyle: TextStyle(
                                  fontSize: ScreenUtil().setSp(67),
                                  fontFamily: "Horizon",
                                  color: Colors.deepOrange),
                              textAlign: TextAlign.start,
                              alignment: AlignmentDirectional
                                  .topStart // or Alignment.topLeft
                              ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  DelayedAnimation(
                    delay: delayedAmount + 600,
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0),
                          side: BorderSide(color: Colors.blue, width: 2)),
                      color: Colors.deepOrange,
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AboutHabba()));
                      },
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                      child: Text(
                        "Know more about habba",
                        style: subtitleWhite,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
