import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'services/db_services.dart';
import 'splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'user_registration/root_screen.dart';

void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(builder: (_) => DatabaseService()),
      ],
      child: Builder(
        builder: (context){
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
                navigateAfterSeconds: RootScreen()
//                   ? Navigation()
//                    : LoginScreen() //HomePage()//MyHomePage(title: "Events list",)
            ),
          );
        },
      ),
    );
  }
  Future getCurrentUser() async {
    FirebaseUser _user = await FirebaseAuth.instance.currentUser();
    print("User: ${_user ?? "None"}");
    return _user;}
}

