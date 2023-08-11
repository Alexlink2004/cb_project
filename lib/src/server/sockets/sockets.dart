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
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  //LOGIN
  bool _isLoggedIn = false; // Propiedad para rastrear el estado de la sesión
  bool get isLoggedIn =>
      _isLoggedIn; // Getter para acceder al estado de la sesión
  //SOCKET
  static final SocketClient _instance = SocketClient._internal();

  final IO.Socket _socket = IO.io('http://localhost:3000',
      IO.OptionBuilder().setTransports(['websocket']).build());
  //STREAMS
  final StreamController<List<User>> _userStreamController =
      StreamController<List<User>>();
  Stream<List<User>> get userStream => _userStreamController.stream;
  List<User> _users = [];

  factory SocketClient() => _instance;

  SocketClient._internal() {
    _socket.onConnect(_onConnect);
    _socket.onConnectError(_onConnectError);
    _socket.on('server:login', (data) => _onLogin(data));
    _socket.on('server:loginerror', _onLoginError);
    _socket.on('server:updateuser', _onUpdateUser);
    _socket.on('server:adduser', _onAddUser);
    _socket.on('server:getusers', _onGetUsers);
    _socket.connect();
  }
  void setContext(BuildContext context) {
    _context = context;
  }

  // Método para emitir un evento al servidor
  void emit(String event, dynamic data) {
    _socket.emit(event, data);
  }

  void login(BuildContext context, dynamic userData) {
    _context = context; // Almacena el contexto
    debugPrint("Login with ${userData['firstName']}");
    _socket.emit('client:login', userData);
    _isLoggedIn = true;
    notifyListeners(); // Notificar a los oyentes del cambio de estado
  }

  // void login(BuildContext context, dynamic userData) {
  //   debugPrint("Login with ${userData['firstName']}");
  //   _socket.emit('client:login', userData);
  //   _isLoggedIn = true;
  //   notifyListeners(); // Notificar a los oyentes del cambio de estado
  //
  //   String userRole = userData['position'];
  //

  // }

  void logout() {
    // Lógica para cerrar la sesión
    _isLoggedIn = false;
    notifyListeners(); // Notificar a los oyentes del cambio de estado
  }

  void _onConnect(data) {
    debugPrint('connected + $data');
    notifyListeners();
  }

  void _onConnectError(data) {
    debugPrint('not connected + $data');
    notifyListeners();
  }

  void _onLogin(data) {
    if (_context == null) {
      debugPrint("Error: Context is null");
      return;
    }
    debugPrint("server:login");

    String userRole = data['position'];

    switch (userRole) {
      case 'Administrador':
        // Redirige a la pantalla del administrador
        Navigator.pushReplacementNamed(
          _context!,
          AdminView.id,
        );
        break;
      case 'Presidente':
        // Redirige a la pantalla del presidente
        Navigator.pushReplacementNamed(
          _context!,
          PresidentView.id,
        );
        break;
      case 'Secretario':
        // Redirige a la pantalla del secretario
        Navigator.pushReplacementNamed(
          _context!,
          SecretaryView.id,
        );
        break;
      case 'Regidor':
        // Redirige a la pantalla del regidor
        Navigator.pushReplacementNamed(
          _context!,
          AldermanView.id,
        );
        break;
      default:
        break;
    }
  }

  void _onLoginError(data) {
    debugPrint("server:loginerror");
  }

  void _onUpdateUser(data) {
    debugPrint("Datos de usuarios actualizada:");
    notifyListeners();
  }

  void _onAddUser(data) {
    debugPrint("server:adduser");
    // Manejo de agregar usuario
  }

  void _onGetUsers(data) {
    debugPrint("server:getusers");
    List<dynamic> userList = data;
    _users = userList.map((userData) => User.fromJson(userData)).toList();
    _userStreamController.add(_users); // Notify the stream listeners
    notifyListeners();
  }

  void dispose() {
    debugPrint("dispose streamcontroller & socket");
    _userStreamController.close();
    _socket.dispose();
    super.dispose();
  }

  set users(data) {
    _users = data;
    notifyListeners();
  }

  List<User> get users => _users;

  // void initSocket(BuildContext context) {
  //   timesInstance++;
  //
  //   if (timesInstance <= 1) {
  //     debugPrint('Veces llamado initSocket: $timesInstance');
  //     _socket.onConnect((data) {
  //       debugPrint('connected + $data');
  //       notifyListeners();
  //     });
  //
  //     _socket.onConnectError((data) {
  //       debugPrint('not connected + $data');
  //
  //       notifyListeners();
  //     });
  //

  //
  //     _socket.on('server:loginerror', (data) {
  //       debugPrint("server:loginerror");
  //     });
  //
  //     _socket.on('server:updateuser', (data) {
  //       debugPrint("Datos de usuarios actualizada:");
  //
  //       notifyListeners();
  //     });
  //
  //     _socket.on('server:adduser', (data) {
  //       _socket.on('server:adduser', (data) {
  //         debugPrint("Nuevo usuario agregado");
  //
  //         users.add(User.fromJson(data));
  //
  //         debugPrint("$data");
  //         _socket.emit('client:getusers', {});
  //
  //         _userStreamController.add(users); // Notify the stream listeners
  //         notifyListeners();
  //       });
  //     });
  //
  //     _socket.on('server:getusers', (data) {
  //       debugPrint("server:getusers");
  //       List<dynamic> userList = data;
  //
  //       List<User> userListConverted =
  //           userList.map((userData) => User.fromJson(userData)).toList();
  //
  //       users.clear();
  //
  //       users.addAll(userListConverted);
  //
  //       debugPrint('Numero de usuarios: ${userListConverted.length}');
  //
  //       // Notify the stream listeners with the updated user list
  //       _userStreamController.add(users);
  //     });
  //
  //   }
  //
  //   _socket.connect();
  // }
}
