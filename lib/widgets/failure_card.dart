import 'package:flutter/material.dart';

class FailureCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  Center(
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        elevation: 12,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)),
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 40,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.error,
                size: 80,
                color: Colors.red,
              ),
              SizedBox(
                height: 30,
              ),
              Text('Something Went Wrong',
                  style:
                  TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
              SizedBox(
                height: 30,
              ),
              OutlineButton(
                  child: Text('Try Again'),
                  onPressed: () {

                  }),
              SizedBox(
                height: 15,
              ),
              OutlineButton(
                child: Text('Go Back'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          ),),
      ),
    );
  }
}
