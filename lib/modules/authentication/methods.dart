import 'package:flutter/material.dart';
import 'package:mc_application/core/appearances/colors.dart';

final ButtonStyle style = ElevatedButton.styleFrom(
    elevation: 0,
    backgroundColor: Colors.white,
    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20));

Row buildPassport() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      ElevatedButton(
          onPressed: () {},
          style: style,
          child: Row(
            children: [
              Image.asset('assets/images/google_logo.png',
                  height: 40, fit: BoxFit.fitWidth),
              const Text(
                'Google',
                style: TextStyle(color: Colors.black),
              ),
            ],
          )),
      ElevatedButton(
          onPressed: () {},
          style: style,
          child: Row(
            children: [
              Image.asset('assets/images/facebook_logo.png',
                  height: 30, fit: BoxFit.fitWidth),
              const Text(
                '  Facebook',
                style: TextStyle(color: Colors.black),
              ),
            ],
          )),
    ],
  );
}

Center buildAppName() {
  return const Center(
    child: Text(
      'Chat app',
      textAlign: TextAlign.left,
      style: TextStyle(
          fontSize: 50, fontWeight: FontWeight.bold, color: primaryGreen),
    ),
  );
}
