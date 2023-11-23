import 'package:cb_project/src/auth/login_screen/conectivity_handler.dart';
import 'package:cb_project/src/auth/login_screen/controllers/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../debug/debug_panel.dart';
import '../../server/models/user.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final loginController = Provider.of<LoginController>(context);
    return InternetAwareWidget(
      child: Scaffold(
        backgroundColor: const Color(0xFF1B1B1B),
        body: SafeArea(
          child: Row(
            children: [
              //Primera seccion (Izquierda)
              Expanded(
                child: ColoredBox(
                  color: const Color(0xFF121212),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 70.109,
                            child: Image.asset('assets/logos/Logo-Mxli.png'),
                          ),
                          const Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Gobierno',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                'De Mexicali',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                '24 ayuntamiento',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        'Sistema de votación para',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      const Text(
                        'cabildo',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              //Segunda Seccion
              Expanded(
                flex: 2,
                child: Stack(
                  children: [
                    const Positioned(
                      top: 0,
                      right: 0,
                      child: DebugPanel(),
                    ),
                    SizedBox(
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Bienvenido/a',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold),
                            ),
                            const Text(
                              'Ingresa tu codigo',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              width: 261,
                              height: 71,
                              constraints: const BoxConstraints(
                                maxWidth: 261,
                                maxHeight: 71,
                              ),
                              child: TextField(
                                controller:
                                    loginController.loginFieldController,
                                keyboardType: TextInputType.number,
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.grey.shade700,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide.none,
                                  ),
                                  hintText: 'Ingresar',
                                  hintStyle: const TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                onSubmitted: (data) async {
                                  User userLogged =
                                      await loginController.setPasswordAndLogin(
                                    data,
                                    context,
                                  );
                                  loginController.login(userLogged, context);
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
