import 'package:flutter/material.dart';
import 'package:mc_application/core/appearances/colors.dart';
import 'package:mc_application/modules/authentication/signup/signup_page_model.dart';

class SignUpButton extends StatefulWidget {
  final SignUpPageModel model;
  const SignUpButton(this.model, {Key? key}) : super(key: key);

  @override
  State<SignUpButton> createState() => _SignUpButtonState();
}

final ButtonStyle style =
    ElevatedButton.styleFrom(backgroundColor: primaryGreen);

class _SignUpButtonState extends State<SignUpButton> {
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
              widget.model.signUp(context);
            },
            child: const Text(
              'Sign up',
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
