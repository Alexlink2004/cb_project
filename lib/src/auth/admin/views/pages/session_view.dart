import 'package:flutter/material.dart';

import '../components/admin_page_template.dart';

class SessionView extends StatelessWidget {
  const SessionView({super.key});

  @override
  Widget build(BuildContext context) {
    return AdminPageTemplate(
      pageTitle: "Ver Sesión",
      pageSubtitle:
          "Controla la sesión de votación, modificando los puntos de discusión, añadiendo opciones y gestionando los integrantes.",
      content: Container(
        height: 700,
        color: Colors.amberAccent,
        child: const Placeholder(),
      ),
    );
  }
}
