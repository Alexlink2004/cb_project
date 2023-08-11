import 'dart:async';

import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../../auth/admin/views/admin_view.dart';
import '../../auth/voting_users/alderman/views/alderman_view.dart';
import '../../auth/voting_users/president/views/president_view.dart';
import '../../auth/voting_users/secretary/views/secretary_view.dart';
import '../models/user.dart';

class SocketClient extends ChangeNotifier {
  BuildContext? _context;
  final IO.Socket _socket = IO.io('http://localhost:3000',
      IO.OptionBuilder().setTransports(['websocket']).build());
  final _userStreamController = StreamController<List<User>>.broadcast();
  Stream<List<User>> get userStream => _userStreamController.stream;
  List<User> _users = [];
  void _startGettingUsers() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      _socket.emit('client:getusers', {});
    });
  }

  SocketClient() {
    _socket.onConnect((_) => print('connected'));
    _socket.onConnectError((_) => print('not connected'));
    _socket.on('server:getusers', _onGetUsers);
    _socket.on('server:adduser', _onAddUser);
    _socket.on('server:updateuser', _onUpdateUser);
    _socket.on('server:deleteuser', _onDeleteUser);
    _socket.on('server:login', _onLogin);
    _socket.connect();
    _startGettingUsers();
  }

  void setContext(BuildContext context) {
    _context = context;
  }

  void _onGetUsers(data) {
    List<dynamic> userList = data;
    _users = userList.map((userData) => User.fromJson(userData)).toList();
    _userStreamController.add(_users);
  }

  void _onAddUser(data) {
    User newUser = User.fromJson(data);
    _users.add(newUser);
    _userStreamController.add(_users);
  }

  void _onUpdateUser(data) {
    User updatedUser = User.fromJson(data);
    int index =
        _users.indexWhere((user) => user.password == updatedUser.password);
    if (index != -1) {
      _users[index] = updatedUser;
      _userStreamController.add(_users);
    }
  }

  void _onDeleteUser(data) {
    String password = data['password'];
    _users.removeWhere((user) => user.password == password);
    _userStreamController.add(_users);
  }

  void _onLogin(data) {
    if (_context == null) {
      debugPrint("Error: Context is null");
      return;
    }
    String userRole = data['position'];
    switch (userRole) {
      case 'Administrador':
        Navigator.pushReplacementNamed(_context!, AdminView.id);
        break;
      case 'Presidente':
        Navigator.pushReplacementNamed(_context!, PresidentView.id);
        break;
      case 'Secretario':
        Navigator.pushReplacementNamed(_context!, SecretaryView.id);
        break;
      case 'Regidor':
        Navigator.pushReplacementNamed(_context!, AldermanView.id);
        break;
      default:
        break;
    }
  }

  void emit(String event, dynamic data) {
    _socket.emit(event, data);
  }

  void disposeSocket() {
    // _userStreamController.close();
    // _socket.disconnect();
  }
}
