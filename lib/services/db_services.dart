import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:habba20/models/event_model.dart';

class DatabaseService extends ChangeNotifier {
  static final Firestore _db = Firestore.instance;


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
}