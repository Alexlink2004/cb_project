import 'package:cb_project/src/auth/admin/views/components/back_button.dart';
import 'package:cb_project/src/server/sockets/voting_session_socket.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../server/models/voting_point.dart';
import '../../controllers/auth_controller.dart';

class VotingSystemTemplate extends StatelessWidget {
  final Widget body;
  final List<VotingPoint> votingPoints;

  const VotingSystemTemplate({
    Key? key,
    // required this.role,
    required this.body,
    required this.votingPoints,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Provider.of<AuthController>(context);
    final VotingSessionSocket votingSessionSocket =
        Provider.of<VotingSessionSocket>(context);
    return Scaffold(
      backgroundColor: const Color(0xFF1B1B1B),
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 90,
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
                'Sesión de cabildo',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24),
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Tipo de sesión: ${authController.userLoggedIn?.position} ',
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Usuario: ${authController.userLoggedIn?.firstName} ${authController.userLoggedIn?.lastName}',
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: Row(
        children: [
          Expanded(
            child: Container(
              color: const Color(0xFF121212),
              child: Column(
                children: [
                  const Text(
                    "Orden del día",
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.white,
                    ),
                  ),
                  Expanded(
                    flex: 6,
                    child: ListView.builder(
                      itemCount: votingPoints.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: index == votingSessionSocket.currentIndex
                                  ? Colors.white
                                  : const Color(0xFF171717),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            width: double.infinity,
                            height: 60,
                            child: Center(
                              child: Text(
                                "Punto ${index + 1}",
                                style: TextStyle(
                                  color:
                                      index != votingSessionSocket.currentIndex
                                          ? Colors.white
                                          : const Color(0xFF171717),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Expanded(
                    child: LogOutButton(),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: ColoredBox(
                  color: Colors.white,
                  child: body,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
