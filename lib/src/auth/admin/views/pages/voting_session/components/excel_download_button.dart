import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../../server/api/api_constants.dart'; // Asegúrate de que esta ruta sea la correcta

class DownloadReportFAB extends StatelessWidget {
  const DownloadReportFAB({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () async {
        final url =
            Uri.parse("${ApiConstants.apiRoute}/download-voting-points");
        if (await canLaunchUrl(url)) {
          await launchUrl(url);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('No se pudo abrir la URL: $url'),
            ),
          );
        }
      },
      icon: const Icon(Icons.download),
      label: const Text("Descargar Reporte de votación"),
      backgroundColor: Colors.green,
    );
  }
}
