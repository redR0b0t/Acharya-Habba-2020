import 'package:flutter/material.dart';
import 'package:habba20/services/google_sigin_in.dart';

class SuccessCard extends StatelessWidget {
  String title;
  SuccessCard({this.title = ''});
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: MediaQuery.of(context).size.height * 0.6,
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        elevation: 12,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 35),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.check_circle,
                size: 80,
                color: Colors.green,
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                ' ${title} ',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 30,
              ),
              SizedBox(
                height: 15,
              ),
              RaisedButton(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                color: Colors.deepPurple,
                onPressed: () {
                  signOutGoogle();
                  Navigator.of(context).pop();
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30))),
                child: Center(
                  child: Text(
                    'Log out',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
