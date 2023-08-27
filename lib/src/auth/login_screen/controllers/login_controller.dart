import 'package:flutter/material.dart';

class LoginController extends ChangeNotifier {
  late final TextEditingController _loginFieldController =
      TextEditingController();
  late String _password;

  String get password {
    return _password;
  }

  void setPassword(String data) {
    _password = data;
    _loginFieldController.text = data;
    notifyListeners();
  }

  TextEditingController get loginFieldController {
    return _loginFieldController;
  }
}
