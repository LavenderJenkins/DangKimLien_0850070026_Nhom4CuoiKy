import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:mc_application/app_data.dart';
import 'package:mc_application/core/bases/base_page_model.dart';
import 'package:mc_application/core/helpers/navigator_helper.dart';
import 'package:mc_application/core/models/user_model.dart';
import 'package:mc_application/routes/route_config.dart';
import 'package:mc_application/services/local_storage_service.dart';
import 'package:mc_application/services/sql_lite_service.dart';

class LoginPageModel extends BasePageModel {
  bool obscureText = true;
  bool switchValue = false;

  TextEditingController userName = TextEditingController(text: '');
  TextEditingController password = TextEditingController(text: '');

  FocusNode userNameFocus = FocusNode();
  FocusNode passwordFocus = FocusNode();

  BuildContext? context;

  LocalStorageService localStorage = LocalStorageService();

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

  void moveToForgetPassword() {}

  void moveToSignUp(context) {
    navigatorHelper.changeView(context, RouteNames.signUp, isReplaceName: true);
  }

  login(BuildContext context) async {
    userNameFocus.unfocus();
    passwordFocus.unfocus();

    try {
      await localStorage.removeJwt();
      final response = await http.post(
          // Uri.parse('http://172.16.3.224:8000/api/auth/login'),
          Uri.parse('${appData.apiHost}/api/auth/login'),
          body: {'username': userName.text, 'password': password.text});
      
      if (response.statusCode == 200) {
        final userJson = jsonDecode(response.body)["data"];
        final user = UserModel.fromJson(userJson);
        await localStorage.setUserInfo(user);
        SqfliteUserService.insertUser(user);

        Fluttertoast.showToast(msg: 'Login successfully');
        Timer(Duration(milliseconds: 200), () {
          navigatorHelper.changeView(context, RouteNames.home,
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
