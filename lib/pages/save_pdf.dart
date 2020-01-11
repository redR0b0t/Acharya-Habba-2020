import 'dart:io';
import 'package:flutter/material.dart' as mat;
import 'package:pdf/widgets.dart';
import 'package:pdf/pdf.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:habba20/models/user_model.dart';

class Pdfsave extends mat.StatelessWidget {
  var user=UserModel();
  Pdfsave({this.user});
  @override
  mat.Widget build(mat.BuildContext context) {
    generatePDF() async {
      final Document pdf = Document();

      final font = await rootBundle.load("assets/fonts/open-sans.ttf");
      final ttf = Font.ttf(font);
//      final fontBold = await rootBundle.load("assets/open-sans-bold.ttf");
//      final ttfBold = pdfLib.Font.ttf(fontBold);
//      final fontItalic = await rootBundle.load("assets/open-sans-italic.ttf");
//      final ttfItalic = pdfLib.Font.ttf(fontItalic);
//      final fontBoldItalic = await rootBundle.load("assets/open-sans-bold-italic.ttf");
//      final ttfBoldItalic = pdfLib.Font.ttf(fontBoldItalic);
      final  theme = Theme.withFont(
        base: ttf,
//        bold: ttfBold,
//        italic: ttfItalic,
//        boldItalic: ttfBoldItalic,
      );

      pdf.addPage(Page(
          theme: theme,
          build: (context) {
            return Column(children: <Widget>[


              Row(
                children: <Widget>[
                  Column(children: <Widget>[
                    Text("Name : ${user.Name}"),
                    Text("Email : ${user.Mail}"),
                    Text("Gender : ${user.Sex}"),
                    Text("Date of Birth : ${user.Date}"),
                    Text("Designation : ${user.Desig}"),
                    Text("USN/ EID : ${user.Id}"),
                    Text("College : ${user.College}"),
                    Text("Mobile : ${user.WhatsApp}"),
                    Text("Catagory: ${user.Work}"),

                  ]),
//                  Container(
//                      height: 80,
//                      width: 80,
//                      decoration: BoxDecoration(
//
//                        image: DecorationImage(
//                            image: PdfImage( pdf.document,                              //   image: decodeImageFromList(FileImage(_image).readAsBytesSync()).data.buffer.asUint8List(),
//                              width: 80,
//                              height: 80,)
//                        ),
//
//
//                      )
//                  )
                ],
              ),
              SizedBox(height: 10,),
              Text("Signature"),

            ]
            ); // Center
          }

//          build: (context) =>
//          [
//            pdfLib.Table.fromTextArray(
//                context: context,
//                data: <List<String>>[
//                  [
//                    'asdasasd',
//                    'asdsadsadsad',
//                    'asdasdasdasdasdasdass',
//                    'asd',
//                    'asdasdasd'
//                  ]
//                ]),
//          ]

      )
      );

      final String dir = (await getApplicationDocumentsDirectory()).path;
      print(dir);
      final String tempdir = (await getTemporaryDirectory()).path;
      print(tempdir);
      final String path = '$dir/test_pdf.pdf';
      final String tpath= '$tempdir/test_pdf.pdf';

      final File file = File(tpath);
      await file.writeAsBytes(pdf.save());
      print("Saved the pdf file");
      final Email email = Email(
        body: 'Hello we welcome you for regsitraion for apl',
        subject: 'APL Registration',
        recipients: [user.Mail],
        // cc: ['cc@example.com'],
        //bcc: ['bcc@example.com'],
        attachmentPath: file.path,
        // isHTML: false,
      );
      print("EMail Sending start");
      await FlutterEmailSender.send(email);
      print("EMail send");
    }

    return mat.MaterialApp(
        home: mat.Scaffold(
          appBar: mat.AppBar(
            title: mat.Text("PDF"),
          ),
          body: mat.Container(
            child: mat.Center(
              child: mat.RaisedButton(
                onPressed: generatePDF,
                child: mat.Text(
                  "call",
                  style: mat.TextStyle(fontFamily: 'Helvetica'),
                ),
              ),
            ),
          ),
        ));
  }
}