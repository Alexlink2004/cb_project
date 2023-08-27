import 'package:cb_project/src/server/models/user.dart';
import 'package:flutter/material.dart';

class AuthController extends ChangeNotifier {
  bool _isConnected = true;
  List<User> _users = [];

  List<User> get users => _users;

  bool get isConnected => _isConnected;

  set isConnected(bool data) {
    _isConnected = data;
    notifyListeners();
  }
}
