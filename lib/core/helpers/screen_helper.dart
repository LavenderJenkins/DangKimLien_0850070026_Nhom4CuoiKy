import 'package:flutter/material.dart';
import 'package:mc_application/app_data.dart';

class ScreenHelper {
  static final ScreenHelper _screen = ScreenHelper._internal();

  double getWidth() {
    return appData.widthScreen;
  }

  double getHeight() {
    return appData.heightScreen;
  }

  double getHeightByPercent(double percent) {
    return appData.heightScreen * percent;
  }

  double getWidthByPercent(double percent) {
    return appData.widthScreen * percent;
  }

  double setWidth(num width) {
    return double.parse(width.toString());
  }

  double setHeight(num height) {
    return double.parse(height.toString());
  }

  double getKeyboardHeight(BuildContext context) {
    return MediaQuery.of(context).viewInsets.bottom;
  }

  double getOriginWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  double getOriginHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  factory ScreenHelper() {
    return _screen;
  }

  ScreenHelper._internal();
}

final screenHelper = ScreenHelper();
