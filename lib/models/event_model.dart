import 'package:cloud_firestore/cloud_firestore.dart';

class EventModel {
  String Id;
  String Name;
  String img;
  String PhoneNumber;
  String WhatsApp;

  EventModel({
    this.Id = '',
    this.Name = '',
    this.img = '',
    this.PhoneNumber = '',
    this.WhatsApp = '',
  });

  factory EventModel.fromFirestore(DocumentSnapshot data) {
    return EventModel(
        Id: data.documentID,
        Name: data['name'] ?? 'name',
        img: data['img'],
        PhoneNumber: data['phone'] ?? 'phone',
    );
  }

  void setData(DocumentSnapshot doc) {
    this.Name = doc.data['name'];
    this.PhoneNumber = doc.data['phone'];
    this.Id = doc.documentID;
    this.img = doc.data['img'];
  }

  Map<String, dynamic> getMap() {
    return {
      'name': Name,
      'phone': PhoneNumber,
      'img': img,
      'wapp': WhatsApp,
    };
  }
}
