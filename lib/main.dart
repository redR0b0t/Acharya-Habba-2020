import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:habba20/pages/home.dart';
import 'pages/volunteer_landing_page.dart';
import 'splash_screen.dart';
import 'package:habba20/pages/home_page.dart';

void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Habba 2020',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(
        seconds: 3,
        image: Image.asset('assets/splash.gif'),
        backgroundColor: Colors.black,
        photoSize: 300,
        navigateAfterSeconds:  VolunteerLandingPage() //HomePage()//MyHomePage(title: "Events list",)
      ),
    );
  }
}

