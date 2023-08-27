import 'package:cb_project/src/auth/admin/controllers/general_data_content_controller.dart';
import 'package:cb_project/src/auth/admin/controllers/general_data_controller.dart';
import 'package:cb_project/src/auth/admin/controllers/page_controller.dart';
import 'package:cb_project/src/auth/auth_controller.dart';
import 'package:cb_project/src/auth/login_screen/controllers/login_controller.dart';
import 'package:cb_project/src/server/api/users_api.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> appProviders = [
  //Auth
  ChangeNotifierProvider(
    create: (_) => AuthController(),
  ),
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
    create: (_) => GeneralDataProvider(),
  ),
];
