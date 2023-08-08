import 'package:flutter/material.dart';

class BasePageModel extends ChangeNotifier {
  bool _busy = false;
  String? _errorMessage;
  String? _errorCode;
  bool _isForceLogin = false;
  bool _invalidVersion = false;

  bool get busy => _busy;
  String? get errorMessage => _errorMessage;
  String? get errorCode => _errorCode;
  bool get isForceLogin => _isForceLogin;
  bool get invalidVersion => _invalidVersion;

  setBusy(bool value) {
    _busy = value;
    notifyListeners();
  }
}
