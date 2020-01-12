import 'package:pdf/widgets.dart';
import 'package:pdf/pdf.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:habba20/models/user_model.dart';
import 'package:printing/printing.dart';
import 'package:flutter/material.dart' as mat;
import 'dart:io';

generatePDF(UserModel user, File img) async {
  double pfont = 12;
  final Document pdf = Document();
  PdfImage pimg = await pdfImageFromImageProvider(
    pdf: pdf.document,
    image: mat.FileImage(img),
  );
  final font = await rootBundle.load("assets/fonts/open-sans.ttf");
  final ttf = Font.ttf(font);
//      final fontBold = await rootBundle.load("assets/open-sans-bold.ttf");
//      final ttfBold = pdfLib.Font.ttf(fontBold);
//      final fontItalic = await rootBundle.load("assets/open-sans-italic.ttf");
//      final ttfItalic = pdfLib.Font.ttf(fontItalic);
//      final fontBoldItalic = await rootBundle.load("assets/open-sans-bold-italic.ttf");
//      final ttfBoldItalic = pdfLib.Font.ttf(fontBoldItalic);
  final theme = Theme.withFont(
    base: ttf,
//        bold: ttfBold,
//        italic: ttfItalic,
//        boldItalic: ttfBoldItalic,
  );

  pdf.addPage(Page(
      theme: theme,
      build: (context) {
        return Column(mainAxisSize: MainAxisSize.max, children: <Widget>[
          SizedBox(height: 50),
          Text("APL Player Registration Form",
              style: TextStyle(
                  font: ttf, fontSize: 22, fontWeight: FontWeight.bold)),
          SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("Name : ${user.Name}",
                        style: TextStyle(font: ttf, fontSize: pfont)),
                    SizedBox(height: 25),
                    Text("Email : ${user.Mail}",
                        style: TextStyle(font: ttf, fontSize: pfont)),
                    SizedBox(height: 25),
                    Text("Gender : ${user.Sex}",
                        style: TextStyle(font: ttf, fontSize: pfont)),
                    SizedBox(height: 25),
                    Text("Date of Birth : ${user.Sex}",
                        style: TextStyle(font: ttf, fontSize: pfont)),
                    SizedBox(height: 25),
                    Text("Designation : ${user.Desig}",
                        style: TextStyle(font: ttf, fontSize: pfont)),
                    SizedBox(height: 25),
                    Text("USN/ EID : ${user.Id}",
                        style: TextStyle(font: ttf, fontSize: pfont)),
                    SizedBox(height: 25),
                    Text("College : ${user.College}",
                        style: TextStyle(font: ttf, fontSize: pfont)),
                    SizedBox(height: 25),
                    Text("Department: ${user.Branch}",
                        style: TextStyle(font: ttf, fontSize: pfont)),
                    SizedBox(height: 25),
                    Text("Mobile : ${user.WhatsApp}",
                        style: TextStyle(font: ttf, fontSize: pfont)),
                    SizedBox(height: 25),
                    Text("Category: ${user.Work}",
                        style: TextStyle(font: ttf, fontSize: pfont)),
                  ]),
              Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Container(
                        height: 100,
                        width: 140,
                        padding: EdgeInsets.fromLTRB(155.0, 30.0, 15.0, 200.0),
                        decoration: BoxDecoration(
                          image: DecorationImage(image: pimg),
                        )),
                    SizedBox(height: 250),
                    Center(
                      child: Text("Signature           ",
                          style: TextStyle(font: ttf, fontSize: pfont)),
                    )
                  ])
            ],
          ),
          SizedBox(
            height: 10,
          ),
          SizedBox(height: 45),
          Text(' Please note',
              style: TextStyle(
                  font: ttf, fontSize: pfont, fontWeight: FontWeight.bold),
              textAlign: TextAlign.left),
          SizedBox(height: 25),
          Text(
              "1)Every player(student) must get this player application form signed from his department Proctor/HOD/Principal/Dean and will submit the same in CPRDreception before 17th February 2019.",
              style: TextStyle(font: ttf, fontSize: pfont),
              textAlign: TextAlign.left),
          SizedBox(height: 15),
          Text(
              "2)Those students who have submitted the application form will next undergo a tryouts conducted by the organising committee, in the stadium on 19,20 & 21 of February 2019, and team owners will be present during this process.",
              style: TextStyle(font: ttf, fontSize: pfont),
              textAlign: TextAlign.left),
          SizedBox(height: 15),
          Text(
              "3) Only players who have participated in the tryouts are eligible for the auction and to take part in APL Season 5.",
              style: TextStyle(font: ttf, fontSize: pfont),
              textAlign: TextAlign.left),
        ]); // Center
      }));

  final String dir = (await getApplicationDocumentsDirectory()).path;
  print(dir);
  final String tempdir = (await getTemporaryDirectory()).path;
  print(tempdir);
  final String path = '$dir/test_pdf.pdf';
  final String tpath = '$tempdir/test_pdf.pdf';

  final File file = File(tpath);
  await file.writeAsBytes(pdf.save());
  print("Saved the pdf file");
  final Email email = Email(
    body: 'Hello we are from apl team. Thank you for registering for apl',
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
