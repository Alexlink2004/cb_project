import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;


class SocketClient extends ChangeNotifier{
  //CAMBIAR ESTO
  static const String socketHost = 'http://192.168.1.104:3000';
  final IO.Socket _socket = IO.io('http://192.168.1.104:3000', IO.OptionBuilder().setTransports(['websocket']).build(),);

  IO.Socket get socket => _socket;

  void initSocket(BuildContext context){
    _socket.onConnect((data) {
      debugPrint('connected + $data');
      notifyListeners();
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Conectado'),
            duration: Duration(seconds: 2),
          ),);

    });
    _socket.onConnectError((data) {
      debugPrint('not connected + $data');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Problema de conexión'),
          duration: Duration(seconds: 2),
        ),);
      notifyListeners();


    });
  }




}