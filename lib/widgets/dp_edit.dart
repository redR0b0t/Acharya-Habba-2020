import 'dart:io';
import 'package:habba20/data/data.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:habba20/widgets/profile_picture.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/widgets.dart';

class DpEdit extends StatefulWidget {
  String image;
  String name;
  //String img;

  DpEdit({this.image = "", this.name = ""});

  @override
  _DpEditState createState() => _DpEditState();
}

class _DpEditState extends State<DpEdit> {
  int state;
  File _image;
  static final FirebaseStorage _storage = FirebaseStorage.instance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    state = 0;
  }

  @override
  Widget build(BuildContext context) {
    print("Staee>>>> ${state}");
    return Scaffold(
      appBar: AppBar(
        title: Text("Dp Edit"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Stack(
                alignment: Alignment.center,
                fit: StackFit.loose,
                children: <Widget>[
                  _image == null
                      ? ProfilePicture(
                          name: "${widget.name}",
                          imagePath: widget.image,
                          size: 80,
                        )
                      : CircleAvatar(
                          radius: 80,
                          backgroundImage: FileImage(_image),
                        ),
                  Positioned(
                    height: 40,
                    width: 40,
                    bottom: 1,
                    right: 1,
                    child: FloatingActionButton(
                        child: Icon(Icons.edit), onPressed: showImagePicker),
                  )
                ]),
            SizedBox(
              height: 20,
            ),
            RaisedButton(
              padding: EdgeInsets.symmetric(horizontal: 35, vertical: 12),
              elevation: 5,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30))),
              //color: AppTheme.primaryBtnColor,
              color: Colors.deepOrange,
              onPressed: () {
                print("pressed btn");
                update(context);
              },
              child: Text(
                'Update',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget showSuccessSnack() {
    Flushbar(
      reverseAnimationCurve: Curves.decelerate,
      forwardAnimationCurve: Curves.elasticOut,
      backgroundColor: Colors.red,
      boxShadows: [
        BoxShadow(
            color: Colors.blue[800], offset: Offset(0.0, 2.0), blurRadius: 3.0)
      ],
      backgroundGradient: LinearGradient(colors: [
        Colors.black,
        Colors.blueGrey,
      ]),
      // flushbarStyle: FlushbarStyle.FLOATING,

      margin: EdgeInsets.all(8),
      borderRadius: 8,
      title: "Uploaded Successfully",
      message: "Your Update will be visible soon.",
      duration: Duration(seconds: 2),
    )..show(context);
  }

  void showImagePicker() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            color: Color(0xFF737373),
            height: 180,
            child: Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).canvasColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  FloatingActionButton(
                    child: Icon(Icons.image),
                    onPressed: getImageFromGallery,
                  ),
                  FloatingActionButton(
                      child: Icon(Icons.camera), onPressed: getImageFromCamera)
                ],
              ),
            ),
          );
        });
  }

  Future getImageFromGallery() async {
    var image = await ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 60);
    setState(() {
      _image = image;
    });
    Navigator.of(context).pop();
  }

  Future getImageFromCamera() async {
    var image = await ImagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 60);
    setState(() {
      _image = image;
    });
    Navigator.of(context).pop();
  }

  Future<bool> updateProfileImage(File _img) async {
    String ts=DateTime.now().millisecondsSinceEpoch.toString();
    String dURL;
    StorageTaskSnapshot task = await _storage
        .ref()
        .child(ts + '.jpg')
        .putFile(_img)
        .onComplete;
    dURL= await task.ref.getDownloadURL();
    imgURL=dURL;

    return true;
  }

  Future update(BuildContext context) async {


    if (_image != null) {
      state = 1;
      getSnack(state, context);
      if (await updateProfileImage(_image)) {
        setState(() {
          state = 2;
          Navigator.pop(context);
          getSnack(state, context);
        });
      } else {
        setState(() {
          state = 3;
          Navigator.pop(context);
          getSnack(state, context);

        });
      }
    }
  }

  Widget showErrorSnack() {
    Flushbar(
      reverseAnimationCurve: Curves.decelerate,
      forwardAnimationCurve: Curves.elasticOut,
      backgroundColor: Colors.red,
      boxShadows: [
        BoxShadow(
            color: Colors.blue[800], offset: Offset(0.0, 2.0), blurRadius: 3.0)
      ],
      backgroundGradient: LinearGradient(colors: [
        Colors.black,
        Colors.blueGrey,
      ]),
      // flushbarStyle: FlushbarStyle.FLOATING,

      margin: EdgeInsets.all(8),
      borderRadius: 8,
      title: "Update Failed",
      message: "Please try again later.",
      duration: Duration(seconds: 2),
    )..show(context);
  }

  Widget showLoadingSnack() {
    Flushbar(
      reverseAnimationCurve: Curves.decelerate,
      forwardAnimationCurve: Curves.elasticOut,
      backgroundColor: Colors.red,
      boxShadows: [
        BoxShadow(
            color: Colors.blue[800], offset: Offset(0.0, 2.0), blurRadius: 3.0)
      ],
      backgroundGradient: LinearGradient(colors: [
        Colors.black,
        Colors.blueGrey,
      ]),
      // flushbarStyle: FlushbarStyle.FLOATING,

      margin: EdgeInsets.all(8),
      showProgressIndicator: true,
      borderRadius: 8,
      title: "Updating ",
      message: "This may take some time.",
      //duration: Duration(seconds: 1),
    )..show(context);
  }

  Widget getSnack(int state, BuildContext context) {
    switch (state) {
      case 1:
        {
          showLoadingSnack();
          break;
        }
      case 2:
        {
          showSuccessSnack();
          break;
        }
      case 3:
        {
          showErrorSnack();
          break;
        }
    }
  }
}
