import 'package:cb_project/src/auth/admin/controllers/general_data_controller.dart';
import 'package:cb_project/src/auth/admin/controllers/page_controller.dart';
import 'package:cb_project/src/auth/admin/views/admin_view.dart';
import 'package:cb_project/src/auth/login_screen/login_controller.dart';
import 'package:cb_project/src/auth/login_screen/login_handler.dart';
import 'package:cb_project/src/auth/tv_summary/views/tv_summary_view.dart';
import 'package:cb_project/src/auth/voting_users/alderman/views/alderman_view.dart';
import 'package:cb_project/src/auth/voting_users/president/views/president_view.dart';
import 'package:cb_project/src/auth/voting_users/secretary/views/secretary_view.dart';
import 'package:cb_project/src/server/sockets/sockets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  //Run app
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
        ChangeNotifierProvider(
          create: (_) => SocketClient(),
        ),
        ChangeNotifierProvider(
          create: (_) => LoginController(),
        ),
        ChangeNotifierProvider(
          create: (_) => GeneralDataProvider(),
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
        initialRoute: LoginHandler.id,
        routes: {
          LoginHandler.id: (_) => const LoginHandler(),
          AdminView.id: (_) => const AdminView(),
          SecretaryView.id: (_) => const SecretaryView(),
          AldermanView.id: (_) => const AldermanView(),
          PresidentView.id: (_) => const PresidentView(),
          TvSummaryView.id: (_) => const TvSummaryView(),
        },
      ),
    );
  }
}
