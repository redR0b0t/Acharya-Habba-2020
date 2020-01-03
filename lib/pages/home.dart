import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:habba20/pages/description.dart';

import 'package:provider/provider.dart';
import 'package:habba20/services/db_services.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void navigationPage(String Id, String name) {
    //Navigator.of(context).pushReplacementNamed('/next');
    Navigator.of(context).push(//new
        new MaterialPageRoute(
            //new

            builder: (context) => new Description(title: name) //new
            ) //new
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      backgroundColor: Colors.black,
      body: new Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/a2.jpg"),
            fit: BoxFit.cover,
          ),),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            new Expanded(child:
            new Container(
                child: new StreamBuilder(
                    stream: Firestore.instance.collection('events').snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData)
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      else {
                        return ListView.builder(
                            itemCount: snapshot.data.documents.length,
                            itemBuilder: (BuildContext context, int index) {
                              DocumentSnapshot docSnap =
                                  snapshot.data.documents[index];
                              return ListTile(
                                leading: CircleAvatar(
                                    child: Text('${docSnap['name'][0]}')),
                                title: Text('${docSnap['name']}'),
                                subtitle: Text("ID/PIN: ${docSnap.documentID}"),
                                onTap: () => navigationPage(
                                    '${docSnap['id']}', '${docSnap['name']}'),
                              );
                            });
                      }
                    })))
          ],
        ),
      ),
    );
  }
}
