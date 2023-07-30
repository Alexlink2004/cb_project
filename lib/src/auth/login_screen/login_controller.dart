

import 'package:flutter/material.dart';

class LoginController extends ChangeNotifier{
  late int _password ;
  late TextEditingController _loginFieldController = TextEditingController();

  TextEditingController get loginFieldController{
    return _loginFieldController;
  }

  set loginFieldController (TextEditingController data){
    _loginFieldController = data;
    notifyListeners();
  }


  int get password{
    return _password;
  }
  set password (data){
    _password = data;
    notifyListeners();
  }
}