import 'package:cb_project/src/auth/admin/views/components/back_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../../../server/api/api_constants.dart';
import '../../../server/models/voting_point.dart';
import '../../../server/sockets/voting_session_socket.dart';
import '../components/voting_summary_chart.dart';

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
      backgroundColor: const Color(0xFF121212),
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
          child: Padding(
            padding: const EdgeInsets.all(64.0),
            child: SizedBox.expand(
              child: Stack(
                children: [
                  Column(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Column(
                                children: [
                                  Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFEAE8EA),
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: VotingSummaryPieChart(
                                          votesFor: votingSessionSocket
                                              .votingPoints[votingSessionSocket
                                                  .currentIndex]
                                              .votesFor
                                              .length,
                                          votesAgainst: votingSessionSocket
                                              .votingPoints[votingSessionSocket
                                                  .currentIndex]
                                              .votesAgainst
                                              .length,
                                          votesAbstain: votingSessionSocket
                                              .votingPoints[votingSessionSocket
                                                  .currentIndex]
                                              .votesAbstain
                                              .length,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Expanded(
                                    child: _buildTableOfUsers(
                                      votingSessionSocket,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 16,
                            ),
                            Expanded(
                              flex: 2,
                              child: SizedBox(
                                height: double.infinity,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: const Color(
                                        0xFFEAE8EA), // Fondo que resalta con el blanco
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(64.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          votingSessionSocket
                                              .votingPoints[votingSessionSocket
                                                  .currentIndex]
                                              .subject,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                            color: Color(
                                                0xFF333333), // Color de texto oscuro
                                          ),
                                        ),
                                        const SizedBox(height: 16),
                                        Text(
                                          votingSessionSocket
                                              .votingPoints[votingSessionSocket
                                                  .currentIndex]
                                              .commision,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                            color: Color(
                                                0xFF666666), // Color de texto medio
                                          ),
                                        ),
                                        const SizedBox(height: 24),
                                        Text(
                                          votingSessionSocket
                                              .votingPoints[votingSessionSocket
                                                  .currentIndex]
                                              .votingForm,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                            color: Color(
                                                0xFF888888), // Color de texto claro
                                          ),
                                        ),
                                        const SizedBox(height: 24),
                                        Text(
                                          votingSessionSocket
                                              .votingPoints[votingSessionSocket
                                                  .currentIndex]
                                              .description,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                            color: Color(
                                                0xFF888888), // Color de texto claro
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    right: 50,
                    top: 10,
                    child: Text(
                      "Punto: ${votingSessionSocket.currentIndex + 1}",
                      style: const TextStyle(
                        fontSize: 21,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _buildTableOfUsers(VotingSessionSocket votingSessionSocket,
      {double borderRadius = 30}) {
    return Container(
      padding: const EdgeInsets.all(32.0),
      decoration: BoxDecoration(
        color: const Color(0xFFEAE8EA), // Fondo que resalta con el blanco
        borderRadius: BorderRadius.circular(
          borderRadius,
        ),
      ),
      child: Table(
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        columnWidths: const {
          0: FlexColumnWidth(1),
          1: FlexColumnWidth(1),
          2: FlexColumnWidth(1),
        },
        children: [
          const TableRow(
            children: [
              Text(
                "Votos A favor",
                style: TextStyle(fontSize: 21, color: Colors.black),
                textAlign: TextAlign.center,
              ),
              Text(
                "Votos en contra",
                style: TextStyle(fontSize: 21, color: Colors.black),
                textAlign: TextAlign.center,
              ),
              Text(
                "Votos en abstención",
                style: TextStyle(fontSize: 21, color: Colors.black),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          TableRow(
            children: [
              Column(
                children: List.generate(
                  votingSessionSocket
                      .votingPoints[votingSessionSocket.currentIndex]
                      .votesFor
                      .length,
                  (i) => Text(
                    "${votingSessionSocket.votingPoints[votingSessionSocket.currentIndex].votesFor[i].firstName} ${votingSessionSocket.votingPoints[votingSessionSocket.currentIndex].votesFor[i].lastName}",
                    style: const TextStyle(fontSize: 16, color: Colors.black),
                  ),
                ),
              ),
              Column(
                children: List.generate(
                  votingSessionSocket
                      .votingPoints[votingSessionSocket.currentIndex]
                      .votesAgainst
                      .length,
                  (i) => Text(
                    "${votingSessionSocket.votingPoints[votingSessionSocket.currentIndex].votesAgainst[i].firstName} ${votingSessionSocket.votingPoints[votingSessionSocket.currentIndex].votesAgainst[i].lastName}",
                    style: const TextStyle(fontSize: 16, color: Colors.black),
                  ),
                ),
              ),
              Column(
                children: List.generate(
                  votingSessionSocket
                      .votingPoints[votingSessionSocket.currentIndex]
                      .votesAbstain
                      .length,
                  (i) => Text(
                    "${votingSessionSocket.votingPoints[votingSessionSocket.currentIndex].votesAbstain[i].firstName} ${votingSessionSocket.votingPoints[votingSessionSocket.currentIndex].votesAbstain[i].lastName}",
                    style: const TextStyle(fontSize: 16, color: Colors.black),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
