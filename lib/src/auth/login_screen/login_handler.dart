import 'package:flutter/material.dart';

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
    final SocketClient socketClient = SocketClient();
    socketClient.disposeSocket();
  }

  @override
  Widget build(BuildContext context) {
    final SocketClient socketClient = SocketClient();
    socketClient.setContext(context);

    if (!socketClient.isLoggedIn) {
      return const LoginScreen();
    } else {
      return const LoadingScreen();
    }
  }
}
