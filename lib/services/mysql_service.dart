import 'dart:io';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'dart:convert';
import 'package:http_parser/http_parser.dart';
import 'package:flushbar/flushbar_helper.dart';
import 'package:flushbar/flushbar.dart';
import 'package:mysql1/mysql1.dart';
import 'package:habba20/models/user_model.dart';

var settings = new ConnectionSettings(
    host: 'server.two-t.com',
    port: 3306,
    user: 'ahabba',
    password: 'BestFest2020',
    db: 'ahabba_apl2020');
//var conn = await MySqlConnection.connect(settings);

Future<void> save_mysql(MySqlConnection conn, UserModel user) async {
  var result = await conn.query(
      'insert into applicants (name, usn,sex,desig,phone,img) values (?, ?, ?, ?,?,?)',
      [user.Name, user.Id, user.Desig, user.WhatsApp, user.img]);
  print(result);
}

void post_apl2(UserModel user) async {
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
        'dob':user.Date.toString(),
        'desig': user.Desig,

      }
  );
  print(result.body);
}

void post_apl(UserModel user,File imageFile) async {
 // String URL2 = 'http://acharyahabba.in/apl/apl_register.php';
  String URL2= 'http://acharyahabba.in/habba2020/apl2020/register_apl.php';
 // File imageFile=Image.network(user.img);
  var stream =
      http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
  var length = await imageFile.length();
  var uri = Uri.parse(URL2);
  var req = http.MultipartRequest('POST', uri);
  var multipartFile = http.MultipartFile('image', stream, length,
      filename: basename(imageFile.path),
      contentType: MediaType('image', 'jpg'));
  req.files.add(multipartFile);
  req.fields.addAll({
    'name': user.Name,
    'usn': user.Id,
    'email': user.Mail,
    'num': user.WhatsApp,
    'dept': user.Branch,
    'clg': user.College,
    'year': user.Year,
    'skill': user.Work,
    //'image':Image.network(user.img),
    'url': user.img,
    'cat': user.Work,
    'gender': user.Sex,
    'dob': user.Date,
    'desig': user.Desig,
  });
//  Flushbar loader =
//      FlushbarHelper.createInformation(message: 'Please Wait. Uploading image')
//        ..isDismissible = false
//        ..show(context);
  var res = await req.send();
  //post_apl2(user);
  print('\t\t\t' + res.statusCode.toString());
  res.stream.transform(utf8.decoder).listen((value) {
//    if (value != null) {
//      loader.dismiss();
//      FlushbarHelper.createInformation(message: value)..show(context);
//    }
  });
}

void post_vol(UserModel user) async {
  var result = await http.post("http://acharyahabba.in/habba19/vol.php", body: {
    'name': user.Name,
    'usn': user.Id,
    'email': user.Mail,
    'num': user.WhatsApp,
    'dept': user.Branch,
    'clg': user.College,
    'year': user.Year,
    'cat': user.Work,
    'gender': user.Sex,
    'dob': user.Date,
    'desig': user.Desig,
    'interest':user.Work,
  });
  print(result.body);
}

//
//void post_vol(UserModel user) async {
//  var result = await http.post("http://acharyahabba.in//habba2020/vol2020/vol_reg_back.php", body: {
//    'name': user.Name,
//    'usn': user.Id,
//    'email': user.Mail,
//    'w_number': user.WhatsApp,
//    'department': user.Branch,
//    'institute': user.College,
//    'year': user.Year,
//
//    'gender': user.Sex,
//    'dob': user.Date,
//    'desig': user.Desig,
//    'c_number':user.PhoneNumber,
//    'contribution': user.Work,
//    'about':'',
//  });
//  print(result.body);
//}
