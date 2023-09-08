import 'package:cb_project/src/auth/admin/views/components/back_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../../../server/api/api_constants.dart';
import '../../../server/models/voting_point.dart';
import '../../../server/sockets/voting_session_socket.dart';

class TvSummaryView extends StatefulWidget {
  static const String id = '/tvSummaryView';
  const TvSummaryView({
    super.key,
  });

  @override
  State<TvSummaryView> createState() => _TvSummaryViewState();
}

class _TvSummaryViewState extends State<TvSummaryView> {
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
        print('Error: votingPoints is not a List');
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
        padding: const EdgeInsets.all(16.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
          ),
          //CONTENIDO:
          child: SizedBox.expand(
            child: Stack(
              children: [
                Positioned(
                  left: 10,
                  top: 10,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          const Text(
                            "Votos A favor:",
                            style: TextStyle(
                              fontSize: 21,
                              color: Colors.black,
                            ),
                          ),
                          Column(
                            children: List.generate(
                              votingSessionSocket
                                  .votingPoints[
                                      votingSessionSocket.currentIndex]
                                  .votesFor
                                  .length,
                              (i) {
                                return Text(
                                  "${votingSessionSocket.votingPoints[votingSessionSocket.currentIndex + 0].votesFor[i].firstName} ${votingSessionSocket.votingPoints[votingSessionSocket.currentIndex + 0].votesFor[i].lastName}"
                                      .toString(),
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Column(
                        children: [
                          const Text(
                            "Votos en contra:",
                            style: TextStyle(
                              fontSize: 21,
                              color: Colors.black,
                            ),
                          ),
                          Column(
                            children: List.generate(
                              votingSessionSocket
                                  .votingPoints[
                                      votingSessionSocket.currentIndex]
                                  .votesAgainst
                                  .length,
                              (i) {
                                return Text(
                                  "${votingSessionSocket.votingPoints[votingSessionSocket.currentIndex + 0].votesAgainst[i].firstName} ${votingSessionSocket.votingPoints[votingSessionSocket.currentIndex + 0].votesAgainst[i].lastName}"
                                      .toString(),
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Column(
                        children: [
                          const Text(
                            "Votos en abstencion:",
                            style: TextStyle(
                              fontSize: 21,
                              color: Colors.black,
                            ),
                          ),
                          Column(
                            children: List.generate(
                              votingSessionSocket
                                  .votingPoints[
                                      votingSessionSocket.currentIndex]
                                  .votesAbstain
                                  .length,
                              (i) {
                                return Text(
                                  "${votingSessionSocket.votingPoints[votingSessionSocket.currentIndex + 0].votesAgainst[i].firstName} ${votingSessionSocket.votingPoints[votingSessionSocket.currentIndex + 0].votesAbstain[i].lastName}"
                                      .toString(),
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Positioned(
                  right: 50,
                  top: 10,
                  child: Text(
                    "Punto: ${votingSessionSocket.currentIndex}",
                    style: TextStyle(
                      fontSize: 21,
                      color: Colors.black,
                    ),
                  ),
                ),
                Positioned(
                  left: 1,
                  right: 1,
                  top: 1,
                  bottom: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        votingSessionSocket
                            .votingPoints[votingSessionSocket.currentIndex + 0]
                            .subject,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        votingSessionSocket
                            .votingPoints[votingSessionSocket.currentIndex + 0]
                            .commision,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        votingSessionSocket
                            .votingPoints[votingSessionSocket.currentIndex + 0]
                            .votingForm,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        votingSessionSocket
                            .votingPoints[votingSessionSocket.currentIndex + 0]
                            .description,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
