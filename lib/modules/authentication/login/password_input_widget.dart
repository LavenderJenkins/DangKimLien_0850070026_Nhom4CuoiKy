import 'package:flutter/material.dart';
import 'package:mc_application/modules/authentication/login/login_page_model.dart';
import 'package:remixicon/remixicon.dart';

class PasswordInputWidget extends StatefulWidget {
  final LoginPageModel model;
  const PasswordInputWidget(this.model, {Key? key}) : super(key: key);

  @override
  State<PasswordInputWidget> createState() => _PasswordInputWidgetState();
}

class _PasswordInputWidgetState extends State<PasswordInputWidget> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.model.password,
      focusNode: widget.model.passwordFocus,
      cursorColor: Colors.black,
      maxLines: 1,
      obscureText: widget.model.obscureText,
      style: const TextStyle(
        fontSize: 14,
      ),
      decoration: InputDecoration(
          labelText: 'Password',
          hintText: 'Please enter your password...',
          hintStyle: const TextStyle(
            fontSize: 14,
            color: Colors.grey,
          ),
          // prefixIcon: const Icon(Icons.key, size: 20),
          suffixIcon: IconButton(
              onPressed: () => widget.model.showPassword(),
              icon: Icon(widget.model.obscureText
                  ? Remix.eye_close_line
                  : Remix.eye_line))),
    );
  }
}
