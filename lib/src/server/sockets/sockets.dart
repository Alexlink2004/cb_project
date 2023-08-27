import 'dart:async';

import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../models/user.dart';

class SocketClient {
  static final SocketClient _singleton = SocketClient._internal();
  factory SocketClient() => _singleton;
  SocketClient._internal();

  final IO.Socket _socket = IO.io('http://localhost:3000',
      IO.OptionBuilder().setTransports(['websocket']).build());
  final _userStreamController = StreamController<List<User>>.broadcast();
  Stream<List<User>> get userStream => _userStreamController.stream;
  List<User> _users = [];

  void initialize() {
    _socket.onConnect((_) {
      _socket.emit('client:getusers');
      print("Conectado");
    });
    _socket.onConnectError((_) => print("Desconectado"));
    _socket.on('server:getusers', _onGetUsers);
    _socket.on('server:adduser', _onAddUser);
    _socket.on('server:updateuser', _onUpdateUser);
    _socket.on('server:deleteuser', _onDeleteUser);
    _socket.connect();
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

  void emit(String event, dynamic data) {
    _socket.emit(event, data);
  }

  void disposeSocket() {
    // _userStreamController.close();
    // _socket.disconnect();
  }
}
