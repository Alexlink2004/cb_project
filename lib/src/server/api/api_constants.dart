import 'package:shared_preferences/shared_preferences.dart';

import '../models/user.dart';

class ApiConstants {
  static String apiRoute = "http://localhost:3001"; // Valor predeterminado

  static Future initializeApiRoute() async {
    final prefs = await SharedPreferences.getInstance();
    apiRoute = prefs.getString('apiRoute') ?? apiRoute;
  }

  static Future setApiRoute(String newApiRoute) async {
    final prefs = await SharedPreferences.getInstance();
    apiRoute = newApiRoute;
    await prefs.setString('apiRoute', newApiRoute);
  }

  static User errorUser = User(
    password: 'error',
    endDate: 'error',
    firstName: 'error',
    gender: 'error',
    lastName: 'error',
    memberPhoto: 'error',
    memberStatus: 'error',
    municipalityNumber: 'error',
    party: 'error',
    position: 'error',
    startDate: 'error',
    id: 'error',
  );
}
