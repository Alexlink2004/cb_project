import 'package:cb_project/src/auth/admin/controllers/voting_point_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../../../server/models/user.dart';
import '../../../../../server/models/voting_point.dart';

class VotingSessionContent extends StatelessWidget {
  final List<VotingPoint> votingPoints;

  const VotingSessionContent({Key? key, required this.votingPoints})
      : super(key: key);

  // void _deleteUser(String password) {
  //   votingPointController.deleteUser(password);
  // }

  @override
  Widget build(BuildContext context) {
    final VotingPointController votingPointController =
        Provider.of<VotingPointController>(context);
    return Padding(
      padding: const EdgeInsets.all(64.0),
      child: Container(
        width: double.infinity,
        height: 400,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Puntos de sesión',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: votingPoints.length,
              itemBuilder: (context, index) {
                final votingPoint = votingPoints[index];
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: ListTile(
                    title: Text(votingPoint.subject),
                    subtitle: Text(votingPoint.description),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        votingPointController.deleteVotingPoint(votingPoint.id);
                      },
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
