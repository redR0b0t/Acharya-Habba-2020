import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:habba20/user_registration/login_screen.dart';
import 'package:habba20/pages/drawer_screen/navigation.dart';

class RootScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  @override
  Widget build(BuildContext context) {
    return new StreamBuilder<FirebaseUser>(
      stream: FirebaseAuth.instance.onAuthStateChanged,
      builder: (BuildContext context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return new Container(
            color: Colors.white,
          );
        } else {
          if (snapshot.hasData) {
            print(snapshot.data);
//user is logged in
            return Navigation(
             // firebaseUser: snapshot.data,
            );
          } else {
//user not logged in
            return LoginScreen();
          }
        }
      },
    );
  }
}