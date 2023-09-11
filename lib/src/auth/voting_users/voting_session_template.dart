import 'package:cb_project/src/auth/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../../server/api/api_constants.dart';
import '../../server/models/voting_point.dart';
import '../../server/sockets/voting_session_socket.dart';

class VotingSessionScreenTemplate extends StatefulWidget {
  const VotingSessionScreenTemplate({super.key});

  @override
  State<VotingSessionScreenTemplate> createState() =>
      _VotingSessionScreenTemplateState();
}

class _VotingSessionScreenTemplateState
    extends State<VotingSessionScreenTemplate> {
  late IO.Socket socket;

  @override
  void initState() {
    super.initState();
    final votingSessionSocket =
        Provider.of<VotingSessionSocket>(context, listen: false);

    // Inicializar el socket aquí
    socket = IO.io(ApiConstants.apiRoute, <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': true,
    });

    socket.on('connect', (_) {
      print('Connected');
      socket.emit("client:getsession");
    });

    socket.on('server:updatesession', (data) {
      print("Data received: $data");
      print(
          "Type of votingPoints: ${data['votingPoints'].runtimeType}"); // Imprime el tipo de data['votingPoints']

      if (data['votingPoints'] is List) {
        final List<dynamic> points = data['votingPoints'] as List<dynamic>;
        final List<VotingPoint> votingPoints = points
            .map((e) => VotingPoint.fromJson(e as Map<String, dynamic>))
            .toList();
        final int currentIndex = data['currentIndex'] as int;
        votingSessionSocket.updateData(votingPoints, currentIndex);
      } else {
        debugPrint('Error: votingPoints is not a List');
      }
    });

    // socket.on('server:getsession', (data) {
    //   Map<String, dynamic> sessionData =
    //       data as Map<String, dynamic>; // Asegúrate de que 'data' es un Map
    //   List<dynamic> jsonVotingPoints = sessionData['votingPoints']
    //       as List<dynamic>; // Asegúrate de que 'votingPoints' es una lista
    //   List<VotingPoint> votingPoints = jsonVotingPoints
    //       .map((json) => VotingPoint.fromJson(json as Map<String, dynamic>))
    //       .toList(); // Convierte cada elemento de la lista a un objeto VotingPoint
    //   int currentIndex = sessionData['currentIndex']
    //       as int; // Asegúrate de que 'currentIndex' es un entero
    //
    //   votingSessionSocket.updateData(votingPoints, currentIndex);
    // });

    socket.on('server:next', (data) {
      votingSessionSocket.updateIndex(data as int);
    });

    socket.on('server:previous', (data) {
      votingSessionSocket.updateIndex(data as int);
    });

    socket.connect();
  }

  @override
  void dispose() {
    // Desconectar el socket aquí
    socket.disconnect();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final votingSessionSocket = Provider.of<VotingSessionSocket>(context);
    final authController = Provider.of<AuthController>(context);
    return SizedBox(
      child: Stack(
        children: [
          Positioned(
            left: 20,
            top: 10,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Votos a favor: ${votingSessionSocket.votingPoints[votingSessionSocket.currentIndex].votesFor.length} ',
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),
                Text(
                  'Votos en contra: ${votingSessionSocket.votingPoints[votingSessionSocket.currentIndex].votesAgainst.length} ',
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),
                Text(
                  'Votos en abstencion: ${votingSessionSocket.votingPoints[votingSessionSocket.currentIndex].votesAbstain.length} ',
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            right: 20,
            top: 20,
            child: Text(
              'Página: ${votingSessionSocket.currentIndex + 1}',
              style: const TextStyle(
                color: Colors.black,
                fontSize: 23,
              ),
            ),
          ),
          Positioned(
            right: 10,
            left: 10,
            bottom: 10,
            top: 10,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  votingSessionSocket
                      .votingPoints[votingSessionSocket.currentIndex].subject,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  votingSessionSocket
                      .votingPoints[votingSessionSocket.currentIndex].commision,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 64.0,
                  ),
                  child: Text(
                    votingSessionSocket
                        .votingPoints[votingSessionSocket.currentIndex]
                        .description,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            right: 0,
            left: 0,
            bottom: 0,
            child: Container(
              height: 120,
              width: double.infinity,
              color: Colors.black,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Retroceder / Avanzar Sesión"),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 32,
                          ),
                          IconButton(
                            color: Colors.white,
                            icon: const Icon(
                              Icons.navigate_before,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              socket.emit("client:previouspoint");
                              votingSessionSocket.nextPoint();
                            },
                          ),
                          const SizedBox(
                            width: 50,
                          ),
                          IconButton(
                            color: Colors.white,
                            icon: const Icon(
                              Icons.navigate_next,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              socket.emit("client:nextpoint");
                              votingSessionSocket.previousPoint();
                            },
                          ),
                          const SizedBox(
                            width: 32,
                          ),
                        ],
                      ),
                    ],
                  ),
                  //Seccion de votacion
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Votación"),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 16,
                          ),
                          InkWell(
                            splashColor: Colors
                                .blue, // Cambia esto para el efecto splash
                            borderRadius: BorderRadius.circular(
                                15), // Esto debe coincidir con el borderRadius del Container
                            onTap: () {
                              socket.emit(
                                "client:votefor",
                                authController.userLoggedIn?.toJson(),
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors
                                    .green, // Cambia esto para cambiar el color del botón
                                borderRadius: BorderRadius.circular(15),
                              ),
                              height: 64,
                              width: 128,
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons
                                      .thumb_up), // Cambia esto para cambiar el icono
                                  SizedBox(width: 8),
                                  Text(
                                      "A favor"), // Cambia esto para cambiar el texto
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          InkWell(
                            splashColor: Colors
                                .blue, // Cambia esto para el efecto splash
                            borderRadius: BorderRadius.circular(
                                15), // Esto debe coincidir con el borderRadius del Container
                            onTap: () {
                              socket.emit(
                                "client:voteagainst",
                                authController.userLoggedIn?.toJson(),
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors
                                    .red, // Cambia esto para cambiar el color del botón
                                borderRadius: BorderRadius.circular(15),
                              ),
                              height: 64,
                              width: 128,
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons
                                      .thumb_down), // Cambia esto para cambiar el icono
                                  SizedBox(width: 8),
                                  Text(
                                    "En contra",
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          InkWell(
                            splashColor: Colors
                                .blue, // Cambia esto para el efecto splash
                            borderRadius: BorderRadius.circular(
                                15), // Esto debe coincidir con el borderRadius del Container
                            onTap: () {
                              socket.emit(
                                "client:voteabstain",
                                authController.userLoggedIn?.toJson(),
                              );
                              debugPrint(authController.userLoggedIn
                                  ?.toJson()
                                  .toString());
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors
                                    .yellow, // Cambia esto para cambiar el color del botón
                                borderRadius: BorderRadius.circular(15),
                              ),
                              height: 64,
                              width: 128,
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.question_mark,
                                  ), // Cambia esto para cambiar el icono
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    "Abstención",
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
