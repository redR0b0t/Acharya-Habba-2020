import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  String Name;
  String Mail;
  int type;
  String WhatsApp;
  String img;
  String College;
  List events_reg;


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
        this.events_reg=null,

      });

  factory UserModel.fromFirestore(DocumentSnapshot data) {
    return UserModel(


        Name: data['name'] ?? 'name',
        Mail: data['mail'],
        type: data['type'],
        College: data['college'] ?? 'college',
        img: data['img'] ?? 'img',
        events_reg: data['events_reg'] ?? null,

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
      'events_reg': null,
      'college': College,
      'img': img,
      'type': type,

    };
  }
}
Future<FirebaseUser>  _fetchUser() async{
  FirebaseUser _user = await FirebaseAuth.instance.currentUser();
  print("User: ${_user ?? "None"}");
  String eid=_user.email;
  print(eid);
  if(eid!=null)
    //fetched=true;
    return _user;


}
