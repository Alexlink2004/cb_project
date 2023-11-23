import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../server/models/voting_point.dart';
import '../../../controllers/voting_point_controller.dart';
import 'components/add_voting_point_popup.dart';
import 'components/excel_download_button.dart';

class VotingSessionContent extends StatelessWidget {
  const VotingSessionContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final votingPointController = Provider.of<VotingPointController>(context);
    List<VotingPoint> votingPoints = votingPointController.votingPoints;

    return Scaffold(
      body: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              child: Container(
                width: 250,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.black,
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Añadir punto de votación",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                  ],
                ),
              ),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return const AddVotingPointPopup();
                  },
                );
              },
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: votingPoints.length,
                itemBuilder: (BuildContext context, int index) {
                  final VotingPoint votingPoint = votingPoints[index];
                  return Card(
                    elevation: 0.6,
                    child: ListTile(
                      isThreeLine: true, // Enable three lines in ListTile
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10.0),
                      leading: CircleAvatar(
                        backgroundColor: Colors.blueAccent,
                        child: Text(
                          votingPoint.subject
                              .substring(0, 1), // First letter of subject
                        ),
                      ),
                      title: Text(
                        votingPoint.subject,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24.0, // Larger font size for bigger screens
                        ),
                      ),
                      subtitle: Text(
                        votingPoint.description,
                        style: const TextStyle(
                          fontSize:
                              18.0, // Slightly larger font size for subtitles
                        ),
                      ),
                      trailing: FittedBox(
                        fit: BoxFit.fill,
                        child: Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () {
                                // Logic for editing voting point
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () {
                                votingPointController
                                    .deleteVotingPoint(votingPoint.id);
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: const DownloadReportFAB(),
    );
  }
}
