import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:habba20/utils/style_guide.dart';
import 'package:habba20/widgets/dev_card.dart';

import 'about_habba.dart';

class Devs extends StatefulWidget {
  @override
  _DevsState createState() => _DevsState();
}

class _DevsState extends State<Devs> {
  double sunSize = 60;
  double sunPosition = 125;
  double hillOnePosition = 150;
  double hillTwoPosition = 150;
  double hillThreePosition = 210;
  double placePosition = 210;

  @override
  Widget build(BuildContext context) {
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
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
          elevation: 0,
          title: Text(
            'Developers',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: NotificationListener(
          onNotification: (notification) {
            if (notification is ScrollUpdateNotification == true) {
              setState(() {
                sunPosition -= notification.scrollDelta / 5;
                sunSize -= notification.scrollDelta / 8;
                hillOnePosition -= notification.scrollDelta / 4;
                hillTwoPosition -= notification.scrollDelta / 3;
                hillThreePosition -= notification.scrollDelta / 2.8;
                placePosition -= notification.scrollDelta / 1;
              });
            }
            // just to avoid the jittery line
            return true;
          },
          child: Stack(
            children: <Widget>[
              ParalaxWidget(
                left: MediaQuery.of(context).size.width / 2 + 30,
                position: this.sunPosition,
                image: SvgPicture.asset(
                  'assets/svgs/sun.svg',
                  width: this.sunSize,
                  color: hexToColor('#f9e6bf'),
                ),
              ),
              ParalaxWidget(
                left: 0,
                position: this.hillOnePosition,
                image: SvgPicture.asset(
                  'assets/svgs/hill1.svg',
                  width: MediaQuery.of(context).size.width,
                ),
              ),
              ParalaxWidget(
                left: 0,
                position: this.hillTwoPosition,
                image: SvgPicture.asset(
                  'assets/svgs/hill2.svg',
                  width: MediaQuery.of(context).size.width,
                ),
              ),
              ParalaxWidget(
                left: 0,
                position: this.hillThreePosition,
                image: SvgPicture.asset(
                  'assets/svgs/hill3.svg',
                  width: MediaQuery.of(context).size.width,
                ),
              ),
              ParalaxWidget(
                left: 0,
                position: this.placePosition,
                image: SvgPicture.asset(
                  'assets/svgs/place.svg',
                  width: MediaQuery.of(context).size.width,
                ),
              ),
              ListView(
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                children: <Widget>[
                  Container(
                    height: 320,
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(20, 30, 20, 0),
                    color: hexToColor('#64147e'),
                    child: ListView(
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      children: <Widget>[
                        Divider(
                          color: Colors.white60,
                        ),
                        Container(height: MediaQuery.of(context).size.height,)
                      ],
                    ),
                  ),
                ],
              ),
              GridView.count(
                shrinkWrap: true,
                crossAxisCount: 2,
                children: <Widget>[
                  DevCard(),
                  DevCard(),
                ],

              )
            ],
          ),
        ),
      ),
    );
  }
}

class DevDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
    /*showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: Text(
              dev.name,
              textAlign: TextAlign.center,
            ),
            children: <Widget>[
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8.0),
                  child: Text(
                    dev.role,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.email),
                      onPressed: () async {
                        String url = "mailto:${dev.email}";
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
                    IconButton(
                      icon: Icon(FontAwesomeIcons.whatsapp),
                      onPressed: () async {
                        String phoneNumber =
                            '91' + dev.phoneNumber;
                        String url =
                            "https://api.whatsapp.com/send?phone=$phoneNumber&text=Hey_dev";
                        if (await canLaunch(url)) {
                          await launch(url);
                        } else
                          Scaffold.of(context).showSnackBar(
                            SnackBar(
                              content:
                              Text('Cannot open whatsapp'),
                            ),
                          );
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.phone),
                      onPressed: () async {
                        String phoneNumber =
                            '91' + dev.phoneNumber;
                        String url = "tel:$phoneNumber";
                        if (await canLaunch(url)) {
                          await launch(url);
                        } else
                          Scaffold.of(context).showSnackBar(
                              SnackBar(
                                  content: Text(
                                      'Cannot open dialer')));
                      },
                    ),
                  ],
                ),
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 8.0),
                child: RichText(
                  text: TextSpan(children: <TextSpan>[
                    TextSpan(
                        text: 'Technologies: ',
                        style: TextStyle(color: Colors.black)),
                    TextSpan(
                      text: dev.technologies,
                      style: TextStyle(
                          color: Colors.black54, fontSize: 12),
                    )
                  ]),
                ),
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 8.0),
                child: RichText(
                  text: TextSpan(children: <TextSpan>[
                    TextSpan(
                        text: 'Insights: ',
                        style: TextStyle(color: Colors.black)),
                    TextSpan(
                      text: dev.about,
                      style: TextStyle(
                          color: Colors.black54, fontSize: 12),
                    )
                  ]),
                ),
              )
            ],
          );
        });*/
  }
}
