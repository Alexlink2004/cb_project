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
    return Column(
      children: [
        Text(
          'Página: ${votingSessionSocket.currentIndex + 1}',
          style: const TextStyle(
            color: Colors.black,
          ),
        ),
        SizedBox(
          height: 500,
          width: 600,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${votingSessionSocket.votingPoints[votingSessionSocket.currentIndex].subject}',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                  ),
                ),
                Text(
                  '${votingSessionSocket.votingPoints[votingSessionSocket.currentIndex].commision}',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),
                //${votingSessionSocket.votingPoints[votingSessionSocket.currentIndex].votesAbstain.length}

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Votos en contra: ${votingSessionSocket.votingPoints[votingSessionSocket.currentIndex].votesFor.length} ',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      'Votos en contra: ${votingSessionSocket.votingPoints[votingSessionSocket.currentIndex].votesAgainst.length} ',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      'Votos en abstencion: ${votingSessionSocket.votingPoints[votingSessionSocket.currentIndex].votesAbstain.length} ',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            socket.emit("client:nextpoint");
            votingSessionSocket.nextPoint();
          },
          child: const Text('Next Point'),
        ),
        ElevatedButton(
          onPressed: () {
            socket.emit("client:previouspoint");
            votingSessionSocket.previousPoint();
          },
          child: const Text('Previous Point'),
        ),
      ],
    );
  }
}
