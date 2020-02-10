import 'package:flutter_flux/flutter_flux.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'dart:async';
import 'dart:io';

import 'package:meta/meta.dart';

class UserSignpModel {
  Completer<Map> completer;
  String email, password, name, collegeName, phoneNumber;

  UserSignpModel(
      {@required this.completer,
      @required this.email,
      @required this.password,
      @required this.name,
      @required this.collegeName,
      @required this.phoneNumber});
}

class UserLoginModel {
  Completer<Map> completer;
  String email, password;

  UserLoginModel(
      {@required this.completer,
      @required this.email,
      @required this.password});
}

class AuthStoreActions {
  static Action<UserSignpModel> signup = Action<UserSignpModel>();
  static Action<UserLoginModel> login = Action<UserLoginModel>();
  static Action<bool> guestLogin = Action<bool>();
  static Action<bool> changeAuth = Action<bool>();
  static Action checkAuth = Action();
}

class AuthStore extends Store {
  bool isLoggedIn = false;
  bool guestLoggedIn = false;

  AuthStore() {
    triggerOnAction(AuthStoreActions.guestLogin, (bool auth) {
      guestLoggedIn = auth;
    });

    triggerOnAction(AuthStoreActions.changeAuth, (bool auth) async {
      isLoggedIn = auth;
      if (auth == false) {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        await preferences.remove('token');
        await preferences.remove('deviceToken');
        guestLoggedIn = false;
      }
      print('STATE: loggedIn $isLoggedIn, guest $guestLoggedIn');
    });

    triggerOnAction(AuthStoreActions.checkAuth, (_) async {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String token = await preferences.getString('token');
      if (token != null) {
        AuthStoreActions.changeAuth.call(true);
      } else {
        AuthStoreActions.changeAuth.call(false);
        AuthStoreActions.guestLogin.call(false);
      }
    });

    triggerOnAction(AuthStoreActions.login, (UserLoginModel loginModel) async {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      try {
        String url = 'https://api.habba19.tk/auth/user/login';
        http.Response response = await http.post(url,
            body: {'email': loginModel.email, 'password': loginModel.password});
        Map jsonResponse = await jsonDecode(response.body);
        if (response.statusCode != 200) {
          loginModel.completer.complete(
              {'success': false, 'code': 0, 'message': 'Severe Server Error'});
          return;
        }
        if (jsonResponse['success']) {
          await preferences.setString('token', jsonResponse['token']);
        }
        loginModel.completer.complete(jsonResponse);
      } on SocketException catch (e) {
        loginModel.completer
            .complete({'success': false, 'error': {'code': 0, 'message': 'No Network'}});
      }
    });
    triggerOnAction(AuthStoreActions.signup,
        (UserSignpModel signupModel) async {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String url = 'https://api.habba19.tk/auth/user/signup';
      try {
        http.Response response = await http.post(url, body: {
          'email': signupModel.email,
          'password': signupModel.password,
          'college_name': signupModel.collegeName,
          'name': signupModel.name,
          'phone_number': signupModel.phoneNumber,
        });
//        if (response?.statusCode != 200 || false) {
//          signupModel.completer.complete({'success': false});
//          return;
//        }
        Map jsonResponse = await jsonDecode(response.body);
        if (jsonResponse['success']) {
          await preferences.setString('token', jsonResponse['token']);
        }
        signupModel.completer.complete(jsonResponse);
      } on SocketException catch (e) {
        signupModel.completer.complete({
          'success': false,
          'error': {'code': 0, 'message': 'No Network'}
        });
      }
    });
  }
}

StoreToken authStoreToken = StoreToken(AuthStore());
