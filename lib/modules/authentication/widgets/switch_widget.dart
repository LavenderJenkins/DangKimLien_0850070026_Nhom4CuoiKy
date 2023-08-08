import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mc_application/core/appearances/colors.dart';
import 'package:mc_application/modules/authentication/login/login_page_model.dart';

class SwitchButton extends StatefulWidget {
  final LoginPageModel model;
  const SwitchButton(this.model, {Key? key}) : super(key: key);

  @override
  State<SwitchButton> createState() => _SwitchButtonState();
}

class _SwitchButtonState extends State<SwitchButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50,
      child: FittedBox(
        fit: BoxFit.fill,
        child: CupertinoSwitch(
          value: widget.model.switchValue,
          onChanged: (bool newValue) {
            widget.model.rememberMe(newValue);
          },
          activeColor: primaryGreen,
        ),
      ),
    );
  }
}
