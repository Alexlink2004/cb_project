import 'package:cb_project/src/auth/login_screen/login_handler.dart';
import 'package:flutter/cupertino.dart';

import '../../server/models/user.dart';

class AuthController extends ChangeNotifier {
  User? userLoggedIn;

  bool isLogged(BuildContext context) {
    notifyListeners();
    if (userLoggedIn != null) {
      return true;
    } else {
      Navigator.of(context).pushReplacementNamed(
        LoginHandler.id,
      );
      notifyListeners();

      return false;
    }
  }
}
