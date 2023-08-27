import 'package:flutter/material.dart';

import '../../../server/models/voting_point.dart';

class VotingSessionTemplate extends StatelessWidget {
  final List<VotingPoint> votingPoints;

  const VotingSessionTemplate({
    super.key,
    required this.votingPoints,
  });

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
