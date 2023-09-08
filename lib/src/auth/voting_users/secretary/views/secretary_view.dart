import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../server/models/voting_point.dart';
import '../../../../server/sockets/voting_session_socket.dart';
import '../../components/voting_system_template.dart';
import '../../voting_session_template.dart';

class SecretaryView extends StatelessWidget {
  static const String id = '/secretaryView';
  const SecretaryView({super.key});

  @override
  Widget build(BuildContext context) {
    final VotingSessionSocket votingSessionSocket =
        Provider.of<VotingSessionSocket>(context);
    List<VotingPoint> votingPoints = votingSessionSocket.votingPoints;
    return VotingSystemTemplate(
      votingPoints: votingPoints,
      body: const VotingSessionScreenTemplate(),
    );
  }
}
