import 'package:cb_project/src/auth/login_screen/login_handler.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../server/api/api_constants.dart'; // Asume que este archivo contiene tus constantes de la API
import '../../server/models/user.dart';

class AuthController extends ChangeNotifier {
  User? userLoggedIn;
  final Dio _dio = Dio();

  bool isLogged() {
    return userLoggedIn != null;
  }

  Future<bool> logout(BuildContext context) async {
    if (userLoggedIn == null) {
      debugPrint('No hay usuario logueado.');
      return false;
    }

    try {
      // Preparar el cuerpo de la solicitud con el objeto completo del usuario
      final body = userLoggedIn!.toJson();

      // Realiza la llamada API para logout, incluyendo el cuerpo de la solicitud
      final response = await _dio.post(
        '${ApiConstants.apiRoute}/users/logout',
        data: body,
      );

      if (response.statusCode == 200) {
        // Logout exitoso en el servidor, procede a limpiar el estado en la app.
        userLoggedIn = null;
        notifyListeners();
        Navigator.of(context).pushReplacementNamed(LoginHandler.id);
        return true;
      } else {
        debugPrint(
            'Error al cerrar sesión con statusCode: ${response.statusCode}');
        _showSnackBar(context, 'Error al cerrar sesión.');
        return false;
      }
    } catch (e) {
      debugPrint('Error al hacer logout: $e');
      _showSnackBar(context, 'Error al comunicarse con el servidor.');
      return false;
    }
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}
