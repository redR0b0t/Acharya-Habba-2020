import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'services/db_services.dart';
import 'splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'user_registration/root_screen.dart';
import 'package:habba20/pages/drawer_screen/navigation.dart';
import 'package:habba20/user_registration/login_screen.dart';


void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  FirebaseUser user;

  // This widget is the root of your application.
  void initScreen() {
    getCurrentUser();
    print(user);
    //print(user);
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(builder: (_) => DatabaseService()),
      ],
      child: Builder(
        builder: (context) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Habba 2020',
            color: Colors.black,
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: SplashScreen(
                seconds: 4,
                image: Image.asset('assets/splash.gif', fit: BoxFit.cover,),
                backgroundColor: Colors.white,
                photoSize: 300,
                navigateAfterSeconds: user !=
                    null ? Navigation() : LoginScreen() //RootScreen()
//                   ? Navigation()
//                    : LoginScreen() //HomePage()//MyHomePage(title: "Events list",)
            ),
          );
        },
      ),
    );
  }

  void getCurrentUser() async {
//    if (await FirebaseAuth.instance.currentUser() != null) {
//      return true;// signed in
//    } else {
//      return false;
//    }
//
//    }

    user = await FirebaseAuth.instance.currentUser();

  }
}

