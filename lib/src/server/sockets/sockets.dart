import 'package:cb_project/src/auth/admin/views/admin_view.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketClient extends ChangeNotifier {
  static const String socketHost = 'http://localhost:3000';
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
          Navigator.pushNamed(context, AdminView.id);
          break;
        case 'Presidente':
        // Redirige a la pantalla del presidente
          Navigator.pushNamed(context, '/presidente');
          break;
        case 'Secretario':
        // Redirige a la pantalla del secretario
          Navigator.pushNamed(context, '/secretario');
          break;
        case 'Regidor':
        // Redirige a la pantalla del regidor
          Navigator.pushNamed(context, '/regidor');
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




    // // Inicia la conexión con el servidor
    // _socket.connect();
  }
}
