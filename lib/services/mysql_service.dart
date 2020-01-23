import 'package:flutter/cupertino.dart';
import 'package:habba20/models/user_model.dart';
import 'package:mysql1/mysql1.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;
var settings = new ConnectionSettings(
    host: 'server.two-t.com', port: 3306, user: 'ahabba', password: 'BestFest2020', db: 'ahabba_apl2020');
//var conn = await MySqlConnection.connect(settings);

Future<void> save_mysql(MySqlConnection conn, UserModel user) async {
  var result = await conn.query(
      'insert into applicants (name, usn,sex,desig,phone,img) values (?, ?, ?, ?,?,?)',
      [user.Name, user.Id,user.Desig,user.WhatsApp,user.img]);
  print(result);
}

void post_apl(UserModel user) async {
  var result = await http.post(
      "http://acharyahabba.in/habba2020/apl2020/register_apl.php",
      body: {
        'name': user.Name,
        'usn':user.Id,
        'email':user.Mail,
        'num':user.WhatsApp,
        'dept': user.Branch,
        'clg':user.College,
        'year':user.Year,
        'skill':user.Work,
        //'image':Image.network(user.img),
        'url': user.img,
        'cat':user.Work,
        'gender':user.Sex,
        'dob':user.Date,
        'desig': user.Desig,

      }
  );
  print(result.body);
}

void post_vol(UserModel user) async{

  var result = await http.post(
      "http://acharyahabba.in/habba19/vol.php",
      body: {
        'name': user.Name,
        'usn':user.Id,
        'email':user.Mail,
        'num':user.WhatsApp,
        'dept': user.Branch,
        'clg':user.College,
        'year':user.Year,
        'cat':user.Work,
        'gender':user.Sex,
        'dob':user.Date,
        'desig': user.Desig,


      }
  );
  print(result.body);
}