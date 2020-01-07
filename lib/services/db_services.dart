import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/widgets.dart';
import 'package:habba20/models/event_model.dart';
import 'package:habba20/models/user_model.dart';
import 'package:habba20/pages/apl_pdf.dart';

class DatabaseService extends ChangeNotifier {
  static final Firestore _db = Firestore.instance;
  static final FirebaseStorage _storage = FirebaseStorage.instance;


  Stream<List<EventModel>> streamEvents() {
    var ref =
    _db.collection('events');
    return ref.snapshots().map((list) =>
        list.documents
            .map((doc) =>
            EventModel.fromFirestore(
              doc,
            ))
            .toList());
  }

  Future<bool> regsiterApl(UserModel _user, File _image) async {
    AplPdf aplPdf;
    int tym = DateTime
        .now()
        .millisecondsSinceEpoch;
    _user.Date = tym.toString();
    try {
      if (_image != null) {
        StorageTaskSnapshot task = await _storage
            .ref()
            .child(_user.WhatsApp.toString() + '.jpg')
            .putFile(_image)
            .onComplete;
        _user.img = await task.ref.getDownloadURL();
        print("Iimage >>> >${_user.img}");
      }
      await Firestore.instance
          .collection('apl')
          .document(_user.Id)
          .setData(_user.getMap());
    // aplPdf = AplPdf(user: _user);
      return true;
    }catch(err){
      print("Errr>>>>> >${err}");
      return false;
    }
  }

}