import 'package:flutter/material.dart';

class SuccessCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        elevation: 12,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 40,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 250,
                child: Icon(Icons.check_circle,color: Colors.green, size: 150,),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Registration Successfull',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              SizedBox(
                height: 30,
              ),
              RaisedButton(
                child: Text('Go Back', style: TextStyle(color: Colors.white),),
                color: Colors.red,
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
