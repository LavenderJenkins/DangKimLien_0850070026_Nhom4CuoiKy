import 'package:flutter/material.dart';

class AppData {
  static final AppData _app = AppData._internal();
  
  String env = '';
  int? version = 0;
  String apiHost = 'http://13.228.119.159:8000';
  // String apiHost = 'http://172.16.3.224:8000';
  // String apiHost = 'http://192.168.150.111:8000';
  String? apiVersion = '';
  String apiUrl = '';
  String? dbName = '';

  double widthScreen = 0;
  double heightScreen = 0;

  String deviceInfo = '';
  int os = 1;

  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  factory AppData() {
    return _app;
  }
  AppData._internal();
}

final appData = AppData();
