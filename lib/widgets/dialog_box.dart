
import 'package:flutter/material.dart';


class DialogBox{

  DialogBox._();

  void  transactionDelete( BuildContext context) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            //backgroundColor: Colors.black87,

            title: Text(
              "Logout",
              // style: TextStyle(color: Colors.white),
            ),
            content: Text(
              "Are you sure ? ",
              //style: TextStyle(color: Colors.white)
            ),
            actions: <Widget>[
              FlatButton(
                child: Text("No"),
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                color: Colors.deepPurple,
                child: Text("Yes", style: TextStyle(color: Colors.white),),
                onPressed: ()  {

                },
              )
            ],
          );
        });
  }

/*
  void onLogoutTapDialog(UserProvider user, BuildContext context) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            //backgroundColor: Colors.black87,

            title: Text(
              "Logout",
              // style: TextStyle(color: Colors.white),
            ),
            content: Text(
              "Are you sure ? ",
              //style: TextStyle(color: Colors.white)
            ),
            actions: <Widget>[
              FlatButton(
                child: Text("No"),
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                color: Colors.deepPurple,
                child: Text("Yes", style: TextStyle(color: Colors.white),),
                onPressed: () async {
                  await user.signOut();
                  Navigator.of(context).pop();

                },
              )
            ],
          );
        });
  }
*/
  void _showUpdatingDialog(BuildContext context) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Sending"),
            content: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CircularProgressIndicator(),
              ],
            ),
          );
        });
  }

  void _showSuccessDialog(BuildContext context) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(' We got your notice'),
            content: Text('Thanks for sending us your valuable notice'),
            actions: <Widget>[
              FlatButton(
                child: Text('Done'),
                onPressed: () {
                  Navigator.of(context).pop();
                  //Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  void _showErrorDialog(BuildContext context ,_sendNotice) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('unable to send notice'),
            content: Text(
                'it seems there is a problem , please retry or try at anthother time'),
            actions: <Widget>[
              FlatButton(
                child: Text('Retry'),
                onPressed: () {
                  _sendNotice();
                },
              )
            ],
          );
        });
  }

}


