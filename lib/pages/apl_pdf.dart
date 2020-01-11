import 'dart:io';

import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:habba20/models/user_model.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:flutter/material.dart'as mat;
import 'package:habba20/widgets/success_card.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart';
class AplPdf extends mat.StatelessWidget{
  var user=UserModel();
  AplPdf({this.user});
  mat.Widget build(mat.BuildContext context){
    //return SuccessCard();
    return mat.Scaffold(

    body: mat.FlatButton(
      //title: mat.Text("save"),
      child: mat.Text("save"),
      onPressed: ()=>save(user),
    ),
    );
  }

  Future save(UserModel user) async {
    final Document pdf = Document();
    final font = await rootBundle.load("assets/fonts/OpenSans-Regular.ttf");
    final ttf = Font.ttf(font);
    final Theme theme = Theme.withFont(
      base: ttf,

    );


    pdf.addPage(Page(
        theme: theme,
        pageFormat: PdfPageFormat.a4,
        build: (context) {
          return Column(children: <Widget>[


            Row(
              children: <Widget>[
                Column(children: <Widget>[
                  Text("Name : ${user.Name}",style: TextStyle(font: ttf, fontSize: 40)),
                  Text("Email : ${user.Mail}",style: TextStyle(font: ttf, fontSize: 40)),
                  Text("Gender : ${user.Sex}",style: TextStyle(font: ttf, fontSize: 40)),
                  Text("Date of Birth : ${user.Sex}",style: TextStyle(font: ttf, fontSize: 40)),
                  Text("Designation : ${user.Desig}",style: TextStyle(font: ttf, fontSize: 40)),
                  Text("USN/ EID : ${user.Id}",style: TextStyle(font: ttf, fontSize: 40)),
                  Text("College : ${user.College}",style: TextStyle(font: ttf, fontSize: 40)),
                  Text("Department: ${user.Branch}",style: TextStyle(font: ttf, fontSize: 40)),
                  Text("Mobile : ${user.WhatsApp}",style: TextStyle(font: ttf, fontSize: 40)),
                  Text("Catagory: ${user.Work}",style: TextStyle(font: ttf, fontSize: 40)),

                ]),
                Container(
                    height: 80,
                    width: 80,
                    decoration: BoxDecoration(

                      image: DecorationImage(
                          image: PdfImage( pdf.document,
                           //   image: decodeImageFromList(FileImage(_image).readAsBytesSync()).data.buffer.asUint8List(),
                            width: 80,
                            height: 80,)
                      ),


                    )
                )
              ],
            ),
            SizedBox(height: 10,),
            Text("Signature",style: TextStyle(font: ttf, fontSize: 40)),

          ]
          ); // Center
        })); // Page
    print("Saving pdf");
    print("sending to ${user.Mail}");
    final String dir = (await getApplicationDocumentsDirectory()).path;
    print(dir);
    final String path = '$dir/apl_pdf.pdf';
    final File file = File(path);
    await file.writeAsBytes(pdf.save());
    print("PDf Saved");
    print("sending to ${user.Mail}");
    final Email email = Email(
      body: 'Hello we welcome you for regsitraion for apl',
      subject: 'APL Registration',
      recipients: [user.Mail],
     // cc: ['cc@example.com'],
      //bcc: ['bcc@example.com'],
      //attachmentPath: '/path/to/attachment.zip',
     // isHTML: false,
    );
    print("EMail Sending start");
    await FlutterEmailSender.send(email);
    print("EMail send");

  }

}