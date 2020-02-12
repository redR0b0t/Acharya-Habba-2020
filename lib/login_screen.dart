import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_flux/flutter_flux.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:habba20/utils/style_guide.dart';
import 'package:url_launcher/url_launcher.dart';

import 'auth_store.dart';
import 'widgets/social_icon.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => new _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin, StoreWatcherMixin<LoginScreen> {
  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
  AuthStore store;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  final FocusNode myFocusNodeEmailLogin = FocusNode();
  final FocusNode myFocusNodePasswordLogin = FocusNode();

  final FocusNode myFocusNodePassword = FocusNode();
  final FocusNode myFocusNodeEmail = FocusNode();
  final FocusNode myFocusNodeName = FocusNode();
  final FocusNode myFocusNodeCollegeName = FocusNode();
  final FocusNode myFocusNodePhoneNumber = FocusNode();

  TextEditingController loginEmailController = new TextEditingController();
  TextEditingController loginPasswordController = new TextEditingController();

  bool _obscureTextLogin = true;
  bool _obscureTextSignup = true;
  bool _obscureTextSignupConfirm = true;

  TextEditingController signupEmailController = new TextEditingController();
  TextEditingController signupPhoneNumberController =
      new TextEditingController();
  TextEditingController signupNameController = new TextEditingController();
  TextEditingController signupPasswordController = new TextEditingController();
  TextEditingController signupConfirmPasswordController =
      new TextEditingController();
  TextEditingController signupCollegeNameController = TextEditingController();

  PageController _pageController;

  Color left = Colors.black;
  Color right = Colors.white;

  bool studentOfAIT = false;
  String _collegeName = 'Acharya Institutes';
  String _aitStudent = 'Acharya Institutes';
  String _otherStudent = 'Other';

  bool isEmailEditingEnabled = true;

  bool isLoading = false;

  bool _nameValidate = false,
      _emailValidate = false,
      _collegeNameValidate = false,
      _phoneNumberValidate = false,
      _passwordMinValidate = false,
      _passwordMatchesValidate = false,
      _loginEmailValidate = false;

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 750, height: 1334);
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          SingleChildScrollView(
              child: Padding(
                  padding: EdgeInsets.only(left: 28.0, right: 28.0, top: 25.0),
                  child: Column(
                    children: <Widget>[
                      Image.asset(
                        'assets/logo.png',
                        //swidth: ScreenUtil().setWidth(550),
                        height: ScreenUtil().setHeight(550),
                      ),

                      /// FORM>>>>>
                      _buildForm(),

                      SizedBox(
                        height: ScreenUtil().setHeight(35),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          InkWell(
                            child: Container(
                                width: ScreenUtil().setWidth(300),
                                height: ScreenUtil().setHeight(100),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Color(0xFFff4f38),
                                      Color(0xFFff355d),
                                    ]
                                  ),
                                  borderRadius: BorderRadius.circular(30.0),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color(0xFF6078ea).withOpacity(.3),
                                      offset: Offset(0.0, 8.0),
                                      blurRadius: 8.0,
                                    )
                                  ],
                                ),
                                child: Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                        onTap: () {},
                                        child: Center(
                                            child: Text('Register',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontFamily: 'Poppins-Bold',
                                                    fontSize: 18.0,
                                                    letterSpacing: 1.0)))))),
                          ),
                          InkWell(
                            child: Container(
                                width: ScreenUtil().setWidth(300),
                                height: ScreenUtil().setHeight(100),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(colors: [
                                    Color(0xFF17ead9),
                                    Color(0xFF6078ea)
                                  ]),
                                  borderRadius: BorderRadius.circular(30.0),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color(0xFF6078ea).withOpacity(.3),
                                      offset: Offset(0.0, 8.0),
                                      blurRadius: 8.0,
                                    )
                                  ],
                                ),
                                child: Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                        onTap: () {},
                                        child: Center(
                                            child: Text('Signin',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontFamily: 'Poppins-Bold',
                                                    fontSize: 18.0,
                                                    letterSpacing: 1.0)))))),
                          )
                        ],
                      ),
                      SizedBox(
                        height: ScreenUtil().setHeight(40),
                      ),
                      OutlineButton(
                        borderSide: BorderSide(color: Colors.blue, width: 2),
                        shape: StadiumBorder(),
                        onPressed: () {
                          AuthStoreActions.guestLogin.call(true);
                        },
                        child: Text(
                          "Continue as guests",
                          style: TextStyle(fontSize: 18, color: Colors.blue),
                        ),
                      ),
                      SizedBox(
                        height: ScreenUtil().setHeight(20),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Connect with us',
                            style: TextStyle(fontSize: 15, color: Colors.red),
                          )
                        ],
                      ),
                      SizedBox(
                        height: ScreenUtil().setHeight(20),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SocialIcon(
                            colors: [
                              Color(0xFFff4f38),
                              Color(0xFFff355d),
                            ],
                            icondata: FontAwesomeIcons.instagram,
                            onPressed: () async {
                              await launch(
                                  'https://www.instagram.com/habba2020/');
                            },
                          ),
                          SocialIcon(
                            colors: [
                              Color(0xFFffDD00),
                              Color(0xFBffB034),
                            ],
                            icondata: FontAwesomeIcons.snapchat,
                            onPressed: () async {
                              await launch(
                                  'https://www.snapchat.com/add/acharya_habba');
                            },
                          ),
                          SocialIcon(
                            colors: [
                              Color(0xFF102397),
                              Color(0xFF187adf),
                              Color(0xFF00eaf8),
                            ],
                            icondata: FontAwesomeIcons.facebook,
                            onPressed: () async {
                              await launch(
                                  'https://www.facebook.com/acharya.ac.in/');
                            },
                          ),
                          SocialIcon(
                            colors: [
                              Color(0xFF17ead9),
                              Color(0xFF6078ea),
                            ],
                            icondata: FontAwesomeIcons.twitter,
                            onPressed: () async {
                              await launch('https://twitter.com/acharyahabba');
                            },
                          ),
                        ],
                      ),
                      SizedBox(
                        height: ScreenUtil().setHeight(30),
                      ),
                    ],
                  ))),
        ],
      ),
    );
  }

  /*@override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 750, height: 1334);
    return Stack(
      children: <Widget>[
        Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Image.asset(
              'assets/imgs/logo.jpg',
              fit: BoxFit.cover,
            )),
        new Scaffold(
          backgroundColor: Colors.transparent,
          key: _scaffoldKey,
          resizeToAvoidBottomInset: true,

          body: NotificationListener<OverscrollIndicatorNotification>(
            onNotification: (overscroll) {
              overscroll.disallowGlow();
            },
            child: SingleChildScrollView(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 1500,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
//                    Padding(
//                      padding: EdgeInsets.only(top: 75.0),
//                      child: new Image(
//                        width: 90.0,
//                        height: 90.0,
//                        fit: BoxFit.fill,
//                        image: new AssetImage(
//                          'assets/imgs/logo.jpg',
//                        ),
//                      ),
//                    ),
                    Center(
                      child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Column(
                            children: <Widget>[
                              _buildTitle('Acharya Habba'),
                              _buildTitle('2020'),
                              Container(
                                height: 350,
                                //child: Image.asset('assets/imgs/logo.jpg',fit: BoxFit.cover,),
                              )
                            ],
                          )),
                    ),
//                    Padding(
//                      padding: EdgeInsets.only(top: 20.0),
//                      child: _buildMenuBar(context),
//                    ),
                    Expanded(
                      flex: 2,
                      child: PageView(
                        controller: _pageController,
                        onPageChanged: (i) {
                          if (i == 0) {
                            setState(() {
                              right = Colors.white;
                              left = Colors.black;
                            });
                          } else if (i == 1) {
                            setState(() {
                              right = Colors.black;
                              left = Colors.white;
                            });
                          }
                        },
                        children: <Widget>[
                          new ConstrainedBox(
                            constraints: const BoxConstraints.expand(),
                            child: _buildForm(),
                          ),
//                          new ConstrainedBox(
//                            constraints: const BoxConstraints.expand(),
//                            child: _buildSignUp(context),
//                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
*/
  @override
  void dispose() {
    myFocusNodePassword.dispose();
    myFocusNodeEmail.dispose();
    myFocusNodeName.dispose();
    _pageController?.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    store = listenToStore(authStoreToken);
    _pageController = PageController();
  }

  void showInSnackBar(String value) {
    FocusScope.of(context).requestFocus(new FocusNode());
    _scaffoldKey.currentState?.removeCurrentSnackBar();
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: new Text(
        value,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          fontSize: 16.0,
        ),
      ),
      backgroundColor: Colors.blue,
      duration: Duration(seconds: 3),
    ));
  }

  Widget _buildSignIn(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 23.0),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Stack(
              alignment: Alignment.topCenter,
              overflow: Overflow.visible,
              children: <Widget>[
                Card(
                  elevation: 2.0,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Container(
                    width: 300.0,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      image: DecorationImage(
                          alignment: Alignment(-.2, 0),
                          image: AssetImage('assets/imgs/pat.jpg'),
                          fit: BoxFit.cover),
                    ),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0, left: 25),
                          child: Row(
                            children: <Widget>[
                              Text(
                                'Student/Faculty Of',
                                textAlign: TextAlign.start,
                              ),
                            ],
                          ),
                        ),
                        _buildCollegeRadios(context),
                        Container(
                          width: 250.0,
                          height: 1.0,
                          color: Colors.grey[400],
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
                          child: TextField(
                            onTap: _onEmailPress,
                            focusNode: myFocusNodeEmailLogin,
                            controller: loginEmailController,
                            readOnly: true,
                            keyboardType: TextInputType.emailAddress,
                            style:
                                TextStyle(fontSize: 16.0, color: Colors.black),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30))),
                              icon: Icon(
                                FontAwesomeIcons.envelope,
                                color: Colors.black,
                                size: 22.0,
                              ),
                              hintText: "Email Address",
                              errorText: _loginEmailValidate
                                  ? 'Enter a valid email address'
                                  : null,
                              hintStyle: TextStyle(fontSize: 17.0),
                            ),
                          ),
                        ),
                        Container(
                          width: 250.0,
                          height: 1.0,
                          color: Colors.grey[400],
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
                          child: TextField(
                            focusNode: myFocusNodePhoneNumber,
                            controller: signupPhoneNumberController,
                            keyboardType: TextInputType.phone,
                            style:
                                TextStyle(fontSize: 16.0, color: Colors.black),
                            decoration: InputDecoration(
                              errorText: _phoneNumberValidate
                                  ? 'Invalid Phonenumber!'
                                  : null,
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30))),
                              icon: Icon(
                                FontAwesomeIcons.phone,
                                color: Colors.black,
                              ),
                              hintText: "Phone Number",
                              hintStyle: TextStyle(fontSize: 16.0),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 270.0),
                  decoration: new BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        //color: Themex.CustomColors.iconInactiveColor,
                        offset: Offset(1.0, 1.0),
                        blurRadius: 1.0,
                      ),
                      BoxShadow(
                        //color: Themex.CustomColors.iconInactiveColor,
                        offset: Offset(1.0, 1.0),
                        blurRadius: 1.0,
                      ),
                    ],
                    //color: Themex.CustomColors.iconInactiveColor,
                  ),
                  child: MaterialButton(
                    //color: Themex.CustomColors.iconInactiveColor,
                    highlightColor: Colors.blueGrey,
                    //splashColor: Themex.CustomColors.iconActiveColor,
                    //shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 42.0),
                      child: Text(
                        "Login",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25.0,
                        ),
                      ),
                    ),
                    onPressed: _handleLogin,
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      gradient: new LinearGradient(
                          colors: [
                            Colors.white10,
                            Colors.white,
                          ],
                          begin: const FractionalOffset(0.0, 0.0),
                          end: const FractionalOffset(1.0, 1.0),
                          stops: [0.0, 1.0],
                          tileMode: TileMode.clamp),
                    ),
                    width: 100.0,
                    height: 1.0,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: new LinearGradient(
                          colors: [
                            Colors.white,
                            Colors.white10,
                          ],
                          begin: const FractionalOffset(0.0, 0.0),
                          end: const FractionalOffset(1.0, 1.0),
                          stops: [0.0, 1.0],
                          tileMode: TileMode.clamp),
                    ),
                    width: 100.0,
                    height: 1.0,
                  ),
                ],
              ),
            ),
            FlatButton(
              onPressed: () {
                AuthStoreActions.guestLogin.call(true);
              },
              child: _buildTitle(
                'Explore without loggin in',
                TextStyle(
                    fontSize: 17.0,
                    color: Colors.white,
                    decoration: TextDecoration.underline),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                IconButton(
                  icon: Icon(
                    FontAwesomeIcons.instagram,
                    color: Colors.white,
                  ),
                  onPressed: () async {
                    await launch('https://www.instagram.com/habba2020/');
                  },
                ),
                IconButton(
                  icon: Icon(FontAwesomeIcons.snapchat, color: Colors.white),
                  onPressed: () async {
                    await launch('https://www.snapchat.com/add/acharya_habba');
                  },
                ),
                IconButton(
                  icon: Icon(FontAwesomeIcons.facebook, color: Colors.white),
                  onPressed: () async {
                    await launch('https://www.facebook.com/acharya.ac.in/');
                  },
                ),
                IconButton(
                  icon: Icon(FontAwesomeIcons.twitter, color: Colors.white),
                  onPressed: () async {
                    await launch('https://twitter.com/acharyahabba');
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void _onSignInButtonPress() {
    _pageController.animateToPage(0,
        duration: Duration(milliseconds: 500), curve: Curves.decelerate);
  }

  void _toggleLogin() {
    setState(() {
      _obscureTextLogin = !_obscureTextLogin;
    });
  }

  void _toggleSignup() {
    setState(() {
      _obscureTextSignup = !_obscureTextSignup;
    });
  }

  void _toggleSignupConfirm() {
    setState(() {
      _obscureTextSignupConfirm = !_obscureTextSignupConfirm;
    });
  }

  Widget _buildForm() {
    return Container(
        width: double.infinity,
        height: ScreenUtil().setHeight(500),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              offset: Offset(0.0, 15.0),
              blurRadius: 15.0,
            ),
            BoxShadow(
              color: Colors.black12,
              offset: Offset(0.0, -10.0),
              blurRadius: 10.0,
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.only(left: 16.0, top: 16.0, right: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Align(
                alignment: Alignment.center,
                child: Text(
                  'Login',
                  style: TextStyle(
                    fontSize: ScreenUtil().setSp(45),
                    fontFamily: 'Poppins-Bold',
                    fontWeight: FontWeight.bold,
                    letterSpacing: .6,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: ScreenUtil().setHeight(30),
              ),
              TextField(
                decoration: InputDecoration(
                    border: new OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(30.0),
                      ),
                    ),
                    filled: true,
                    hintText: 'username',
                    prefixIcon: Icon(
                      FontAwesomeIcons.solidEnvelope,
                    ),
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 12.0)),
              ),
              SizedBox(
                height: ScreenUtil().setHeight(40),
              ),
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                    border: new OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(30.0),
                      ),
                    ),
                    filled: true,
                    prefixIcon: Icon(FontAwesomeIcons.lock),
                    hintText: 'password',
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 12.0)),
              ),
              SizedBox(
                height: ScreenUtil().setHeight(35),
              )
            ],
          ),
        ));
  }

  Widget _buildCollegeRadios(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Row(
        children: <Widget>[
          Radio(
            activeColor: Theme.of(context).primaryColor,
            value: _aitStudent,
            groupValue: _collegeName,
            onChanged: (String val) {
              setState(() {
                _collegeName = val;
                loginEmailController.clear();
              });
              signupCollegeNameController.value =
                  TextEditingValue(text: 'Prefilled Value');
            },
          ),
          Text('Acharya Institutes'),
          Radio(
            activeColor: Theme.of(context).primaryColor,
            value: _otherStudent,
            groupValue: _collegeName,
            onChanged: (String val) {
              setState(() {
                _collegeName = val;
                loginEmailController.clear();
              });
              signupCollegeNameController.clear();
            },
          ),
          Text('Other'),
        ],
      ),
    );
  }

  void _handleLogin() async {
    setState(() {
      _loginEmailValidate = false;
    });
    if (!RegExp(
            r'^(([^<>()\[\]\.,;:\s@\"]+(\.[^<>()\[\]\.,;:\s@\"]+)*)|(\".+\"))@(([^<>()[\]\.,;:\s@\"]+\.)+[^<>()[\]\.,;:\s@\"]{2,})$')
        .hasMatch(loginEmailController.text)) {
      setState(() {
        _loginEmailValidate = true;
      });
    }
    if (_loginEmailValidate != true) {
      Completer<Map> loginCompleter = Completer<Map>();
      AuthStoreActions.login.call(UserLoginModel(
          email: loginEmailController.text,
          password: loginPasswordController.text,
          completer: loginCompleter));
      showInSnackBar('Logging you in!');
      setState(() {
        isLoading = true;
      });
      Map res = await loginCompleter.future;
      setState(() {
        isLoading = false;
      });
      if (res['success']) {
        AuthStoreActions.changeAuth.call(true);
      } else {
        print(res);
        showInSnackBar(
            '[${res['error']['code']}]: ${res['error']['message']} ');
      }
    }
  }

  void _handleSignup() async {
    setState(() {
      _passwordMatchesValidate = false;
      _emailValidate = false;
      _passwordMinValidate = false;
      _nameValidate = false;
      _collegeNameValidate = false;
      _phoneNumberValidate = false;
    });
    Completer<Map> signupCompleter = Completer<Map>();
    String email = signupEmailController.text;
    String password = signupPasswordController.text;
    String confirmPassword = signupConfirmPasswordController.text;
    String name = signupNameController.text;
    String collegeName = signupCollegeNameController.text;
    String phoneNumber = signupPhoneNumberController.text;

    bool flag = false;

    if (name.trim() == '') {
      setState(() {
        _nameValidate = true;
      });
      flag = true;
    }
    if (!RegExp(
            r'^(([^<>()\[\]\.,;:\s@\"]+(\.[^<>()\[\]\.,;:\s@\"]+)*)|(\".+\"))@(([^<>()[\]\.,;:\s@\"]+\.)+[^<>()[\]\.,;:\s@\"]{2,})$')
        .hasMatch(email)) {
      setState(() {
        _emailValidate = true;
      });
      flag = true;
    }
    if (_collegeName != _aitStudent && collegeName.trim() == '') {
      setState(() {
        _collegeNameValidate = true;
      });
      flag = true;
    }
    if (phoneNumber.trim().length != 10) {
      setState(() {
        _phoneNumberValidate = true;
      });
    }
    if (password.trim().length < 5) {
      setState(() {
        _passwordMinValidate = true;
      });
      flag = true;
    }
    if (password != confirmPassword) {
      setState(() {
        _passwordMatchesValidate = true;
      });
      flag = true;
    }

    if (flag == false) {
      AuthStoreActions.signup.call(UserSignpModel(
          completer: signupCompleter,
          email: email,
          password: password,
          name: name,
          collegeName: _collegeName == _aitStudent ? 'ay_cert' : collegeName,
          phoneNumber: phoneNumber));
      showInSnackBar('Signing you up!');
      setState(() {
        isLoading = true;
      });
      Map res = await signupCompleter.future;
      setState(() {
        isLoading = false;
      });
      if (res['success']) {
        AuthStoreActions.changeAuth.call(true);
      } else {
        showInSnackBar('[${res['error']['code']}]: ${res['error']['message']}');
      }
    }
  }

  void _onEmailPress() async {
    signupEmailController.clear();
    try {
      await _googleSignIn.signOut();
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return Center(
              child: CircularProgressIndicator(),
            );
          });
      GoogleSignInAccount account = await _googleSignIn.signIn();

      Navigator.pop(context);
      if (_collegeName == _aitStudent &&
          !account.email.endsWith('acharya.ac.in')) {
        Fluttertoast.showToast(
            msg: "Select Acharya Email ID",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIos: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      } else {
        loginEmailController.text = account.email;
      }
    } catch (error) {
      print(error);
    }
  }

  Widget _buildTitle(String s,
      [TextStyle textStyle = const TextStyle(
        color: Colors.white,
        fontSize: 54,
        fontFamily: 'ProductSans',
        fontWeight: FontWeight.w100,
      )]) {
    return Padding(
      padding: const EdgeInsets.only(top: 4.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 5),
          //color: Themex.CustomColors.iconInactiveColor.withOpacity(0.85),
//          child: GradientText(
//            s,
//            gradient: Gradients.haze,
//            shaderRect: Rect.fromLTWH(100, 0, 100, 100),
//            style: textStyle,
//          ),
        ),
      ),
    );
  }
}
