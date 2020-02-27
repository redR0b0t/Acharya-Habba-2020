import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:habba20/data/data.dart';
import 'package:habba20/utils/style_guide.dart';

class AboutHabba extends StatefulWidget {
  @override
  _AboutHabbaState createState() => _AboutHabbaState();
}

class _AboutHabbaState extends State<AboutHabba> {
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
            'About Habba',
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
                        ListView(
                          shrinkWrap: true,
                          physics: ClampingScrollPhysics(),
                          padding: EdgeInsets.fromLTRB(5, 0, 5, 5),
                          children: <Widget>[
                            Text(
                              "About Habba",
                              style: title,
                            ),
                            Text(
                              aboutUs,
                              style: subtitleWhite,
                              textAlign: TextAlign.left,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ParalaxWidget extends StatelessWidget {
  final double position;
  final double left;
  final Widget image;

  ParalaxWidget({
    Key key,
    @required this.position,
    @required this.left,
    @required this.image,
  })  : assert(position != null),
        assert(left != null),
        assert(image != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: position,
      left: left,
      child: Container(
        child: this.image,
      ),
    );
  }
}
