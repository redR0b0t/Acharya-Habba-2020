import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String Id;
  String img;
  String Name;
  String Mail;
  String PhoneNumber;
  String WhatsApp;
  String Desig;
  int Type;
  String College;
  String Branch;
  String Year;
  String Work;
  String Date;
  String Sex;

  ///type specifies account type
  /// 0----> Volunteer
  /// 1-----> Students of acharya
  /// 2------> Student outside of acharya

  UserModel(
      {this.Id = '',
        this.img='',
      this.Name = 'Md imran',
      this.Mail = '',
      this.PhoneNumber = '',
      this.WhatsApp,
        this.Desig = "",
      this.College = 'Acharya Institute of technology',
      this.Branch = "nil",
      this.Year = "",
      this.Work = "",
      this.Type = 1,
        this.Sex='Male',
      this.Date=""});

  factory UserModel.fromFirestore(DocumentSnapshot data) {
    return UserModel(
        Id: data.documentID,

        Name: data['name'] ?? 'name',
        Mail: data['mail'],
        PhoneNumber: data['phone'] ?? 'phone',
        College: data['college'] ?? 'college'
    );

  }

  void setData(DocumentSnapshot doc) {
    this.Name = doc.data['name'];
    this.PhoneNumber = doc.data['phone'];
    this.Id = doc.documentID;
    this.Mail = doc.data['mail'];
    this.Desig = doc.data['desig'];
    this.College = doc.data['college'];
    this.Type = doc.data['type'];
    this.Date = doc.data['date'];
  }

  Map<String, dynamic> getMap() {
    return {
      'name': Name,
      'phone': PhoneNumber,
      'mail': Mail,
      'wapp': WhatsApp,
      'desig' : Desig,
      'college': College,
      'branch': Branch,
      'year': Year,
      'work': Work,
      'type': Type,
      'img':img,
      'date': Date
    };
  }
}
