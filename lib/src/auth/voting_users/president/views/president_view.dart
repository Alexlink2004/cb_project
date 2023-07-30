import 'package:flutter/material.dart';

import '../../components/voting_system_template.dart';

class PresidentView extends StatelessWidget {
  static const String id = '/presidentView';
  const PresidentView({super.key});

  @override
  Widget build(BuildContext context) {
    return VotingSystemTemplate(
      role: "Presidente",
      body: Placeholder(),
    );
  }
}
