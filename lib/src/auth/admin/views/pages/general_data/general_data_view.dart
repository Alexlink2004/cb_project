import 'package:cb_project/src/auth/admin/views/components/admin_page_template.dart';
import 'package:cb_project/src/auth/admin/views/pages/general_data/components/general_data_content.dart';
import 'package:flutter/material.dart';

class GeneralDataView extends StatelessWidget {
  const GeneralDataView({super.key});

  @override
  Widget build(BuildContext context) {
    return const AdminPageTemplate(
      pageTitle: "Datos Generales",
      pageSubtitle:
          "Actualiza la información clave del Ayuntamiento, como los nombres de los gobernantes y otros detalles relevantes.",
      content: Expanded(
        child: GeneralDataPage(),
      ),
    );
  }
}
