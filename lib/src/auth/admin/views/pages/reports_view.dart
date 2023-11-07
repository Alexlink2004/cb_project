import 'package:excel/excel.dart';
import 'package:flutter/material.dart';

import '../components/admin_page_template.dart';

class ReportsView extends StatelessWidget {
  const ReportsView({super.key});
  Future<void> _generateExcel(BuildContext context) async {
    // Crear un nuevo archivo de Excel
    var excel = Excel.createExcel();

    // Crear una nueva hoja en el archivo de Excel
    var sheet = excel['Voting Points'];

    // Agregar datos a la hoja de Excel
    sheet.appendRow(['Nombre', 'Votos']);
    sheet.appendRow(['Candidato 1', '100']);
    sheet.appendRow(['Candidato 2', '200']);
    sheet.appendRow(['Candidato 3', '150']);

    // Guardar el archivo de Excel en el dispositivo
    var excelPath = '/ruta/del/archivo/excel.xlsx';
    await excel.save(fileName: excelPath);

    // Mostrar un mensaje de éxito
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Archivo de Excel generado con éxito')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AdminPageTemplate(
      pageTitle: "Reportes",
      pageSubtitle:
          "Accede a los resultados y estadísticas de la última sesión de votación realizada.",
      content: Container(
        height: 700,
        color: Colors.purple,
        child: ElevatedButton(
          onPressed: () {
            _generateExcel(context);
          },
          child: Text("Generar excel"),
        ),
      ),
    );
  }
}
