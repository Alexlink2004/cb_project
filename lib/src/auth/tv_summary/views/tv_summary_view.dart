import 'package:cb_project/src/auth/admin/views/components/back_button.dart';
import 'package:flutter/material.dart';

class TvSummaryView extends StatelessWidget {
  static const String id = '/tvSummaryView';
  const TvSummaryView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF121212),
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 60,
        backgroundColor: const Color(0xFF121212),
        leading: SizedBox(
          width: 40,
          height: 40,
          child: Image.asset(
            'assets/logos/Logo-Mxli.png',
            scale: 0.5,
          ),
        ),
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Gobierno',
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  'De Mexicali',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            SizedBox(width: 16),
            Expanded(
              child: Text(
                'Sesión de cabildo ',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24),
              ),
            ),
          ],
        ),
        actions: [
          LogOutButton(),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
          ),
          //CONTENIDO:
          child: SizedBox.expand(
            child: Center(
              child: SizedBox(
                width: 800,
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Punto 3ro',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Seguridad Pública, Tránsito y Transporte',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Propuesta de dispensa de trámite relativa adenda a la iniciativa de ley de ingresos del municipio de Mexicali, Baja California, para el ejercico fiscal del 2023 sea la atenta iniciativa de tabla de valores catastrales unitarios. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
