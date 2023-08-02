import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../../server/sockets/sockets.dart';
import 'login_screen.dart';

class LoginHandler extends StatefulWidget {
  static const id = '/login';
  const LoginHandler({Key? key}) : super(key: key);

  @override
  State<LoginHandler> createState() => _LoginHandlerState();
}

class _LoginHandlerState extends State<LoginHandler> {
  late IO.Socket _socket;
  @override
  void initState() {
    super.initState();
    //Socket Client
    _socket = IO.io(
      SocketClient.socketHost,
      IO.OptionBuilder().setTransports(['websocket']).build(),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _socket.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final SocketClient socketClient = Provider.of<SocketClient>(context);
    socketClient.initSocket(context, _socket);
    if (!_socket.connected) {
      return const LoadingScreen();
    } else {
      return const LoginScreen();
    }
  }
}
