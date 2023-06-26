import 'package:cb_project/src/auth/admin/views/pages/general_data_view.dart';
import 'package:cb_project/src/auth/admin/views/pages/reports_view.dart';
import 'package:cb_project/src/auth/admin/views/pages/session_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controllers/page_controller.dart';
import 'components/vertical_menu.dart';

class AdminView extends StatelessWidget {
  static const id = '/adminDashboard';
  const AdminView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _pageController = Provider.of<AdminPageController>(context);
    const List<Widget> pages = [
      GeneralDataView(),
      SessionView(),
      ReportsView(),
    ];
    return Scaffold(
      backgroundColor: const Color(0xFF1B1B1B),
      body: SafeArea(
        child: Row(
          children: [
            Container(
              width: 150,
              decoration: const BoxDecoration(
                color: Color(0xFF121212),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  VerticalMenuItem(
                    icon: Icons.settings,
                    title: 'Datos Generales',
                    buttonIndex: 0,
                  ),
                  VerticalMenuItem(
                    icon: Icons.create,
                    title: 'Sesión',
                    buttonIndex: 1,
                  ),
                  VerticalMenuItem(
                    icon: Icons.summarize,
                    title: 'Ver Reportes',
                    buttonIndex: 2,
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 6,
              child: ColoredBox(
                color: const Color(0xFF1B1B1B),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white,
                    ),
                    child: pages[_pageController.index],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
