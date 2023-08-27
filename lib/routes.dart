import 'package:cb_project/src/auth/admin/views/admin_view.dart';
import 'package:cb_project/src/auth/login_screen/loading_screen.dart';
import 'package:cb_project/src/auth/login_screen/login_handler.dart';
import 'package:cb_project/src/auth/tv_summary/views/tv_summary_view.dart';
import 'package:cb_project/src/auth/voting_users/alderman/views/alderman_view.dart';
import 'package:cb_project/src/auth/voting_users/president/views/president_view.dart';
import 'package:cb_project/src/auth/voting_users/secretary/views/secretary_view.dart';
import 'package:flutter/material.dart';

Map<String, WidgetBuilder> routes = {
  LoginHandler.id: (_) => const LoginHandler(),
  AdminView.id: (_) => const AdminView(),
  SecretaryView.id: (_) => const SecretaryView(),
  AldermanView.id: (_) => const AldermanView(),
  PresidentView.id: (_) => const PresidentView(),
  TvSummaryView.id: (_) => const TvSummaryView(),
  LoadingScreen.id: (_) => const LoadingScreen(),
};
