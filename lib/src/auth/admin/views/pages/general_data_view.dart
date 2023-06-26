import 'package:cb_project/src/auth/admin/views/components/admin_page_template.dart';
import 'package:flutter/material.dart';

class GeneralDataView extends StatelessWidget {
  const GeneralDataView({super.key});

  @override
  Widget build(BuildContext context) {
    return AdminPageTemplate(
      pageTitle: "Datos Generales",
      pageSubtitle:
          "Actualiza la información clave del Ayuntamiento, como los nombres de los gobernantes y otros detalles relevantes.",
      content: Container(
        height: 700,
        color: Colors.pink,
        child: const Placeholder(),
      ),
    );
  }
}
