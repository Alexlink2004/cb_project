import 'package:cb_project/src/auth/admin/controllers/general_data_controller.dart';
import 'package:cb_project/src/auth/admin/models/general_data.dart';
import 'package:cb_project/src/auth/admin/views/admin_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../models/user.dart';

class SocketClient extends ChangeNotifier {
  static const String socketHost = 'http://192.168.1.102:3000';
  final IO.Socket _socket = IO.io(socketHost, IO.OptionBuilder().setTransports(['websocket']).build());

  IO.Socket get socket => _socket;

  void initSocket(BuildContext context) {
    _socket.onConnect((data) {
      debugPrint('connected + $data');
      notifyListeners();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Conectado'),
          duration: Duration(seconds: 1),
        ),
      );
    });

    _socket.onConnectError((data) {
      debugPrint('not connected + $data');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Problema de conexión'),
          duration: Duration(seconds: 1),
        ),
      );
      notifyListeners();
    });

    _socket.on('server:login', (data) {
      // Aquí recibes la información del usuario que ha iniciado sesión
      print("Usuario ha iniciado sesión: $data");

      String userRole = data['position'];
      debugPrint(userRole);

      // Añade los casos para cada rol y redirige a la pantalla correspondiente
      switch (userRole) {
        case 'Administrador':
        // Redirige a la pantalla del administrador
          Navigator.pushReplacementNamed(context, AdminView.id);
          break;
        case 'Presidente':
        // Redirige a la pantalla del presidente
          Navigator.pushReplacementNamed(context, '/presidente');
          break;
        case 'Secretario':
        // Redirige a la pantalla del secretario
          Navigator.pushReplacementNamed(context, '/secretario');
          break;
        case 'Regidor':
        // Redirige a la pantalla del regidor
          Navigator.pushReplacementNamed(context, '/regidor');
          break;
        default:


          break;
      }
    });

    _socket.on('server:loginerror', (data) {
      debugPrint("server:loginerror");

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Usuario no reconocido :( Habla con el administrador"),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 1,),
      ),);
    });

    _socket.on('server:requestgeneraldata', (data) {
      final GeneralDataProvider _generalDataProvider =
      Provider.of<GeneralDataProvider>(context, listen: false);

      // Assuming 'data' is a Map containing the 'users' and 'municipalityNumber' keys
      List<dynamic> usersData = data['users'];
      debugPrint("Datos de server:requestgeneraldata" + usersData.toString(),);
      List<User> users = usersData.map((userData) => User.fromJson(userData)).toList();


      int municipalityNumber = data['municipalityNumber'];

      _generalDataProvider.generalData =
          GeneralData(users: users, ayuntamientoNumber: municipalityNumber);

      notifyListeners();
      debugPrint('Datos generales: $data');
    });






    // // Inicia la conexión con el servidor
    // _socket.connect();
  }
}
