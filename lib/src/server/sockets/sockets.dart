import 'package:cb_project/src/auth/admin/controllers/general_data_controller.dart';
import 'package:cb_project/src/auth/admin/models/general_data.dart';
import 'package:cb_project/src/auth/admin/views/admin_view.dart';
import 'package:cb_project/src/auth/voting_users/alderman/views/alderman_view.dart';
import 'package:cb_project/src/auth/voting_users/president/views/president_view.dart';
import 'package:cb_project/src/auth/voting_users/secretary/views/secretary_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketClient extends ChangeNotifier {
  static const String socketHost = 'http://192.168.1.102:3000';
  final IO.Socket _socket = IO.io(
      socketHost, IO.OptionBuilder().setTransports(['websocket']).build());
  IO.Socket get socket => _socket;

  void initSocket(BuildContext context) {
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
      //debugPrint(userRole);

      // Añade los casos para cada rol y redirige a la pantalla correspondiente
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

    _socket.on('server:requestgeneraldata', (data) {
      final GeneralDataProvider generalDataProvider =
          Provider.of<GeneralDataProvider>(context, listen: false);

      debugPrint(
        "Datos de server:requestgeneraldatageneral",
      );

      int municipalityNumber = data['municipalityNumber'];

      generalDataProvider.generalData = GeneralData(
        users: data['users'],
        cityHallNumber: municipalityNumber.toInt(),
      );

      notifyListeners();
    });

    _socket.on('server:updateuser', (data) {
      debugPrint("Datos de usuarios actualizada:");
      notifyListeners();
    });

    _socket.on('server:adduser', (data) {
      // final GeneralDataProvider generalDataProvider =
      //     Provider.of<GeneralDataProvider>(context, listen: false);
      debugPrint("Nuevo usuario agregado");
      _socket.emit('client:requestgeneraldata');

      notifyListeners();
    });

    _socket.connect();
  }

  void disposeSocket() {
    _socket.off('server:requestgeneraldata');
    _socket.off('server:updateuser');
    _socket.off('server:adduser');
    // Add other socket event listeners that need to be removed on dispose
  }
}
