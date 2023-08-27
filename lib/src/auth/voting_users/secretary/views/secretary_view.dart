import 'package:flutter/material.dart';

import '../../components/voting_system_template.dart';

class SecretaryView extends StatelessWidget {
  static const String id = '/secretaryView';
  const SecretaryView({super.key});

  @override
  Widget build(BuildContext context) {
    return const VotingSystemTemplate(
      role: "Secretario",
      body: Placeholder(),
    );
  }
}
