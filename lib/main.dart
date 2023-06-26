import 'package:cb_project/src/auth/login_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const VotingSystemApp());
}

class VotingSystemApp extends StatelessWidget {
  const VotingSystemApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.blue,
      ),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      initialRoute: LoginScreen.id,
      routes: {
        LoginScreen.id: (context) => const LoginScreen(),
      },
    );
  }
}
