import 'dart:io';

import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:habba20/models/user_model.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

class AplPdf{
  UserModel user;
  AplPdf({this.user});
  Future<void> main() async {
    final Document pdf = Document();


    pdf.addPage(Page(
        pageFormat: PdfPageFormat.a4,
        build: (context) {
          return Column(children: <Widget>[


            Row(
              children: <Widget>[
                Column(children: <Widget>[
                  Text("Name : ${user.Name}"),
                  Text("Email : ${user.Mail}"),
                  Text("Gender : ${user.Sex}"),
                  Text("Date of Birth : ${user.Sex}"),
                  Text("Designation : ${user.Desig}"),
                  Text("USN/ EID : ${user.Id}"),
                  Text("College : ${user.College}"),
                  Text("Department: ${user.Branch}"),
                  Text("Mobile : ${user.WhatsApp}"),
                  Text("Catagory: ${user.Work}"),

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
            Text("Signature"),

          ]
          ); // Center
        })); // Page
    print("Saviing pdf");
    final File file = File('example.pdf');
    file.writeAsBytesSync(pdf.save());
    print("PDf Saved");
    final Email email = Email(
      body: 'Hello we welcome you for regsitraion for apl',
      subject: 'APL Registration',
      recipients: ['${user.Mail}'],
     // cc: ['cc@example.com'],
      //bcc: ['bcc@example.com'],
      //attachmentPath: '/path/to/attachment.zip',
      isHTML: false,
    );
    print("EMail Sending start");
    await FlutterEmailSender.send(email);
    print("EMail send");

  }

}