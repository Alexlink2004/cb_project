import 'package:flutter/material.dart';

import '../components/admin_page_template.dart';

class ReportsView extends StatelessWidget {
  const ReportsView({super.key});

  @override
  Widget build(BuildContext context) {
    return AdminPageTemplate(
      pageTitle: "Reportes",
      pageSubtitle:
          "Accede a los resultados y estadísticas de la última sesión de votación realizada.",
      content: Container(
        height: 700,
        color: Colors.purple,
        child: const Placeholder(),
      ),
    );
  }
}
