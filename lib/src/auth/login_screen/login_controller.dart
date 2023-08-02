import 'package:flutter/material.dart';

class LoginController extends ChangeNotifier {
  late final TextEditingController _loginFieldController =
      TextEditingController();
  late String _password;

  String get password {
    return _password;
  }

  set password(String data) {
    _password = data;
    _loginFieldController.text = data.toString();
    notifyListeners();
  }

  TextEditingController get loginFieldController {
    return _loginFieldController;
  }
}
