import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:habba20/models/user_model.dart';
import 'package:habba20/pages/apl_sign_up.dart';
import 'package:habba20/pages/pdf_save.dart';
import 'delayed_animation.dart';
import 'volunteer_sign_up.dart';

class VolunteerLandingPage extends StatefulWidget {
  @override
  _VolunteerLandingPageState createState() => _VolunteerLandingPageState();
}

class _VolunteerLandingPageState extends State<VolunteerLandingPage>
    with SingleTickerProviderStateMixin {
  final int delayedAmount = 500;
  double _scale;
  AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 200,
      ),
      lowerBound: 0.0,
      upperBound: 0.1,
    )..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final color = Colors.white;
    _scale = 1 - _controller.value;
    return Scaffold(
        backgroundColor: Color(0xFF8185E2),
        body: Center(
          child: ListView(
            children: <Widget>[
              AvatarGlow(
                endRadius: 90,
                duration: Duration(seconds: 2),
                glowColor: Colors.white24,
                repeat: true,
                repeatPauseDuration: Duration(milliseconds: 25),
                startDelay: Duration(seconds: 1),
                child: Material(
                    elevation: 8.0,
                    shape: CircleBorder(),
                    child: CircleAvatar(
                      backgroundColor: Colors.grey[100],
                      child: Image.asset("assets/xpaw.png"),
                      radius: 50.0,
                    )),
              ),
              DelayedAnimation(
                child: Text(
                  "Hi There",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 35.0,
                      color: color),
                  textAlign: TextAlign.center,
                ),
                delay: delayedAmount + 1000,
              ),
              DelayedAnimation(
                child: Text(
                  "I'm Simba",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 35.0,
                      color: color),
                  textAlign: TextAlign.center,
                ),
                delay: delayedAmount + 2000,
              ),
              SizedBox(
                height: 30.0,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                child: DelayedAnimation(
                  child: Text(
                    "Welcome to the Volunteer and Apl Registration of Habba \n2020",
                    style: TextStyle(fontSize: 25.0, color: color),
                    textAlign: TextAlign.center,
                  ),
                  delay: delayedAmount + 3000,
                ),
              ),
              SizedBox(
                height: 30.0,
              ),

              DelayedAnimation(
                child: GestureDetector(
                  onTapDown: _onTapApl,
                  onTapUp: _onTapUp,
                  child: Transform.scale(
                    scale: _scale,
                    child: aplBtn,
                  ),
                ),
                delay: delayedAmount + 4000,
              ),
              SizedBox(height: 25,),
              DelayedAnimation(
                child: GestureDetector(
                  onTapDown: _onTapDown,
                  onTapUp: _onTapUp,
                  child: Transform.scale(
                    scale: _scale,
                    child: _animatedButtonUI,
                  ),
                ),
                delay: delayedAmount + 5000,
              ),
              SizedBox(
                height: 50.0,
              ),
             /* DelayedAnimation(
                child: Text(
                  "I Already have An Account".toUpperCase(),
                  style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: color),
                ),
                delay: delayedAmount + 5000,
              ),*/
            ],
          ),
        )
        //  Column(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: <Widget>[
        //     Text('Tap on the Below Button',style: TextStyle(color: Colors.grey[400],fontSize: 20.0),),
        //     SizedBox(
        //       height: 20.0,
        //     ),
        //      Center(

        //   ),
        //   ],

        // ),
        );
  }

  Widget get aplBtn => Padding(
    padding: EdgeInsets.symmetric(horizontal: 30),
    child:Container(
      height: 60,
      width: 270,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100.0),
        color: Colors.white,
      ),
      child: Center(
        child: Text(
          'APL',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Color(0xFF8185E2),
          ),
        ),
      ),
    ),
  );
  Widget get _animatedButtonUI => Padding(
    padding: EdgeInsets.symmetric(horizontal: 30),
    child:Container(
      height: 60,
      width: 270,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100.0),
        color: Colors.white,
      ),
      child: Center(
        child: Text(
          'Volunteer',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Color(0xFF8185E2),
          ),
        ),
      ),
    ),
  );
  UserModel _user = UserModel();

  void _onTapApl(TapDownDetails details) {
    Navigator.push(context, MaterialPageRoute(builder: (context)=> Pdfsave(user: _user)));
   // Navigator.push(context, MaterialPageRoute(builder: (context)=> AplSignUp()));
    _controller.forward();
  }
  void _onTapDown(TapDownDetails details) {
    Navigator.push(context, MaterialPageRoute(builder: (context)=> VolunteerSignUp()));
    _controller.forward();
  }

  void _onTapUp(TapUpDetails details) {
    _controller.reverse();
  }
}
