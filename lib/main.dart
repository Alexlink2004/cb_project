import 'package:cb_project/providers.dart';
import 'package:cb_project/routes.dart';
import 'package:cb_project/src/auth/controllers/auth_controller.dart';
import 'package:cb_project/src/auth/login_screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() {
  //Run app
  runApp(
    const CoreApp(),
  );
}

class CoreApp extends StatelessWidget {
  const CoreApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    //Inicia los providers hasta arriba del app
    //Full screen
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    return MultiProvider(
      providers: appProviders,
      child: const VotingSystemApp(),
    );
  }
}

class VotingSystemApp extends StatelessWidget {
  const VotingSystemApp({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
    final authController = Provider.of<AuthController>(context);

    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.black,
      ),
      navigatorKey: navigatorKey,
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,
      home: const LoginScreen(),
      routes: routes,
    );
  }
}
//
// else {
// return MaterialApp(
// theme: ThemeData(
// brightness: Brightness.light,
// primaryColor: Colors.black,
// ),
// darkTheme: ThemeData.dark(),
// themeMode: ThemeMode.system,
// debugShowCheckedModeBanner: false,
// home: const LoadingScreen(),
// routes: routes,
// );
// }
