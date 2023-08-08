import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:mc_application/core/appearances/colors.dart';
import 'package:mc_application/core/bases/base_mixin_model.dart';
import 'package:mc_application/core/helpers/screen_helper.dart';
import 'package:mc_application/core/widgets/loading/loading_widget.dart';
import 'package:mc_application/modules/authentication/methods.dart';
import 'package:mc_application/modules/authentication/signup/password_input_widget.dart';
import 'package:mc_application/modules/authentication/signup/signup_button_widget.dart';
import 'package:mc_application/modules/authentication/signup/signup_page_model.dart';
import 'package:mc_application/modules/authentication/signup/username_input_widget.dart';
import 'package:mc_application/resources/modal_progress_hud.dart';
import 'package:need_resume/need_resume.dart';

class SignUpPage extends StatefulWidget {
  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends ResumableState<SignUpPage>
    with MixinModel<SignUpPageModel> {
  SignUpPageModel signUpPageModel = SignUpPageModel();
  double widthScreen = screenHelper.getWidth();
  double heightScreen = screenHelper.getHeight();
  double yPadding = screenHelper.getHeightByPercent(0.02);
  double xPadding = screenHelper.getWidthByPercent(0.05);

  @override
  Widget build(BuildContext context) {
    return present(context);
  }

  @override
  Function(BuildContext ctx, SignUpPageModel model, Widget? child)
      withBuilder() {
    return (BuildContext context, SignUpPageModel model, Widget? child) {
      return ModalProgressHUD(
          child: buildBody(context),
          progressIndicator: const Loading(),
          inAsyncCall: signUpPageModel.busy);
    };
  }

  @override
  SignUpPageModel withModel() {
    return signUpPageModel;
  }

  buildBody(context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        backgroundColor: backgroundColor,
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: Container(
            margin: EdgeInsets.only(top: yPadding),
            padding:
                EdgeInsets.symmetric(vertical: yPadding, horizontal: xPadding),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildAppName(),
                  SizedBox(height: screenHelper.setHeight(40)),
                  buildPassport(),
                  SizedBox(height: screenHelper.setHeight(20)),
                  const Text(
                    'Sign up',
                    style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: screenHelper.setHeight(10)),
                  UserNameInputWidget(signUpPageModel),
                  SizedBox(height: screenHelper.setHeight(20)),
                  PasswordInputWidget(signUpPageModel),
                  SizedBox(height: screenHelper.setHeight(85)),
                  SignUpButton(signUpPageModel),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: SizedBox(
          height: screenHelper.getHeightByPercent(0.15),
          child: Center(
            child: RichText(
                text: TextSpan(children: <TextSpan>[
              const TextSpan(
                text: 'Have a account? ',
                style: TextStyle(color: Colors.black),
              ),
              TextSpan(
                text: 'Log in now!',
                style: const TextStyle(
                    color: primaryGreen, fontWeight: FontWeight.w500),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    signUpPageModel.moveToLogIn(context);
                  },
              ),
            ])),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    signUpPageModel.dispose();
    super.dispose();
  }
}
