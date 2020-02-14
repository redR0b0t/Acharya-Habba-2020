import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String Name;
  String Mail;
  int type;
  String WhatsApp;
  String img;
  String College;


  ///type specifies account type
  /// 0----> Volunteer
  /// 1-----> Students of acharya
  /// 2------> Student outside of acharya

  UserModel(
      {
        this.Name = 'Md imran',
        this.Mail = '',
        this.type=0,
        this.WhatsApp='',
        this.img='',
        this.College = 'Acharya Institute of technology',
      });

  factory UserModel.fromFirestore(DocumentSnapshot data) {
    return UserModel(


        Name: data['name'] ?? 'name',
        Mail: data['mail'],
        type: data['type'],
        College: data['college'] ?? 'college',
        img: data['img'] ?? 'img'
    );

  }

  void setData(DocumentSnapshot doc) {
    this.Name = doc.data['name'];

    this.Mail = doc.data['mail'];
    this.type =doc.data['type'];
    this.College = doc.data['college'];

  }

  Map<String, dynamic> getMap() {
    return {
      'name': Name,
      'mail': Mail,
      'wapp': WhatsApp,

      'college': College,
      'img': img,
      'type': type,

    };
  }
}
