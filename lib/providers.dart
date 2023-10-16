import 'package:cb_project/src/auth/admin/controllers/general_data_content_controller.dart';
import 'package:cb_project/src/auth/admin/controllers/page_controller.dart';
import 'package:cb_project/src/auth/admin/controllers/voting_point_controller.dart';
import 'package:cb_project/src/auth/controllers/auth_controller.dart';
import 'package:cb_project/src/auth/login_screen/controllers/login_controller.dart';
import 'package:cb_project/src/server/api/users_api.dart';
import 'package:cb_project/src/server/api/voting_point_api.dart';
import 'package:cb_project/src/server/sockets/voting_session_socket.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> appProviders = [
  ChangeNotifierProvider(
    create: (_) => UsersApi(),
  ),
  //General Data
  ChangeNotifierProvider(
    create: (_) => GeneralDataContentController(),
  ),
  //Admin Page Index
  ChangeNotifierProvider(
    create: (_) => AdminPageController(),
  ),
  ChangeNotifierProvider(
    create: (_) => LoginController(),
  ),
  ChangeNotifierProvider(
    create: (context) => VotingSessionSocket(),
  ),
  ChangeNotifierProvider(
    create: (context) => AuthController(),
  ),
  ChangeNotifierProvider(
    create: (context) => VotingPointController(),
  ),
  ChangeNotifierProvider(
    create: (context) => VotingPointApi(),
  ),
];
