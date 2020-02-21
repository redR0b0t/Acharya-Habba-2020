import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:habba20/widgets/background.dart';
import 'package:insta_html_parser/insta_html_parser.dart';

class InstaScreen extends StatefulWidget {
  @override
  _InstaScreenState createState() => _InstaScreenState();
}

class _InstaScreenState extends State<InstaScreen>
    with SingleTickerProviderStateMixin<InstaScreen> {
  AnimationController _controller;
  Animation<double> _yTranlationAnimation, _opacityAnimation;
  List<String> _userPosts;
  List<String> picu = [];

  @override
  void initState() {
    super.initState();
    _fetchPosts();

    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    _yTranlationAnimation = Tween(begin: 300.0, end: 0.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
    _opacityAnimation = Tween(begin: 0.0, end: 1.0)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    // _fetchNewsFeed();
  }

  List<String> instaPictures = <String>[];
  bool isLoading = true;
  bool isError = false;

  _fetchPosts() async {
    _userPosts = await InstaParser.postsUrlsFromProfile(
        'https://www.instagram.com/acharyahabba/');
    Future.delayed(Duration(seconds: 6));
    print(_userPosts);
    _fetchNewsFeed();
  }

  _fetchNewsFeed() async {
    setState(() {
      isLoading = true;
    });

    if (_userPosts != null)
      for (int i = 0; i < _userPosts.length; i++) {
        String tpic = await fetchPic(_userPosts[i]);
        print(tpic);
        picu.add(tpic);
      }
//    http.Response response =
//        await http.get('https://api.habba19.tk/events/instapics');
//    Map jsonMap = await jsonDecode(response.body);
//    _controller.forward();
    //  InstaModel instaModel = InstaModel.fromJson(jsonMap);
    setState(() {
      isLoading = false;
      instaPictures.clear();
      // instaPictures.addAll(instaModel.data);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[Background(), _buildActual(context)],
    );
  }

  Widget _buildActual(BuildContext context) {
//    if (isError) {
//      return NotificationListener<OverscrollIndicatorNotification>(
//        onNotification: (OverscrollIndicatorNotification overscroll) {
//          overscroll.disallowGlow();
//        },
//        child: Scaffold(
//          backgroundColor: Colors.transparent,
//          body: Center(
//            child: RaisedButton(
//              onPressed: () {},
//              child: Text('Error occured! Retry'),
//            ),
//          ),
//        ),
//      );
//    }
//    if (isLoading) {
//      return NotificationListener<OverscrollIndicatorNotification>(
//        onNotification: (OverscrollIndicatorNotification overscroll) {
//          overscroll.disallowGlow();
//        },
//        child: Scaffold(
//          backgroundColor: Colors.transparent,
//          body: Center(
//            child: CircularProgressIndicator(
//              valueColor:
//                  AlwaysStoppedAnimation(Colors.red),
//            ),
//          ),
//        ),
//      );
//    }

    return isLoading
        ? Center(
      child: RefreshProgressIndicator(),
    )
        : Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: Text('#habba20 on Instagram'),
              centerTitle: true,
              elevation: 0,
            ),
            body: ListView.builder(
              padding: EdgeInsets.only(bottom: 100),
              itemBuilder: (BuildContext context, int index) {
                //fetchPic(_userPosts[index]);
                return Padding(
                  padding:
                      const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.5),
                          blurRadius: 10.0,
                          // has the effect of softening the shadow
                          spreadRadius: 0.0,
                          // has the effect of extending the shadow
                          offset: Offset(
                            0.0, // horizontal, move right 10
                            5.0, // vertical, move down 10
                          ),
                        )
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        color: Colors.blue,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            CachedNetworkImage(
                              imageUrl: isLoading ? '' : picu[index],
                              //'https://images.habba19.tk/instagram/habba19/${instaPictures[index]}',
                              //'https://www.google.com/logos/doodles/2015/googles-new-logo-5078286822539264.3-hp2x.gif',
                              //'https://cdn.vox-cdn.com/thumbor/th5YNVqlkHqkz03Va5RPOXZQRhA=/0x0:2040x1360/1200x800/filters:focal(857x517:1183x843)/cdn.vox-cdn.com/uploads/chorus_image/image/57358643/jbareham_170504_1691_0020.0.0.jpg',
                              // 'https://yt3.ggpht.com/a/AGF-l7-BBIcC888A2qYc3rB44rST01IEYDG3uzbU_A=s900-c-k-c0xffffffff-no-rj-mo',
                              placeholder: (context, url) => Container(
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: CircularProgressIndicator(
                                      valueColor:
                                          AlwaysStoppedAnimation(Colors.red),
                                    ),
                                  ),
                                ),
                              ),
                              fit: BoxFit.contain,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
              itemCount: _userPosts.length,
            ),
          );
  }

  Future<String> fetchPic(String pURL) async {
    Map<String, String> picUrl;
    picUrl = await InstaParser.photoUrlsFromPost(pURL);
    print(picUrl);
    return picUrl['medium'];
  }
}
