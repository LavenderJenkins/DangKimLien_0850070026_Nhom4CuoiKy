import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:mc_application/app_data.dart';
import 'package:mc_application/core/bases/base_page_model.dart';
import 'package:mc_application/core/helpers/navigator_helper.dart';
import 'package:mc_application/routes/route_config.dart';

class SignUpPageModel extends BasePageModel {
  bool obscureText = true;
  bool switchValue = false;

  TextEditingController userName = TextEditingController(text: '');
  TextEditingController password = TextEditingController(text: '');

  FocusNode userNameFocus = FocusNode();
  FocusNode passwordFocus = FocusNode();

  BuildContext? context;

  bool isValidPassword() {
    return true;
  }

  void rememberMe(bool newValue) {
    switchValue = newValue;
    notifyListeners();
    //logic save to local storage
  }

  void showPassword() {
    obscureText = !obscureText;
    notifyListeners();
  }

  void moveToLogIn(context) {
    navigatorHelper.changeView(context, RouteNames.login, isReplaceName: true);
  }

  signUp(BuildContext context) async {
    userNameFocus.unfocus();
    passwordFocus.unfocus();

    try {
      final response = await http.post(
          Uri.parse('${appData.apiHost}/api/auth/sign-up'),
          body: {'username': userName.text, 'password': password.text});

      if (response.statusCode == 201) {
        Fluttertoast.showToast(msg: 'Register successfully');
        Timer(const Duration(milliseconds: 500), () {
          navigatorHelper.changeView(context, RouteNames.login,
              isReplaceName: true);
        });
      } else {
        Fluttertoast.showToast(msg: jsonDecode(response.body)["message"]);
      }
    } catch (e) {
      Fluttertoast.showToast(msg: '$e');
    }
  }
}
