import 'dart:async';

import 'package:cb_project/src/auth/admin/views/admin_view.dart';
import 'package:cb_project/src/auth/voting_users/alderman/views/alderman_view.dart';
import 'package:cb_project/src/auth/voting_users/president/views/president_view.dart';
import 'package:cb_project/src/auth/voting_users/secretary/views/secretary_view.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../models/user.dart';

class SocketClient extends ChangeNotifier {
  static const String socketHost = 'http://localhost:3000';
  final IO.Socket _socket = IO.io(
      socketHost, IO.OptionBuilder().setTransports(['websocket']).build());
  IO.Socket get socket => _socket;
  int timesInstance = 0;

  final StreamController<List<User>> _userStreamController =
      StreamController<List<User>>();

  Stream<List<User>> get userStream => _userStreamController.stream;

  List<User> _users = [];

  set users(data) {
    _users = data;
    notifyListeners();
  }

  List<User> get users => _users;

  void initSocket(BuildContext context) {
    timesInstance++;

    if (timesInstance <= 1) {
      debugPrint('Veces llamado initSocket: $timesInstance');
      _socket.onConnect((data) {
        debugPrint('connected + $data');
        notifyListeners();
      });

      _socket.onConnectError((data) {
        debugPrint('not connected + $data');

        notifyListeners();
      });

      _socket.on('server:login', (data) {
        // Aquí recibes la información del usuario que ha iniciado sesión

        String userRole = data['position'];

        switch (userRole) {
          case 'Administrador':
            // Redirige a la pantalla del administrador
            Navigator.pushReplacementNamed(
              context,
              AdminView.id,
            );
            break;
          case 'Presidente':
            // Redirige a la pantalla del presidente
            Navigator.pushReplacementNamed(
              context,
              PresidentView.id,
            );
            break;
          case 'Secretario':
            // Redirige a la pantalla del secretario
            Navigator.pushReplacementNamed(
              context,
              SecretaryView.id,
            );
            break;
          case 'Regidor':
            // Redirige a la pantalla del regidor
            Navigator.pushReplacementNamed(
              context,
              AldermanView.id,
            );
            break;
          default:
            break;
        }
      });

      _socket.on('server:loginerror', (data) {
        debugPrint("server:loginerror");
      });

      _socket.on('server:updateuser', (data) {
        debugPrint("Datos de usuarios actualizada:");

        notifyListeners();
      });

      _socket.on('server:adduser', (data) {
        _socket.on('server:adduser', (data) {
          debugPrint("Nuevo usuario agregado");

          users.add(User.fromJson(data));

          debugPrint("$data");
          _socket.emit('client:getusers', {});

          _userStreamController.add(users); // Notify the stream listeners
          notifyListeners();
        });
      });

      _socket.on('server:getusers', (data) {
        debugPrint("server:getusers");
        List<dynamic> userList = data;

        List<User> userListConverted =
            userList.map((userData) => User.fromJson(userData)).toList();

        users.clear();

        users.addAll(userListConverted);

        debugPrint('Numero de usuarios: ${userListConverted.length}');

        // Notify the stream listeners with the updated user list
        _userStreamController.add(users);
      });
      //
      // _socket.on(
      //     "server:deleteerror",
      //     (data) => {
      //           ScaffoldMessenger.of(context).showSnackBar(
      //             const SnackBar(
      //               content: Text(
      //                 'Delete Error',
      //                 style: TextStyle(color: Colors.white),
      //               ),
      //               backgroundColor: Colors.red,
      //               duration: Duration(seconds: 2),
      //             ),
      //           ),
      //         });
      // notifyListeners();
    }

    _socket.connect();
  }

  void disposeSocket() {
    socket.off('server:updateuser');
    socket.off('server:adduser');
    socket.off('server:loginerror');
    socket.off('server:server:login');
    // Add other socket event listeners that need to be removed on dispose
  }
}
