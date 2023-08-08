import 'package:flutter/material.dart';
import 'package:mc_application/core/appearances/colors.dart';
import 'package:mc_application/modules/authentication/login/login_page_model.dart';

class LoginButton extends StatefulWidget {
  final LoginPageModel model;
  const LoginButton(this.model, {Key? key}) : super(key: key);

  @override
  State<LoginButton> createState() => _LoginButtonState();
}

final ButtonStyle style =
    ElevatedButton.styleFrom(backgroundColor: primaryGreen);

class _LoginButtonState extends State<LoginButton> {
  @override
  Widget build(BuildContext context) {
    return buildExpandedButton();
  }

  Row buildExpandedButton() {
    return Row(
      children: [
        Expanded(
            child: SizedBox(
          height: 60,
          child: ElevatedButton(
            style: style,
            onPressed: () {
              widget.model.login(context);
            },
            child: const Text(
              'Log in',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 18),
            ),
          ),
        )),
      ],
    );
  }
}
