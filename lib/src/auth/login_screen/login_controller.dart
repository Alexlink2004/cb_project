
import 'package:flutter/material.dart';

class LoginController extends ChangeNotifier {
  late TextEditingController _loginFieldController = TextEditingController();
  late String _password;

  String get password {
    return _password;
  }

  set password(String data) {
    _password = data;
    // Actualizar el texto del loginFieldController cuando se cambie el password.
    _loginFieldController.text = data.toString();
    notifyListeners();
  }

  TextEditingController get loginFieldController {
    return _loginFieldController;
  }


}
