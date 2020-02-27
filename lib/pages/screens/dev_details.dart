import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:habba20/utils/style_guide.dart';
import 'package:habba20/widgets/social_icon.dart';
import 'package:url_launcher/url_launcher.dart';

class DevDetails extends StatefulWidget {
  DocumentSnapshot docSnap;

  DevDetails({this.docSnap});

  @override
  _DevDetailsState createState() => _DevDetailsState();
}

class _DevDetailsState extends State<DevDetails> {
  void initSate(){
    super.initState();
  }
  void dispose(){
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    print("Dev Details");
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            hexToColor('#EC9F05'),
            hexToColor('#FF4E00'),
          ],
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Text("About Dev"),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        backgroundColor: Colors.transparent,
        body: ListView(
          children: <Widget>[
            Stack(alignment: AlignmentDirectional.topCenter, children: <Widget>[
              Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(13)),
                  elevation: 12.0,
                  margin: EdgeInsets.only(
                      top: 82.0, bottom: 20.0, left: 20, right: 20),
                  child: Padding(
                      padding: EdgeInsets.all(18.0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                                padding:
                                    EdgeInsets.only(top: 85.0, bottom: 6.0),
                                child: Text(
                                  widget.docSnap['name'],
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 32.0,
                                      fontFamily: "Quicksand",
                                      fontWeight: FontWeight.w600),
                                )),
                            Text(
                              widget.docSnap['about'],
                              style: TextStyle(
                                  color:
                                      Theme.of(context).textTheme.caption.color,
                                  fontSize: 20,
                                  fontFamily: "Quicksand"),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "  Skills : ",
                                style: subtitle,
                              ),
                            ),
                            Wrap(
                              children: <Widget>[
                                Chip(
                                  label: Text(
                                    widget.docSnap['skills'][0],
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Chip(
                                  label: Text(
                                    widget.docSnap['skills'][1],
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Chip(
                                  label: Text(
                                    widget.docSnap['skills'][2],
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Chip(
                                  label: Text(
                                    widget.docSnap['skills'][3],
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "  Connect with us : ",
                                style: subtitle,
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Wrap(
                              children: <Widget>[
                                Visibility(
                                  visible: widget.docSnap['insta'] != '',
                                  child: SocialIcon(
                                    colors: [
                                      Color(0xFFff4f38),
                                      Color(0xFFff355d),
                                    ],
                                    icondata: FontAwesomeIcons.instagram,
                                    onPressed: () async {
                                      await launch(
                                          '${widget.docSnap['insta']}');
                                    },
                                  ),
                                ),
                                SocialIcon(
                                  colors: [Colors.red, Colors.redAccent],
                                  icondata: FontAwesomeIcons.solidEnvelope,
                                  onPressed: () async {
                                    String url =
                                        "mailto:${widget.docSnap['mail']}";
                                    if (await canLaunch(url)) {
                                      await launch(url);
                                    } else
                                      Scaffold.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text('Cannot open mail'),
                                        ),
                                      );
                                  },
                                ),
                                SocialIcon(
                                  colors: [
                                    Color(0xFF102397),
                                    Color(0xFF187adf),
                                    Color(0xFF00eaf8),
                                  ],
                                  icondata: FontAwesomeIcons.linkedinIn,
                                  onPressed: () async {
                                    await launch(
                                        '${widget.docSnap['linkedin']}');
                                  },
                                ),
                                SocialIcon(
                                  colors: [
                                    Colors.green.shade600,
                                    Colors.greenAccent
                                  ],
                                  icondata: FontAwesomeIcons.whatsapp,
                                  onPressed: () async {
                                    String phoneNumber =
                                        '91' + widget.docSnap['wapp'];
                                    String url =
                                        "https://api.whatsapp.com/send?phone=$phoneNumber&text=Hey_dev";
                                    if (await canLaunch(url)) {
                                      await launch(url);
                                    } else
                                      Scaffold.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text('Cannot open whatsapp'),
                                        ),
                                      );
                                  },
                                ),
                              ],
                            ),
                            Padding(
                                padding: EdgeInsets.only(
                                    top: 10.0,
                                    bottom: 10.0,
                                    left: 30.0,
                                    right: 30.0),
                                child: Divider(
                                  indent: 10.0,
                                )),
                          ]))),
              Hero(
                tag: "${widget.docSnap['name']}",
                child: CircleAvatar(
                  backgroundImage: CachedNetworkImageProvider(widget.docSnap['img'] ),
                  maxRadius: 90.0,
                ),
              ),
            ])
          ],
        ),
      ),
    );
  }
}
