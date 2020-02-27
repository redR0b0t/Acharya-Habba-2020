import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:habba20/user_registration/login_screen.dart';
import 'package:habba20/pages/drawer_screen/navigation.dart';

class LoggedIn extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _LoggedInState();
}

class _LoggedInState extends State<LoggedIn> {
  void initState(){
    Navigator.pushReplacement(context, MaterialPageRoute(builder:(context)=>Navigation()));
  }
  @override
  Widget build(BuildContext context) {
    return Navigation();
  }
}