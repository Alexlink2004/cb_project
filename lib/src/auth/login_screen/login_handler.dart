import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../server/sockets/sockets.dart';
import 'login_screen.dart';

class LoginHandler extends StatefulWidget {
  static const id = '/login';
  const LoginHandler({Key? key}) : super(key: key);

  @override
  State<LoginHandler> createState() => _LoginHandlerState();
}

class _LoginHandlerState extends State<LoginHandler> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final SocketClient socketClient = Provider.of<SocketClient>(context);
    socketClient.initSocket(context);
    if (!socketClient.socket.connected) {
      return const LoadingScreen();
    } else {
      return const LoginScreen();
    }
  }
}
