import 'package:flutter/material.dart';
import 'package:mc_application/modules/authentication/signup/signup_page_model.dart';

class UserNameInputWidget extends StatefulWidget {
  final SignUpPageModel model;

  const UserNameInputWidget(this.model, {Key? key}) : super(key: key);

  @override
  State<UserNameInputWidget> createState() => _UserNameInputWidgetState();
}

class _UserNameInputWidgetState extends State<UserNameInputWidget> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.model.userName,
      focusNode: widget.model.userNameFocus,
      cursorColor: Colors.black,
      maxLines: 1,
      style: const TextStyle(
        fontSize: 14,
      ),
      decoration: const InputDecoration(
        labelText: 'Username',
        hintText: 'Please enter your username...',
        hintStyle: TextStyle(
          fontSize: 14, // Kích thước mới cho hintText
          color: Colors.grey, // Màu sắc mới cho hintText
        ),
        // prefixIcon: Icon(Icons.account_circle_outlined)
      ),
    );
  }
}
