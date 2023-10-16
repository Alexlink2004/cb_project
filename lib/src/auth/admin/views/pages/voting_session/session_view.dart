import 'package:cb_project/src/auth/admin/views/pages/voting_session/voting_session_content.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../server/models/voting_point.dart';
import '../../../controllers/voting_point_controller.dart';
import '../../components/admin_page_template.dart';

class SessionView extends StatelessWidget {
  const SessionView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get the VotingPointController from the Provider
    final votingPointController = Provider.of<VotingPointController>(context);
    List<VotingPoint> votingPoints = votingPointController.votingPoints;

    debugPrint("Datos en SessionView:");
    for (int i = 0; i < votingPoints.length; i++) {
      debugPrint("item no: $i");
      debugPrint("subject: ${votingPoints[i].subject}");
      debugPrint("subject: ${votingPoints[i].description}");
    }

    return AdminPageTemplate(
      pageTitle: "Ver Sesión",
      pageSubtitle:
          "Controla la sesión de votación, modificando los puntos de discusión, añadiendo opciones y gestionando los integrantes.",
      content: Container(
        height: 700,
        color: Colors.white,
        child: VotingSessionContent(
          votingPoints: votingPoints,
        ), // Pass the voting points to VotingSessionContent
      ),
    );
  }
}
