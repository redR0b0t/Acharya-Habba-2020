import 'package:cloud_firestore/cloud_firestore.dart';


class UserModel {
  String Id;
  String Name;
  String Mail;
  String PhoneNumber;
  String WhatsApp;
  int Sex;
  String Institution;


  UserModel({
    this.Id = '',
    this.Name = '',
    this.Mail='',
    this.PhoneNumber = '',
    this.WhatsApp,
    this.Sex = 1,
    this.Institution='',

  });




 /* factory UserModel.fromFirestore(DocumentSnapshot data) {
    return UserModel(
        Id: data.documentID,

        Name: data['name'] ?? 'name',
        Mail: data['mail'],
        PhoneNumber: data['phone'] ?? 'phone',
        Sex: data['sex'] ?? 'sex',
        Institution: data['institution'] ?? 'institution'
    );

  }
*/
  void setData(DocumentSnapshot doc) {
    this.Name = doc.data['name'];
    this.PhoneNumber = doc.data['phone'];
    this.Id = doc.documentID;
    this.Mail=doc.data['mail'];
    this.Sex = doc.data['sex'];
    this.Institution = doc.data['institution'];

  }

  Map<String, dynamic> getMap() {
    return {
      'name': Name,
      'phone': PhoneNumber,
      'mail':Mail,
      'wapp':WhatsApp,
      'sex': Sex,
      'institution': Institution,

    };
  }
}
