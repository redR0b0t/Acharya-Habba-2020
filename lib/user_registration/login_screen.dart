import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_flux/flutter_flux.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:habba20/data/data.dart';
import 'package:habba20/models/user_main.dart';
import 'package:habba20/pages/drawer_screen/navigation.dart';
import 'package:habba20/services/google_sigin_in.dart';
import 'package:habba20/widgets/background.dart';
import 'package:habba20/widgets/social_icon.dart';
import 'package:url_launcher/url_launcher.dart';

import '../auth_store.dart';

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
  int cHeight = 600;
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
  TextEditingController loginCollegeNameController = TextEditingController();
  TextEditingController loginPhoneController = TextEditingController();

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
  UserModel _user = new UserModel();
  GoogleSignInAccount account;

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 750, height: 1334);
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Background(
            imgUrl: "assets/galaxy_comp.gif",
          ),
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
                      Align(
                        alignment: Alignment.center,
                        child: InkWell(
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
                                      onTap: _handleLogin,
                                      child: Center(
                                          child: Text('Signin',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontFamily: 'Poppins-Bold',
                                                  fontSize: 18.0,
                                                  letterSpacing: 1.0)))))),
                        ),
                      ),
                      SizedBox(
                        height: ScreenUtil().setHeight(40),
                      ),
                      OutlineButton(
                        borderSide: BorderSide(color: Colors.blue, width: 2),
                        shape: StadiumBorder(),
                        onPressed: () {
                          isGuest = true;
                          //AuthStoreActions.guestLogin.call(true);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Navigation()));
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
                            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white),
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
                                  'https://www.instagram.com/acharyahabba');
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
                                  'https://www.facebook.com/habbaacharya');
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

  Widget _buildForm() {
    return Container(
        width: double.infinity,
        height: ScreenUtil().setHeight(cHeight),
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
              _buildCollegeRadios(context),
              SizedBox(
                height: ScreenUtil().setHeight(30),
              ),
              TextField(
                controller: loginEmailController,
                onTap: _onEmailPress,
                readOnly: true, //_collegeName==_aitStudent,
                decoration: InputDecoration(
                    border: new OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(30.0),
                      ),
                    ),
                    filled: true,
                    hintText: 'EMail',
                    prefixIcon: Icon(
                      FontAwesomeIcons.solidEnvelope,
                    ),
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 12.0)),
              ),
              SizedBox(
                height: ScreenUtil().setHeight(40),
              ),
              TextField(
                controller: loginPhoneController,
                //obscureText: true,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                    border: new OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(30.0),
                      ),
                    ),
                    filled: true,
                    prefixIcon: Icon(FontAwesomeIcons.phone),
                    hintText: 'Phone Number',
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 12.0)),
              ),
              SizedBox(
                height: ScreenUtil().setHeight(35),
              ),
              Visibility(
                visible: _collegeName == _otherStudent,
                child: TextField(
                  controller: loginCollegeNameController,
                  //obscureText: true,
                  decoration: InputDecoration(
                      border: new OutlineInputBorder(
                        borderRadius: const BorderRadius.all(
                          const Radius.circular(30.0),
                        ),
                      ),
                      filled: true,
                      prefixIcon: Icon(FontAwesomeIcons.building),
                      hintText: 'College Name',
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 12.0)),
                ),
              ),
              SizedBox(
                height: ScreenUtil().setHeight(5),
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
                cHeight = 600;
                _collegeName = val;
                loginEmailController.clear();
              });
              loginCollegeNameController.value = TextEditingValue(text: '');
            },
          ),
          Text('AIT'),
          Radio(
            activeColor: Theme.of(context).primaryColor,
            value: _otherStudent,
            groupValue: _collegeName,
            onChanged: (String val) {
              setState(() {
                cHeight = 800;
                _collegeName = val;
                loginEmailController.clear();
              });
            },
          ),
          Text('Other'),
        ],
      ),
    );
  }

  void _handleLogin() async {
//      Completer<Map> loginCompleter = Completer<Map>();
//      AuthStoreActions.login.call(UserLoginModel(
//          email: loginEmailController.text,
//          password: loginPhoneController.text,
//          completer: loginCompleter));
    //showInSnackBar('Logging you in!');
    this._user.Mail = loginEmailController.text;
    this._user.WhatsApp = loginPhoneController.text;
    if (this._user.Mail == '' || this._user.WhatsApp == '') return;
    if (_user.type == 2) this._user.College = loginCollegeNameController.text;
    var documentReference =
        Firestore.instance.collection('users').document(_user.Mail);

    Firestore.instance.runTransaction((transaction) async {
      await transaction.set(
        documentReference,
        this._user.getMap(),
      );
    });
    print("data saved to firebase");
    FirebaseUser fUser = await regUser(account);
    print("firebase user=$fUser");
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => Navigation()));

//      if (res['success']) {
//        AuthStoreActions.changeAuth.call(true);
//      } else {
//        print(res);
//        showInSnackBar(
//            '[${res['error']['code']}]: ${res['error']['message']} ');
//      }
//    }
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
      account = await _googleSignIn.signIn();
      //GoogleSignInAccount account=await signInWithGoogle();

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
        _user.Name = account.displayName;
        _user.img = account.photoUrl;
        if (_collegeName == _aitStudent) {
          _user.type = 1;
          _user.College = _aitStudent;
        } else
          _user.type = 2;
      }
    } catch (error) {
      print(error);
    }
  }
}
