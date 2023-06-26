import 'package:cb_project/src/auth/admin/controllers/page_controller.dart';
import 'package:cb_project/src/auth/admin/views/admin_view.dart';
import 'package:cb_project/src/auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    const VotingSystemApp(),
  );
}

class VotingSystemApp extends StatelessWidget {
  const VotingSystemApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AdminPageController(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: Colors.black,
        ),
        darkTheme: ThemeData.dark(),
        themeMode: ThemeMode.system,
        debugShowCheckedModeBanner: false,
        initialRoute: LoginScreen.id,
        routes: {
          LoginScreen.id: (_) => const LoginScreen(),
          AdminView.id: (_) => const AdminView(),
        },
      ),
    );
  }
}
