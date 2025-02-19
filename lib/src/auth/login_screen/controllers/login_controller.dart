import 'package:cb_project/src/auth/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../server/api/users_api.dart';
import '../../../server/models/user.dart';
import '../../admin/views/admin_view.dart';
import '../../voting_users/alderman/views/alderman_view.dart';
import '../../voting_users/president/views/president_view.dart';
import '../../voting_users/secretary/views/secretary_view.dart';

class LoginController extends ChangeNotifier {
  final TextEditingController _loginFieldController = TextEditingController();
  String _password = '';
  List<User> users = [];

  String get password {
    return _password;
  }

  Future<User> setPasswordAndLogin(String data, BuildContext context) async {
    final UsersApi userApi = Provider.of<UsersApi>(context, listen: false);
    final List<User> usersForLogin = await userApi.read();
    users = usersForLogin;
    _password = data;
    _loginFieldController.text = data;

    //LOGIN PROCESS:
    final User userLogged = await userApi.getUserByPassword(password);
    String userRole = userLogged.position;

    debugPrint("id del usuario: ${userLogged.id}");

    //END LOGIN PROCESS
    notifyListeners();

    return userLogged;
  }

  void login(User userLogged, BuildContext context) {
    final AuthController authController = Provider.of<AuthController>(
      context,
      listen: false,
    );
    authController.userLoggedIn = userLogged;
    String userRole = userLogged.position;
    switch (userRole) {
      case 'Administrador':
        Navigator.pushReplacementNamed(context, AdminView.id);
        break;
      case 'Presidente':
        Navigator.pushReplacementNamed(context, PresidentView.id);
        break;
      case 'Secretario':
        Navigator.pushReplacementNamed(context, SecretaryView.id);
        break;
      case 'Regidor':
        Navigator.pushReplacementNamed(context, AldermanView.id);
        break;
      case 'error':
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
                "No se encontró ningun usuario o el usuario ya esta activo"),
          ),
        );
        break;

      default:
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
                "No se encontró ningun usuario o el usuario ya esta activo"),
          ),
        );
        break;
    }
    _loginFieldController.text = '';
  }

  TextEditingController get loginFieldController {
    return _loginFieldController;
  }
}
