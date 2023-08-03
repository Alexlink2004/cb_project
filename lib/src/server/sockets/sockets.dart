import 'package:cb_project/src/auth/admin/views/admin_view.dart';
import 'package:cb_project/src/auth/voting_users/alderman/views/alderman_view.dart';
import 'package:cb_project/src/auth/voting_users/president/views/president_view.dart';
import 'package:cb_project/src/auth/voting_users/secretary/views/secretary_view.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../models/user.dart';

class SocketClient extends ChangeNotifier {
  static const String socketHost = 'http://192.168.1.102:3000';
  final IO.Socket _socket = IO.io(
      socketHost, IO.OptionBuilder().setTransports(['websocket']).build());
  IO.Socket get socket => _socket;
  int timesInstance = 0;

  final List<User> _users = [
    // User(
    //   password: "0046",
    //   endDate: "2023-12-31",
    //   firstName: "John",
    //   gender: "Male",
    //   lastName: "Doe",
    //   memberPhoto: "url" "https://example.com/user123.jpg",
    //   memberStatus: "Active",
    //   municipalityNumber: 123,
    //   party: "Example Party",
    //   position: "Administrador",
    //   startDate: "2021-01-01",
    // ),
  ];

  set users(data) {
    users = data;
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
        // final GeneralDataProvider generalDataProvider =
        //     Provider.of<GeneralDataProvider>(context, listen: false);
        debugPrint("Nuevo usuario agregado");
        // _socket.emit('client:adduser', {});

        // debugPrint(data.toString());

        notifyListeners();
      });

      _socket.on('server:getusers', (data) {
        List<dynamic> userList = data;

        List<User> userListConverted =
            userList.map((userData) => User.fromJson(userData)).toList();

        users.clear();

        users.addAll(userListConverted);

        debugPrint('Numero de usuarios: ${userListConverted.length}');

        notifyListeners();
      });
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
